Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7DE4279E6
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675721; cv=none; b=jtZ1ZzHzCo2Io0hsxGR6MaNvFEgk+vItySxaUBhXatgBGBOFt6SuMM06TbgvCv6SL2YwXZrgAOWeUJ6uSlWC+SA0ufPeUy3kpiPkQkqcW1yUkfvPSB3Wi/xdboxViNJ7MfErEKR7SFNbssQt+oI1QudVV1hdSwWVVYPxP4f6MFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675721; c=relaxed/simple;
	bh=6oBZEPvbhbq0m4/sCOO1SmKKtanv3Zg0HUty27Kvidk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UmE9T4CoUou+uh8uE69mkDq0nfpL7+3ISYpCrvqxMZYgC5os80viqyM+7X+AwAm6D/CqQsPU8gN8L8uxLXTk9VrUXBU0fL7wV1cSn7ynsuvr1ZYKlTrJXyzESplblr/eiF70A47szjUw4RFR09Js9am8WfQwJiTOWktoAaVhi2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/i59tdZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/i59tdZ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48919890a95so47148095e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778675719; x=1779280519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLzi6slHGxfhu4Y8NlwXvD2GZX7MC6Ih+pKGkr9pVTY=;
        b=b/i59tdZQRofgZu2NK7bQsHu/OS164z0IkSbBIXtTZeYY5QiRYnWaHppswrlT73Nop
         ucgq/aGXGt5H/ghh3Y1aQ+HoCJpLpzW9d4PeIwrkAkv7FKJkpjD/xHW9JpFBBcS/DmWR
         /QzIV/zMtORyrjZ8SNNco6qha124vptNImAVpDvmztwI7LxAX2E2T8+XNEznUupgXIGf
         XNk0yotBWODdW9gftAVzOD5IzExQN2zsfg4Tq4+fx2BqBUgGAUTuk6ZVjNotCVXd52DX
         i88rGx9+lgt4bG4R5RKs3+9LCL6uzyXZ/jLC+11vnNyhluj0SHEaBTpjiT0sA88g1q8y
         uAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778675719; x=1779280519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLzi6slHGxfhu4Y8NlwXvD2GZX7MC6Ih+pKGkr9pVTY=;
        b=ju/uCPuU5wHCCJl8avSn0nQwj3fEqQ3cGs0kxF6/B35lG1Y+bqRrwHuDEOPgVCQll2
         Ja1sQwt5TGCimYHSZppuWb7VOq6Nlct8WftDEkRYfPgLy4j8JyAEZuKZ5LWmdQELmqHt
         QpqWmwcC3l3ifkDl6QvtrPmnQhv9Omz3rl5WO1/OryUv2K1em3nOK5aqn49zjAAE+c9b
         UhyXqVg4UeZy1jMlYHFZV+L0yzwWLPfIWRUo/PJFXMfmXk5wYCCRCoxg/x3nqtX+vO3q
         pD9+ghywM1CGaYjzOrl+tVJRS/+0suYiGe59b2cJqaMebquWe4FYH/QYYUh8on6C2bsG
         p8Bw==
X-Forwarded-Encrypted: i=1; AFNElJ9Wm25L5lEidzlNhWjgxtyFuHvTTxUqAZakBzl+Wvl9h1BRi+mNxZsczgJ4nNHO2Ps2vawchEie1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WSywpOZ2lmHafFoBEGYzbVSGRuIA+Owz4c7eLY0wQg/iKtMl
	CTk8ttNsDdaMa1277q9U6fPVwMGCKdXo5mmyzOiqLUGxm9cfXRRos388DZoQhYhKBfufZQo4wo2
	jpBD0Qnm8CHvwYQ==
X-Received: from wmbjd23.prod.google.com ([2002:a05:600c:68d7:b0:48a:5e23:da86])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:1c:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48fce99dc29mr26844625e9.5.1778675718495;
 Wed, 13 May 2026 05:35:18 -0700 (PDT)
Date: Wed, 13 May 2026 12:35:15 +0000
In-Reply-To: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20260513-page_alloc-unmapped-prep-v1-3-dacdf5402be8@google.com>
Subject: [PATCH 3/4] mm: rejig pageblock mask definitions
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

- Add a PAGEBLOCK_ prefix to the names to avoid polluting the "global
  namespace" too much.

