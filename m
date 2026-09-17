Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA940B112;
	Thu, 17 Sep 2026 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625247; cv=none; b=Tu8ZFXwLkjFEM6lLl2pVtm+QuKh61OI2iRlYcqS56/FnUj65Z4WmpjBeuVASQoQZkUuxBjY66vmCofhfVNFJiWZ7QPoOSnPToFR688oJAMN+sYUx1QdEuEf0ndqdGnpZSXjVV8Wq0gBDnFZnynKY9owTTd4qOs40JNMTGM9itnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625247; c=relaxed/simple;
	bh=Q6cAM4O5eAIwGoWnasxenLK5ozO6cBWnRBeJmTnRmRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+H+jOFMU4arr8L0QaigZrJA7RuwjIiYa9JLULNvx5jGDEvXuCFXqKG+cqMTJ8zoIy9njpoXwfg068C6FX3AJkYghqoEXR0oIEP52fMkAQYbxHXVcNDVHBIX68iBBDZiymu4L5zZVecV1kK5CsPgFN1tWCNTlzfutFHs1ZSd0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfwRWZ5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfwRWZ5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4FF1F00893;
	Thu, 17 Sep 2026 06:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625246;
	bh=mdeE4ROmDNb4ihV9MLQcmwZeFwDitWjg3f1f4fxRfv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hfwRWZ5n23bWhuT0S3T+MfKJw84apNiXIo3e+imvPYjhjNSd5qf64NMcc9+ylF6cM
	 6TdeYdyyvkRrVB+Y4B5ed4bBEZ/krm3nyE8VIXclOfJiglJBPVMi030KSv6mbGRlQb
	 cQFYDckmhlBl33SrWh0j2AWgSF+IYTVxsLJus5aWQgsAzWYRWiL7JPNN31fqLDNlDE
	 xNyUpCMJAq9SUR/sv4HSaukYHEHAa2ixZPW8KNbkXSOrYS19nLmrYrCnIbQe3lJoF0
	 /pwOYnGnPzEyfIPFN1TazbfBPFScShsSVcaYWU/Jy/1nqLLQPHFF598MBHoKlAHRfT
	 NiXJGh9WsmaYg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 17 Sep 2026 09:07:05 +0300
Subject: [PATCH 3/5] hibernate: handle potential errors in
 hibernate_{map,unmap}_page()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-hibernation-v1-3-7f7dfae3dbe0@kernel.org>
References: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
In-Reply-To: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Potapenko <glider@google.com>, 
 David Hildenbrand <david@kernel.org>, Marco Elver <elver@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Len Brown <lenb@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.1-dev

When safe_copy_page() had to map/unmap pages only because of
debug_pagealloc() there could be no errors in the kernel page table
updates.

However, with the increasing desire to remove pages from the direct map
this assumption becomes a real stretch.

Properly handle errors in hibernate_map_page() and hibernate_unmap_page()
and propagate that error along the page copying path.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/power/snapshot.c | 102 +++++++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 40 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index e732bf6389e4c..52ef0599c2076 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -79,37 +79,30 @@ static inline int hibernate_restore_unprotect_page(void *page_address) {return 0
 #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
 
 
-/*
- * The calls to set_direct_map_*() should not fail because remapping a page
- * here means that we only update protection bits in an existing PTE.
- * It is still worth to have a warning here if something changes and this
- * will no longer be the case.
- */
-static inline void hibernate_map_page(struct page *page)
+static inline int hibernate_map_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		int ret = set_direct_map_default_noflush(page, 1);
-
-		if (ret)
-			pr_warn_once("Failed to remap page\n");
+		return set_direct_map_default_noflush(page, 1);
 	} else {
 		debug_pagealloc_map_pages(page, 1);
+		return 0;
 	}
 }
 
-static inline void hibernate_unmap_page(struct page *page)
+static inline int hibernate_unmap_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		unsigned long addr = (unsigned long)page_address(page);
 		int ret  = set_direct_map_invalid_noflush(page, 1);
 
 		if (ret)
-			pr_warn_once("Failed to remap page\n");
+			return ret;
 
 		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 	} else {
 		debug_pagealloc_unmap_pages(page, 1);
 	}
+	return 0;
 }
 
 static int swsusp_page_is_free(struct page *page);
@@ -1449,21 +1442,25 @@ static inline bool do_copy_page(long *dst, long *src)
  * Check if the page we are going to copy is marked as present in the kernel
  * page tables. This always is the case if CONFIG_DEBUG_PAGEALLOC or
  * CONFIG_ARCH_HAS_SET_DIRECT_MAP is not set. In that case kernel_page_present()
- * always returns 'true'. Returns true if the page was entirely composed of
- * zeros, otherwise it will return false.
+ * always returns 'true'.
+ * Sets @zeros_only to true if the page was entirely composed of zeros.
+ *
+ * Returns 0 on success, a negative error code on failure.
  */
-static bool safe_copy_page(void *dst, struct page *s_page)
+static int safe_copy_page(void *dst, struct page *s_page, bool *zeros_only)
 {
-	bool zeros_only;
+	int err;
 
 	if (kernel_page_present(s_page)) {
-		zeros_only = do_copy_page(dst, page_address(s_page));
-	} else {
-		hibernate_map_page(s_page);
-		zeros_only = do_copy_page(dst, page_address(s_page));
-		hibernate_unmap_page(s_page);
+		*zeros_only = do_copy_page(dst, page_address(s_page));
+		return 0;
 	}
-	return zeros_only;
+
+	err = hibernate_map_page(s_page);
+	if (err)
+		return err;
+	*zeros_only = do_copy_page(dst, page_address(s_page));
+	return hibernate_unmap_page(s_page);
 }
 
 #ifdef CONFIG_HIGHMEM
