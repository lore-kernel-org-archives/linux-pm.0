Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA734D934
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034866; cv=none; b=BqgokwVXf7bnp+1EEN/XttmKx/eRDP+8R6sFWGxFc5LFBZY7zaxOEc2fgTjSwNmDTK030DFINaAGNGUlqO1mWEm6GKPRJkFOwFkfcfqawJez/fL6RdCTvLqepuEkJzWR4KZ3BcGqg+dUAYJgOxD9P6e1N/8sWA5K34KwSfUYyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034866; c=relaxed/simple;
	bh=LlHIWMKorAg3gifPtuIPuc9aL19mRqXLOyrlrlnvDI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLGMYDtxtvVJhl/0Orwj2iauHdh10aBNgeh94UPTLZpd47NQH3JJuZUTrB2P3pg4Ql6gieHUwiFGIGDVPelViPG7ON68p8a7kP+zYdilwgjhKx/GtxWI406crR4g5tXm7QRBajruURWGgnUhAECb6EYqbylGeuvhLWd6BFdr4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw+etyR8; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw+etyR8"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4670676ba03so824821b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034863; x=1774639663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHzOeFlaQp2gdFIuNzaMDht2eyy5SJ0a+c6tcwRztv0=;
        b=bw+etyR8tp1SSd0RskyIC6G1hhmgIGhotiXSu6+/EjiyCgvEu18wuEjhIShc2QolQi
         nfXWz6fgEWoUb0cQVKpOmvF3R3a0puoOI5CBdHcm6fMGnGsVpuEieVvgtFybc3J8hWSr
         trPKXpWAifqPTWEuP/xKwQkarcUFZfioJcxYAFBV4RcPk3Q8aOh12KGG8Un3iUL5Otsu
         XsMRxhde/XFicGrtxyu/brRrlth+XWDmNEaaRLH934CggSLsYoxzp2O2y9zC4Wb5i/C/
         Uqq9KDXfdhlDg+KsPAGWTU2Bv3B1kNQ8cCElxnrRENAFC5UZVz0FcXYoAzZuKOfL4iUB
         hrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034863; x=1774639663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHzOeFlaQp2gdFIuNzaMDht2eyy5SJ0a+c6tcwRztv0=;
        b=iW0OuQzCSOTNqFfzUS4R4n/ngWcVdZPiu1jeGcW+g8JK1OMs0l38MDtGEuHjkw1W7k
         pUWvMPVxphwnxWymkck5lIw2rQ1dm9XZK7+f1sw5g5iDtqkHG1vT8BIwEcDuVlq0XAym
         Rkucw0fnVXBN2RNI/hgwd7HpRWbE3CsTXoz97asaLc6oJPqQFMaJ0v4jUKQei07ZqtJT
         P7QmgOCQdj8QQck8dY7BRo7QPcRGjuYa/Bb5VjkUCJ1Z44jIKXlk2GwOI08pQz29d+EK
         pXe/FuehijhRerz7LYB1fuaEWPXF+HlikTbHbHAZyddkzMKW4xVYDetlgC+QonlU3MQn
         hQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeQur5GvgMN1NWYX4hf25ODfr2AqukO1gLdpp2kb9fL7EF78PhgVmxdNe+ExAUqSDowdT3Q0RGlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuCUFom4WLcVU5gscFqXHdFiUBeAM/+64a0AoM6BhnFYi/vdcf
	Evl1TA3Vj+1VKG1zFQ3A12PuMQRl0EyJfT3uhcChwOuOZTeTuQbfxVDr
X-Gm-Gg: ATEYQzwlMbl+prxJS5zgdaTU1kE0wVAQZeNvIjfRan2GY/Ms6VGLZPXYKt4ZVpOKplr
	wru8lyEnLZHxirgUvZQTYPWj0zIDgTUbfs/Nn8heJwWHLQDIIXzDjfJ66D4jupQsdiEomwFrC/e
	xLVvBrBkriBk8NI5qCibSwTOHmj6FUbLl8aw4XsrUsfRb5zuCv8HR6CjsfYorTCUDsp+z8srTxi
	lxeKEM3ig540ppQu6Nx27qtsRFhNflkBjDZ/GpdwDIPwylHJhRjL/cxAgVjWQ4InYeT+hCgNQaW
	Pc1JYcadWUVIcskprc7Ub7EHXisTLih6Mc+IJkjs9/6cIm/st+tYEBV7o3IEZmecu72H2suzyOq
	cUqJ7OKBT0nxE2QmE1NGD5ivHIGqytYtQmPrTmJpy2A+oKQcDSMcWWCYsIvracQ9QtZPg+uUPzY
	bHK70jYho4lcO01AGchmAj85EWVZDHtddieEdmK9t57UtvNki0kHHZX2Wk
