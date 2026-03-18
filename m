Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A739385517
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873028; cv=none; b=lMlmkv/J5xWN+3gVt62FfdOkL42qaL7Ja5CmHx4jS0yDrHLEwvQauu2+q2pR3s98nnL6akUYi23Ezq8zBufA+U6/aPH57M2aiTfWXYKjvWCk+56MmNX68lA6YJFrM2oL+d0grmBpj52XIVf3ZUHN7r41AYFi6p4HB6L3W3YiG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873028; c=relaxed/simple;
	bh=fnjImx7VCwMKBpHwkDW1K85lk6CY/A2Ul7Cqjhn0QzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqKZzE9rsdUjwNPktR/WpCxjWQ6sjuqpYRSUIXZQKP/OrTr73uSa310Hdmy9N3RWhy8beZWzT66JAXh2kiVnPXtWfn62IzWEWsBP77+gbgtKAVqROm/baztqqJV4GzY7QPTRLymzoDoLjkgIxPAFtes7e9nPRAWpHlnDJUxGnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODFnzVc8; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODFnzVc8"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so229994a34.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873022; x=1774477822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKrmsaRryTJ5nHXiiuirqMc/v+zxITLhw4bMyN6ZWm0=;
        b=ODFnzVc858qDi1mXZysSz7VqRXZ85fqpT46m+xw2hCc9HoK+NtVe89BIpGAhlBGfyU
         5ezJDUWEqTUnfH7FhbRGCtzJSao3DOonIXH+/ApmLLNzbaIGxGaD9QGgBvPvfFwqMXth
         aN659UwJvSnoeL3AchKQx8fAL8UOMCQVpaIWi4IvXdYuS3kU0hOElHN4vlALkfnXKXwj
         2oMnALciPcEHPy4MUeOKoj/X8Rn5DSoCAsUlfhFXaZCjT6aYTVkpuq99Iuf9aRG+PT55
         fRbqLOmnGkYGR7qFQXb9U3tgQ7ui2Stny67g/GdX2maZCsudg/LosPB3Q2U9xP043z/E
         n1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873022; x=1774477822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKrmsaRryTJ5nHXiiuirqMc/v+zxITLhw4bMyN6ZWm0=;
        b=IZrs6ecAqasOZhiGf0yAyi2/Wa+tt5k8lmIOTdh9GHJtoxxMMcTDgGTnE423T+b75T
         O02KNVZlHNKCrNN9HQsmeXYTT2uIELyClTEQUz2EN30us0122k4X3jcwGpsunXaKrSRS
         P+W2TX3qNKLysjQ8jcHjvBo0/Ol9h+8WFFexaJhSAys9srndBIOrUQ55VwNAUTObpefk
         mjD6S7hhhjBsbIZS4zLqtYZM5NsM872wFwRDrSZRDjyKU8wDc5JZIumTgbtTBy+Gvy+L
         8zr8XFQngf6d8ljXb4PNFUWkpcMZ1GWjEfUppkmYGqN72nGdunk1brd2dZJsIW70iS7M
         OFVg==
X-Forwarded-Encrypted: i=1; AJvYcCVuOw6jsd3kOtjqY1lPDW+Ey7WYdG8CVUMCp4+ws/i3DdqIIgFzlMZOmo8K/4JYgjY7mNAvCHpOxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfl7y6Fs2JtU2o146TQx7qdtBOiTun6oE5txyP8Kqe2l2AuzL
	Iv2yt2cY6EY/dGZAaVEhCUvPtcqyCZ00rvesuEVIURBQ+6yjdtQdbsee