@@ -1473,18 +1470,19 @@ static inline struct page *page_is_saveable(struct zone *zone, unsigned long pfn
 		saveable_highmem_page(zone, pfn) : saveable_page(zone, pfn);
 }
 
-static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn,
+			  bool *zeros_only)
 {
 	struct page *s_page, *d_page;
 	void *src, *dst;
-	bool zeros_only;
+	int err = 0;
 
 	s_page = pfn_to_page(src_pfn);
 	d_page = pfn_to_page(dst_pfn);
 	if (PageHighMem(s_page)) {
 		src = kmap_local_page(s_page);
 		dst = kmap_local_page(d_page);
-		zeros_only = do_copy_page(dst, src);
+		*zeros_only = do_copy_page(dst, src);
 		kunmap_local(dst);
 		kunmap_local(src);
 	} else {
@@ -1493,23 +1491,29 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 			 * The page pointed to by src may contain some kernel
 			 * data modified by kmap_atomic()
 			 */
-			zeros_only = safe_copy_page(buffer, s_page);
+			err = safe_copy_page(buffer, s_page, zeros_only);
+			if (err)
+				goto out;
 			dst = kmap_local_page(d_page);
 			copy_page(dst, buffer);
 			kunmap_local(dst);
 		} else {
-			zeros_only = safe_copy_page(page_address(d_page), s_page);
+			err = safe_copy_page(page_address(d_page), s_page,
+					     zeros_only);
 		}
 	}
-	return zeros_only;
+out:
+	return err;
+
 }
 #else
 #define page_is_saveable(zone, pfn)	saveable_page(zone, pfn)
 
-static inline int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static inline int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn,
+				 bool *zeros_only)
 {
 	return safe_copy_page(page_address(pfn_to_page(dst_pfn)),
-				pfn_to_page(src_pfn));
+				pfn_to_page(src_pfn), zeros_only);
 }
 #endif /* CONFIG_HIGHMEM */
 
@@ -1517,15 +1521,20 @@ static inline int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
  * Copy data pages will copy all pages into pages pulled from the copy_bm.
  * If a page was entirely filled with zeros it will be marked in the zero_bm.
  *
- * Returns the number of pages copied.
+ * Sets @copied_pages to the number of pages copied.
+ *
+ * Returns 0 on success, a negative error code on failure.
  */
-static unsigned long copy_data_pages(struct memory_bitmap *copy_bm,
-			    struct memory_bitmap *orig_bm,
-			    struct memory_bitmap *zero_bm)
+static int copy_data_pages(struct memory_bitmap *copy_bm,
+			   struct memory_bitmap *orig_bm,
+			   struct memory_bitmap *zero_bm,
+			   unsigned int *copied_pages)
 {
-	unsigned long copied_pages = 0;
+	unsigned long nr_pages = 0;
 	struct zone *zone;
 	unsigned long pfn, copy_pfn;
+	bool zeros_only;
+	int err;
 
 	for_each_populated_zone(zone) {
 		unsigned long max_zone_pfn;
@@ -1543,15 +1552,21 @@ static unsigned long copy_data_pages(struct memory_bitmap *copy_bm,
 		pfn = memory_bm_next_pfn(orig_bm);
 		if (unlikely(pfn == BM_END_OF_MAP))
 			break;
-		if (copy_data_page(copy_pfn, pfn)) {
+		err = copy_data_page(copy_pfn, pfn, &zeros_only);
+		if (err)
+			return err;
+
+		if (zeros_only) {
 			memory_bm_set_bit(zero_bm, pfn);
 			/* Use this copy_pfn for a page that is not full of zeros */
 			continue;
 		}
-		copied_pages++;
+		nr_pages++;
 		copy_pfn = memory_bm_next_pfn(copy_bm);
 	}
-	return copied_pages;
+
+	*copied_pages = nr_pages;
+	return 0;
 }
 
 /* Total number of image pages */
@@ -2112,6 +2127,7 @@ static int swsusp_alloc(struct memory_bitmap *copy_bm,
 asmlinkage __visible int swsusp_save(void)
 {
 	unsigned int nr_pages, nr_highmem;
+	int err;
 
 	pm_deferred_pr_dbg("Creating image\n");
 
@@ -2133,7 +2149,9 @@ asmlinkage __visible int swsusp_save(void)
 	 * Kill them.
 	 */
 	drain_local_pages(NULL);
-	nr_copy_pages = copy_data_pages(&copy_bm, &orig_bm, &zero_bm);
+	err = copy_data_pages(&copy_bm, &orig_bm, &zero_bm, &nr_copy_pages);
+	if (err)
+		goto err_swsusp_free;
 
 	/*
 	 * End of critical section. From now on, we can write to memory,
@@ -2149,6 +2167,10 @@ asmlinkage __visible int swsusp_save(void)
 			   nr_copy_pages, nr_zero_pages);
 
 	return 0;
+
+err_swsusp_free:
+	swsusp_free();
+	return err;
 }
 
 #ifndef CONFIG_ARCH_HIBERNATION_HEADER

-- 
2.53.0

