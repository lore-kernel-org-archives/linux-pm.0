Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640216;
	b=oBEB/CNQZiTn9lAPuAnlniH5LLO6aeuOi/1nX6oPy8L8TLmU7mk36yMU6tlgOU6sdbRx
	 Oa2aBRA8vn9HfwxKAFzKzYTj4r8/QVwoCHB0cFPTn711f9w5ykdOhnuEUjCkCutmez8co
	 22aWn19HpdVzKAbsvO9Atru8HImPkZnySKS5gcdIsOSZOLwW3FkwTpZcdjql57e508mau
	 VgxNF8DUgvGQG/NgQniV9HIUaTI+19KVOJ1A26ZaG4O0MkBQhaW+IjrQGRRh2DeUwztWp
	 vNjL04CuvUY9qF5Z2To4KDU9tU2fyRRheOqufVE+JUujUp92zEPGBt11OassaIEdGdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
	b=j8CZsQh5iO2V8XXRxW43Q8Sq5VqEiJjDZ3NUgOR59fBH4sLWh506fj50fZNvnhQV6//t
	 AoOHVtO0GaLX0hIWGQuKUDsKOk58fy2tfJ6sDGD7gbNHEsLtLRH5P9TGsKOwytkgkWvSN
	 6kSUVN+tFTnJBb9fS24pmUNcFMkb2klEy38Fx3Ly5aJ5lAGzMvFK7HLUOGguo25ECvIMg
	 LjCvLFSfT9EgxFgg7+ZENqS2qjhrI2wrYiUpWIBDZvIMHs2/XolZtoTMY/raBcjFYMsOm
	 OKAnvjFr64+wWWsCZTB+KrcmiaYkvD9qtj0u7lw7GHzNGC6RsO5En4m5hQJH+Iwvl3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=d7KKfvBB;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BA60A262E
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 382BA60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=d7KKfvBB
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91e8938fd01so29666656d6.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640215; x=1795245015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
        b=d7KKfvBBW5/5gvjm+2xpumHZ1G9opFmCK0hLy80god6602rP4hD7WpJOGpuokt5mAL
         oS0dK1kG353je+Plx7acyy3uDD+xG+fq13pPPunFf2FrrH3HCYFO6byP3Sxtv2jFPZRS
         xkvrHljmRCgifnLPU7TTzNYxo6K/0+6E/ugTWtazA660Z6j34/gCIt06b/pby46TMW4f
         tuIOIKSVgbsNBqf2nKWyrmyI0gqtvTjJCJgKoGlUlvqVhTxSTJN+XkpcJKcwx1Td3Q6t
         AEo832DgjwwYB1HZ/pxFbAs31Gd3WOnHnsRaeSVQ8XmVN/B1qBnlz7xTmeoX3z8P3pSY
         IBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640215; x=1795245015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
        b=nyLMj2J3bibyPc05JqnGxXbus/mt9YinV8ceWTV0UQ2qXsyGzupfm/7d+QuQX4FMCr
         pU4AJ/L6DCqrGENCi42xfYNgZiJ9Yah7eIGVMxpJ5buc2t3/VrfpLt9G6dO04rDL7MEC
         ZTwQtIWi9G3yMEMeAC4+yErTADYr/8AGuTH91346a/CyDPSxlWuRpWV+LRHLZJ5WkueB
         X+vrCAXkWZJY+iJOYr4Y7oky9wUuIHPXlYXnXJLrfFtEorqJ4CKpvfiNMpbZNMw/9rTz
         pH1XC5xy7BkfDxGUyVzHLhgS6puKlWDGCwHqimhC5m0nmdNG8b/IgvYD/hyeLlv0oaMw
         HLMw==
X-Forwarded-Encrypted: i=1; AL+hErE5Fe6DZbd9TPRVw9birhrxPWguJBROsHQffF1LVvz4d9M//2wfenT2T7GwuaMjISm6aW5V6oSUmw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9f8AQgGXF2rWbU8RIoFdwIxv4Toi+Z3Rd6ghIE9+g+kZ7+HCV6
	47wSdoPfeHwvawZMgl1QzR8NWeqLiGXYbGQs9lGH0h85gkj9bB5V3eqIO4ZpUvLrwds=
