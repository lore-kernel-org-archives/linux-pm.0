Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BF426D19
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675721; cv=none; b=ebq/hYal2/Y3k6HmEbfyrpC080lTC+tnDZ1e/ytSIkG3+d34dSTpdK31Xk9YA1nZtizWb3puCERxX8tdxfyL1qw4fPsosdkRfuA41ctf9DPk7G9PPoTRMfjM308nk2XnNLfS1Kgbz134pxH24foLjW4ub9/tW11UR0n3N3bgU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675721; c=relaxed/simple;
	bh=GLXrR2CnFpsGBxuXjZDHjUzrzViyjISnFoJLrUty2bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hMAWg7Vbde0DGGnIDJJC6IPgAxNBWpIJGGPc/BC5BvHJUwX8KhmnleDErXs9V6hbsKWvHvu4QmFSf39pjia55lvtaACmgAZ3/0ihGrLBrCCDLDTHh4ME4JzaQz25bfZhdnZBBgsL+3PCWlOU33WWwfwMTrCFqQvo/FkETYy98NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XV7LkcLk; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XV7LkcLk"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so4428892f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778675718; x=1779280518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jK8oWMUhgh8u2h0g/pQlZW0WDLVUtUJGpIoHocj5R7o=;
        b=XV7LkcLk/aiR2GO78oa13cdzKKm1xGbKho3YHZUucoD8jNs/6ZCZZvIyWjaFWM9kwq
         ndIDWdu0UOZMC2VyhI0QJSoBDn1y62CVOjaJHJxtrBt/bJkPM0RwmZ07k7w/WMJ/8NiL
         hxs4oSZxf6gRrQK4VRJgfhEaakA+2cudnUaPHQs34vblCGFs9j7Wl3BKnNugGr7DnbPP
         4aJlfRNpz303Se9x5RmYv37RjABvoF2QQqV0hmOLKRLZKvficpTJtXDpfuq3nhsHq727
         zj1Hru5H4yR/cv5/PlNlnzF14S+athMWn+TDvkXaw0V7WkCxMvWRqA8qAgWLdlu0fYIE
         WpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778675718; x=1779280518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jK8oWMUhgh8u2h0g/pQlZW0WDLVUtUJGpIoHocj5R7o=;
        b=GYC0GwDcT1K5cgAcNCOEhS6dIfH6y4Z0B5AGugVPfXjMEh/OvLgUxDtep+61ni1BHm
         buCbTczj4Xp9sCQDqZn+eW89J2wNUvacs5PqCHEHkr0dX76ZqKXtLSifX99wK12et9hk
         xCzVpQ9MfLCt9dG+8dCNjZ3Hgae1i00S3VXDf7CC4nB81r63DukI7McPIyeKnROKqaMU
         Hqy6+wF30J/XBYUVE7szLN3BKt1qUhIRyJBxbdxM9D4tpni8Wx5vuaDvgrfMT97R/l18
         +O+ts9dd2wovd2qGSOOcN+Oo1JkewHeeYhhIAoFKOy3IVitLtIi1IO9kZZbkJWNkGskn
         DXjA==
X-Forwarded-Encrypted: i=1; AFNElJ/juoe6NiSrjgHUobBVUdsWMZp/gDKDUA3KEaH2eRXzmX7Mhfwuv8mceaVzwcQWcA1NyGVBSMboAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUET9w4d4MAgXlVoSXxHiweho+58ccxYY6mKjy1DdE89kKXxGq
	VwyBjPBYeEhRLQLxv1PMfgf0Tv4Px+xk5EliGsto0sFijlvzbqmOnYbSy6otkqm/5udg3pRnCb/
	UZs+vG9WyPrUXDg==
X-Received: from wrbdf7.prod.google.com ([2002:a5d:5b87:0:b0:44b:16d7:6b87])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1acd:b0:44b:c220:f8ce with SMTP id ffacd0b85a97d-45c5762d633mr4903489f8f.6.1778675717362;
 Wed, 13 May 2026 05:35:17 -0700 (PDT)
Date: Wed, 13 May 2026 12:35:14 +0000
In-Reply-To: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20260513-page_alloc-unmapped-prep-v1-2-dacdf5402be8@google.com>
Subject: [PATCH 2/4] mm/page_alloc: don't overload migratetype in find_suitable_fallback()
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This function currently returns a signed integer that encodes status
in-band, as negative numbers, along with a migratetype. Switch to a more
explicit/verbose style that encodes the status and migratetype
separately.

