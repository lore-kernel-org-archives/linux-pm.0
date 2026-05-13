Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B5423A81
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675719; cv=none; b=VTPzAuhQGbZSjZnsgbFjoqggILrEpbmYf9z+kc10ZRJL5mRRT8y1oWfKlxmX/ACUSqOZ03OTyeKQQPgP/TfoF84StCXr9Gwdy+7VkMvY+35TEFLfODmqUv0hYcrwsQ56HZQJm9SyDS+iwjCZUxwj7FoTmAJK/OTbb5ENS6WHAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675719; c=relaxed/simple;
	bh=wJKc2L/2gOFq+4ciJL13zwsEExRmStV9nRngieSP9CQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l4UN5sWEvA0c0nk+2/UgohVVSQAWV2z52VC3YDyMcDQ5ndVbEkhD0WUgQ0cqLtLSYD3+2k4PkBT5PwGHj4zKLRnKtW/iV+qBJtRR7OxC0yIXp7eoAx3kylsTSS3MziBRSK9VuQrLWiCeJW3i6+rQHd03LZ7f5eLz2jekKmZELMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F301OG4s; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F301OG4s"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48919890a95so47147445e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778675716; x=1779280516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4WWLXd62Tgfh1ZCpYAiYrTX8S2ssjZcjbx8zKPYKSN8=;
        b=F301OG4scjX+8cpGGiJSFlSFV5zfQqncClKPvFnbZEe8cl9d4WwBtsAg6x51B8Dur5
         Wcv2RyH14MmpimSWwfuCC2aB/J50XwVepqlGUfm7my9LUcCN/dyR9Nsd+9yrvRFPqalO
         r7AHhXgs0JlKiR0+UZJP1Gfq09BpMcq/Ge25vXnhUBrpPkiAxTe8s8pRItpK6tNQPZlH
         ZeOlVIFI2CqTL/8BoaWFYc7IAWSvNq6+/VPY3Dqsdcd+vdN63CkKM1xC98OfngX/M58J
         ASZgaR9DteL2AqURtwuPX9R5RGiU+fkN7H5WJrBsnheahQbgXX7htGf7kGviC0w1TUQP
         iJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778675716; x=1779280516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WWLXd62Tgfh1ZCpYAiYrTX8S2ssjZcjbx8zKPYKSN8=;
        b=qzBLZAcdl6vYLAP6mFV7B1jDNNwNuAAaBwbTdiQAgYYvvu1TeZ8g9z9OZe8T6Os8M9
         itsDachpg/bhvnUFH/shDG9TP2aRHcB3h8bXh3kQ5OCTQBycIPLN88mYNKy2G12fgPFM
         ZqaeNcsJVuCoHjL1BzzTTS8CSd+ftvWGFRA6adHK2tsg6BHfiAQ2hjv2UIdVjEVjbQQU
         sOWl016UcpjcSHfDWIcVBqvwp3jbfCtDfT/k2O0R/NJUWXC7Tt4M4jo5dhmPcXa9FUtr
         DH6bMMLXw2p1SXb+szJxDxfwTTSzR8mqADeT19z6Ha9zP/51mERuUbfpQLv2ESZxFo6E
         r1DQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zP06jIJ/xaKxwonFSu+FCj2sPdbnW+xCled0Am5OlfdQHIG666vvrB973Z3JSzkeCXCxKbDJbCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBbdf8WxYP4vroPOoXwQzCiHP42nMrnP9U6o3u1bDP3nDKN8v
	13QMrTsg5kTwmBLmjE0CV5ct7lxMPN9L6BXdJ2wzQclyHW/NVYgS69L4yUt1Jr1y4P54AZaLST6
	VYWLrSWnBoiu+Gg==
X-Received: from wmpj8.prod.google.com ([2002:a05:600c:4888:b0:48e:914f:1eff])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b86:b0:48a:563c:c8c5 with SMTP id 5b1f17b1804b1-48fce9ab28emr38271865e9.8.1778675716013;
 Wed, 13 May 2026 05:35:16 -0700 (PDT)
Date: Wed, 13 May 2026 12:35:13 +0000
In-Reply-To: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20260513-page_alloc-unmapped-prep-v1-1-dacdf5402be8@google.com>
Subject: [PATCH 1/4] mm: introduce for_each_free_list()
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

There are a couple of places that iterate over the freelists with
awareness of the data structures' layout.

It seems ideally, code outside of mm should not be aware of the page
allocator's freelists at all. But, this patch just doesn't hide them
completely, it's just a meek incremental step in that direction: provide
a macro to iterate over it without needing to be aware of the actual
struct fields.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/mmzone.h  |  9 ++++++---
 kernel/power/snapshot.c |  8 ++++----
 mm/mm_init.c            | 11 +++++++----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9adb2ad21da599354600b48b4f3f9a4158efa049..1331a7b93f33c67c6e07df1fd8c5e4504dc28e80 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -177,9 +177,12 @@ static inline bool migratetype_is_mergeable(int mt)
 	return mt < MIGRATE_PCPTYPES;
 }
 
-#define for_each_migratetype_order(order, type) \
-	for (order = 0; order < NR_PAGE_ORDERS; order++) \
-		for (type = 0; type < MIGRATE_TYPES; type++)
+#define for_each_free_list(list, zone, order) 				\
+	for (order = 0; order < NR_PAGE_ORDERS; order++) 		\
+		for (unsigned int __type = 0; 				\
+		     __type < MIGRATE_TYPES &&				\
+			(list = &(zone)->free_area[order].free_list[__type], 1); \
+		     __type++)
 
 extern int page_group_by_mobility_disabled;
 
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index a564650734dcdceda7193ca3c1bc6b347cc1ec8b..d933b5b2c05d453bbda93c728136fc2a76758fc7 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1244,8 +1244,9 @@ unsigned int snapshot_additional_pages(struct zone *zone)
 static void mark_free_pages(struct zone *zone)
 {
 	unsigned long pfn, max_zone_pfn, page_count = WD_PAGE_COUNT;
+	struct list_head *free_list;
 	unsigned long flags;
-	unsigned int order, t;
+	unsigned int order;
 	struct page *page;
 
 	if (zone_is_empty(zone))
@@ -1269,9 +1270,8 @@ static void mark_free_pages(struct zone *zone)
 			swsusp_unset_page_free(page);
 	}
 
-	for_each_migratetype_order(order, t) {
-		list_for_each_entry(page,
-				&zone->free_area[order].free_list[t], buddy_list) {
+	for_each_free_list(free_list, zone, order) {
+		list_for_each_entry(page, free_list, buddy_list) {
 			unsigned long i;
 
 			pfn = page_to_pfn(page);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index bd466a3c10c8e204dddd881c5334364e3d47d612..db5568cf36e12b6fe52854b274fc331d9b36cac3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1429,11 +1429,14 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
 
 static void __meminit zone_init_free_lists(struct zone *zone)
 {
-	unsigned int order, t;
-	for_each_migratetype_order(order, t) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
+	struct list_head *list;
+	unsigned int order;
+
+	for_each_free_list(list, zone, order)
+		INIT_LIST_HEAD(list);
+
+	for (order = 0; order < NR_PAGE_ORDERS; order++)
 		zone->free_area[order].nr_free = 0;
-	}
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	INIT_LIST_HEAD(&zone->unaccepted_pages);

-- 
2.51.2

