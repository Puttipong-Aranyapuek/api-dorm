/*
  Warnings:

  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropForeignKey
ALTER TABLE `expense` DROP FOREIGN KEY `Expense_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `maintenance` DROP FOREIGN KEY `Maintenance_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `notification` DROP FOREIGN KEY `Notification_user_id_fkey`;

-- DropIndex
DROP INDEX `Expense_user_id_fkey` ON `expense`;

-- DropIndex
DROP INDEX `Maintenance_user_id_fkey` ON `maintenance`;

-- DropIndex
DROP INDEX `Notification_user_id_fkey` ON `notification`;

-- AlterTable
ALTER TABLE `expense` MODIFY `user_id` VARCHAR(20) NOT NULL;

-- AlterTable
ALTER TABLE `maintenance` MODIFY `user_id` VARCHAR(20) NOT NULL;

-- AlterTable
ALTER TABLE `notification` MODIFY `user_id` VARCHAR(20) NOT NULL;

-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(20) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AddForeignKey
ALTER TABLE `Expense` ADD CONSTRAINT `Expense_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Maintenance` ADD CONSTRAINT `Maintenance_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
