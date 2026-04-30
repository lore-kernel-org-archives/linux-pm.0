Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7F3A5E91;
	Thu, 30 Apr 2026 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580583; cv=none; b=QKwVi8L5aLfh9JI2gaSeTzMbzjBpnTihRN8TXguaVVJmtPYQ+alvXA7MDYm7Qxh5WdrG8bm/d1r8/mfkfOo71uTQt4hQy9czAi32V1v390bQ3y9mdp+kCsdFNmhlGcRL6vj9ikrUSOJIXbIm4+tSQEds+uHr8Ym+SNQhwkAmEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580583; c=relaxed/simple;
	bh=pnXAYOs30mVhnVtkGUlwcw+5YUy2HELOjT7tzuuMzww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8JIp2r2P8uzcTH25C9GMxsXI0Us8t/fWrra0KzT2ZkLZlMxKHJ/wDKR5mUZ9mid7/ehdlfJVcmtvyMXyneRIZSZhZkG1sNZL8tAkZAFM725rwGYNYT3amDeY6Nmch0Lres91KQ1C/NrddqTRr4hBxqrkXyqN7MB38wO8p/3KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=K2Xu+q0t; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="K2Xu+q0t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bwbYmQVONNFpRoy+LHkanYVTDHsfJ9bQknKONF3uXUc=; b=K2Xu+q0t/1gTbY57QvJ6yUbQk0
	uWSz2Wt0MWjd3Xo7TqN6ZNWzFQRibo5tG6vNnRNhcpyFGM/ALsgQK1HP4OH2zxfL1JOFT2ULrWg1+
	Rvf3o8uGCi/T50BgoClLgdnLkq5I/rAHnrcgk6i84F2hC/W4D4fycnaaWD2uMuLRh8AURRzIOGHbI
	xb8ooNhZJTi/0eUAkkJcyohq0Oo892yLrRJyPsPBP7L+VrTPckbHbCQoorPafdfd2jMnURjQXPl1F
	18twvp/TrWKV5BiDSfVcCbPOUcOK/o1r5L4XTT+/DhhWW7Ma2lcYJfPPC8Bgs9qkM3MS5c4bdiA2O
	72tGySBA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wIXuD-000000001R0-1tn0;
	Thu, 30 Apr 2026 16:22:41 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	linux-mm@kvack.org,
	david@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	hannes@cmpxchg.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	usama.arif@linux.dev,
	Rik van Riel <riel@meta.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [RFC PATCH 40/45] PM: hibernate: walk per-superpageblock free lists in mark_free_pages
Date: Thu, 30 Apr 2026 16:21:09 -0400
Message-ID: <20260430202233.111010-41-riel@surriel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430202233.111010-1-riel@surriel.com>
References: <20260430202233.111010-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@meta.com>

mark_free_pages() walks the buddy allocator's free lists and calls
swsusp_set_page_free() on each free page so it is omitted from the
hibernation image. After the SPB rework, free pages live on per-
superpageblock free lists rather than the zone-level free list, so
the existing list_for_each_entry() walk over zone->free_area[order]
.free_list[t] found nothing. The hibernation snapshot then treated
every free page as needing to be saved, wasting image space and risking
OOM during the snapshot.

Wrap the existing per-page walk in an SPB iteration loop. When the
zone has no SPBs (e.g. an unpopulated hotplug zone), fall back to the
zone-level free list. The whole function still runs under
spin_lock_irqsave(&zone->lock) without drops, so there are no lock-
order or hotplug concerns.

Note: kernel/power/snapshot.o currently fails to build with
-Werror=return-type due to an unrelated pre-existing warning in
enough_free_mem(). This patch was reviewed but not build-tested in
isolation; the change itself is mechanical.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Assisted-by: Claude:claude-opus-4.7 syzkaller
---
 kernel/power/snapshot.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 6e1321837c66..682c3bf2ba8b 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1270,17 +1270,32 @@ static void mark_free_pages(struct zone *zone)
 	}
 
 	for_each_migratetype_order(order, t) {
-		list_for_each_entry(page,
-				&zone->free_area[order].free_list[t], buddy_list) {
-			unsigned long i;
-
-			pfn = page_to_pfn(page);
-			for (i = 0; i < (1UL << order); i++) {
-				if (!--page_count) {
-					touch_nmi_watchdog();
-					page_count = WD_PAGE_COUNT;
+		unsigned long sb_idx;
+		unsigned long nr_lists = zone->nr_superpageblocks ? : 1;
+
+		/*
+		 * After the SPB rework, free pages live on per-superpageblock
+		 * free lists. Walk every SPB's list for this (order, mt) cell.
+		 * If the zone has no SPBs (unpopulated zone), fall back to the
+		 * zone-level list head so that any pre-SPB pages are still
+		 * marked.
+		 */
+		for (sb_idx = 0; sb_idx < nr_lists; sb_idx++) {
+			struct list_head *list = zone->nr_superpageblocks ?
+				&zone->superpageblocks[sb_idx].free_area[order].free_list[t] :
+				&zone->free_area[order].free_list[t];
+
+			list_for_each_entry(page, list, buddy_list) {
+				unsigned long i;
+
+				pfn = page_to_pfn(page);
+				for (i = 0; i < (1UL << order); i++) {
+					if (!--page_count) {
+						touch_nmi_watchdog();
+						page_count = WD_PAGE_COUNT;
+					}
+					swsusp_set_page_free(pfn_to_page(pfn + i));
 				}
-				swsusp_set_page_free(pfn_to_page(pfn + i));
 			}
 		}
 	}
-- 
2.52.0

