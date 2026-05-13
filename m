Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEF43D50D
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675723; cv=none; b=uq2LHGNfiV1VJFTjWb7KexRa3Vh7sSxgjPwM7pcjL6/d6F/j+YoCbC+tmlCveJeS3COZm4n3wqFqs1DkzyLw0FzybMqe9i6dFG5ChSNmbQZhH7vzuJ5CD7hmwFJEsaVDybVCSORE8H/FJAA+xalZfeUQzNHoKxretGANOJCj8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675723; c=relaxed/simple;
	bh=hIW5qNVwHhdoiSIcY8kmhcu+ilfQ1veen9WmaiIpw3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aGaMjKuvSyGBhyMMzJXGCCOX5904M8TzbbDF2Pg1pPUJf7xHz6nYT+Is4UDxRtjpyrwXKptKnt1lv2cfNXQ3Yd8W+Zj8ZzunOAgYxpCF74zD16yKVcMwQ6gGr2I6qXmTEfwbwBTstxB6wwbsmMh+OcgvPR7zBqwS4oudfAbhbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPZ3Xt40; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPZ3Xt40"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45b7ff2140eso1550652f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778675720; x=1779280520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQev7kNyu1JquEWKDjbbV4w/SlArzFcQsccQoFbUKmI=;
        b=UPZ3Xt40JEvPAhBQkoWpAbJrBarPTucEUyakCkE5IxroyrTCxLKdXOCle2svZF2el/
         yyAMUo3CTTgxNwEIu4K3v4A8gommdk1kD25g+fazvHV/6Dnzj+w0uhusfGi+FCUHxvPE
         zNqmUWIYpzAfSOyI3Z62bYC7ql8YN1natO1qywJqZ/UvyZlnhrFLyL3mUBSiq1/054/g
         jYrrzn+t2hRyADrSgTrg/5n5TY7dHaDv3IP5E6l43PMAf5lpG6z1+urKiR5Sxrae1zDW
         rmVbNsDTAik7eWJSRpMO9WP0g302mbP8T22vl9ico3Kw/I6TIKxfiiWBmpcw3kxbaELh
         LfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778675720; x=1779280520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQev7kNyu1JquEWKDjbbV4w/SlArzFcQsccQoFbUKmI=;
        b=tADnFFr0+jl0Xio3IIkdFE2VjjkJJs88J3RIj2284AVBu9z13owWUtKuRTT9KKOoXc
         6GkpTAiyZQ5vKUoaQMFji7NqYo8gEfej13RE3LZy77qaCZvSj+knWYeY1y2gFlU3ebTT
         f8aee51E0jJ8cSVDcjrd3zRMMJ+OVtdrODcvC7a55LvmUgEosO5PXuUamHtscsbvds9J
         EehePFTC0bwPUiI3VhYfv9lu6QpKihqpN8cxy23X7pBFqjdy9VP4E3cC9MJcZFWVP3ov
         JQCuWnISVIUg8xPXqeQJWvM9UylamdaS7F39jsxnPub0g7DsQ5bUYPto+IYLFjFjapbj
         bozQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Q+X27SS0axz2UUD0s8YCpdIJabGfAWxMfIDglcBHbauUmIHjK9Z0r+CXRAAwWEIZIJIsChuPg/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdjYxGUa98l4wSGN6+LnRbiy49VdEvZFIOqnFno0eleiq27SM
	fbkX4rISZAtQCHx8FMKVLD7o1pr9RkoApeLAQv9ojU+Z9Q2uJswUPaSuO/iOgOOM1FOqPLa+ogB
	rq8oW6m/crBItFQ==
X-Received: from wruh9.prod.google.com ([2002:a5d:6889:0:b0:444:bd72:fec6])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:144c:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45c580ce3abmr4261824f8f.4.1778675719914;
 Wed, 13 May 2026 05:35:19 -0700 (PDT)
Date: Wed, 13 May 2026 12:35:16 +0000
In-Reply-To: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20260513-page_alloc-unmapped-prep-v1-4-dacdf5402be8@google.com>
Subject: [PATCH 4/4] mm/page_alloc: remove ifdefs from pindex helpers
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

The ifdefs are not technically needed here, everything used here is
always defined.

Switching to IS_ENABLED() makes the code a bit less tiresome to read.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5d6144c8860ed10fd641184f389c4953465d5178..2985ad0ab1044bdfda8ccc7aaed2ded19b5ac7ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -650,19 +650,17 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		bool movable = migratetype == MIGRATE_MOVABLE;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	bool movable;
-	if (order > PAGE_ALLOC_COSTLY_ORDER) {
-		VM_BUG_ON(!is_pmd_order(order));
+		if (order > PAGE_ALLOC_COSTLY_ORDER) {
+			VM_BUG_ON(!is_pmd_order(order));
 
-		movable = migratetype == MIGRATE_MOVABLE;
-
-		return NR_LOWORDER_PCP_LISTS + movable;
+			return NR_LOWORDER_PCP_LISTS + movable;
+		}
+	} else {
+		VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
 	}
-#else
-	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-#endif
 
 	return (MIGRATE_PCPTYPES * order) + migratetype;
 }
@@ -671,12 +669,12 @@ static inline int pindex_to_order(unsigned int pindex)
 {
 	int order = pindex / MIGRATE_PCPTYPES;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex >= NR_LOWORDER_PCP_LISTS)
-		order = HPAGE_PMD_ORDER;
-#else
-	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-#endif
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		if (pindex >= NR_LOWORDER_PCP_LISTS)
+			order = HPAGE_PMD_ORDER;
+	} else {
+		VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
+	}
 
 	return order;
 }

-- 
2.51.2

