Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1548AE1D
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995550; cv=none; b=IdKMTTPCXlMyfq5YNER5N13KIlwnyqeYoXwI0HkybaoaawoBSoSZ2or3CFCSA5o3Sbb2aVmf8QqFuAe7cN94si2DQta0UuQN9x06Z2Idu1PMTHwlXIwoKGjyME4UrOWt/plcV2qYaRB+t/S6q2ye8ctrm8vRyQ/cojDwY8zsxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995550; c=relaxed/simple;
	bh=mkcvMuU5djSo9+vIBFEeZQbilCGEOXeQmpYMwgCper0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjkH9tOHJXf8IYKMRZkx7zHzt5Uz0evfQP3iauv+bMUjBy6uI/3U0gXVfgkgmlJ28xW/J13T/o5tlvn2jDLZMzHN/t5Rlv+U9kiaXV/GJy5Zb3RS+jjSCthTicx6PuiWDT3LZ8K28/EuS4fuu0WEexX/J0eqkkmwN5J++tC6lV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErHjXckL; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErHjXckL"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47c941f7213so1677456b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995546; x=1778600346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KREMUBUXFd40dOrxzMFx0/PDjOEkv9ZqqqX11trPF+8=;
        b=ErHjXckLChm6Ah2bOqUohKMeDi12+YrLEtDX64k3tFBY/1+h+xSFO3G4mF5bynHQlf
         Wcg4SGuiTxPvDthDv9J4SFnaRB6HneaeNxBJTMs8kb7r7Xeo4VhvsOTcT6soLMtHqLjD
         QUv/STKlOxDyZ1fwLitPlz6Xdr1cNOYF/QJVKM7lEiEPEK5tz+M3vKgrEBeGUuv6nTtm
         DYf7qnlQBBZ9KkAHCXwNw+m4bJ2/g8DLxnHw5JUVJ0inhcnh8l+HKG1vGvQiqhNp2+SK
         hi1VHzRRrmfNzGfCblcAJ145BOLlBRoZPSsKtnPJik9e3vs7KstoCiNAUJnQX0MUr/0c
         9uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995546; x=1778600346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KREMUBUXFd40dOrxzMFx0/PDjOEkv9ZqqqX11trPF+8=;
        b=egk4GA61pdRFfNLrZFtAg402423XZo8SxchtW1tiyP0xiLzNQYDBP1PIAX8k+G6jn+
         O69z263183rXDVUhJNx/VNGdSyiPa0VS206aCip8RKGhKV9t0OkOthBm5FtDRtXuJLwb
         C/MxfGJ6rRD+HQ+FD/6V6Vny7mGTP5F8jIdJQ7dOPFWUsdv8f/0nK5Gd3rH6lW2fL2KG
         70iSSFHhWrbYGu1SfUW3QmfiwlMVSUaVMCB311KmCpGQ0rDJubhMXDCS/eDJM29OuNCQ
         F//5Y8PvVVcEXewEkh+6GbWy5++Cen58LLWOTdD9mxKlkQhIcLgwuiIoplrl1X7J6ZYo
         bNhg==
X-Forwarded-Encrypted: i=1; AFNElJ9sB0GQar6R88oTbQIW0O0hwMfvFCSF+7CZPOWvfz3eLZUMw2WXAKXCo2SXmLIfWXbmLNJiLQJyVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJwYD+ZkndgO/FP+kV+yo1DC02eBTX+fZoNVfsqhifAdGcAQ3
	wol1YW8ZmkRBB4eh3/5BghCtVsx7VtyEiA0973F08SqWywq/NdM6Pbld
X-Gm-Gg: AeBDiev84/Jmj4em1UVxJMN4TxL5VnHYXHs3wUf8GsIzMTqOdwlu5Az/F9qY4JdgxXz
	kJU2BmrJsIwLfs3nmUn7SeyUdGFyiVks+QdUR6ewGiT1DZbC+cyRZXlSj07xlJsW+9ytO6SE5Rt
	hY0AXNRJAzH9/OXTDVxAzzEpF5BUNoUNZ+AlEW5pRtfNWqFqsGCYWWullDnhTPDkAuIeWYSJZ08
	Rn1N4tz1rTQggcaYNvcTfxEa9aQiOlxgMLfe/hXwD/JwiU6DgxqgVtq2ubAjy9igwMwgiJiB+eK
	LyqUb1R7805fHPLpAjx+b/TSYCcE53aCh8X8zR+hsA3bgrSBT8NmYZ/0hOIZT8FxzbUPHEKLGdP
	UoDg6FhTrfuOwljqGWuoxeIy/HQb1TUd0CtbCZ6e+HLQGmmb/j1G/Ld6eTjRiSrZcI6Lfi4mwwg
	IyvUuAnfLe15xaUIDyTDDbRIfBqKnkH4Hq1qg3hhaqvXizQUJUS5pcOYjnh0Rf1ox6Zzg=
X-Received: by 2002:a05:6808:1787:b0:467:2a6e:adb3 with SMTP id 5614622812f47-47c892314ddmr6943387b6e.23.1777995546294;
        Tue, 05 May 2026 08:39:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c7640069csm8753456b6e.8.2026.05.05.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:05 -0700 (PDT)
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
Subject: [PATCH v6 04/22] zswap: add new helpers for zswap entry operations
Date: Tue,  5 May 2026 08:38:33 -0700
Message-ID: <20260505153854.1612033-5-nphamcs@gmail.com>
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

Add new helper functions to abstract away zswap entry operations, in
order to facilitate re-implementing these functions when swap is
virtualized.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 59 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 315e4d0d0831..a5a3f068bd1a 100644
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

