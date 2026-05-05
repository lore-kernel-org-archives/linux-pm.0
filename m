Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FD481FC4
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995547; cv=none; b=IJmrKkvs9oPToNaDmUt6+eMYi+nv/Nt0QtZDnnvv8KsF/7/DNUBrVtGytZGbzIJLj9E5/5Ws/LXf9Hol/4lb/5IHHMCPPGU6pCKsnBfKFEnqWrRLiRF7030VcGuag5ElRurMJcfz2a/UhObdxy1IiaCWzgYs5O4UrUnPn9WnTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995547; c=relaxed/simple;
	bh=8oglW42b0d7jgBCqsdydX1XONXtNOXCHTChyJjkcRBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLcJyPOzEej5h+AQg7dHfwFUWG8WI6l8AjBWwrtDgd1rzpkfYGTU9b0jnXn4MO1gQYXmdAWGvdfC/fr4WRYG0/7aS/T8d9cK/NdgY1vd0p2u+ronpD4LvGSRc5mH6qadgUjChB4Ml/rs9UY2tVzOecBJg48OG1Bo1Gc29mcT6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYr9b2Kl; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYr9b2Kl"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479dd56d016so3874023b6e.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995544; x=1778600344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDrN5UJNMucxxkduNBtwUT+YIWRTL7z/5dVTQpr2UXk=;
        b=qYr9b2KlOf6aOiCic67aYCSInScJ9O3InPGKxnCVlM6lJYre0XY9FEMUsPqeibUthT
         U7ke5ofyGm3tOz/dgqK+fzu/0VCF4KyC7bcl7F725M2uC5fgvpGHqTMlE66/NLykz24L
         DBIN3ec4kT3hFtSL9kzOTA1D9dsm7BADwCtJjnLmmnw6GXp7wU854nLUQQuWnCBcN3oc
         +WXDY2NmtAp02SWXUenYAGsJLj3QregT0HjGGE8520Xyf2OHj8JsSIqPPjyKn0FACsZ0
         DHvpvicvK9KH89u9ecO9waX3T13Z5m78TniL4NaFwS6f3m0uGnPXYChs9aWOEoSbwkin
         gG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995544; x=1778600344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDrN5UJNMucxxkduNBtwUT+YIWRTL7z/5dVTQpr2UXk=;
        b=GQkD/3jAgttFky6q68414TrLeMz6eW8rgdG3ABSwG8P/w5iIti6Xy7RTn3nNXcfZcl
         cjyoFhuJ/awUuQUsO/mrn3te/QOO+7XNLAxLSl5cEYHO5vll5bCxZa9Y0EZ6FqC9do9j
         6o2Uorj8WN+5ZXA/IR3xFdghnbAuMTrCE2NLyQ1CypD5IWAJQJeV7czEu2iNpoThCQnl
         7LTV9Nr9CNM5HByWHYrQhi7rgE55XqsuntNWZ+RW53+3Bfp6ra1B2uDflXcHQKuBi76V
         x+e86PRE5Xq4UH45izuAipgShks2x7WnvIG8a97GmGmoq5VYlJL5qnxntPyqSG2GiP6d
         fRxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/x4CymI6QvKo+aMZ5V0SJ9pUAFACoFU/31Ft6eEzm0kfBdjDEaKdEiS+u5l9weSqvE+nhJ51s/UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqZVXyY9mg3PP6J0jqczk7L3fg/vOQafgnsLXqgtJSTV+Y6vl
	JVPi/ZnakU++rkSOKW0w41GBc9Vn7Rvsfl9QUyu2NKk6pDh2y9/S/wmg
X-Gm-Gg: AeBDiesv4INH8Dx4/odAJqE+veK4P8QABd4CdLDLO3XKGLDL3bEvqrC/uSg1Tn2WNGK
	jZUxiai08DYfqkPKGuDL3vbKYh32vJWEC1mQNI1i0EMlt5Ri8wkO60W0UT071/lI86N5VxeEsSS
	RbLbCs6RkFOocltMIl3crRTN3emfp2nsaOlQL0RNMhuJqZyrWvPTsD90OFKHkObccsvc/YGQPZC
	7F1eGNU4H+1A04VLHR4FE1XmiRLQs6iFUGD578CPRryhCx8VRNobYfLrSIySSVM47ykyGZyy87C
	P3DDRXTIgldYOhZDktoXS04Nmu1w2DKvGfydBMiUe8640nhHAkQaTktqE1TS8mnVTtZfsxjULBJ
	DGbnqyXLA4BNriqj4UjebJdoRfxCvbiTJ6wdImLj6k3IkhShtDow1Mp1d7IuQQ8ICjpe/ISd9fO
	uRubySMuj0dF4cPdZy6zkuDyl6ObIAri0pdhpjdt8cWvN0wY+ihdrSCQwxiUjOBgRpFhc=
