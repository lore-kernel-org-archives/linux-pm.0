Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0F48B37A
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995591; cv=none; b=jgcgQ2Eoa7Gyfn5ZcXVRWdNRFQ/f3++WXfTey7W8aL+RLn+nOGm4TirWlPoXy1hLglhyw4UsojQYO4MoQJ3a47eXU39U+yHaAOCl7ijSDlxfBiGa/CrxPWDVRU3Mm31cQENTI8glfVmoL9Jp/vkxCZHbfGzzZZQ23LdkBY8+DKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995591; c=relaxed/simple;
	bh=Hd+gorxnpksj2SeHzQNvJk6R01VLS+FyxGb3FAaP1tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNKUXnG1LSHUIm/rVk/soansgm/Qi71kh33vQV4jtBYXrprflqGZUuNB2WpVdahE0+1uU7PbYUHiNF3cHFU6vOBXS5ETWbyOAcZzPVpy9X2gqPmkXFNk46QW8/QQOy2IuwFNT4c5moalJVb4JCXMQu5J52t/qFXaEk7ph8JaPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGmeBTPs; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGmeBTPs"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-47bdee5bfc4so3911786b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995586; x=1778600386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/yyOr/4pj99tbSJw4a+KNInaif0dFyRreHuOMw4Fwo=;
        b=qGmeBTPs7/1NfMIWORwmMkkfNLkaYdkfgi6w4xCxZgwP10oiKf4+DsICDzS4n+nxHP
         6s/Csu7XJ9Lu5N18W0efNz9eA6DOjisIq2GiWAsP1eXMFXtAV3BuZ5yj5R0cSsiKDemC
         D5TSLPUNooFHlapFQLVFvWqKuvbR2rtbW8cvTKtj0Yh15pCI8epliliq9HEInCURGe26
         /hw5Lhajy7x0ybxBBURNMYoiNYuhFc/GATQ/qeRT4oVNYA2Y6I/GreNkemzRP+YlV3XW
         +t4JdeGLDc+6awDqSXlWSBZzKvrJoNReYHpFFulH6ravER8gKrFS2pSVNcfkVgjkJA1n
         y0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995586; x=1778600386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/yyOr/4pj99tbSJw4a+KNInaif0dFyRreHuOMw4Fwo=;
        b=Zq6BvzN7n/ipvtvmAvxwE5VDFZayw2Ru7k4FZ9XEgt7Nvof23Hy1Ik+NNBmO/x3RfV
         jrg/W0tA6a101kgZh9lx/MjRW46Q6RdYpd4Ol7+Lp0HxN0pUiFr+iKUT9TlKU9L0V+Cf
         i0OUrpl4kyc82+7cI5+s4OQRTzuceB65euaA+bHb1ACcppBPyGbhy3UZwMn1aSTAg47r
         m/KX81MO3Htw65cUEqiWawjh6fiKqo6ecaDdK5c3w2lPnYNCbeCbpFtLjxCU01RZopFl
         lfQdamEpO+RxrEgh2Eux95ZrSza5ZrITNBmDYiEfBqLv/htIm167bTtpPvZafP4Z6fRg
         8gGA==
X-Forwarded-Encrypted: i=1; AFNElJ9vUPTmZ7JwHt6KSiQaeoDxjTo1opWCJuY/WCpigxDQa32+0bef4DqOC4pYp4b2k1ENY3LpQyZbUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwftjfE5cK5YSkAEL2j0jszYHVUuFLahYf0uvN0bmzHaX1SzGmu
	OeUHQQ8hcNYE4TGnok35PjTfdzgWv9r8/v46yIG9kZktlvcWpvXEDvPb
X-Gm-Gg: AeBDiesWeM5XGLKQeXZ8/8IlRPnQ/CBNgWQAopbZDooY+IFVuwhrSc+DQI9Z6YDuH7B
	MAzuzLIhb2xAobhqK9exnbyI5amDg+GcTEe7tNoUp7ICkUJc64gdwvgS8B+AxpbhKRkkFUpSewo
	UskfPjRLbVp6IwjpP6W+AZQNEtEcWZQs9ijaHixOI02GNrVTva7sMnqyJy7BKPvMvsgBBRfsumy
	STl0zMTEFvsfjyN+nIkff69BSM5PqrH/9GYthOJ+HwujoJTcFWBS2iBv4V8v6zccTryDIMuX1kU
	h0QCH9MU8NU+OaUoE8/vuxCzTRCaO8HFnLw7ekD0/SfNhrfKTW3nhoJMNKIABDEJhSqZDRK7afl
	N7XYjAYCNCudYnn5l6i2PeqBrZ5famGKIsy0O4s4vfhiBt0gSnE0g6pLewpo0JYpeVbKjqAKaWQ
	C5wNnY9TiNLkNaFfhQ72ZGm2abnsI6X3Es3JIeQrDl3LPbqG+AhYv8
