From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] PM / sleep: constify attribute_group structures.
Date: Fri, 30 Jun 2017 10:22:14 +0530
Message-ID: <ff23d3ae01b1a980eee8df412dfda4e64dfdc223.1498798163.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34439 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbdF3Ew2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 00:52:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   3802	    624	     32	   4458	   116a	kernel/power/main.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   3866	    560	     32	   4458	   116a	kernel/power/main.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index d401c21..42bd800 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -705,7 +705,7 @@ static ssize_t pm_freeze_timeout_store(struct kobject *kobj,
 	NULL,
 };
 
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = g,
 };
 
-- 
1.9.1
