Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957103793B1
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873001; cv=none; b=O1YqsJwnFnTTRYw0z9ZsHNmSmNPtXZHTSkXIy/pfPJvDmL8GUIbnoPZ0bVsFPgZxG+bqUzD2zMJ02NbsBNbggqoRLwFDLAGLWHGBGzDqFnA2Ta5tB/4PZ0EBtOF4HfaskH2xV2PmRDy4YFaeODA7nfPDpd+ITzIZPlAXaIiOWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873001; c=relaxed/simple;
	bh=yko9Ai+xXzBPyBtaZDvB4WH97vS9etz/cyKxz4bc+eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWujrnoO7PQlxI8r+z0BSnOmmMZDqemZhrurjcV1Rb5lK2Kftkw3fVf7ycniL2W3PI5wNg+34GEIdhevYtLZCeR4qQfHSPrrzs/eMf+31wNkEEUq76ihvZGJ7JfuxLpYNfC9/1+mgjTWJOup9kCeG4nPWph9e1iOHqa2GoM7IZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Atu4GZM3; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atu4GZM3"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d556c1a79eso377572a34.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773872998; x=1774477798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2YShPZ4Jwzd3oBlE3QRrECRq+KlYIXhWhrhg6PnH0Y=;
        b=Atu4GZM3OtGcOTHstbngzWu4tZMlXNpeqRk1VJLcUbMAcS6rladqYKNcQuiGIAj8YP
         AiklSk4kSQBPVMGklx4JW9RpVO2pCWSTuZ1N2FaUVvsURZ48i1UkmzsXPgSIkSUGjuL0
         qc83PtPLz9V4OYKpNO8s1CICR1v1I2i3nq/2+lSVVxAL+xaUh+Ntr7MMRPmlJ7aXtU5C
         GSBra+9fUtrYyzEqsJ4ayKLpVP++NvkLGmQR+9BSEH/D27Xz8uB/FALeHc8dl14HRrPH
         bhPNRfrmv33BDCWZQOKthNOWiO1mpFqsh4wB2QBJGQoDEAcP6VhipMyI9R0lYQ2K1Gu+
         8tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773872998; x=1774477798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2YShPZ4Jwzd3oBlE3QRrECRq+KlYIXhWhrhg6PnH0Y=;
        b=GkgfSfMVo9XxdrJi5/V8ySpHOGTHwrtZNdtD43lU5Nebkx62QbzBfVBcwUwTmLj1vu
         g01hwsAAUsxQbU9kq6doLtPwpxIBFMECGkNFN2OEwcaH32M/b3NsvWag3YUzPoqZJvIj
         /bti2tHugLr303rOMIin15HIXt2KvIOhnbGMX+wQr3LX29NypvEcaACUpzjpGubcBovR
         D2HrCyLBFYO482K2I5+shT4D+DXHv1lWQKHrfoL+bmLOWi/MmkZ/1MHjjAylStKysYFL
         zv6NczibUoRfkaC5KDEKbIu9vMZ8dkRRcs4qhsQb6mI6dmp1wUIUzteoqRj2mSQ2DLaO
         Qovw==
X-Forwarded-Encrypted: i=1; AJvYcCWDH7ZmBLUY4Pr1chcJ7IX3lbUwO4BXaXRn3IQUVbv8W0CHhMTLOAjWvIMbvk2O12wJWMxJ18OB7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cZBlabldkvOkYiicPXUVUc6Nl1lcP61HEMUq7o9XwHtqrUNa
	oGALU/2ysWdYcDVlyifOmLUuUzcIoAM5DNJVGQkVZwJDjQeiU7JEy++j