X-Gm-Gg: ATEYQzxp77iytmgOluS5rXbU9+vocxMR8KBR1mSIbRUgrdWpIdVhK39dEM2OibEOze3
	BfABoLqOTjTiIWM3xhTk/+/vr7WYvXuGEw7qTZ7ARNhtT/bjXpVAlaPBbB3wV7nl1Sl3i4ZWkgC
	f6AolQmSbwVa8fhzR2ySJYo+dGranpNSTSrpvPOApZ786azQ7Kg6fzMKhbqCz6OwwfTfRB+WW3l
	fr5bb4WbscVzD2WiAJUpmi4QwZbMI5nnHzLAIgrHU/ZJg7gHfs4+F5drzWva5NKFjzapp/EJS48
	aAtenN3BAh122m/ULtw2ZOkwla9gBIZdBoq1cGbiaRJYBgTf4alfMbx3j9hSfpq0fgtIZpsQSp0
	nUmS+kl8s3tLSwFfDpc+R1y8gesdPYwZl8HfNN7GffJLmLxgvRhQJBFQXRup2jgcpgYieGrf5ig
	ZwLv01zBucENinWzDPzVIwVcbMk+puWmC7JYrxpdNVu2dzEg==
X-Received: by 2002:a05:6830:6af5:b0:7d7:d217:5116 with SMTP id 46e09a7af769-7d7d21752afmr1935454a34.17.1773873022052;
        Wed, 18 Mar 2026 15:30:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b3696asm3133813a34.16.2026.03.18.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:20 -0700 (PDT)
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
Subject: [PATCH v4 16/21] swap: do not unnecesarily pin readahead swap entries
Date: Wed, 18 Mar 2026 15:29:47 -0700
Message-ID: <20260318222953.441758-17-nphamcs@gmail.com>
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

When we perform swap readahead, the target entry is already pinned by
the caller. No need to pin swap entries in the readahead window that
belongs in the same virtual swap cluster as the target swap entry.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap.h       |  1 +
 mm/swap_state.c | 22 +++++++++-------------
 mm/vswap.c      | 10 ++++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index d7981ec82cf49..2229c3485b7e2 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -213,6 +213,7 @@ void swap_cache_lock(swp_entry_t entry);
 void swap_cache_unlock(swp_entry_t entry);
 void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 			   unsigned long vswap, int nr);
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2);
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ad80bf098b63f..e8e0905c7723f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -553,22 +553,18 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		/*
-		 * Readahead entry may come from a device that we are not
-		 * holding a reference to, try to grab a reference, or skip.
-		 *
-		 * XXX: for now, always try to pin the swap entries in the
-		 * readahead window to avoid the annoying conversion to physical
-		 * swap slots. Once we move all swap metadata to virtual swap
-		 * layer, we can simply compare the clusters of the target
-		 * swap entry and the current swap entry, and pin the latter
-		 * swap entry's cluster if it differ from the former's.
+		 * The target entry is already pinned - if the readahead entry
+		 * belongs to the same cluster, it's already protected.
 		 */
-		swapoff_locked = tryget_swap_entry(entry, &si);
-		if (!swapoff_locked)
-			continue;
+		if (!vswap_same_cluster(entry, targ_entry)) {
+			swapoff_locked = tryget_swap_entry(entry, &si);
+			if (!swapoff_locked)
+				continue;
+		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
-		put_swap_entry(entry, si);
+		if (swapoff_locked)
+			put_swap_entry(entry, si);
 		if (!folio)
 			continue;
 		if (page_allocated) {
diff --git a/mm/vswap.c b/mm/vswap.c
index fbb7c6003ad8c..b391511e0f0b9 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -1418,6 +1418,16 @@ void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si)
 	rcu_read_unlock();
 }
 
+/*
+ * Check if two virtual swap entries belong to the same vswap cluster.
+ * Useful for optimizing readahead when entries in the same cluster
+ * share protection from a pinned target entry.
+ */
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2)
+{
+	return VSWAP_CLUSTER_IDX(entry1) == VSWAP_CLUSTER_IDX(entry2);
+}
+
 static int vswap_cpu_dead(unsigned int cpu)
 {
 	struct vswap_cluster *cluster;
-- 
2.52.0

