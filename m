Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3C309EF2
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047007; cv=none; b=o48mrKTm3pzOYE+QSsXwUCoLH/544Pp6iC3Os71kSprbA5coS/ah1Z7yHo6uwVnHnnW0qIIyTnAQA5hToINdq7Vu/23qGtagVIwcjaczYMVW75XSyx5ZlKXPmPDcFcq8PKwF/FdrEl1lomyUGQfElMBPBtGodU5QPy/Pw+DUM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047007; c=relaxed/simple;
	bh=u1AdhdsV0mwi/EmpLL5f6ETgvddK1j8cv3P2wA1xfGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap+kXDLGFDZqubHU/HFB/8ZCyAcSxjIwB4/+KaU+z8cP0acAS25fjbtjFhmcM+aq4MkHD7UL1+WkBrqC8FQWCUHWzgWDeOC/YR/E8N+YF6WFXP69pR1UI0Oqnv0ujTXW6jKraadYHijDud7pthaZC2nCdz2ov1oUYRlgu8OF/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOesBdNP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOesBdNP"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so2579812a12.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 16:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781047005; x=1781651805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BEyMjwR1iJDcTluKt4LdLmsJ40U+xuFM1tMeziy7aTw=;
        b=dOesBdNPm+pmHnOBcLtw7lwHHRGdWgA7Fdw2oycMyMMfa/AD8gC7fIBqfMEPi229ZE
         a+Qa8ZhX8fqZcNtUku725E7R4oCm4FCxEA/anGV8u4VfZChLt/dJfzMAB5AOHikRI873
         GEYM5TjdXnEhGG5pV6gtsEiDPttoShn5IZ7pX96k9/xMYdsQTbgeLNExH3RIpKsXQXfu
         PtuTuBe8nzzxqU7R4PDUN+0hQA9wY8YHzJaG2ZVXUp5al7kn2nYfPrYKir/DbMTBuZKg
         R6SdXkJJOAKq4TksZ+FjemijtIj0QIOOyYdULuc1ReCZD9oJDKFhLebVDg9xoM4G6XDW
         g1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781047005; x=1781651805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEyMjwR1iJDcTluKt4LdLmsJ40U+xuFM1tMeziy7aTw=;
        b=K7eUSgfp+YoE4BT/UujN4wZJeq2MpKl+5RiVbKLVyU73jijPSefgiLyY41a4doVnBt
         +wPKg3rESjk9jVSAOCPD7BwR5Zpv7uLuh2a4hpikjvZr5JiNuBMJhbu0RIVxucktChpx
         pnzkbl536R1E6HQFEO/z3/AkJa0cxlFHOgDh/TmyKtfGQa7pBI4TsgpC7lC82ZRVROpe
         Ic0/MmDFnFP/sjW+PC6BKK4j/0VCq53zUL56FoXeJpLT/GBE4VtbcPP7qTlQCrQvwI7s
         jdO6mDszxK/5zwF2roGhv1ehQnfIpr9LFvTVO5Dvl2QtHxMvawdw7pGVp8PXnsPAF5Wt
         53XA==
X-Forwarded-Encrypted: i=1; AFNElJ/1gD8nfDArVxzIlrKUtLiTmukzZYWmDcxNzRM5zpvrOPjb43Y0lmh+nt0rv0QFjJXCnyGDjItVcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwHMa5Gtnyp0AuZZ+WaU+fJR9hVcx8XgDf4frR8MzDubw5sWXh
	3/Bqix/mu5aS9Tg0M5rtzaUvhXTg/zPJZo7mZU96M4w/KVmRb0JFAQWv
