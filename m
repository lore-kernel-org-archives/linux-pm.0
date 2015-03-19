From: "Tom(JeHyeon) Yeon" <tomyeon750415lkml@gmail.com>
Subject: [PATCH] PM / Hiberante : optimize swsusp_free()
Date: Thu, 19 Mar 2015 17:28:58 +0900
Message-ID: <1426753738-26747-1-git-send-email-tom.yeon@windriver.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f196.google.com ([209.85.192.196]:33156 "EHLO
	mail-pd0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbCSI3X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 04:29:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pavel@ucw.cz, len.brown@intel.com, jroedel@suse.de, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Tom(JeHyeon) Yeon" <tom.yeon@windriver.com>

From: "Tom(JeHyeon) Yeon" <tom.yeon@windriver.com>

I tested the performance of swsusp_free operation.
The free time took about 58768us before commit fdd64ed, and
the free time took about 40535us after the commit fdd64ed.

But, I optimized the function before I saw commit fdd64ed.
So, I applied the patch in my system.(ARM Coretex A9, Dual Core 1GHz)
The free time took about 35164us.
I think that the finding routine for the same pfn is redundant

Signed-off-by: Tom(JeHyeon) Yeon <tom.yeon@windriver.com>
---
 kernel/power/snapshot.c |   43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c24d5a2..a1ad801 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -726,14 +726,6 @@ static void memory_bm_clear_bit(struct memory_bitmap *bm, unsigned long pfn)
 	clear_bit(bit, addr);
 }
 
-static void memory_bm_clear_current(struct memory_bitmap *bm)
-{
-	int bit;
-
-	bit = max(bm->cur.node_bit - 1, 0);
-	clear_bit(bit, bm->cur.node->data);
-}
-
 static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
 {
 	void *addr;
@@ -1342,36 +1334,21 @@ static struct memory_bitmap copy_bm;
 
 void swsusp_free(void)
 {
-	unsigned long fb_pfn, fr_pfn;
+	unsigned long pfn;
 
 	if (!forbidden_pages_map || !free_pages_map)
 		goto out;
 
 	memory_bm_position_reset(forbidden_pages_map);
-	memory_bm_position_reset(free_pages_map);
-
-loop:
-	fr_pfn = memory_bm_next_pfn(free_pages_map);
-	fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
-
-	/*
-	 * Find the next bit set in both bitmaps. This is guaranteed to
-	 * terminate when fb_pfn == fr_pfn == BM_END_OF_MAP.
-	 */
-	do {
-		if (fb_pfn < fr_pfn)
-			fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
-		if (fr_pfn < fb_pfn)
-			fr_pfn = memory_bm_next_pfn(free_pages_map);
-	} while (fb_pfn != fr_pfn);
-
-	if (fr_pfn != BM_END_OF_MAP && pfn_valid(fr_pfn)) {
-		struct page *page = pfn_to_page(fr_pfn);
-
-		memory_bm_clear_current(forbidden_pages_map);
-		memory_bm_clear_current(free_pages_map);
-		__free_page(page);
-		goto loop;
+	for ( ; ; ) {
+		pfn  = memory_bm_next_pfn(forbidden_pages_map);
+		if (BM_END_OF_MAP == pfn)
+			break;
+		if (memory_bm_test_bit(free_pages_map, pfn)) {
+			memory_bm_clear_bit(forbidden_pages_map, pfn);
+			memory_bm_clear_bit(free_pages_map, pfn);
+			__free_page(pfn_to_page(pfn));
+		}
 	}
 
 out:
-- 
1.7.9.5

