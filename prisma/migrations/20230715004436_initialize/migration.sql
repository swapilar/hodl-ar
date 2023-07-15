-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "bio" TEXT,
    "email" TEXT,
    "github" TEXT,
    "twitter" TEXT,
    "npub" TEXT,
    "discord" TEXT,
    "lud06" TEXT
);

-- CreateTable
CREATE TABLE "LNBits" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "lndhubUrl" TEXT,
    "adminKey" TEXT NOT NULL,
    CONSTRAINT "LNBits_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "LNURL" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "tag" TEXT NOT NULL,
    "callback" TEXT,
    "minSendable" INTEGER NOT NULL,
    "maxSendable" INTEGER NOT NULL,
    "metadata" TEXT NOT NULL,
    "commentAllowed" INTEGER NOT NULL,
    "payerData" TEXT,
    CONSTRAINT "LNURL_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Relay" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "OTToken" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "validUntil" DATETIME NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "OTToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Card" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" TEXT NOT NULL,
    "userId" INTEGER,
    "uuid" TEXT NOT NULL,
    "k01" TEXT,
    "k02" TEXT,
    "k03" TEXT,
    "k04" TEXT,
    CONSTRAINT "Card_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Wallet" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "cardId" INTEGER,
    "uuid" TEXT NOT NULL,
    CONSTRAINT "Wallet_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Wallet_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_RelayToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_RelayToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Relay" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_RelayToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_github_key" ON "User"("github");

-- CreateIndex
CREATE UNIQUE INDEX "User_twitter_key" ON "User"("twitter");

-- CreateIndex
CREATE UNIQUE INDEX "User_npub_key" ON "User"("npub");

-- CreateIndex
CREATE UNIQUE INDEX "User_discord_key" ON "User"("discord");

-- CreateIndex
CREATE UNIQUE INDEX "LNBits_userId_key" ON "LNBits"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "LNURL_userId_key" ON "LNURL"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Relay_name_key" ON "Relay"("name");

-- CreateIndex
CREATE UNIQUE INDEX "OTToken_userId_key" ON "OTToken"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Card_uuid_key" ON "Card"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Wallet_userId_key" ON "Wallet"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Wallet_cardId_key" ON "Wallet"("cardId");

-- CreateIndex
CREATE UNIQUE INDEX "Wallet_uuid_key" ON "Wallet"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "_RelayToUser_AB_unique" ON "_RelayToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_RelayToUser_B_index" ON "_RelayToUser"("B");
