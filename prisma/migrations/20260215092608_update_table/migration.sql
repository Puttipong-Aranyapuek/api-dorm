/*
  Warnings:

  - You are about to drop the `maintenancerequest` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `month` on table `expense` required. This step will fail if there are existing NULL values in that column.
  - Made the column `electricity` on table `expense` required. This step will fail if there are existing NULL values in that column.
  - Made the column `water` on table `expense` required. This step will fail if there are existing NULL values in that column.
  - Made the column `rent` on table `expense` required. This step will fail if there are existing NULL values in that column.
  - Made the column `total` on table `expense` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `maintenancerequest` DROP FOREIGN KEY `MaintenanceRequest_user_id_fkey`;

-- AlterTable
ALTER TABLE `expense` MODIFY `month` VARCHAR(191) NOT NULL,
    MODIFY `electricity` DOUBLE NOT NULL,
    MODIFY `water` DOUBLE NOT NULL,
    MODIFY `rent` DOUBLE NOT NULL,
    MODIFY `total` DOUBLE NOT NULL;

-- DropTable
DROP TABLE `maintenancerequest`;

-- CreateTable
CREATE TABLE `Maintenance` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `image_url` VARCHAR(191) NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notification` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `message` VARCHAR(191) NOT NULL,
    `read` BOOLEAN NOT NULL DEFAULT false,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Maintenance` ADD CONSTRAINT `Maintenance_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