X-Received: by 2002:a05:6808:1446:b0:45e:f0af:5148 with SMTP id 5614622812f47-47c892315e3mr7434984b6e.30.1777995543417;
        Tue, 05 May 2026 08:39:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76935904sm8701006b6e.11.2026.05.05.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:02 -0700 (PDT)
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
Subject: [PATCH v6 03/22] mm: swap: add an abstract API for locking out swapoff
Date: Tue,  5 May 2026 08:38:32 -0700
Message-ID: <20260505153854.1612033-4-nphamcs@gmail.com>
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

Currently, we get a reference to the backing swap device in order to
prevent swapoff from freeing the metadata of a swap entry. This does not
make sense in the new virtual swap design, especially after the swap
backends are decoupled - a swap entry might not have any backing swap
device at all, and its backend might change at any time during its
lifetime.

In preparation for this, abstract away the swapoff locking out behavior
into a generic API.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 17 +++++++++++++++++
 mm/memory.c          | 13 +++++++------
 mm/mincore.c         | 15 ++++++---------
 mm/shmem.c           | 12 ++++++------
 mm/swap_state.c      | 14 +++++++-------
 mm/userfaultfd.c     | 15 +++++++++------
 mm/zswap.c           |  5 ++---
 7 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index aa29d8ac542d..3da637b218ba 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -659,5 +659,22 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+static inline bool tryget_swap_entry(swp_entry_t entry,
+				struct swap_info_struct **sip)
+{
+	struct swap_info_struct *si = get_swap_device(entry);
+
+	if (sip)
+		*sip = si;
+
+	return si;
+}
+
+static inline void put_swap_entry(swp_entry_t entry,
+				struct swap_info_struct *si)
+{
+	put_swap_device(si);
+}
+
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff --git a/mm/memory.c b/mm/memory.c
index da360a6eb8a4..90031f833f52 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4630,6 +4630,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool need_clear_cache = false;
+	bool swapoff_locked = false;
 	bool exclusive = false;
 	softleaf_t entry;
 	pte_t pte;
@@ -4698,8 +4699,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* Prevent swapoff from happening to us. */
-	si = get_swap_device(entry);
-	if (unlikely(!si))
+	swapoff_locked = tryget_swap_entry(entry, &si);
+	if (unlikely(!swapoff_locked))
 		goto out;
 
 	folio = swap_cache_get_folio(entry);
@@ -5047,8 +5048,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (waitqueue_active(&swapcache_wq))
 			wake_up(&swapcache_wq);
 	}
-	if (si)
-		put_swap_device(si);
+	if (swapoff_locked)
+		put_swap_entry(entry, si);
 	return ret;
 out_nomap:
 	if (vmf->pte)
@@ -5066,8 +5067,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (waitqueue_active(&swapcache_wq))
 			wake_up(&swapcache_wq);
 	}
-	if (si)
-		put_swap_device(si);
+	if (swapoff_locked)
+		put_swap_entry(entry, si);
 	return ret;
 }
 
diff --git a/mm/mincore.c b/mm/mincore.c
index e5d13eea9234..ee6ce6088d51 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -78,18 +78,15 @@ static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
 		return !shmem;
 
 	/*
-	 * Shmem mapping lookup is lockless, so we need to grab the swap
-	 * device. mincore page table walk locks the PTL, and the swap
-	 * device is stable, avoid touching the si for better performance.
+	 * Shmem mapping lookup is lockless, so we need to pin the swap entry.
+	 * mincore page table walk holds the PTL, which keeps the swap entry
+	 * (and thus its vswap cluster) alive, so skip the pin for performance.
 	 */
-	if (shmem) {
-		si = get_swap_device(entry);
-		if (!si)
-			return 0;
-	}
+	if (shmem && !tryget_swap_entry(entry, &si))
+		return 0;
 	folio = swap_cache_get_folio(entry);
 	if (shmem)
