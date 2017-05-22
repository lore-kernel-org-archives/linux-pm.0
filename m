From: BaoJun Luo <baojun.luo@samsung.com>
Subject: [PATCH] PM/hibernate: Free memory occupied by the memory bitmap
 when hibernation failed
Date: Mon, 22 May 2017 13:43:17 +0800
Message-ID: <39101.522396277$1505300871@news.gmane.org>
References: <CGME20170522054414epcas1p38b221b576b6f304c911a196457e248fe@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42978 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbdEVFoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 01:44:17 -0400
Content-language: zh-cn
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz
Cc: linux-pm@vger.kernel.org

>From 17f24d918f4c2ac292ec2aaeb13a527a10b91f80 Mon Sep 17 00:00:00 2001
From: "baojun.luo" <baojun.luo@samsung.com>
Date: Fri, 19 May 2017 17:58:21 +0800
Subject: [PATCH] PM/hibernate: Free memory bitmap by orig_bm/copy_bm hold when  hibernation failed

During prepare for hibernation operation, if there is an error, the image bitmap memory needs to be released.

This patch will make sure the bitmap memory be released when hibernation error

Signed-off-by: baojun.luo <baojun.luo@samsung.com>
---
 kernel/power/hibernate.c |  1 +
 kernel/power/power.h     |  1 +
 kernel/power/snapshot.c  | 50 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c index a8b978c..e54ef08 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -743,6 +743,7 @@ int hibernate(void)
 	}
 
  Free_bitmaps:
+	free_image_memory_bitmaps();
 	free_basic_memory_bitmaps();
  Thaw:
 	unlock_device_hotplug();
diff --git a/kernel/power/power.h b/kernel/power/power.h index 7fdc40d..0393bc8 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -108,6 +108,7 @@ static inline void hibernate_image_size_init(void) {}
 
 extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
+extern void free_image_memory_bitmaps(void);
 extern int hibernate_preallocate_memory(void);
 
 extern void clear_free_pages(void);
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c index 3b1e0f3..d96c939 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1441,6 +1441,46 @@ static void copy_data_pages(struct memory_bitmap *copy_bm,
  */
 static struct memory_bitmap copy_bm;
 
+/* Helper functions used for the shrinking of memory. */
+
+#define GFP_IMAGE	(GFP_KERNEL | __GFP_NOWARN)
+
+/**
+ * create_image_memory_bitmaps - Create bitmaps to hold image page information.
+ *
+ */
+int create_image_memory_bitmaps(void)
+{
+	int error = 0;
+
+	error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
+	if (error)
+		goto err_out;
+
+	memset(&copy_bm, 0, sizeof(struct memory_bitmap));
+	error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
+	if (error) {
+		memory_bm_free(&orig_bm, PG_UNSAFE_CLEAR);
+		goto err_out;
+	}
+	return 0;
+err_out:
+	return -ENOMEM;
+}
+
+/**
+ * free_image_memory_bitmaps - Free memory bitmaps holding image page information.
+ *
+ */
+void free_image_memory_bitmaps(void)
+{
+	if(copy_bm.p_list) {
+		memory_bm_free(&orig_bm, PG_UNSAFE_CLEAR);
+		memory_bm_free(&copy_bm, PG_UNSAFE_CLEAR);
+		pr_debug("PM: Image memory bitmaps freed\n");
+	}
+}
+
 /**
  * swsusp_free - Free pages allocated for hibernation image.
  *
@@ -1492,10 +1532,6 @@ void swsusp_free(void)
 	hibernate_restore_protection_end();
 }
 
-/* Helper functions used for the shrinking of memory. */
-
-#define GFP_IMAGE	(GFP_KERNEL | __GFP_NOWARN)
-
 /**
  * preallocate_image_pages - Allocate a number of pages for hibernation image.
  * @nr_pages: Number of page frames to allocate.
@@ -1695,11 +1731,7 @@ int hibernate_preallocate_memory(void)
 	printk(KERN_INFO "PM: Preallocating image memory... ");
 	start = ktime_get();
 
-	error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
-	if (error)
-		goto err_out;
-
-	error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
+	error = create_image_memory_bitmaps();
 	if (error)
 		goto err_out;
 
--
1.9.1
