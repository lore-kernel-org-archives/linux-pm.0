Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640210;
	b=S5sEfERX9pkjEuLjAWGT7+wjFsKIwxfDaPpk0Mew/qyUhlfDoYAb36L1Q/weAncyAkOb
	 1nfrrJISLKHZSs1FtNhZaErGWKKzdBxiI76vdQwY/L7PkiZPiQi3icQsp0J5OyQacyMUQ
	 riXAdlANKbhzSdiqXd95thNZqXgCXgPx4IgqRDWLTFHBSuxKbWUW8YW6UvE0pmatiQ62I
	 wHh3BuQ3zuuXZIlHAnLjIxIAriqnbHh1fzDfaVwTsnLnUCD+CDNJmff3aYSvrqg07NXDy
	 OJydytd0W2we7H1kNs3rKh9o8dZXtH6VOJtxQ9ktu1X4tHjA5sT+GawVe23OlYLl3QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
	b=ArPoCIDKTOy7280oPzEkpJs3qZDjDPiT0sG0bYHPJ2u64Eg9tPMKYzpGmHnvxcbgxeiW
	 KPcz9MHmzpP/GpW3nMTWXd5hWj5c0CV17tlzlerSuDpUy88q33GNiGzlglY60fijvB1zF
	 VpybpgYkAzjFQOsEP2/7qzFFXgaRemcGjWPRvmDyQx9t8qPpa7bE+/Djh3Blvh/ECdxIg
	 /yck7FzD2a+CsFChJ+YkxnuRwhRGQSD83142mT/nWkHwA8yvWD5qNNvxUVwWt5Nt/+Buj
	 BDZHFUAUIc7PX+d1VWV2fdn9bTMLjkysH+OQFFjGkm/RbEqB7yWFYSAmNaHlCD8XAbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=aVufzMF1;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F2B606A8A5
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F2B606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=aVufzMF1
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ea5600c9cso37046676d6.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640209; x=1795245009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
        b=aVufzMF1ziuixYF2LwjyH7kreUYrlXQnpmHijWkoeW/lvqdaKolzkN+GuWEZ9Elxku
         RmQM/Qd0JknXCOcyFCsoSHle6c93jvb8DGPwDV82hDd+ity5CVzxo6dZ0JwnEVxsoijw
         l73/guNH+o32V7hOir1Y3NVrZQ9xH7aaOudDuml/feYSeQtX1VB/TBSXbWwRm1zVJ4eC
         4SRSkSm9RnIZsT0C3vyFyDFMvaxtRaYsG/xYd/+qSUNiNbPqs9XXNoyYeqSgIdZ/Bx/E
         u2s5+Pw6kq0V8ZrSXVzNReSYfzUzMeJUxU5+RedW1C1ra4crn5FfH525mKnVav04kDdc
         OjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640209; x=1795245009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
        b=0Y0MOjbw3RddChkROkkzWUyF6hBk2+ft+T731/Ca+R4rbtQcYU/vSxWbWJMZz/3Uif
         +jQh1IPotmS+EQjpNia2qFmhVKuVoXE8V0X5KM2rmhdMTxOhUKSQ4ZgHA3S9wSfewUof
         /EU7P/1HhjE805bTRsWt01SBAEYUXdM7wc4OWcsNaCpADd9HZykKcQTbtQ3g6MZm4GqH
         yDtd1yapbqFIjp7V5Hjj9J3BJHQWiPI+baJMVj8Jsv2DCwmU2qNSfhvQYHu9oeDU+K4O
         mxRmQsBuPEQjQB3hY+d0DIuIhYJLCsLEx/gwpMaYfdkTov1AMdzFDXO13DzmLP81mxtY
         CYBw==
X-Forwarded-Encrypted: i=1; AL+hErGlLRPoNowcE3gX44bIoRrMwY2+uHV7GGuRhO1qur4Iebqig52UNTJQ2NZqzofJBGXdpRWQDtFq8w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+UNbmugX1PQeBIR5T+knrzlKOQVKre4zntuSZUx0dQOPcSGQpE
	wp1vRP2E2gcJ7EodPjWG+OWomVCLTnkaV1hW9thQfvTeWxEz74JyXnDQ5Eff2kG4qok=
X-Gm-Gg: AYBFou1LRstdU8NRXPWc0xiz5JIWLfcLWQ4Yrwd0K9/3EaxA23vpM4rVkaF3aOJOZHB
	QuF++FscNPr8pFSZ0uBWQx6NHgSTDqeh+l2KQwM5mG6LBEUIuhV3o8pIwpm+/pDC9F+xHkJNbCG
	wuVcMa0qJvd6XvJLJR4R/ySWuN1B/B994P1a/kfl34bILgo+lT3UKGYqYUwcrWmuDHbq4TZvm1N
	4hwmmofko/EaM2POPRdaFBsm6ySzYcOGH4j/VEMXp+CTZkuDIjUMzH+HptsNIFMmZzs8Et67xAG
	22XLa3p4slZ6Qp9WKiFjBMAJnUXI4fpXNoub8OShjCrontjkUuoFRuWrtVZ49rsVj73oIf1YfXS
	OoAbsfmvQ9JrfeAItEiFKpJ5F4kuP/gM40IM91H6iyOWl+2DB0jmOD7oQ7OvlE3ipOLCKDt7Nyp
	f5kWlspI3MSr3AuB2G4FvjOtVmHIUZNWZDl2nWIBgo23WS4cKymDcpJsCCwHdl3BaJMvtLz98s4
	7gtUBvGIwE5hK9DwLgi4xkEmbROa6wJE6e1OjwIIuT+wvF06YIlIWMT+Sa0E+i47WxDZjtpONnv
	BntOAlr47+ZHAq9OkpEaMGNiYNVc5HEGtIQkYcyTOlGPLizTresz7d5c6zT9rg/y/7USISo1/0x
	SVyjJUehTq8aSUaGV8emCvoBdzHT50JcEz5t+
