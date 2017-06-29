From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] PM: hibernate: constify attribute_group structures.
Date: Thu, 29 Jun 2017 16:58:40 +0530
Message-ID: <06cb04785b169107e86016267fd52b414e46efaa.1498735541.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33711 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdF2L3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 07:29:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   6332	    488	    308	   7128	   1bd8	kernel/power/hibernate.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   6396	    424	    308	   7128	   1bd8	kernel/power/hibernate.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a8b978c..e1914c7 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1108,7 +1108,7 @@ static ssize_t reserved_size_store(struct kobject *kobj,
 };
 
 
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = g,
 };
 
-- 
1.9.1