In the spirit of making things more explicit, also create an enum to
avoid using magic integer literals with special meanings. This enables
documenting the values at their definition instead of in one of the
callers.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/compaction.c |  3 ++-
 mm/internal.h   | 14 +++++++++++---
 mm/page_alloc.c | 40 +++++++++++++++++++++++-----------------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 3648ce22c80728b894cffce502d8caa3e4532406..168e63940b78247e08aef8b177a4c68adb36db31 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2340,7 +2340,8 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 		 * Job done if allocation would steal freepages from
 		 * other migratetype buddy lists.
 		 */
-		if (find_suitable_fallback(area, order, migratetype, true) >= 0)
+		if (find_suitable_fallback(area, order, migratetype, true, NULL)
+		    == FALLBACK_FOUND)
 			/*
 			 * Movable pages are OK in any pageblock. If we are
 			 * stealing for a non-movable allocation, make sure
diff --git a/mm/internal.h b/mm/internal.h
index 5a2ddcf68e0b6d1a9fbaeae07670dd252729f96a..09931b1e535f3f71887b5b6473f93ed21a41c7e7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1104,9 +1104,17 @@ static inline void init_cma_pageblock(struct page *page)
 }
 #endif
 
-
-int find_suitable_fallback(struct free_area *area, unsigned int order,
-			   int migratetype, bool claimable);
+enum fallback_result {
+	/* Found suitable migratetype, *mt_out is valid. */
+	FALLBACK_FOUND,
+	/* No fallback found in requested order. */
+	FALLBACK_EMPTY,
+	/* Passed @claimable, but claiming whole block is a bad idea. */
+	FALLBACK_NOCLAIM,
+};
+enum fallback_result
+find_suitable_fallback(struct free_area *area, unsigned int order,
+		       int migratetype, bool claimable, int *mt_out);
 
 static inline bool free_area_empty(struct free_area *area, int migratetype)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c9edffe968ac25b8cd9f6f983bf4c9ba21e73a11..91d83c967bd478982e0161a99d47d3a76bd89992 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2249,25 +2249,29 @@ static bool should_try_claim_block(unsigned int order, int start_mt)
  * we would do this whole-block claiming. This would help to reduce
  * fragmentation due to mixed migratetype pages in one pageblock.
  */
-int find_suitable_fallback(struct free_area *area, unsigned int order,
-			   int migratetype, bool claimable)
+enum fallback_result
+find_suitable_fallback(struct free_area *area, unsigned int order,
+		       int migratetype, bool claimable, int *mt_out)
 {
 	int i;
 
 	if (claimable && !should_try_claim_block(order, migratetype))
-		return -2;
+		return FALLBACK_NOCLAIM;
 
 	if (area->nr_free == 0)
-		return -1;
+		return FALLBACK_EMPTY;
 
 	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
 		int fallback_mt = fallbacks[migratetype][i];
 
-		if (!free_area_empty(area, fallback_mt))
-			return fallback_mt;
+		if (!free_area_empty(area, fallback_mt)) {
+			if (mt_out)
+				*mt_out = fallback_mt;
+			return FALLBACK_FOUND;
+		}
 	}
 
-	return -1;
+	return FALLBACK_EMPTY;
 }
 
 /*
@@ -2377,16 +2381,16 @@ __rmqueue_claim(struct zone *zone, int order, int start_migratetype,
 	 */
 	for (current_order = MAX_PAGE_ORDER; current_order >= min_order;
 				--current_order) {
-		area = &(zone->free_area[current_order]);
-		fallback_mt = find_suitable_fallback(area, current_order,
-						     start_migratetype, true);
+		enum fallback_result result;
 
-		/* No block in that order */
-		if (fallback_mt == -1)
+		area = &(zone->free_area[current_order]);
+		result = find_suitable_fallback(area, current_order,
+						start_migratetype, true, &fallback_mt);
+
+		if (result == FALLBACK_EMPTY)
 			continue;
 
-		/* Advanced into orders too low to claim, abort */
-		if (fallback_mt == -2)
+		if (result == FALLBACK_NOCLAIM)
 			break;
 
 		page = get_page_from_free_area(area, fallback_mt);
@@ -2416,10 +2420,12 @@ __rmqueue_steal(struct zone *zone, int order, int start_migratetype)
 	int fallback_mt;
 
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
+		enum fallback_result result;
+
 		area = &(zone->free_area[current_order]);
-		fallback_mt = find_suitable_fallback(area, current_order,
-						     start_migratetype, false);
-		if (fallback_mt == -1)
+		result = find_suitable_fallback(area, current_order, start_migratetype,
+						false, &fallback_mt);
+		if (result == FALLBACK_EMPTY)
 			continue;
 
 		page = get_page_from_free_area(area, fallback_mt);

-- 
2.51.2