X-Received: by 2002:a05:6214:18f1:b0:91f:1a70:4b0c with SMTP id 6a1803df08f44-91f1a70a6famr79219716d6.4.1794640209017;
        Fri, 13 Nov 2026 23:10:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:08 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 02/22] mm: publish and clear node memory states via helpers
Date: Sat, 14 Nov 2026 02:09:39 -0500
Message-ID: <20261114070959.3490008-3-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

N_MEMORY, N_NORMAL_MEMORY and N_HIGH_MEMORY are set separately in
free_area_init(), check_for_memory() and online_pages(), and cleared
in offline_pages().

Centralize those updates in node_set/clear_memory_state().

Behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/internal.h       |  3 +++
 mm/memory_hotplug.c | 11 ++++-------
 mm/mm_init.c        | 14 ++++++--------
 mm/page_alloc.c     | 15 +++++++++++++++
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cd3675c044e0a..608a83c34c224 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -62,6 +62,9 @@ void lru_add_drain_cpu_zone(struct zone *zone);
 void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
 
+void node_set_memory_state(int nid, bool high, bool normal);
+void node_clear_memory_state(int nid);
+
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f04a248d8adaf..490f400498f14 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1184,14 +1184,11 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	online_pages_range(pfn, nr_pages);
 	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
-	if (node_arg.nid >= 0)
-		node_set_state(nid, N_MEMORY);
 	/*
-	 * Check whether we are adding normal memory to the node for the first
-	 * time.
+	 * Publish this node's memory states, including any newly-normal zone.
+	 * Hotplug never adds highmem.
 	 */
-	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
-		node_set_state(nid, N_NORMAL_MEMORY);
+	node_set_memory_state(nid, false, zone_idx(zone) <= ZONE_NORMAL);
 
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
@@ -2146,7 +2143,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * list. Otherwise this node would still appear in the fallback lists.
 	 */
 	if (node_arg.nid >= 0)
-		node_clear_state(node, N_MEMORY);
+		node_clear_memory_state(node);
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a9d848c92678b..b4c4dba93652d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1763,21 +1763,21 @@ static void __init free_area_init_node(int nid)
 	lru_gen_init_pgdat(pgdat);
 }
 
-/* Any regular or high memory on that node? */
+/* Publish the memory states of a node that has present pages. */
 static void __init check_for_memory(pg_data_t *pgdat)
 {
 	enum zone_type zone_type;
+	bool high = false, normal = false;
 
 	for (zone_type = 0; zone_type <= ZONE_MOVABLE - 1; zone_type++) {
 		struct zone *zone = &pgdat->node_zones[zone_type];
 		if (populated_zone(zone)) {
-			if (IS_ENABLED(CONFIG_HIGHMEM))
-				node_set_state(pgdat->node_id, N_HIGH_MEMORY);
-			if (zone_type <= ZONE_NORMAL)
-				node_set_state(pgdat->node_id, N_NORMAL_MEMORY);
+			high = IS_ENABLED(CONFIG_HIGHMEM);
+			normal = zone_type <= ZONE_NORMAL;
 			break;
 		}
 	}
+	node_set_memory_state(pgdat->node_id, high, normal);
 }
 
 #if MAX_NUMNODES > 1
@@ -1924,10 +1924,8 @@ static void __init free_area_init(void)
 		 *memory-less node. The pgdat will get fully initialized by
 		 *hotadd_init_pgdat() when memory is hotplugged into this node.
 		 */
-		if (pgdat->node_present_pages) {
-			node_set_state(nid, N_MEMORY);
+		if (pgdat->node_present_pages)
 			check_for_memory(pgdat);
-		}
 	}
 
 	calc_nr_kernel_pages();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8532af052d74b..834d199ff8429 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -208,6 +208,21 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 };
 EXPORT_SYMBOL(node_states);
 
+void __meminit node_set_memory_state(int nid, bool high, bool normal)
+{
+	node_set_state(nid, N_MEMORY);
+	if (high)
+		node_set_state(nid, N_HIGH_MEMORY);
+	if (normal)
+		node_set_state(nid, N_NORMAL_MEMORY);
+}
+
+void __meminit node_clear_memory_state(int nid)
+{
+	node_clear_state(nid, N_NORMAL_MEMORY);
+	node_clear_state(nid, N_MEMORY);
+}
+
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
-- 
2.53.1-Meta

