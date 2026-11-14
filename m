Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640242;
	b=hye18/nvprscXoNQPxEaimJlZAGOlkv9QB1kvM/IAFe4+F0CYuvwl779OdGy1jUQc65J
	 84vWhDtPhQB8Cu1Fe7OnrJBMLU9MMD7zNUJFNun2rAiu0mB79lfuvS1DyWN+PJhQpgvI0
	 ME27xDV7uykJKJQWd1LwxaFbJdQVl3Y2MxQCBlqjETU7+VlXYlLqWYTwonG5rgAMO94fv
	 xgagoUsocIp+RPVqlMp3smr/c/P84fSvNJWPn3UVYXbm+dBbgde+2OZiE5RyD44LJUdmr
	 syuztR+OcuFiuvOJjhreLhPkqd2MG2l9Yc/Tm0U26gx0/j633J8xg7X8wE4vQoy7lRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
	b=n0BkySH1m80e6L4E4wU/yc/RedAxYDZdaGAxNjwgpkDiNUrXQUhcTnWUBLSlkM6dPl4g
	 AH4cpXon28SiWCI6tpXapxuLdZ/pOWbK7VzS5l5xqXHWGi4URTZNdZWtpsWK06uC7VFU4
	 /O8hUDAnq96SiH2QMcAGqG6kWPKf6/N268xrj7Oo680eAAY/yLtv1OOIifbhUNvR5tHqg
	 tg8E/RoY/Xs7h4+u05+bkwscO+rFJ3h3tufK3e8/S6xdgtdKfTWYI9zKpOsfTvvT0nFem
	 oCi52PsNdtkqd/T65hLTnVqMytTcRmSv8juyeST9/SiG3dQ3SsInX3gRkgHcjUEbY9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=D9A1vsmT;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2E60A3825
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB2E60A3825
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=D9A1vsmT
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91f2b826fe9so19624066d6.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640241; x=1795245041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
        b=D9A1vsmTybX5qvyGrrwjuz0qfMhMCmSQaNyn6nnZSRb6LSMt/zZ4S9s3hm+H3FkHCR
         SG2SISoIW0tA/UkIS8ZIjAJYclJ8n15cYdVuyVR0M6TNYjxudXryIGYUlLTffCKApNtT
         L9V7DtX/RDb3IW725jkVaFFLu8fllFC8RUg/BCf/soPXFJdVTjGbGh6Y20jSFnNwtB+1
         d9upU+RfmfzHIX56UPwgbX1+NUg0F/ZhXyF8jpC4BQeYnzkcwImEQnlAEvqtk3JqdpNo
         9XdIJkNyk41TuO3O7wjteZ30+0JtKPuU1KD7fcffJ0Tvt/O93YRyjh6yIdiXMAS5kJPl
         4eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640241; x=1795245041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
        b=W43Du4FxR87xt+NBM9uErZRnCvBefv2rU0z1JOgiRlyvdXPPyzI2KFbXftSMS6F3ks
         eTjMjcm6WwTAlQ5w+TqLkeJifOzzjJChRoiJ7Ndy0pbpxUhlD9vs92PxmBXkZYZk+BWH
         nrJkL7NpKkbu6fz1ckwD0LG/Y6fHABUAnd5Wj8nvDPkl/f3qQqVLELT1kTLJJ8SOspBH
         56uE5GAsV+bI2KcuzZMxQlMU01u9QQRGkDo9EbScDYdXDEPByburIRHBIHRWmqouSFy3
         sz7J5JdXIT4wxzesbDadHW+Dj9WcNGt1EEHps/JmAscyxIQfBLieSJBQcYkcKi1pXy5B
         r7vw==
X-Forwarded-Encrypted: i=1; AL+hErGzULw+O6qjOmcHBK48IrRbdK8n+xEstNIen5SvCgc0xfsopYBPauQ/6p/fcrtgvyCMTQ4tw865vg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9A3yJqS6/2zCsnb7yCyMJ3PPMW03+zkuXlSDEERsMPuRgiVCb
	KjHB12JjnOF9uOSKPml0wzyMiIWWcuy4kqg1MAyPpu9JfRD84ZjuJNkGZVIGd3h2F5Q=
X-Gm-Gg: AYBFou34N08pvnLaOa3NouRzZOtSxCmy7erDlCTnlTp+EIwHL4Id6WgbyOhMpkrnq+U
	Mt7IVuTtdgPm6OLzwrMbi5xBqeiG/m1IfAZabHtYrSBqEMVErbzPzABwIZeY9otia3GU1DOb8b7
	RihorRe9+TX6bNnyQCkebnSY1lP4QMh7I1nj+dTsH1Piy/V1Y+a0WqbK0tUzp7gwW5/omCYxf8O
	6O83vrlQdQuMul6jYlP4rJPmeVKlbvpV2k/VfNAAHpYk1hAWX6wMyJhCycPb5muSIC7p97jM8lc
	SqkQEOZUxnugx+K2hpeeB7yssq46kgISS/F2XUPp4iZ/78TLaEaVXAI+oQ68YcWVZnLrvfCM04W
	c8+1GKfek2pUT2cWaLwcNHyaA/KOPmdwl9wjhOGdk15ArTXJySnoADxRk0iIzj847EdhxJ6NKpX
	qVkBywaaUU34rMvx16cPFzLJ2QOjrB7u8c13Psd+ZTcB7pKd+V6cuTG+nEgseZR1FVKJUz4Shn8
	9KF97h+7qaPepT+BcjhlFyVqE/1NFIdjB/qCOFYf0jBg9adMp3+l0KxrFV36ujJeuqxMS+0QIR+
	O7SgzBL7UHDB01KkvHBnxGwUpD/9ELMWXTbgqJEclgfrhOlZ6enEaqfdbpzATDkMlFCqTktH+OQ
	E0eRzLlhuUmeq2xA=