X-Gm-Gg: Acq92OHW6P+560XTYQQK2YwW8AZNhRXZXTZQpGqXFtMlTB+wpcl0Yv/i57r9W+BAWsI
	xKdcsGSJhg80x6uCgT33bHkHHbK/htdTOA3Dkgd0A/zfu2EfkIA6OtElDURpMIBFdkozg5IHMeD
	4bmmMGzFDZIGWEI+mWN32XxK6HpgQd3VZi7XBcwPP7u6xyaOROkLzYUbsKFZ6qtI2YKt9yX+/0q
	nPoqbO3+JM/iNdW6s4maOdfePU/2Nk30nHO5KBHFUakH+nTBVd9XgiqJgC4ucM++0ipyY3g4Vrw
	nNYz5VgEuZyuBt3IMOz2AYAYc5o/9qORBfZUO4KCjbcxbLNS5/WZ5X5cHLAANdU4iD3WqQ3X3r5
	xMKIfKUHNqyF6BTuMusb5a8daPslTcyA4aQ5NxoN2jn12MLJOyJ6lmWPnLX6VGduG61V3+PW2ym
	ibYD2Yizf3fS//NDsd0TGIIx4f6nFg0UriD2j4ykzh2UItcCtg3SGTHCdZpermpOlfVO97sGNKx
	AD3HeLTXbUP6RfWzBmWeiVK4HMIJPigxaJH+v3ZUlnWOxcKL1RHddH+GngixvqrKtVMfPWSVpZV
	6y/jivbVqpDeXQROC4O/iy378MsCZYu55jk+4xvUU7TQJs7GDu+U
X-Received: by 2002:a05:6a20:3d1f:b0:3a1:ed2a:1a4f with SMTP id adf61e73a8af0-3b4ccd6ac48mr26822178637.16.1781047005127;
        Tue, 09 Jun 2026 16:16:45 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04311bsm18941479a12.9.2026.06.09.16.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:16:44 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: rafael@kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: hibernate: Mark undocumented snapshot helpers as non-kernel-doc
Date: Wed, 10 Jun 2026 07:16:26 +0800
Message-ID: <20260609231626.38839-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several helpers in snapshot.c are introduced with kernel-doc (/**)
comment blocks but do not describe their parameters with @param
tags.This emits warnings when building
with extra warnings enabled (make W=1), for example:
kernel/power/snapshot.c:469: warning: Function parameter or member
    'zone' not described in 'add_rtree_block'
kernel/power/snapshot.c:469: warning: Function parameter or member
    'gfp_mask' not described in 'add_rtree_block'
kernel/power/snapshot.c:469: warning: Function parameter or member
    'safe_needed' not described in 'add_rtree_block'
kernel/power/snapshot.c:469: warning: Function parameter or member
    'ca' not described in 'add_rtree_block'

These are file-local implementation details, not part of the
exported kernel API documented under Documentation/. Replace the
kernel-doc markers with plain block comments for the affected
functions.

Properly documented symbols such as
alloc_rtree_node(), snapshot_read_next() and snapshot_write_next()
remain unchanged.

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 kernel/power/snapshot.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index a564650734dc..552958f58359 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -458,7 +458,7 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp_mask, int safe_needed,
 	return node;
 }
 
-/**
+/*
  * add_rtree_block - Add a new leave node to the radix tree.
  *
  * The leave nodes need to be allocated in order to keep the leaves
@@ -528,7 +528,7 @@ static int add_rtree_block(struct mem_zone_bm_rtree *zone, gfp_t gfp_mask,
 static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
 			       int clear_nosave_free);
 
-/**
+/*
  * create_zone_bm_rtree - Create a radix tree for one zone.
  *
  * Allocated the mem_zone_bm_rtree structure and initializes it.
@@ -566,7 +566,7 @@ static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
 	return zone;
 }
 
-/**
+/*
  * free_zone_bm_rtree - Free the memory of the radix tree.
  *
  * Free all node pages of the radix tree. The mem_zone_bm_rtree
@@ -678,7 +678,7 @@ static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 	return 0;
 }
 
-/**
+/*
  * memory_bm_create - Allocate memory for a memory bitmap.
  */
 static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
@@ -720,7 +720,7 @@ static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 	goto Exit;
 }
 
-/**
+/*
  * memory_bm_free - Free memory occupied by the memory bitmap.
  * @bm: Memory bitmap.
  */
@@ -736,7 +736,7 @@ static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
 	INIT_LIST_HEAD(&bm->zones);
 }
 
