package com.Sarah.characters.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.Sarah.characters.entity.OC;
import com.Sarah.characters.repository.OCRepository;

@Service
public class OCService {

    private final OCRepository repository;

    public OCService(OCRepository repository) {
        this.repository = repository;
    }

    public List<OC> getAll(String species, String name) {
        boolean hasName = name != null && !name.isBlank();
        boolean hasSpecies = species != null && !species.isBlank();

        if (hasName && hasSpecies) {
            return repository.findByNameContainingIgnoreCaseAndSpeciesIgnoreCase(name, species);
        }
        if (hasName) {
            return repository.findByNameContainingIgnoreCase(name);
        }
        if (hasSpecies) {
            return repository.findBySpeciesIgnoreCase(species);
        }
        return repository.findAll();
    }

    public List<String> getDistinctSpecies() {
        return repository.findDistinctSpecies();
    }

    public OC getById(long id) {
        return repository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Character not found: " + id));
    }

    public OC create(OC c) {
        return repository.save(c);
    }

    public OC update(long id, OC updated) {
        OC existing = getById(id);
        existing.setName(updated.getName());
        existing.setDescription(updated.getDescription());
        existing.setSpecies(updated.getSpecies());
        existing.setOccupancy(updated.getOccupancy());
        existing.setAbilities(updated.getAbilities());
        existing.setInterests(updated.getInterests());
        existing.setImageUrl(updated.getImageUrl()); // ← must be here
        existing.setActiveDate(updated.getActiveDate());
        return repository.save(existing);
    }

    public void delete(long id) {
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND, "Character not found: " + id);
        }
        repository.deleteById(id);
    }
}