X-Received: by 2002:a05:6214:c2b:b0:91c:9086:ee07 with SMTP id 6a1803df08f44-91f2420df31mr81654406d6.38.1794640240818;
        Fri, 13 Nov 2026 23:10:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:40 -0800 (PST)
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
Subject: [PATCH 17/22] mm/vmscan: restrict reclaim to common memory
Date: Sat, 14 Nov 2026 02:09:54 -0500
Message-ID: <20261114070959.3490008-18-gourry@gourry.net>
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

Reclaim serves the ordinary allocation domain.

Restrict it to N_MEMORY_COMMON:
  - start kswapd only on common nodes, at boot or hotplug.
  - walk only common zones in direct reclaim and when throttling it,
    so no reclaimer waits on a node that has no kswapd.
  - walk common nodes when MGLRU registers an mm and when its debugfs
    interface iterates or validates nodes, using first_node_state()
    and next_node_state() in place of first_memory_node and
    next_memory_node.

The fallback zonelists hold only common memory, and all memory is common
at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory_hotplug.c |  3 ++-
 mm/vmscan.c         | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 29ff2c46499b3..410a29732bae7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1207,7 +1207,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
-	kswapd_run(nid);
+	if (node_state(nid, N_MEMORY_COMMON))
+		kswapd_run(nid);
 	kcompactd_run(nid);
 
 	if (node_arg.nid >= 0)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 061fbd168d982..bb7b1c50bfb78 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2932,7 +2932,7 @@ void lru_gen_add_mm(struct mm_struct *mm)
 #endif
 	spin_lock(&mm_list->lock);
 
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
@@ -5562,7 +5562,7 @@ static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
 	do {
 		int nid;
 
-		for_each_node_state(nid, N_MEMORY) {
+		for_each_node_state(nid, N_MEMORY_COMMON) {
 			if (!nr_to_skip--)
 				return mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		}
@@ -5587,13 +5587,13 @@ static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
 
 	++*pos;
 
-	nid = next_memory_node(nid);
+	nid = next_node_state(nid, N_MEMORY_COMMON);
 	if (nid == MAX_NUMNODES) {
 		memcg = mem_cgroup_iter(NULL, memcg, NULL);
 		if (!memcg)
 			return NULL;
 
-		nid = first_memory_node;
+		nid = first_node_state(N_MEMORY_COMMON);
 	}
 
 	return mem_cgroup_lruvec(memcg, NODE_DATA(nid));
@@ -5665,7 +5665,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	if (nid == first_memory_node) {
+	if (nid == first_node_state(N_MEMORY_COMMON)) {
 		const char *path = memcg ? m->private : "";
 
 #ifdef CONFIG_MEMCG
@@ -5765,7 +5765,7 @@ static int run_cmd(char cmd, u64 memcg_id, int nid, unsigned long seq,
 	int err = -EINVAL;
 	struct mem_cgroup *memcg = NULL;
 
-	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY_COMMON))
 		return -EINVAL;
 
 	if (!mem_cgroup_disabled()) {
@@ -6492,8 +6492,8 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
 	}
 
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					sc->reclaim_idx, sc->nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, sc->reclaim_idx,
+				 sc->nodemask, N_MEMORY_COMMON) {
 		/*
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
@@ -6604,8 +6604,8 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	} while (--sc->priority >= 0);
 
 	last_pgdat = NULL;
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
-					sc->nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, sc->reclaim_idx,
+				 sc->nodemask, N_MEMORY_COMMON) {
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
@@ -6756,8 +6756,8 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * for remote pfmemalloc reserves and processes on different nodes
 	 * should make reasonable progress.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					gfp_zone(gfp_mask), nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+				 nodemask, N_MEMORY_COMMON) {
 		if (zone_idx(zone) > ZONE_NORMAL)
 			continue;
 
@@ -7736,7 +7736,7 @@ static int __init kswapd_init(void)
 {
 	int nid;
 
-	for_each_node_state(nid, N_MEMORY)
+	for_each_node_state(nid, N_MEMORY_COMMON)
  		kswapd_run(nid);
 	register_sysctl_init("vm", vmscan_sysctl_table);
 	return 0;
-- 
2.53.1-Meta

