From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] power: add const to bin_attribute structures
Date: Wed,  2 Aug 2017 15:59:38 +0530
Message-ID: <1501669778-25033-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37377 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdHBKaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2017 06:30:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: julia.lawall@lip6.fr, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Add const to bin_attribute structures as they are only passed to the
functions sysfs_{remove/create}_bin_file or
device_{remove/create}_bin_file. The corresponding parameters
passed are of type const, so declare the structures to be const.

Done using Coccinelle:

@m disable optional_qualifier@
identifier s;
position p;
@@
static struct bin_attribute s@p={...};

@okay1@
position p;
identifier m.s;
@@
(
sysfs_create_bin_file(...,&s@p,...)
|
sysfs_remove_bin_file(...,&s@p,...)
)

@bad@
position p!={m.p,okay1.p};
identifier m.s;
@@
s@p

@change depends on !bad disable optional_qualifier@
identifier m.s;
@@
static
+const
struct bin_attribute s={...};

Same script was modified for device_{create/remove}_bin_file functions.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Could not find an architecture to cross compile olpc_battery.o file.

 drivers/power/supply/ds2780_battery.c | 4 ++--
 drivers/power/supply/ds2781_battery.c | 4 ++--
 drivers/power/supply/olpc_battery.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index 8edd4aa..e5d81b4 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -663,7 +663,7 @@ static ssize_t ds2780_write_param_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static struct bin_attribute ds2780_param_eeprom_bin_attr = {
+static const struct bin_attribute ds2780_param_eeprom_bin_attr = {
 	.attr = {
 		.name = "param_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
@@ -708,7 +708,7 @@ static ssize_t ds2780_write_user_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static struct bin_attribute ds2780_user_eeprom_bin_attr = {
+static const struct bin_attribute ds2780_user_eeprom_bin_attr = {
 	.attr = {
 		.name = "user_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index 4400402..efe83ef 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -665,7 +665,7 @@ static ssize_t ds2781_write_param_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static struct bin_attribute ds2781_param_eeprom_bin_attr = {
+static const struct bin_attribute ds2781_param_eeprom_bin_attr = {
 	.attr = {
 		.name = "param_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
@@ -711,7 +711,7 @@ static ssize_t ds2781_write_user_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static struct bin_attribute ds2781_user_eeprom_bin_attr = {
+static const struct bin_attribute ds2781_user_eeprom_bin_attr = {
 	.attr = {
 		.name = "user_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 9e29b13..fc20ca3 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -535,7 +535,7 @@ static ssize_t olpc_bat_eeprom_read(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute olpc_bat_eeprom = {
+static const struct bin_attribute olpc_bat_eeprom = {
 	.attr = {
 		.name = "eeprom",
 		.mode = S_IRUGO,
-- 
1.9.1