X-Received: by 2002:a05:6808:228f:b0:467:2509:c207 with SMTP id 5614622812f47-467e5d9cf3emr2304552b6e.17.1774034862980;
        Fri, 20 Mar 2026 12:27:42 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7ef9c05sm1872071b6e.13.2026.03.20.12.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:41 -0700 (PDT)
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
Subject: [PATCH v5 04/21] zswap: add new helpers for zswap entry operations
Date: Fri, 20 Mar 2026 12:27:18 -0700
Message-ID: <20260320192735.748051-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new helper functions to abstract away zswap entry operations, in
order to facilitate re-implementing these functions when swap is
virtualized.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 59 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 315e4d0d08311..a5a3f068bd1a6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -234,6 +234,38 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 		>> ZSWAP_ADDRESS_SPACE_SHIFT];
 }
 
+static inline void *zswap_entry_store(swp_entry_t swpentry,
+		struct zswap_entry *entry)
+{
+	struct xarray *tree = swap_zswap_tree(swpentry);
+	pgoff_t offset = swp_offset(swpentry);
+
+	return xa_store(tree, offset, entry, GFP_KERNEL);
+}
+
+static inline void *zswap_entry_load(swp_entry_t swpentry)
+{
+	struct xarray *tree = swap_zswap_tree(swpentry);
+	pgoff_t offset = swp_offset(swpentry);
+
+	return xa_load(tree, offset);
+}
+
+static inline void *zswap_entry_erase(swp_entry_t swpentry)
+{
+	struct xarray *tree = swap_zswap_tree(swpentry);
+	pgoff_t offset = swp_offset(swpentry);
+
+	return xa_erase(tree, offset);
+}
+
+static inline bool zswap_empty(swp_entry_t swpentry)
+{
+	struct xarray *tree = swap_zswap_tree(swpentry);
+
+	return xa_empty(tree);
+}
+
 #define zswap_pool_debug(msg, p)			\
 	pr_debug("%s pool %s\n", msg, (p)->tfm_name)
 
@@ -1000,8 +1032,6 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 static int zswap_writeback_entry(struct zswap_entry *entry,
 				 swp_entry_t swpentry)
 {
-	struct xarray *tree;
-	pgoff_t offset = swp_offset(swpentry);
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
@@ -1040,8 +1070,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * old compressed data. Only when this is successful can the entry
 	 * be dereferenced.
 	 */
-	tree = swap_zswap_tree(swpentry);
-	if (entry != xa_load(tree, offset)) {
+	if (entry != zswap_entry_load(swpentry)) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1051,7 +1080,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		goto out;
 	}
 
-	xa_erase(tree, offset);
+	zswap_entry_erase(swpentry);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1427,9 +1456,7 @@ static bool zswap_store_page(struct page *page,
 	if (!zswap_compress(page, entry, pool))
 		goto compress_failed;
 
-	old = xa_store(swap_zswap_tree(page_swpentry),
-		       swp_offset(page_swpentry),
-		       entry, GFP_KERNEL);
+	old = zswap_entry_store(page_swpentry, entry);
 	if (xa_is_err(old)) {
 		int err = xa_err(old);
 
@@ -1563,11 +1590,9 @@ bool zswap_store(struct folio *folio)
 		unsigned type = swp_type(swp);
 		pgoff_t offset = swp_offset(swp);
 		struct zswap_entry *entry;
-		struct xarray *tree;
 
 		for (index = 0; index < nr_pages; ++index) {
-			tree = swap_zswap_tree(swp_entry(type, offset + index));
-			entry = xa_erase(tree, offset + index);
+			entry = zswap_entry_erase(swp_entry(type, offset + index));
 			if (entry)
 				zswap_entry_free(entry);
 		}
@@ -1599,9 +1624,7 @@ bool zswap_store(struct folio *folio)
 int zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-	pgoff_t offset = swp_offset(swp);
 	bool swapcache = folio_test_swapcache(folio);
-	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1619,7 +1642,7 @@ int zswap_load(struct folio *folio)
 		return -EINVAL;
 	}
 
-	entry = xa_load(tree, offset);
+	entry = zswap_entry_load(swp);
 	if (!entry)
 		return -ENOENT;
 
@@ -1648,7 +1671,7 @@ int zswap_load(struct folio *folio)
 	 */
 	if (swapcache) {
 		folio_mark_dirty(folio);
-		xa_erase(tree, offset);
+		zswap_entry_erase(swp);
 		zswap_entry_free(entry);
 	}
 
@@ -1658,14 +1681,12 @@ int zswap_load(struct folio *folio)
 
 void zswap_invalidate(swp_entry_t swp)
 {
-	pgoff_t offset = swp_offset(swp);
-	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
-	if (xa_empty(tree))
+	if (zswap_empty(swp))
 		return;
 
-	entry = xa_erase(tree, offset);
+	entry = zswap_entry_erase(swp);
 	if (entry)
 		zswap_entry_free(entry);
 }
-- 
2.52.0

