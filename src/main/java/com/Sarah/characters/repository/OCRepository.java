package com.Sarah.characters.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.Sarah.characters.entity.OC;

public interface OCRepository extends JpaRepository<OC, Long> {

    List<OC> findBySpeciesIgnoreCase(String species);

    List<OC> findByNameContainingIgnoreCase(String name);

    List<OC> findByNameContainingIgnoreCaseAndSpeciesIgnoreCase(String name, String species);

    @Query("select distinct c.species from OC c where c.species is not null order by c.species")
    List<String> findDistinctSpecies();
}