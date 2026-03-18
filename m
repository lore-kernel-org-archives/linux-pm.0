Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053137E319
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873003; cv=none; b=KLxX0jyd1EM8oGDSBMZcHgnQCQ87MFdzWFQmHKs48BWPUqDc6IWaequCgPsPyCbmbCyjj6sb/6Xq86wlBjG8zpxG/WWRp7mOIbAls3eSAmd73GpXdQtZAs+y/ycKl00zK+FVVNhqBJSrovSu5esLTRRQUHlcivOMuDuetPElhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873003; c=relaxed/simple;
	bh=LlHIWMKorAg3gifPtuIPuc9aL19mRqXLOyrlrlnvDI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZURBXUMjZDoYR8yzACFeIk5u1jsqD1k98KtCP1t5lB2Cvq9B2NKfC17zOK5VtkwAOGJtA1aqH3cGrJySr+Ytr20hiP5fozd49YucvR+zdPndUVPkDbF34ZgxVp3M84XAcA15Y+Ez5XlbZXs0oaSj5P7KlhuVmGZvwKleBR9I8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhHbO/f3; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhHbO/f3"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4670676ba03so37422b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873000; x=1774477800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHzOeFlaQp2gdFIuNzaMDht2eyy5SJ0a+c6tcwRztv0=;
        b=XhHbO/f3jo8AB5TXOeFs00pPzbD51V0Wbh3wEN3A0p+0k+Twh1Osqem/ySLd43vuXn
         GfvmEnjg30QwivcaBnAqboPBBQYjjgA7ppw6ZWhXg2uEgvvkAiwQaDKWlVca87y7dUkV
         E3l/p3L3xvbMbPS8BVyNrbpvA/0BtpzIBEeS/hf1QCNKltstgnScbpyQy6E9a/rqyD98
         bkCUN9cwLJxwNQ+sPelVyrNH/wmYmoq9G9QwKy9zGXpkmFbZMciRIfwVWJV/4iWdvdb/
         nep+XQtb6CB/uByiMd1ouuppUV3XXU5EiJUpSu0JM7MvbbaDDfhz7ACGiB7JZ+UU+td2
         EZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873000; x=1774477800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHzOeFlaQp2gdFIuNzaMDht2eyy5SJ0a+c6tcwRztv0=;
        b=Y6So8RwVCmL3dL7exrflQFU0TL7zZ4stqyG+MwLmFLa6ZSZjB9O6Uftj1Li8WdwvQL
         VVcXhQK59wjd0UkKcU99MKpr08sgq4e38A/D/DjC/sdgxmu0Ab3e3Av6XKiX6ARJ3tLo
         ksynJ+tJjeeWvlsqeq/69PgKhXFB4MpalXm6F9H5zQ5g8QsJBSoxfRJxCAleYGefXOQL
         venI3ZqRVPr4xm1f0kEkXD81T0D/N5cIy4nQH7b585eJsIy+KJa+hI9L2x/mU4bzheq/
         XKB3VirHbNeHLtT4QKKnrVg6M9//AMZk7g2TB9RBc9UBWbG+PW0nDjOmrJLZrVOSiJjF
         MvUA==
X-Forwarded-Encrypted: i=1; AJvYcCXs8pU5nSsUM6b/cdC4Tj3U8/PRWzSgoIqFbOdg388M7zjvpkHWardf33XFZGfbazNPIBT9fdx0RA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MQrqaKQK234znrlJV3ullvYgbI6iiq/W2J9FKOo5vn3Y80Hy
	VoA+qIM96BOLhPdhYQR8mwH1L/zv2iNK3bqmU00HujFCPX2CHfM5WSAm
X-Gm-Gg: ATEYQzzk5Qql6Z9Xoaw6e3krDjcs4JPKWml4u6IghvZ7PwtD3V1TaZLUqKrvLur33L5
	lyYS6GwXf/wbUaYw6lpv6eijjOgq3+/Op9vWxlrPPj2JmWwaQXSaagESK+0Cgx6Bhh2k1r/0BgF
	N6i8geZ4V7EWu0k5+QjonAUMnLbEAlp0eEcTb4v2pchorR+of5avM6sgc5dHuDDLbonMOJW692n
	Pl2huR2CkGUiNs++CVcVydM+cSgO4DjTkERUTDhrI976PupILJN1Y3PWqrN8LfvdYPagGdTj0Al
	MtsN+thzO9nkAYgxTe60yZwbeTaZQsW2GmbhAHxVibORdYj7/vF7cxIJnKxEM+eaoyfhXhcFVZJ
	uo49n28WhlqyE9sVW6xps4gp6NYd25bw5r1OkIfBTcHBcGjOqIjGlCi7y8lW8x8DHvs4bVgH4xv
	K8xCMewQ13gBv0o+sIE91zed2X20B7LexJUWPcMsITd+shTg==
X-Received: by 2002:a05:6808:4f67:b0:450:5e3a:6f20 with SMTP id 5614622812f47-467ba15fab5mr2899816b6e.10.1773873000519;
        Wed, 18 Mar 2026 15:30:00 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467bab02e3esm2553952b6e.17.2026.03.18.15.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:00 -0700 (PDT)
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
Subject: [PATCH v4 04/21] zswap: add new helpers for zswap entry operations
Date: Wed, 18 Mar 2026 15:29:35 -0700
Message-ID: <20260318222953.441758-5-nphamcs@gmail.com>
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

