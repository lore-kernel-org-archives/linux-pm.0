Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A43EFFC2;
	Wed, 20 May 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289259; cv=none; b=Br6lSCcn482EonEqH92nIAzAOkrrWiWjbP5/GX8aOqahYH17GBboYJb7zqP5Jc+fgIeIK8SLEIiNCbI8n8bU5Yup6J2s4onZlDxYsSCSkTmZC389lf58lQjUjidhHg7GxHFL6MYvuzxrHLmNxQbimf0yoXqfqjzqHx6ccdVgokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289259; c=relaxed/simple;
	bh=h4YAvjMwugtBeP5rgTTnM3/4ur6xJ+sNlmMg9e/BRN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8wuTSr37y/yQ2szr4S6MyLrbNpu8FPFpKz66t59hxd6C0tVlBOwWfVaGX76xv17YizFZQeWHsRxglYqjdoq88zN6vdqhxKgHdAFnF7HDBB49CFQmkFdZBkmMVHAE3gmbMub12dfyy96T++ir8UpMtbiR7bOR3dXq+v9WcSMEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=f5AW/Fqk; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="f5AW/Fqk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kgTR8MXGEfuZkiCxXrjBV2lPgK1Sp/fx+wzmK8Ohvys=; b=f5AW/FqkAgj7z0DGFu9w4cBw2N
	WcrdccVsn6mnShQ3g+LF1B382noR9hBdYJxGn2eAt8L+SrCyApBFclSQV+UcMOEFo62dnI6hwc8M6
	KEIegcWCFXj4oFpj4WW7RW7A2hmyIiz0pIEx0sJzTVKVDfSM2TZWBjCa8WqwzSzmYaGsLBICkVHEr
	RClmwLZr/1msvSbgFj+2fhtj6LXzNBAhcoIuH6P8IW1To04EhBbRJa/tFv7ERy5EP1AJRpbqTqI35
	8FJMQtiQKZ+VO6kHdehJgW+gCdOWvXTFr0tcQHRcVGWMpYiZYgJiqHq8wEXb1OUON+kH4t0c1l95x
	kkRVT+sw==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wPiPM-0000000024Q-3zfV;
	Wed, 20 May 2026 11:00:28 -0400
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
	fvdl@google.com,
	Rik van Riel <riel@surriel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 33/40] PM: hibernate: walk per-superpageblock free lists in mark_free_pages
Date: Wed, 20 May 2026 10:59:39 -0400
Message-ID: <20260520150018.2491267-34-riel@surriel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520150018.2491267-1-riel@surriel.com>
References: <20260520150018.2491267-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Build-tested as part of the full mm series; kernel/power/snapshot.o
compiles cleanly in that build.  An -Werror=return-type warning in
enough_free_mem() exists on some configurations but is unrelated to
this change and predates the SPB series.

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
index a564650734dc..f96885bc46f8 100644
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
2.54.0

