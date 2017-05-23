From: BaoJun Luo <baojun.luo@samsung.com>
Subject: [PATCH] PM/hibernate: Delete the redundant parameters of the
 swsusp_alloc()
Date: Tue, 23 May 2017 09:47:13 +0800
Message-ID: <14144.1925465644$1505300903@news.gmane.org>
References: <CGME20170523014807epcas1p44d542b7f3bb7ed19f05a11b874231c55@epcas1p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:47465 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbdEWBsK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 21:48:10 -0400
Content-language: zh-cn
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz
Cc: linux-pm@vger.kernel.org

>From 2a91f46951c676a96621ab7505e168a2dc619064 Mon Sep 17 00:00:00 2001
From: "baojun.luo" <baojun.luo@samsung.com>
Date: Mon, 22 May 2017 15:30:19 +0800
Subject: [PATCH] PM/hibernate: Delete the redundant parameters of the
 swsusp_alloc()

The first parameter of swsusp_alloc has not been used. The patch to make
sure to delete the redundant parameters

Signed-off-by: baojun.luo <baojun.luo@samsung.com>
---
 kernel/power/snapshot.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 3b1e0f3..0f8a039 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1929,8 +1929,7 @@ static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
  * also be located in the high memory, because of the way in which
  * copy_data_pages() works.
  */
-static int swsusp_alloc(struct memory_bitmap *orig_bm,
-			struct memory_bitmap *copy_bm,
+static int swsusp_alloc(struct memory_bitmap *copy_bm,
 			unsigned int nr_pages, unsigned int nr_highmem)
 {
 	if (nr_highmem > 0) {
@@ -1976,7 +1975,7 @@ asmlinkage __visible int swsusp_save(void)
 		return -ENOMEM;
 	}
 
-	if (swsusp_alloc(&orig_bm, &copy_bm, nr_pages, nr_highmem)) {
+	if (swsusp_alloc(&copy_bm, nr_pages, nr_highmem)) {
 		printk(KERN_ERR "PM: Memory allocation failed\n");
 		return -ENOMEM;
 	}
-- 
1.9.1
