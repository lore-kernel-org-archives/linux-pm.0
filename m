Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640222;
	b=v8EGeVPESDN0Ram82clF3qOEnGgTLCzF5KqOrGbqKJ+dZh0ZNrOtLelh+MoB+qwyYzKC
	 Mgpw83Amqh1nV+Aq+/xToTiavEavveIJZEZoVzWRXIDujDeRNwy56MoJVs5Qmjh2C8XSj
	 QjPvG0Dg1nThGGSioJy6iiPRADk6QWFaUJKJghpv1ZKucuqvU0E8p2KxGG2KZ9tQxw8nE
	 PWjaW33LSZp4ZSBdjevEiLJaaSE62q/ydY4iJM3OEQat8XdsCWSb5qowpvcf53DzLVt3x
	 xmN7LFqt2yAObJUuU/bPdespvdHLGLq7Xynbgcr9mJqlFY5jjPe/strWDw4c0OLjw7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DOXRgiF+CNyVqkJbhOIwPMg67CTmwFoCbwz1N9b8GHg=;
	b=ZD+iCDDwA5lHGNqj6B93DZ1o4j4gu+uMz3Uuxmc0SWecLKst17NY95i1EqvD5xp76Mz9
	 E344RyPAa31uufsPH6mdG5nCY3yttJ45NMQs1UlrvxxHOCjHMX/BZuknwag8+VajmwvGX
	 JOSQTxr6MsER3SUQk5FYYcR7naiHrjDMv5mapTvpCzjjMqVex1OBvKqzGlCVltpuK0fuc
	 dhc0lGO4BMjihiDeUHlZJl6Z8mn0kZYETeTTDrSyXoiT/90M6ULnR2CiX8Yw779M3kh+H
	 woIgl9RjUFvabm/TVsvO04sKFEWXUlJfXLWb/RkDU7UKbu7kkNvtOQCkkt7/N5mrN7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=dn8aPYjq;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB4606A89E
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DB4606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=dn8aPYjq
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91f0274f88cso35692616d6.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640221; x=1795245021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOXRgiF+CNyVqkJbhOIwPMg67CTmwFoCbwz1N9b8GHg=;
        b=dn8aPYjqsKhZwsk82BdbxjEFSE/vMaBbe+cox5m/7Df2gkmp44jLmMvpjtlgfZpehZ
         8VtDuumfxKQgTiwQyA44zpz1VpN8VYZrXf//xLpygTlh/mmCOZUUriWdYQcivo3a6L8c
         pSLy+otkzSzeQbpqiCjEhw6ybrSDAS0wwtWIYAPCdN3t4w0SHwGCt9z5OPI431nT9Bi8
         d01uBHt/f2gRMxcffnVFJlRyMNQJXgPKkXXTca1su0yl/rgRpd+kzFKuE5dh3T9Fb0zS
         4a847RJn2X8B2/ph4+ebCG/EDKFe2shPGmqiKw/sYMfZOB+DZUFZhAVD4emTOAPr5BYM
         1JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640221; x=1795245021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOXRgiF+CNyVqkJbhOIwPMg67CTmwFoCbwz1N9b8GHg=;
        b=N6J8W5e4WUFSAGRJAlv0itRP2oy9jItosLzxpxcOBB/VEVkn/d2tr9h9XCnpBN4f2M
         t7xWpsqnJ7o2Aesn6kiLU5JihxBD6+qVcmYA1Fu/kYNhIScSioIzH1E62j1rB2XjAWOh
         kpj8lHllvpW0Wd8Usr6Q6yhLdZ09pQ/g2YYzeDdKnhYQ9sq3wM6CLIC5d833fpZw0n/o
         S2dA01x29zR0pZ8QCt5Gj+Cj2zjyj3GoAgwMkGOxTEzOnWAWwtAVNHpQlQj/NnIcGAR3
         u0bao3wD8wj9NStdyAxXAX3vZwd39nFOFgyebNVuP9OyVYybnVSOwVLT29AcIBTwN4Ke
         TtSw==
X-Forwarded-Encrypted: i=1; AL+hErHjXBU5AtIY8Fvpjajoofd7Z+l6PX210jBmglrPio2sHxGmewrOd6GP0EfQz4jWy9tOoCqSBom1Yg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/gtDETfGp0VetyjZ4Z0YI80yHS33qRf65trf5dInt1vsb8TQN3
	wnzXmlQ/354CR/KFXfvOXfTn4jQi5G/PqXaUdS+dNOWjL1iTZbaBPvTShEq+OhL9zYM=
X-Gm-Gg: AYBFou2UYJeyzU4+AsCe3k8oUzKYR/IEAyhEvnQRkPmYjlotRgJKfb61NcKQVj3AQas
	pIjFjkh5Sn0c42AP92u1uXs5OBzMSTIweyzKLfr7nW3lvezPdbPRVuTnC5XkaZX3p/koa27rdaw
	kMnwjYNYYmOcYPKodepDRb4tp15nGxGNEQ/hjIXV9G4URSZvCVBO/8DX/Lx21GU2vZM8f+sL9pu
	K0ug0cftA8U7mqqEqrROhqfwt9Cw22/tmHQ2F04j4Oa0GEvOFTUMU/JeUU3Rd83+aLh1NO2AE9o
	noAsvypi3h1Pho8WqmWrI0IAAfVajizfTvOgwn6+AqXNtBYFkOtldxr3JH8LQE1bWERn2yJ7oq+
	C+XufKEu/DPcfjGYLV1azzcAOjKqcuKXjIkKxkOATs38nwpyl6mghqkuUJbRugzTGHKeP8Tz9Fr
	fl9Bg2sA58Jb2Dug4UtWSBB+StjE8BG4gL202OxZJAzV+plRn4ML8DR6pnO/Tnm7iSRyZo1RKSc
	rvkYlNK9jm2Ap4GzcQ3tbuOMmni6shgT+wkR30U8jSfDgJxZMzR/pm+C0dQkMj3qkFugdLXUG8f
	2Sp6czJvC7tUl31I9+uzMjrQCifz6FZrU0+BLRhymLA5I342qtIjRL6Xwp0QcgiH1RwN/sBevLt
	R5/IqlJS1GZsI3BY=
