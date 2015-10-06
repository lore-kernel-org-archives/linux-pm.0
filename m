From: Wonhong Kwon <wonhongkwon@gmail.com>
Subject: [PATCH] PM / hibernate: Move pm_init/pm_disk_init to late_initcall_sync
Date: Tue,  6 Oct 2015 10:10:20 +0900
Message-ID: <1444093820-6934-1-git-send-email-wonhong.kwon@lge.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33355 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbJFBLd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 21:11:33 -0400
Received: by pacex6 with SMTP id ex6so192581932pac.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2015 18:11:32 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc: linux-pm@vger.kernel.org, gunho.lee@lge.com, Wonhong Kwon <wonhong.kwon@lge.com>

pm_init is being invoked by core_initcall and hibernate_image_size_init
calculates preferred image size (image_size) based on total pages
(totalram_pages). This totalram_pages can be modified during various
initcall-s phase and this can cause miscalculated image_size.

For example, when CMA is being used, init_cma_reserved_pageblock tries
to change the totalram_pages and this job is done during core_initcall.
In order words, the totalram_pages doesn't take CMA reserved pages into
account when image_size is calculated and it can be too small.

Move pm_init and pm_disk_init to late_initcall_sync so that it happens
after all other initcall-s change the totalram_pages.

Reported-by: Sangseok Lee <sangseok.lee@lge.com>
Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
---
 kernel/power/hibernate.c |    2 +-
 kernel/power/main.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 690f78f..c7ff849 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1087,7 +1087,7 @@ static int __init pm_disk_init(void)
 	return sysfs_create_group(power_kobj, &attr_group);
 }
 
-core_initcall(pm_disk_init);
+late_initcall_sync(pm_disk_init);
 
 
 static int __init resume_setup(char *str)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 63d395b..c3e223b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -643,4 +643,4 @@ static int __init pm_init(void)
 	return pm_autosleep_init();
 }
 
-core_initcall(pm_init);
+late_initcall_sync(pm_init);
-- 
1.7.9.5

