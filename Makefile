GHC = ghc
GHCFLAGS = -rtsopts
TEST_DB = test.sqlite
LIST = selectList
SOURCE = selectSource
DB = createDB
RMRF = rm -rf

all: $(TEST_DB)
	$(GHC) $(LIST) $(GHCFLAGS)
	$(GHC) $(SOURCE) $(GHCFLAGS)

$(TEST_DB):
	$(GHC) $(DB)
	./$(DB)

clean:
	$(RMRF) *.hi *.o
	$(RMRF) $(TEST_DB) $(LIST) $(SOURCE) $(DB)
	