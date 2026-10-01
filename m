Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941284AE102
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845911; cv=none; b=ByrqDLZ+ZLOQbg/dqSe8/mBR0oCK7518AmAnjtXesJ4F6ozim7Sohk2WwMMy8UBnt3ymAdVcMnvBKZcHRa97KJ0V68HR0dpJIKIXYa3rx14T0uWMuAM66hZFDf6A5RxznRg+n5Xz0tkWv7YR97oRgYC7jhTswTw3cnZTTa8ocSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845911; c=relaxed/simple;
	bh=d+WazRSU4VC1NB15GWvGk7DKr8Zdmm7JHR7wwGEuilA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcpTKHcQ8A0XxPIZb41Op57bGa56HV+XIzRmBeL5VOXmfRGWzfoKSOTNUpruUZh2Tfw1DRRCO8gvRsk3GgWPpym0QUGeqtwa4pjt07NLnPn2vVRDuB1TDITGHLPucY+fOUyxMfJxpeZ8xgWFBNvjMPnDH2Dk8u0d87ldE5/TwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.51 with ESMTP; 1 Oct 2026 17:41:44 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: trieu2.huynh@lge.com
Received: from unknown (HELO trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local) (10.159.39.43)
	by 156.147.1.121 with ESMTP; 1 Oct 2026 17:41:44 +0900
X-Original-SENDERIP: 10.159.39.43
X-Original-MAILFROM: trieu2.huynh@lge.com
From: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>
To: rafael@kernel.org
Cc: trieu2.huynh@lge.com,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: hibernate: exclude unusable free pages from image preallocation
Date: Thu,  1 Oct 2026 17:41:15 +0900
Message-ID: <20261001084115.2549761-1-trieu2.huynh@lge.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hibernate_preallocate_memory() derives the number of page frames to
preallocate for the image from the per-zone NR_FREE_PAGES counters.  Those
counters count every free pageblock regardless of its migratetype,
including MIGRATE_HIGHATOMIC and MIGRATE_CMA pageblocks. Such pages are
free from the buddy allocator's point of view, but they cannot be used by
the order-0, non-movable, non-reserve GFP_KERNEL allocations with which the
image is preallocated (GFP_IMAGE = GFP_KERNEL|__GFP_NOWARN).

(*) Reported free vs usable free:

The mm subsystem already accounts for this in
__zone_watermark_unusable_free() [1]. For order-0 GFP_KERNEL neither
ALLOC_RESERVES nor ALLOC_CMA is set, so the allocator subtracts the free
high-order atomic [2], and the free CMA pages from the free count before
checking the watermarks. The hibernation preallocation, however, computes
its target from the unadjusted NR_FREE_PAGES value, so it asks for about
half of the unusable pages more than the allocator can deliver.  On arm64
(no CONFIG_HIGHMEM) the highmem fallback in the failure path is a no-op,
hence even a small shortfall aborts hibernation, see [4] for example.

(*) Why those pages are not usable by GFP_KERNEL:

(**) CMA is reserved for movable allocations, so GFP_KERNEL has no
ALLOC_CMA, and MIGRATE_CMA is not in the unmovable fallback list. Free CMA
pages are therefore never handed to these allocations.

(**) The high-order atomic reserve is only handed out to atomic, order > 0,
__GFP_HIGH allocations (ALLOC_HIGHATOMIC), which GFP_KERNEL order-0 is not.
These pages can be unreserved under memory pressure [3], but only all but
one pageblock per zone and only after an allocation has already failed, so
counting them as available still overestimates what the preallocation can
obtain without failing first. Excluding them is conservative.

(*) Consequence of not excluding the unusable pages:

With M = managed, S = saveable, F = free, U = highatomic + CMA and
R = reclaimable, count = S + F - totalreserve and alloc is about count / 2,
while the allocator can actually provide about (F - U) + R pages. The
shortfall is therefore inflated by exactly U compared with the usable
memory.

From [4], with U = 11430 unusable free pages (5120 highatomic + 6310 CMA),
the preallocation target is inflated by about U / 2 = 5715 pages, while the
allocator ends up 1247 pages short and hibernation is aborted even though
the system is able to create the image.

(*) What changes after excluding the unusable pages:

Subtract U from the per-zone free accounting used to compute count and
avail_normal. Then count' = count - U and, since max_size is roughly
count / 2, max_size' = max_size - U / 2 and alloc' = alloc - U / 2.
max_size' remains well above minimum_image_size() in practice, so the
resulting image is effectively unchanged while hibernation no longer aborts
unnecessarily.

Testing
=======
(*) SA6155P running on AAOS with S2D feature
(*) backport locally on GKI 6.1

References
==========
[1] commit f27ce0e14088 ("page_alloc: consider highatomic reserve in watermark fast")
[2] commit c928807f6f6b ("mm/page_alloc: keep track of free highatomic")
[3] commit ac3f3b0a5551 ("mm: page_alloc: unreserve highatomic page blocks before oom")
[4] Example of an abort:
    Mem-Info:
     free:344621 free_pcp:931 free_cma:6310
    DMA32 free:973864kB reserved_highatomic:8192KB free_cma:25240kB
    Normal free:404620kB reserved_highatomic:12288KB free_cma:0kB
    PM: hibernation: Image allocation is 1247 pages short

Signed-off-by: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>
---
Changes since v1:
(*) Add a reference to commit c928807f6f6b, and correct the words and
quotes in the description as well.
(*) Switched from zone->nr_reserved_highatomic to
READ_ONCE(zone->nr_free_highatomic) to accurately fetch the active free
highatomic counter, reflecting c928807f6f6b (Reported by: Sashiko).

Link to v1:
(*) https://lore.kernel.org/lkml/20260921101446.1193565-1-trieu2.huynh@lge.com/

 kernel/power/snapshot.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index b209712cb2c3..195db45ce80f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1867,11 +1867,32 @@ int hibernate_preallocate_memory(void)
 	highmem = save_highmem;
 	size = 0;
 	for_each_populated_zone(zone) {
+		unsigned long free, unusable;
+
 		size += snapshot_additional_pages(zone);
+
+		/*
+		 * Pages reserved for high-order atomic allocations
+		 * (MIGRATE_HIGHATOMIC) and free CMA pages cannot be used by
+		 * the order-0 non-movable GFP_KERNEL allocations that
+		 * preallocate the image, so do not count them as available.
+		 * This mirrors __zone_watermark_unusable_free().
+		 */
+		free = zone_page_state(zone, NR_FREE_PAGES);
+		unusable = READ_ONCE(zone->nr_free_highatomic);
+#ifdef CONFIG_CMA
+		unusable += zone_page_state(zone, NR_FREE_CMA_PAGES);
+#endif
+		/*
+		 * nr_reserved_highatomic counts whole reserved pageblocks,
+		 * so it can exceed the actual free pages.
+		 */
+		unusable = min(unusable, free);
+
 		if (is_highmem(zone))
-			highmem += zone_page_state(zone, NR_FREE_PAGES);
+			highmem += free - unusable;
 		else
-			count += zone_page_state(zone, NR_FREE_PAGES);
+			count += free - unusable;
 	}
 	avail_normal = count;
 	count += highmem;
-- 
2.43.0

