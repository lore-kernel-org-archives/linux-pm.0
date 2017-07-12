From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] power: supply: constify attribute_group structures.
Date: Wed, 12 Jul 2017 17:13:22 +0530
Message-ID: <cee17fda23a2dd44e9b0f7bb575282c4dd1e5f8e.1499859597.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34799 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756401AbdGLLnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 07:43:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, sebastian.reichel@collabora.co.uk
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   2673	    400	      0	   3073	    c01	power/supply/pcf50633-charger.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   2737	    336	      0	   3073	    bed	power/supply/pcf50633-charger.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/power/supply/pcf50633-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
index b3c1873..1ad7ccc 100644
--- a/drivers/power/supply/pcf50633-charger.c
+++ b/drivers/power/supply/pcf50633-charger.c
@@ -254,7 +254,7 @@ static ssize_t set_chglim(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group mbc_attr_group = {
+static const struct attribute_group mbc_attr_group = {
 	.name	= NULL,			/* put in device directory */
 	.attrs	= pcf50633_mbc_sysfs_entries,
 };
-- 
1.9.1