-/**
+/*
  * memory_bm_find_bit - Find the bit for a given PFN in a memory bitmap.
  *
  * Find the bit in memory bitmap @bm that corresponds to the given PFN.
@@ -988,7 +988,7 @@ static void memory_bm_recycle(struct memory_bitmap *bm)
 	}
 }
 
-/**
+/*
  * register_nosave_region - Register a region of unsaveable memory.
  *
  * Register a range of page frames the contents of which should not be saved
@@ -1305,7 +1305,7 @@ static unsigned int count_free_highmem_pages(void)
 	return cnt;
 }
 
-/**
+/*
  * saveable_highmem_page - Check if a highmem page is saveable.
  *
  * Determine whether a highmem page should be included in a hibernation image.
@@ -1362,7 +1362,7 @@ static unsigned int count_highmem_pages(void)
 }
 #endif /* CONFIG_HIGHMEM */
 
-/**
+/*
  * saveable_page - Check if the given page is saveable.
  *
  * Determine whether a non-highmem page should be included in a hibernation
@@ -1440,7 +1440,7 @@ static inline bool do_copy_page(long *dst, long *src)
 	return !z;
 }
 
-/**
+/*
  * safe_copy_page - Copy a page in a safe way.
  *
  * Check if the page we are going to copy is marked as present in the kernel
@@ -1687,7 +1687,7 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
 	return preallocate_image_pages(nr_pages, GFP_IMAGE | __GFP_HIGHMEM);
 }
 
-/**
+/*
  *  __fraction - Compute (an approximation of) x * (multiplier / base).
  */
 static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
@@ -1982,7 +1982,7 @@ int hibernate_preallocate_memory(void)
 }
 
 #ifdef CONFIG_HIGHMEM
-/**
+/*
  * count_pages_for_highmem - Count non-highmem pages needed for copying highmem.
  *
  * Compute the number of non-highmem pages that will be necessary for creating
@@ -2003,7 +2003,7 @@ static unsigned int count_pages_for_highmem(unsigned int nr_highmem)
 static unsigned int count_pages_for_highmem(unsigned int nr_highmem) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
-/**
+/*
  * enough_free_mem - Check if there is enough free memory for the image.
  */
 static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
@@ -2023,7 +2023,7 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 }
 
 #ifdef CONFIG_HIGHMEM
-/**
+/*
  * get_highmem_buffer - Allocate a buffer for highmem pages.
  *
  * If there are some highmem pages in the hibernation image, we may need a
@@ -2035,7 +2035,7 @@ static inline int get_highmem_buffer(int safe_needed)
 	return buffer ? 0 : -ENOMEM;
 }
 
-/**
+/*
  * alloc_highmem_pages - Allocate some highmem pages for the image.
  *
  * Try to allocate as many pages as needed, but if the number of free highmem
@@ -2065,7 +2065,7 @@ static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
 					       unsigned int n) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
-/**
+/*
  * swsusp_alloc - Allocate memory for hibernation image.
  *
  * We first try to allocate as many highmem pages as there are
@@ -2292,7 +2292,7 @@ static void duplicate_memory_bitmap(struct memory_bitmap *dst,
 	}
 }
 
-/**
+/*
  * mark_unsafe_pages - Mark pages that were used before hibernation.
  *
  * Mark the pages that cannot be used for storing the image during restoration,
@@ -2330,7 +2330,7 @@ static int check_header(struct swsusp_info *info)
 	return 0;
 }
 
-/**
+/*
  * load_header - Check the image header and copy the data from it.
  */
 static int load_header(struct swsusp_info *info)
@@ -2483,7 +2483,7 @@ static int prepare_highmem_image(struct memory_bitmap *bm,
 
 static struct page *last_highmem_page;
 
-/**
+/*
  * get_highmem_page_buffer - Prepare a buffer to store a highmem image page.
  *
  * For a given highmem image page get a buffer that suspend_write_next() should
@@ -2706,7 +2706,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 	return error;
 }
 
-/**
+/*
  * get_buffer - Get the address to store the next image data page.
  *
  * Get the address that snapshot_write_next() should return to its caller to
@@ -2843,7 +2843,7 @@ int snapshot_write_next(struct snapshot_handle *handle)
 	return PAGE_SIZE;
 }
 
-/**
+/*
  * snapshot_write_finalize - Complete the loading of a hibernation image.
  *
  * Must be called after the last call to snapshot_write_next() in case the last
-- 
2.47.3