-		put_swap_device(si);
+		put_swap_entry(entry, si);
 	/* The swap cache space contains either folio, shadow or NULL */
 	if (folio && !xa_is_value(folio)) {
 		present = folio_test_uptodate(folio);
diff --git a/mm/shmem.c b/mm/shmem.c
index 1db97ef2d14e..b40be22fa5f0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2307,7 +2307,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	softleaf_t index_entry;
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
-	bool skip_swapcache = false;
+	bool swapoff_locked, skip_swapcache = false;
 	int error, nr_pages, order;
 	pgoff_t offset;
 
@@ -2319,16 +2319,16 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (softleaf_is_poison_marker(index_entry))
 		return -EIO;
 
-	si = get_swap_device(index_entry);
+	swapoff_locked = tryget_swap_entry(index_entry, &si);
 	order = shmem_confirm_swap(mapping, index, index_entry);
-	if (unlikely(!si)) {
+	if (unlikely(!swapoff_locked)) {
 		if (order < 0)
 			return -EEXIST;
 		else
 			return -EINVAL;
 	}
 	if (unlikely(order < 0)) {
-		put_swap_device(si);
+		put_swap_entry(index_entry, si);
 		return -EEXIST;
 	}
 
@@ -2448,7 +2448,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 	folio_mark_dirty(folio);
 	swap_free_nr(swap, nr_pages);
-	put_swap_device(si);
+	put_swap_entry(swap, si);
 
 	*foliop = folio;
 	return 0;
@@ -2466,7 +2466,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		swapcache_clear(si, folio->swap, folio_nr_pages(folio));
 	if (folio)
 		folio_put(folio);
-	put_swap_device(si);
+	put_swap_entry(swap, si);
 
 	return error;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 01212975c00c..7647341e00ed 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -539,8 +539,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	pgoff_t ilx;
 	struct folio *folio;
 
-	si = get_swap_device(entry);
-	if (!si)
+	if (!tryget_swap_entry(entry, &si))
 		return NULL;
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
@@ -551,7 +550,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (page_allocated)
 		swap_read_folio(folio, plug);
 
-	put_swap_device(si);
+	put_swap_entry(entry, si);
 	return folio;
 }
 
@@ -764,6 +763,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
 		struct swap_info_struct *si = NULL;
 		softleaf_t entry;
+		bool swapoff_locked = false;
 
 		if (!pte++) {
 			pte = pte_offset_map(vmf->pmd, addr);
@@ -782,14 +782,14 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		 * holding a reference to, try to grab a reference, or skip.
 		 */
 		if (swp_type(entry) != swp_type(targ_entry)) {
-			si = get_swap_device(entry);
-			if (!si)
+			swapoff_locked = tryget_swap_entry(entry, &si);
+			if (!swapoff_locked)
 				continue;
 		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
-		if (si)
-			put_swap_device(si);
+		if (swapoff_locked)
+			put_swap_entry(entry, si);
 		if (!folio)
 			continue;
 		if (page_allocated) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e6dfd5f28acd..25f89eba0438 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1262,9 +1262,11 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 	pte_t *dst_pte = NULL;
 	pmd_t dummy_pmdval;
 	pmd_t dst_pmdval;
+	softleaf_t entry;
 	struct folio *src_folio = NULL;
 	struct mmu_notifier_range range;
 	long ret = 0;
+	bool swapoff_locked = false;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
 				src_addr, src_addr + len);
@@ -1429,7 +1431,7 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 					len);
 	} else { /* !pte_present() */
 		struct folio *folio = NULL;
-		const softleaf_t entry = softleaf_from_pte(orig_src_pte);
+		entry = softleaf_from_pte(orig_src_pte);
 
 		if (softleaf_is_migration(entry)) {
 			pte_unmap(src_pte);
@@ -1449,8 +1451,8 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 			goto out;
 		}
 
-		si = get_swap_device(entry);
-		if (unlikely(!si)) {
+		swapoff_locked = tryget_swap_entry(entry, &si);
+		if (unlikely(!swapoff_locked)) {
 			ret = -EAGAIN;
 			goto out;
 		}
@@ -1480,8 +1482,9 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 				pte_unmap(src_pte);
 				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
-				put_swap_device(si);
+				put_swap_entry(entry, si);
 				si = NULL;
+				swapoff_locked = false;
 				/* now we can block and wait */
 				folio_lock(src_folio);
 				goto retry;
@@ -1507,8 +1510,8 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 	if (dst_pte)
 		pte_unmap(dst_pte);
 	mmu_notifier_invalidate_range_end(&range);
-	if (si)
-		put_swap_device(si);
+	if (swapoff_locked)
+		put_swap_entry(entry, si);
 
 	return ret;
 }
diff --git a/mm/zswap.c b/mm/zswap.c
index ac9b7a60736b..315e4d0d0831 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1009,14 +1009,13 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
-	si = get_swap_device(swpentry);
-	if (!si)
+	if (!tryget_swap_entry(swpentry, &si))
 		return -EEXIST;
 
 	mpol = get_task_policy(current);
 	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
 			NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
-	put_swap_device(si);
+	put_swap_entry(swpentry, si);
 	if (!folio)
 		return -ENOMEM;
 
-- 
2.52.0

