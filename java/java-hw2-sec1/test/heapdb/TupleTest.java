package heapdb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class TupleTest {
	
	@Test
	void createTestRecord() {
		// create a schema with three integer fields, named 'a', 'b', 'c',
		// with 'a' the key
		Schema schema = new Schema();
		schema.addKeyIntType("a");
		schema.addIntType("b");
		schema.addIntType("c");
		
		Tuple rec = new Tuple(schema, 1, 1, 1);
		assertEquals(1, rec.getInt(0));
		assertEquals(1, rec.getInt(1));
		assertEquals(1, rec.getInt(2));
	}
	
	@Test
	void varCharTypeTest() {
		Schema schema = new Schema();
		schema.addKeyVarCharType("a",  4);
		schema.addVarCharType("b",  2);
		assertEquals(14, schema.getTupleSizeInBytes());
		Assertions.assertThrows(RuntimeException.class, () -> 
			new Tuple(schema, "1234", "123"));
		Tuple t = new Tuple(schema, "1234", "12");
		assertEquals("1234", t.get(0));
		assertEquals("1234", t.get("a"));
		assertEquals("12", t.getString(1));
	}

	// construct a simple record and check value of the field
	@Test
	void createSimpleRecord() {
		Schema schema = new Schema();
		schema.addIntType("a");
		Tuple rec = new Tuple(schema, 1);
		assertEquals(rec.get(0), 1);
	}
	
	// the Tuple constructor should throw an exception if schema doesn't
	// match supplied field values
	@Test
	void recordsMatchSchema() {
		Schema schema = new Schema();
		schema.addIntType("a"); 
		Assertions.assertThrows(IllegalArgumentException.class, () -> 
			new Tuple(schema, 1, 2));
	}
}