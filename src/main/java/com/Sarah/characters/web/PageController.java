package com.Sarah.characters.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Sarah.characters.entity.OC;
import com.Sarah.characters.service.OCService;

import jakarta.validation.Valid;

@Controller
public class PageController {

    private final OCService service;

    public PageController(OCService service) {
        this.service = service;
    }

    // ---------- Gallery + search ----------
    @GetMapping("/")
    public String gallery(@RequestParam(required = false) String name,
            @RequestParam(required = false) String species,
            Model model) {
        model.addAttribute("characters", service.getAll(species, name));
        model.addAttribute("searchName", name);
        model.addAttribute("searchSpecies", species);
        model.addAttribute("speciesOptions", service.getDistinctSpecies());
        return "gallery";
    }

    // ---------- Details ----------
    @GetMapping("/characters/{id}")
    public String details(@PathVariable long id, Model model) {
        model.addAttribute("character", service.getById(id));
        return "details";
    }

    // ---------- Add ----------
    @GetMapping("/characters/new")
    public String newForm(Model model) {
        model.addAttribute("character", new OC());
        model.addAttribute("formAction", "/characters");
        model.addAttribute("heading", "Create a Character");
        return "character-form";
    }

    @PostMapping("/characters")
    public String create(@Valid @ModelAttribute("character") OC character,
            BindingResult result,
            Model model,
            RedirectAttributes redirect) {
        if (result.hasErrors()) {
            model.addAttribute("formAction", "/characters");
            model.addAttribute("heading", "Create a Character");
            model.addAttribute("errors", fieldErrors(result));
            return "character-form";
        }
        OC saved = service.create(character);
        redirect.addFlashAttribute("successMessage", saved.getName() + " was added");
        return "redirect:/";
    }

    // ---------- Edit ----------
    @GetMapping("/characters/{id}/edit")
    public String editForm(@PathVariable long id, Model model) {
        model.addAttribute("character", service.getById(id));
        model.addAttribute("formAction", "/characters/" + id);
        model.addAttribute("heading", "Edit Character");
        return "character-form";
    }

    @PostMapping("/characters/{id}")
    public String update(@PathVariable long id,
            @Valid @ModelAttribute("character") OC character,
            BindingResult result,
            Model model,
            RedirectAttributes redirect) {
        if (result.hasErrors()) {
            model.addAttribute("formAction", "/characters/" + id);
            model.addAttribute("heading", "Edit Character");
            model.addAttribute("errors", fieldErrors(result));
            return "character-form";
        }
        OC saved = service.update(id, character); // load-then-copy, no duplicate row
        redirect.addFlashAttribute("successMessage", saved.getName() + " was updated");
        return "redirect:/characters/" + id;
    }

    // ---------- Delete ----------
    @PostMapping("/characters/{id}/delete")
    public String delete(@PathVariable long id, RedirectAttributes redirect) {
        OC existing = service.getById(id);
        String name = existing.getName();
        service.delete(id);
        redirect.addFlashAttribute("successMessage", name + " was removed");
        return "redirect:/";
    }

    // ---------- About ----------
    @GetMapping("/about")
    public String about() {
        return "about";
    }

    // ---------- Friendly not-found for page routes ----------
    @ExceptionHandler(ResponseStatusException.class)
    public ModelAndView handlePageError(ResponseStatusException ex) {
        ModelAndView mv = new ModelAndView("error");
        mv.setStatus(ex.getStatusCode());
        mv.addObject("errorMessage", ex.getReason());
        return mv;
    }

    private List<String> fieldErrors(BindingResult result) {
        List<String> out = new ArrayList<>();
        result.getFieldErrors().forEach(fe -> out.add(fe.getDefaultMessage()));
        return out;
    }
}