X-Received: by 2002:a05:6808:e64b:b0:467:da0d:537e with SMTP id 5614622812f47-47d260dcc6cmr1641681b6e.7.1777995585821;
        Tue, 05 May 2026 08:39:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b33c1sm8866816b6e.1.2026.05.05.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:44 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [PATCH v6 21/22] vswap: batch contiguous vswap free calls
Date: Tue,  5 May 2026 08:38:50 -0700
Message-ID: <20260505153854.1612033-22-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vswap_free(), we release and reacquire the cluster lock for every
single entry, even for non-disk-swap backends where the lock drop is
unnecessary. Batch consecutive free operations to avoid this overhead.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/vswap.c | 97 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/mm/vswap.c b/mm/vswap.c
index 3f86bbb3a5ea..f07e6d9ec1df 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -529,18 +529,18 @@ static void vswap_cluster_free(struct vswap_cluster *cluster)
 	call_rcu(&cluster->rcu, vswap_cluster_free_rcu);
 }
 
-static inline void release_vswap_slot(struct vswap_cluster *cluster,
-		unsigned long index)
+static inline void release_vswap_slot_nr(struct vswap_cluster *cluster,
+		unsigned long index, int nr)
 {
 	unsigned long slot_index = VSWAP_IDX_WITHIN_CLUSTER_VAL(index);
 
 	lockdep_assert_held(&cluster->lock);
-	cluster->count--;
+	cluster->count -= nr;
 
-	bitmap_clear(cluster->bitmap, slot_index, 1);
+	bitmap_clear(cluster->bitmap, slot_index, nr);
 
 	/* we only free uncached empty clusters */
-	if (refcount_dec_and_test(&cluster->refcnt))
+	if (refcount_sub_and_test(nr, &cluster->refcnt))
 		vswap_cluster_free(cluster);
 	else if (cluster->full && cluster_is_alloc_candidate(cluster)) {
 		cluster->full = false;
@@ -553,7 +553,7 @@ static inline void release_vswap_slot(struct vswap_cluster *cluster,
 		}
 	}
 
-	atomic_dec(&vswap_used);
+	atomic_sub(nr, &vswap_used);
 }
 
 /*
@@ -585,7 +585,7 @@ static unsigned short swp_desc_memcgid(struct swp_desc *desc);
  *
  * 1. Callers ensure no concurrent modification of the swap entry's internal
  *    state can occur. This is guaranteed by one of the following:
- *    - For vswap_free() callers: the swap entry's refcnt (swap count and
+ *    - For vswap_free_nr() callers: the swap entry's refcnt (swap count and
  *      swapcache pin) is down to 0.
  *    - For vswap_store_folio(), swap_zeromap_folio_set(), and zswap_entry_store()
  *      callers: the folio is locked and in the swap cache.
@@ -706,26 +706,17 @@ static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
 
 /*
  * Entered with the cluster locked. The cluster lock is held throughout.
- *
- * This is safe, because:
- *
- * 1. The swap entry to be freed has refcnt (swap count and swapcache pin)
- *    down to 0, so no one can change its internal state.
- *
- * 2. The swap entry to be freed still holds a refcnt to the cluster, keeping
- *    the cluster itself valid.
- *
- * 3. swap_slot_free_nr() takes the physical swap cluster lock (ci->lock),
- *    but the only vswap function called under ci->lock is vswap_rmap_set(),
- *    which uses atomic ops and does not take cluster->lock. So there is no
- *    ABBA deadlock risk.
  */
