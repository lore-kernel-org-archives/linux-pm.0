Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C63D669A
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779059164; cv=none; b=mZXiskJxAvN9ciO6Jyi0QIhFbwA6foBsAZEGoprJuV87AFrdIH44Wk6rc+i7K5WDdabE/n80a478qyF2U+9v/vwC+WJLe5+ciKChf8vbH9u1ntb+dQXAOXNKOxC86VpAooHqmn6eODOZrkZbZIfhpd5iNEDWyUsRyhYfyA3xFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779059164; c=relaxed/simple;
	bh=GEIPvyLRYiAIqR/pv5iDg5p2UGFOLxobthzFMY7jTPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CIQsfsh5iKbtOVpSe4pAP/Leh+dLlt3V4PG99rHOQB34a65OREaaVv3gq/fVx0xevd+C9dUdJ77P1LXt7QuFPdbY/cDOQLZ/XIDLdHBHesBrT8qfeHLkvoEwd0KC7/TFn3w4ug1AqPJ7M2vHsFqF/TJ2Z0rgBIv8+Q+gGnmBSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMxAZcKZ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMxAZcKZ"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45e80183514so16714f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779059161; x=1779663961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RucpAInGrAJfsY0XRVsWleuNH9XqB7VdVnWXH3TZFzQ=;
        b=HMxAZcKZo6UMiKXrWkbygtZ82cjEB5f6r6WkYgBe9L0UAZT/cpo5UBpYvA6TjuDRBc
         q1bbXcLZcs05+4sdL4HEjRSsYnsOrqBaUjvqqalO7Yif4WLaoRRhL2Bkjrkjut61Vx/I
         omeKPHQgbEl31ecdePbeVjb+/tPZflhVHCz4ZfivaX3upFRhWQ/bxm+pjNEfi2xRf+4N
         as71sYxHFmnXBmOt6bA9F1oJh3EDLvOgs7aBMU/RKQTziPsK2tpL+l3bCztRTdRBeIEt
         8Mkpy27/qHSee0EW/7xZlPVcixqcfPAWh890UVxVZkZevNLI3ySDe9NJlR39KwQ32L/N
         lIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779059161; x=1779663961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RucpAInGrAJfsY0XRVsWleuNH9XqB7VdVnWXH3TZFzQ=;
        b=TzdZBPUOl9gHrG47mt8cSxDGlysFV9WcrnHKQfgOruKBojluYE9kqLe+pJZL9PeVx4
         RjIvn2/hpoRtcqreNBimvivWhzWEcphA9jeHnAAYVXet+fuMyIQGMTmX1s+gRBUUphHQ
         X2deREmhpm+2/AS6aOg4d0HiyFEYAZC7a6nyL83AFp4GJBCAc9dcDlDELFzMZVSiotdH
         +qcvDY3orprM7GCzW0QVUwHOPiLVYPeveWdJEbiM65DWgTYykO9/1hgRYjH5PdwSosnx
         NYyk0MCE2U2nhVH6QTjB5omh608vcsImRzD8vfnwraH+9Iplu169YjUladDAf3qhbc6h
         FOdg==
X-Forwarded-Encrypted: i=1; AFNElJ/FC0dx3nhikgIyNqAhn+d0dCD6oH8GRHG9FgP6vQjCSCWREHyDdIODYuedD+GXq4BRtxaHdqjm5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1sbKGHs5Pkz77Xd4OcBZ0GjuW89lT29E3TWkSBfP+/6d/019
	MHDH9/sI84kGIWmcFG1JpwdGWkXXsMRDSwLrvc5ug7S4Jw6mP4w4auLH6nHjHipddOJQB2ILVHs
	rmVQ64JniEeFV/Q==
X-Received: from wrxn17.prod.google.com ([2002:a5d:6b91:0:b0:43c:f700:880f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e1b:b0:48a:8905:a500 with SMTP id 5b1f17b1804b1-48fe60da647mr202718675e9.12.1779059161517;
 Sun, 17 May 2026 16:06:01 -0700 (PDT)
Date: Sun, 17 May 2026 23:05:56 +0000
In-Reply-To: <4074a816-9e75-45a6-8141-25459bcc106b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <4074a816-9e75-45a6-8141-25459bcc106b@kernel.org>
X-Mailer: git-send-email 2.51.2
Message-ID: <20260517230556.590677-1-jackmanb@google.com>
Subject: [PATCH v2] mm/page_alloc: tidy up pindex helpers
From: Brendan Jackman <jackmanb@google.com>
To: vbabka@kernel.org
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	david@kernel.org, hannes@cmpxchg.org, jackmanb@google.com, kasong@tencent.com, 
	lenb@kernel.org, liam@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, ljs@kernel.org, mhocko@suse.com, 
	pavel@kernel.org, qi.zheng@linux.dev, rafael@kernel.org, rppt@kernel.org, 
	shakeel.butt@linux.dev, surenb@google.com, weixugc@google.com, 
	yuanchu@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

The ifdefs are not technically needed here, everything used here is
always defined, so switch to IS_ENABLED() to make things a little less
tiresome to read.

Also, Vlastimil pointed out that the VM_BUG_ON()s have fallen out of
favour, so remove them.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

>> And it's all internal to page alloc so I'd just drop those checks
>> completely at this point.
>
> But, I won't die on the above hill, if people really hate BUG that much
> happy to go with the flow.
>
> In that case, I'd suggest we drop them as a separate patch.

Oh, actually no, the VM_BUG_ONs were the main thing making the ifdefs
awkward, it makes sense to drop them together. Here's a combined patch.

 mm/page_alloc.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5d6144c8860ed..76d5d9464e2ef 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -650,19 +650,12 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		bool movable = migratetype == MIGRATE_MOVABLE;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	bool movable;
-	if (order > PAGE_ALLOC_COSTLY_ORDER) {
-		VM_BUG_ON(!is_pmd_order(order));
-
-		movable = migratetype == MIGRATE_MOVABLE;
-
-		return NR_LOWORDER_PCP_LISTS + movable;
+		if (order > PAGE_ALLOC_COSTLY_ORDER)
+			return NR_LOWORDER_PCP_LISTS + movable;
 	}
-#else
-	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-#endif
 
 	return (MIGRATE_PCPTYPES * order) + migratetype;
 }
@@ -671,12 +664,10 @@ static inline int pindex_to_order(unsigned int pindex)
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
+	}
 
 	return order;
 }
-- 
2.51.2