X-Gm-Gg: ATEYQzzmmJ9ablSR4nR5QbUV/xKZrNi+OGgVSKd8dzxgYNlOi5TadlFRsaWXquppKm1
	+FoWWLklLrUjqsen4MPHkAJ5ejeNxaZwofNLbBuKKmTgEY2oBVEhFbQGwZwjv+kMwfJR2nrGvn8
	fijN558Tp8RMAc37BuxPG+1SF+vNfMnC+Z73oIWjyOx6w91dsnFmGJn/nU0cbDtvbt98/vw7Q3l
	PyvAnt2Z2ydV8ZjciXzZuRm4ZYG0IhF6O6TOmnQUYB6f2GKiEfTVLZn1YdH4z6cd+RwslQK2TxA
	P9YjhPwYZ3mg9Fk+n3NFo8+86exye81YDH2ievcThv2b8/5F1tkQBHj6U8SwrLYMXBeFO8LjZh3
	CdG7AANH7DVywQgM1qoMCorBuQ+EIgIxN0xawLAsc3a5mvENAjTcs4ikJ07XxFT5QLrhIDBAYrm
	Obhc4oMFjwEc06EVBXch/2WotI/qHT0mzz0W4kJem17yV09A==
X-Received: by 2002:a05:6830:3148:b0:7d7:cda1:36b with SMTP id 46e09a7af769-7d7cda10537mr2804540a34.20.1773872998497;
        Wed, 18 Mar 2026 15:29:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b39e11sm2988989a34.18.2026.03.18.15.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:29:58 -0700 (PDT)
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
	riel@surriel.com
Subject: [PATCH v4 03/21] mm: swap: add an abstract API for locking out swapoff
Date: Wed, 18 Mar 2026 15:29:34 -0700
Message-ID: <20260318222953.441758-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
References: <20260318222953.441758-1-nphamcs@gmail.com>
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
 mm/mincore.c         | 15 +++------------
 mm/shmem.c           | 12 ++++++------
 mm/swap_state.c      | 14 +++++++-------
 mm/userfaultfd.c     | 15 +++++++++------
 mm/zswap.c           |  5 ++---
 7 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index aa29d8ac542d1..3da637b218baf 100644
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
index da360a6eb8a48..90031f833f52e 100644
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
index e5d13eea92347..f3eb771249d67 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -77,19 +77,10 @@ static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
 	if (!softleaf_is_swap(entry))
 		return !shmem;
 
-	/*
-	 * Shmem mapping lookup is lockless, so we need to grab the swap
-	 * device. mincore page table walk locks the PTL, and the swap
-	 * device is stable, avoid touching the si for better performance.
-	 */
-	if (shmem) {
-		si = get_swap_device(entry);
-		if (!si)
-			return 0;
-	}
+	if (!tryget_swap_entry(entry, &si))
+		return 0;
 	folio = swap_cache_get_folio(entry);
-	if (shmem)
-		put_swap_device(si);
+	put_swap_entry(entry, si);
 	/* The swap cache space contains either folio, shadow or NULL */
 	if (folio && !xa_is_value(folio)) {
 		present = folio_test_uptodate(folio);
diff --git a/mm/shmem.c b/mm/shmem.c
index 1db97ef2d14eb..b40be22fa5f09 100644
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
index 34c9d9b243a74..bece18eb540fa 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -538,8 +538,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	pgoff_t ilx;
 	struct folio *folio;
 
-	si = get_swap_device(entry);
-	if (!si)
+	if (!tryget_swap_entry(entry, &si))
 		return NULL;
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
@@ -550,7 +549,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (page_allocated)
 		swap_read_folio(folio, plug);
 
-	put_swap_device(si);
+	put_swap_entry(entry, si);
 	return folio;
 }
 
@@ -763,6 +762,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
 		struct swap_info_struct *si = NULL;
 		softleaf_t entry;
+		bool swapoff_locked = false;
 
 		if (!pte++) {
 			pte = pte_offset_map(vmf->pmd, addr);
@@ -781,14 +781,14 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
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
index e6dfd5f28acd7..25f89eba0438c 100644
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
index ac9b7a60736bc..315e4d0d08311 100644
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