-static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
-	swp_entry_t entry)
+static void vswap_free_nr(struct vswap_cluster *cluster, swp_entry_t entry,
+		int nr)
 {
-	unsigned short id = swp_desc_memcgid(desc);
+	struct swp_desc *desc = __vswap_iter(cluster, entry.val);
+	unsigned short id;
 	struct mem_cgroup *memcg;
 
+	VM_WARN_ON(!desc);
+	id = swp_desc_memcgid(desc);
+
 	/*
 	 * The swap_cgroup id reference taken at swapout time pins this
 	 * memcg until swap_cgroup_clear() runs below, so we can resolve
@@ -733,11 +724,11 @@ static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 	 */
 	memcg = id ? mem_cgroup_from_id(id) : NULL;
 
-	release_backing(cluster, entry, 1, memcg);
-	__vswap_swap_cgroup_clear(cluster, entry, 1, memcg);
+	release_backing(cluster, entry, nr, memcg);
+	__vswap_swap_cgroup_clear(cluster, entry, nr, memcg);
 
-	/* erase forward mapping and release the virtual slot for reallocation */
-	release_vswap_slot(cluster, entry.val);
+	/* erase forward mapping and release the virtual slots for reallocation */
+	release_vswap_slot_nr(cluster, entry.val, nr);
 }
 
 
@@ -908,10 +899,18 @@ static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	bool ret = false;
-	int i;
+	swp_entry_t free_start;
+	unsigned short batch_memcgid = 0;
+	int i, free_nr = 0;
 
+	free_start.val = 0;
 	rcu_read_lock();
 	for (i = 0; i < nr; i++) {
+		/* flush pending free batch at cluster boundary */
+		if (free_nr && !VSWAP_IDX_WITHIN_CLUSTER_VAL(entry.val)) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		desc = vswap_iter(&cluster, entry.val);
 		VM_WARN_ON(!desc);
 		ret |= (desc->swap_count == 1 && desc->in_swapcache);
@@ -919,18 +918,34 @@ static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
 		if (!desc->swap_count && !desc->in_swapcache) {
 			if (xa_is_value(desc->shadow))
 				desc->shadow = NULL;
-			vswap_free(cluster, desc, entry);
-		} else if (!desc->swap_count && desc->in_swapcache &&
-			   desc->type == VSWAP_SWAPFILE) {
+			/* flush at cgroup boundary */
+			if (free_nr &&
+			    swp_desc_memcgid(desc) != batch_memcgid) {
+				vswap_free_nr(cluster, free_start, free_nr);
+				free_nr = 0;
+			}
+			if (!free_nr)
+				batch_memcgid = swp_desc_memcgid(desc);
+			if (!free_nr++)
+				free_start = entry;
+		} else {
+			if (free_nr) {
+				vswap_free_nr(cluster, free_start, free_nr);
+				free_nr = 0;
+			}
 			/*
 			 * swap_count just dropped to 0, but still in swap
 			 * cache. If backed by a physical swap slot, mark it
 			 * so the physical swap allocator can check cheaply.
 			 */
-			swap_rmap_mark_cache_only(desc->slot);
+			if (!desc->swap_count && desc->in_swapcache &&
+			    desc->type == VSWAP_SWAPFILE)
+				swap_rmap_mark_cache_only(desc->slot);
 		}
 		entry.val++;
 	}
+	if (free_nr)
+		vswap_free_nr(cluster, free_start, free_nr);
 	if (cluster)
 		spin_unlock(&cluster->lock);
 	rcu_read_unlock();
@@ -1032,8 +1047,9 @@ bool folio_free_swap(struct folio *folio)
 		VM_WARN_ON_FOLIO(!desc || desc->swap_cache != folio, folio);
 		desc->swap_cache = NULL;
 		desc->in_swapcache = false;
-		vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
 	}
+
+	vswap_free_nr(cluster, entry, nr);
 	spin_unlock_irq(&cluster->lock);
 	rcu_read_unlock();
 
@@ -1095,14 +1111,23 @@ static void __swapcache_clear(struct vswap_cluster *cluster,
 			      swp_entry_t entry, int nr)
 {
 	struct swp_desc *desc;
-	int i;
+	swp_entry_t free_start;
+	int i, free_nr = 0;
 
+	free_start = entry;
 	for (i = 0; i < nr; i++) {
 		desc = __vswap_iter(cluster, entry.val + i);
 		desc->in_swapcache = false;
-		if (!desc->swap_count)
-			vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
+		if (!desc->swap_count) {
+			if (!free_nr++)
+				free_start.val = entry.val + i;
+		} else if (free_nr) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 	}
+	if (free_nr)
+		vswap_free_nr(cluster, free_start, free_nr);
 }
 
 void swapcache_clear(swp_entry_t entry, int nr)
-- 
2.52.0

