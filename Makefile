EXTENSION    = postgis_letters
EXTVERSION    = 0.0.3
MINORVERSION  = 2013.4.18

MICRO_NUMBER  = $(shell echo $(EXTVERSION) | sed "s/[0-9]\.[0-9]\.\([0-9]*\)[a-zA-Z]*[0-9]*/\1/")
PREREL_NUMBER = $(shell echo $(EXTVERSION) | \
                        sed "s/[0-9]\.[0-9]\.\(.*\)/\1/" | \
                        grep "[a-zA-Z]" | \
                        sed "s/[0-9][a-zA-Z]\([0-9]*\)[a-zA-Z]*/\1/")
MICRO_PREV    = $(shell if test "$(MICRO_NUMBER)x" != "x"; then expr $(MICRO_NUMBER) - 1; fi)
PREREL_PREV   = $(shell if test "$(PREREL_NUMBER)x" != "x"; then expr $(PREREL_NUMBER) - 1; fi)

PREREL_PREFIX = $(shell echo $(EXTVERSION) | \
                        sed "s/[0-9]\.[0-9]\.\(.*\)/\1/" | \
                        grep "[a-zA-Z]" | \
                        sed "s/\([0-9][a-zA-Z]*\)[0-9]*/\1/")

DATA         = $(filter-out $(wildcard sql/*--*.sql),$(wildcard sql/*.sql))

SQL_BITS     = $(wildcard sql_bits/*.sql)
EXTRA_CLEAN += sql/*.sql ${SQL_BITS} 


all: sql/$(EXTENSION)--$(EXTVERSION).sql sql/postgis_letters.control

sql/$(EXTENSION)--$(EXTVERSION).sql: sql/$(EXTENSION).sql
	cp $< $@
	
sql/$(EXTENSION).sql: sql_bits/postgis_letters.sql.in sql_bits/font_set.sql.in
	cat $^ > $@
	
sql/postgis_letters.control: postgis_letters.control.in
	cp $< $@

DATA = $(wildcard sql/*--*.sql)
EXTRA_CLEAN += sql/$(EXTENSION)--$(EXTVERSION).sql sql/$(EXTENSION)--unpackaged--$(EXTVERSION).sql

# PG_CONFIG = pg_config
# PGXS := $(shell $(PG_CONFIG) --pgxs)