- This new prefix makes MIGRATETYPE_AND_ISO_MASK look pretty long. Well,
  that global mask only exists for quite a specific purpose, and is
  quite a weird thing to have a name for anyway. So drop it and take
  advantage of the newly-defined PAGEBLOCK_ISO_MASK.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/pageblock-flags.h |  6 +++---
 mm/page_alloc.c                 | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index e046278a01fa8c37d898df94114d088933b6747f..9a6c3ea17684d821fde9ec272b0802dfb78249a9 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -36,12 +36,12 @@ enum pageblock_bits {
 
 #define NR_PAGEBLOCK_BITS (roundup_pow_of_two(__NR_PAGEBLOCK_BITS))
 
-#define MIGRATETYPE_MASK (BIT(PB_migrate_0)|BIT(PB_migrate_1)|BIT(PB_migrate_2))
+#define PAGEBLOCK_MIGRATETYPE_MASK (BIT(PB_migrate_0)|BIT(PB_migrate_1)|BIT(PB_migrate_2))
 
 #ifdef CONFIG_MEMORY_ISOLATION
-#define MIGRATETYPE_AND_ISO_MASK (MIGRATETYPE_MASK | BIT(PB_migrate_isolate))
+#define PAGEBLOCK_ISO_MASK	BIT(PB_migrate_isolate)
 #else
-#define MIGRATETYPE_AND_ISO_MASK MIGRATETYPE_MASK
+#define PAGEBLOCK_ISO_MASK	0
 #endif
 
 #if defined(CONFIG_HUGETLB_PAGE)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91d83c967bd478982e0161a99d47d3a76bd89992..5d6144c8860ed10fd641184f389c4953465d5178 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -364,7 +364,7 @@ get_pfnblock_bitmap_bitidx(const struct page *page, unsigned long pfn,
 #else
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 #endif
-	BUILD_BUG_ON(__MIGRATE_TYPE_END > MIGRATETYPE_MASK);
+	BUILD_BUG_ON(__MIGRATE_TYPE_END > PAGEBLOCK_MIGRATETYPE_MASK);
 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
 	bitmap = get_pageblock_bitmap(page, pfn);
@@ -437,7 +437,7 @@ bool get_pfnblock_bit(const struct page *page, unsigned long pfn,
 __always_inline enum migratetype
 get_pfnblock_migratetype(const struct page *page, unsigned long pfn)
 {
-	unsigned long mask = MIGRATETYPE_AND_ISO_MASK;
+	unsigned long mask = PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK;
 	unsigned long flags;
 
 	flags = __get_pfnblock_flags_mask(page, pfn, mask);
@@ -446,7 +446,7 @@ get_pfnblock_migratetype(const struct page *page, unsigned long pfn)
 	if (flags & BIT(PB_migrate_isolate))
 		return MIGRATE_ISOLATE;
 #endif
-	return flags & MIGRATETYPE_MASK;
+	return flags & PAGEBLOCK_MIGRATETYPE_MASK;
 }
 
 /**
@@ -534,11 +534,11 @@ static void set_pageblock_migratetype(struct page *page,
 	}
 	VM_WARN_ONCE(get_pageblock_isolate(page),
 		     "Use clear_pageblock_isolate() to unisolate pageblock");
-	/* MIGRATETYPE_AND_ISO_MASK clears PB_migrate_isolate if it is set */
+	/* PAGEBLOCK_ISO_MASK clears PB_migrate_isolate if it is set */
 #endif
 	__set_pfnblock_flags_mask(page, page_to_pfn(page),
 				  (unsigned long)migratetype,
-				  MIGRATETYPE_AND_ISO_MASK);
+				  PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK);
 }
 
 void __meminit init_pageblock_migratetype(struct page *page,
@@ -564,7 +564,7 @@ void __meminit init_pageblock_migratetype(struct page *page,
 		flags |= BIT(PB_migrate_isolate);
 #endif
 	__set_pfnblock_flags_mask(page, page_to_pfn(page), flags,
-				  MIGRATETYPE_AND_ISO_MASK);
+				  PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK);
 }
 
 #ifdef CONFIG_DEBUG_VM
@@ -2130,15 +2130,15 @@ static bool __move_freepages_block_isolate(struct zone *zone,
 	}
 
 move:
-	/* Use MIGRATETYPE_MASK to get non-isolate migratetype */
+	/* Use PAGEBLOCK_MIGRATETYPE_MASK to get non-isolate migratetype */
 	if (isolate) {
 		from_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
-						    MIGRATETYPE_MASK);
+						    PAGEBLOCK_MIGRATETYPE_MASK);
 		to_mt = MIGRATE_ISOLATE;
 	} else {
 		from_mt = MIGRATE_ISOLATE;
 		to_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
-						  MIGRATETYPE_MASK);
+						  PAGEBLOCK_MIGRATETYPE_MASK);
 	}
 
 	__move_freepages_block(zone, start_pfn, from_mt, to_mt);

-- 
2.51.2

