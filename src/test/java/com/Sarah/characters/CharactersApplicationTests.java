package com.Sarah.characters;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(properties = "spring.datasource.url=jdbc:h2:mem:characters;DB_CLOSE_DELAY=-1")
class CharactersApplicationTests {

	@Test
	void contextLoads() {
	}

}
