-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_tasks" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "initialDescription" TEXT NOT NULL,
    "title" TEXT,
    "status" TEXT,
    "priority" TEXT,
    "worktreePath" TEXT,
    "sessionId" TEXT,
    "links" JSONB NOT NULL DEFAULT [],
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_tasks" ("createdAt", "id", "initialDescription", "priority", "sessionId", "status", "title", "updatedAt", "worktreePath") SELECT "createdAt", "id", "initialDescription", "priority", "sessionId", "status", "title", "updatedAt", "worktreePath" FROM "tasks";
DROP TABLE "tasks";
ALTER TABLE "new_tasks" RENAME TO "tasks";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