X-Received: by 2002:a05:6214:3905:b0:91e:7f01:f95a with SMTP id 6a1803df08f44-91f24229457mr72251376d6.46.1794640221033;
        Fri, 13 Nov 2026 23:10:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:20 -0800 (PST)
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
Subject: [PATCH 08/22] mm/memory-tiers: restrict demotion topology to common memory
Date: Sat, 14 Nov 2026 02:09:45 -0500
Message-ID: <20261114070959.3490008-9-gourry@gourry.net>
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

Memory outside N_MEMORY_COMMON is outside the ordinary allocation pool
and cannot be a generic demotion source or destination.

Build demotion paths and the default DRAM performance reference from
N_MEMORY_COMMON rather than every node that has memory, and do not
assign other nodes to a memory tier through the generic hotplug path.

Removing a node's memory already resets its demotion targets, so a node
that unplugs and returns outside N_MEMORY_COMMON keeps none.

All memory nodes currently carry N_MEMORY_COMMON, behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory-tiers.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 7fc56a8c66518..97d5ecefd89f3 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -370,7 +370,8 @@ int next_demotion_node(int node, const nodemask_t *allowed_mask)
 	 * closest demotion target.
 	 */
 	nodes_complement(mask, *allowed_mask);
-	return find_next_best_node_in(node, &mask, &node_states[N_MEMORY]);
+	return find_next_best_node_in(node, &mask,
+				      &node_states[N_MEMORY_COMMON]);
 }
 
 static void disable_all_demotion_targets(void)
@@ -405,7 +406,7 @@ static void dump_demotion_targets(void)
 {
 	int node;
 
-	for_each_node_state(node, N_MEMORY) {
+	for_each_node_state(node, N_MEMORY_COMMON) {
 		struct memory_tier *memtier = __node_get_memory_tier(node);
 		nodemask_t preferred = node_demotion[node].preferred;
 
@@ -441,7 +442,7 @@ static void establish_demotion_targets(void)
 
 	disable_all_demotion_targets();
 
-	for_each_node_state(node, N_MEMORY) {
+	for_each_node_state(node, N_MEMORY_COMMON) {
 		best_distance = -1;
 		nd = &node_demotion[node];
 
@@ -459,7 +460,7 @@ static void establish_demotion_targets(void)
 		 * nodelist to skip list so that we find the best node from the
 		 * memtier nodelist.
 		 */
-		nodes_andnot(tier_nodes, node_states[N_MEMORY], tier_nodes);
+		nodes_andnot(tier_nodes, node_states[N_MEMORY_COMMON], tier_nodes);
 
 		/*
 		 * Find all the nodes in the memory tier node list of same best distance.
@@ -468,7 +469,7 @@ static void establish_demotion_targets(void)
 		 */
 		do {
 			target = find_next_best_node_in(node, &tier_nodes,
-							&node_states[N_MEMORY]);
+							&node_states[N_MEMORY_COMMON]);
 			if (target == NUMA_NO_NODE)
 				break;
 
@@ -507,7 +508,7 @@ static void establish_demotion_targets(void)
 	 * allocation to a set of nodes that is closer the above selected
 	 * preferred node.
 	 */
-	lower_tier = node_states[N_MEMORY];
+	lower_tier = node_states[N_MEMORY_COMMON];
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		/*
 		 * Keep removing current tier from lower_tier nodes,
@@ -554,7 +555,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
-	if (!node_state(node, N_MEMORY))
+	if (!node_state(node, N_MEMORY_COMMON))
 		return ERR_PTR(-EINVAL);
 
 	mt_calc_adistance(node, &adist);
@@ -706,8 +707,8 @@ static int __init memory_tier_late_init(void)
 	get_online_mems();
 	guard(mutex)(&memory_tier_lock);
 
-	/* Assign each uninitialized N_MEMORY node to a memory tier. */
-	for_each_node_state(nid, N_MEMORY) {
+	/* Assign each uninitialized common memory node to a memory tier. */
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		/*
 		 * Some device drivers may have initialized
 		 * memory tiers, potentially bringing memory nodes
@@ -929,8 +930,8 @@ static int __init memory_tier_init(void)
 	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
-	/* Record nodes with memory and CPU to set default DRAM performance. */
-	nodes_and(default_dram_nodes, node_states[N_MEMORY],
+	/* Record common-memory nodes with CPUs for default DRAM performance. */
+	nodes_and(default_dram_nodes, node_states[N_MEMORY_COMMON],
 		  node_states[N_CPU]);
 
 	hotplug_node_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
-- 
2.53.1-Meta

