From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Tue, 23 Sep 2014 19:27:06 +0200
Message-ID: <878ulaxn6d.fsf@nemi.mork.no>
References: <87zjdq8k7i.fsf@nemi.mork.no> <2218322.ridXK8jFtJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:55777 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbaIWR3K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Sep 2014 13:29:10 -0400
In-Reply-To: <2218322.ridXK8jFtJ@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Tue, 23 Sep 2014 17:24:46 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:


> I would suspect one of these commits:
>
> 84c91b7ae07c PM / hibernate: avoid unsafe pages in e820 reserved regions
> 0f7d83e85dbd PM / Hibernate: Touch Soft Lockup Watchdog in rtree_next_node
> 9047eb629e5c PM / Hibernate: Remove the old memory-bitmap implementation
> 6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFNs in sws=
usp_free()
> 3a20cb177961 PM / Hibernate: Implement position keeping in radix tree
> 07a338236fdc PM / Hibernate: Add memory_rtree_find_bit function
> f469f02dc6fa PM / Hibernate: Create a Radix-Tree to store memory bitmap
>
> so I guess you can start from checking them (the topmpost one is the late=
st).

Thanks.  Yes, you were correct. The bad commit is

 6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFNs in swsu=
sp_free()

I have confirmed that reverting only this commit on top of a clean
v3.17-rc6 fixes the problem.  I am attaching the context-modified revert
patch I used.


Bj=C3=B8rn


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Revert-PM-Hibernate-Iterate-over-set-bits-instead-of.patch

>From 92950fd86c2f74ae17840bfc15651b6ae77e43df Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Date: Tue, 23 Sep 2014 19:18:43 +0200
Subject: [PATCH] Revert "PM / Hibernate: Iterate over set bits instead of
 PFNs in swsusp_free()"

This reverts commit 6efde38f07690652bf0d93f5e4f1a5f496574806.

Conflicts:
	kernel/power/snapshot.c
---
 kernel/power/snapshot.c |   50 ++++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c4b8093c80b3..f1604d8cf489 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -725,14 +725,6 @@ static void memory_bm_clear_bit(struct memory_bitmap *bm, unsigned long pfn)
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
@@ -1341,35 +1333,23 @@ static struct memory_bitmap copy_bm;
 
 void swsusp_free(void)
 {
-	unsigned long fb_pfn, fr_pfn;
-
-	memory_bm_position_reset(forbidden_pages_map);
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
+	struct zone *zone;
+	unsigned long pfn, max_zone_pfn;
 
-		memory_bm_clear_current(forbidden_pages_map);
-		memory_bm_clear_current(free_pages_map);
-		__free_page(page);
-		goto loop;
+	for_each_populated_zone(zone) {
+		max_zone_pfn = zone_end_pfn(zone);
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			if (pfn_valid(pfn)) {
+				struct page *page = pfn_to_page(pfn);
+
+				if (swsusp_page_is_forbidden(page) &&
+				    swsusp_page_is_free(page)) {
+					swsusp_unset_page_forbidden(page);
+					swsusp_unset_page_free(page);
+					__free_page(page);
+				}
+			}
 	}
-
 	nr_copy_pages = 0;
 	nr_meta_pages = 0;
 	restore_pblist = NULL;
-- 
1.7.10.4


--=-=-=--
