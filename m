From: Wonhong Kwon <wonhongkwon@gmail.com>
Subject: [PATCH] PM / hibernate: take freed pages into account for preallocated memory
Date: Tue,  3 Feb 2015 17:22:00 +0900
Message-ID: <1422951720-29020-1-git-send-email-wonhong.kwon@lge.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41793 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbbBCIWe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 03:22:34 -0500
Received: by mail-pa0-f49.google.com with SMTP id fa1so93440478pad.8
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 00:22:33 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc: linux-pm@vger.kernel.org, gunho.lee@lge.com, Wonhong Kwon <wonhong.kwon@lge.com>

hibernate_preallocate_memory() prints out that how many pages are
allocated, but it doesn't take into consideration the pages freed by
free_unnecessary_pages(). Therefore, it always shows the count more
than actually allocated.

Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
---
 kernel/power/snapshot.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 0c40c16..3a47dcd 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1472,9 +1472,9 @@ static inline unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
 /**
  * free_unnecessary_pages - Release preallocated pages not needed for the image
  */
-static void free_unnecessary_pages(void)
+static unsigned long free_unnecessary_pages(void)
 {
-	unsigned long save, to_free_normal, to_free_highmem;
+	unsigned long save, to_free_normal, to_free_highmem, free;
 
 	save = count_data_pages();
 	if (alloc_normal >= save) {
@@ -1495,6 +1495,7 @@ static void free_unnecessary_pages(void)
 		else
 			to_free_normal = 0;
 	}
+	free = to_free_normal + to_free_highmem;
 
 	memory_bm_position_reset(&copy_bm);
 
@@ -1518,6 +1519,8 @@ static void free_unnecessary_pages(void)
 		swsusp_unset_page_free(page);
 		__free_page(page);
 	}
+
+	return free;
 }
 
 /**
@@ -1707,7 +1710,7 @@ int hibernate_preallocate_memory(void)
 	 * pages in memory, but we have allocated more.  Release the excessive
 	 * ones now.
 	 */
-	free_unnecessary_pages();
+	pages -= free_unnecessary_pages();
 
  out:
 	stop = ktime_get();
-- 
1.7.9.5