X-Gm-Gg: AYBFou0Y1N9/1sPJqguy/HqvUiucYAqEn/AOZc/vVOtqLKJ4KFlh0NX+lIjV6qbwKkw
	rcOkG/XfTUhl5SE9GKcN7o7Dw8XSk2Pt2I7gupPUcgqEvFzqttpnnbEHYZwMKxhoIM+TPPz8TSr
	XIuXCaSFZom1NS4RExB2kJRbLm4SJY3iTRz7ZAWEd1bu98qJ5MYQ9TdHw/p+6Dz9F0cqk96dQsV
	5Xa4NPqBFRZZuHQMhgC2BCrndDD0Wo2HhIKj/1ywSsYKcrQ6zf5XLTwe7dkfYtBi/88UsgX+ZPW
	Fa3XO01p1BqY1OqzxkNPw9ZXZXkdJ7JYZk4zgtk8h+GNBG4K814Apv8HBnTDKtO/E0AGbeb4jCB
	UCS5A0FQFDakvgJT6lcin8h1r3soP2uolBVr4Nj2KAr4azpYMJyUR1Si0tQ0APOfNs4HweG3XWm
	cF4swYkKhrNWUc/aMS1lj494CRmczUPVIJe5y01ud/EuDBvmRRX6zgku3+UnbXww9i04gnXONH8
	jPUrSFB5Ai1szJN2QSRvcuyArlHUVcnH9NtGX8dPIq5NbSca8+IgPbLRYC7XZHJ585y8I0qyNnp
	GXiVuJ+mWIMqxB+feuc6cQqoTZuEnDlKWutNtJfjIEt1Ue0GyvOPyInCix4igeIkblUpsBGym8j
	B4jC5QGhVTLIX8kY=
X-Received: by 2002:a05:6214:8581:20b0:91e:a16b:7f59 with SMTP id 6a1803df08f44-91f241f7044mr56496996d6.32.1794640215081;
        Fri, 13 Nov 2026 23:10:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:14 -0800 (PST)
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
Subject: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount policies on common memory
Date: Sat, 14 Nov 2026 02:09:42 -0500
Message-ID: <20261114070959.3490008-6-gourry@gourry.net>
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

Use N_MEMORY_COMMON for boot mempolicy calculations and their per-node
sysfs entries (weighted interleave weights). 

Restrict the node set mpol_set_nodemask() applies to set_mempolicy()
and mbind() masks to N_MEMORY_COMMON nodes.

Later when an N_MEMORY node is omitted frmo the N_MEMORY_COMMON set,
they will be stripped from mempolicy nodemasks as they're not eligible
(similar to memoryless nodes today).

All memory is common at this point, no behavior change at this point.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b10c098e9c2a3..662ab420fe03c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -213,10 +213,10 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 	int nid;
 
 	/*
-	 * N_MEMORY can change while wi_state_lock is held. Remember the
-	 * nodes contributing to sum_bw so all passes use the same set.
+	 * N_MEMORY_COMMON can change while wi_state_lock is held. Remember
+	 * the nodes contributing to sum_bw so all passes use the same set.
 	 */
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		node_set(nid, nodes);
 		sum_bw += bw[nid];
 	}
@@ -439,9 +439,9 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (!pol || pol->mode == MPOL_LOCAL)
 		return 0;
 
-	/* Check N_MEMORY */
+	/* Check N_MEMORY_COMMON */
 	nodes_and(nsc->mask1,
-		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+		  cpuset_current_mems_allowed, node_states[N_MEMORY_COMMON]);
 
 	VM_BUG_ON(!nodes);
 
@@ -3400,11 +3400,11 @@ void __init numa_policy_init(void)
 
 	/*
 	 * Set interleaving policy for system init. Interleaving is only
-	 * enabled across suitably sized nodes (default is >= 16MB), or
-	 * fall back to the largest node if they're all smaller.
+	 * enabled across suitably sized common memory nodes (default is
+	 * >= 16MB), or fall back to the largest node if they're all smaller.
 	 */
 	nodes_clear(interleave_nodes);
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		unsigned long total_pages = node_present_pages(nid);
 
 		/* Preserve the largest node */
@@ -3476,7 +3476,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		*nodelist++ = '\0';
 		if (nodelist_parse(nodelist, nodes))
 			goto out;
-		if (!nodes_subset(nodes, node_states[N_MEMORY]))
+		if (!nodes_subset(nodes, node_states[N_MEMORY_COMMON]))
 			goto out;
 	} else
 		nodes_clear(nodes);
@@ -3508,7 +3508,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		 * Default to online nodes with memory if no nodelist
 		 */
 		if (!nodelist)
-			nodes = node_states[N_MEMORY];
+			nodes = node_states[N_MEMORY_COMMON];
 		break;
 	case MPOL_LOCAL:
 		/*
@@ -3903,6 +3903,9 @@ static int wi_node_notifier(struct notifier_block *nb,
 
 	switch (action) {
 	case NODE_ADDED_FIRST_MEMORY:
+		/* Weighted interleave spans only common memory. */
+		if (!node_state(nid, N_MEMORY_COMMON))
+			break;
 		err = sysfs_wi_node_add(nid);
 		if (err)
 			pr_err("failed to add sysfs for node%d during hotplug: %d\n",
@@ -3934,10 +3937,7 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 	if (err)
 		goto err_put_kobj;
 
-	for_each_online_node(nid) {
-		if (!node_state(nid, N_MEMORY))
-			continue;
-
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs for node%d during init: %d\n",
-- 
2.53.1-Meta

