Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D9235EDA9
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587939; cv=none; b=L1M4nxjTGzvhYcMXTGpp/lTVE4bSlAh/9HVq7lIF1b3uUgf3zp6hVI1mRCw8DyQu3lLRMus9K2lnYq+9xQXkYzDNfWYtndI/hjyFje0C3j9k7l8ln3ocMayx6PC7KUg8qbn4OxFqW1ZHUqbLH7cJunD/GgtYgJ07amerf0uHA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587939; c=relaxed/simple;
	bh=K9PmpF4kbVu6ILPHk8wqR1G3rBTWjZhGbr2v5i6EdoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhcKm4FfN2fXSt/g8q8dFjhamxm134TC0mR9OPEjIbNdGVKtApM2/LwtFi0CFtlVU2egihcxGtymxSTQAamiuFKbFYaj51rD9I6VuCFSYiPgDxgPSMV3qjxiHwCKq1OZncgd5bjtmvuw/+wcuSHZHbhdwiVYmw5YygnRxTwRr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1oaq3Bn; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1oaq3Bn"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45effa36240so2685557b6e.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 13:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587938; x=1771192738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br8/Kp0dBiDnoT9vYl1sItOdYWaxT3y8ap5a4tIpuAg=;
        b=F1oaq3Bnt8jDbn0tVnE2PGBKUeKJKvXvkfCJoBFZ+5VIlMddyCHsVpw80dZwRttfDQ
         dZHYsFLQvKpLimoM7PtR3WCTYfVLKdqpQXZxFVbgxKvNV0rx5zOaFWvv7nKKNHHCJO0u
         bvKJQPup5+fEa/jKYohF3Mxb32Porh4KSuAzlXd24gkVAcn7S6zX33Syx14kpw9MFjTG
         Ks3mooiqSvQ9y6keqSBsH2r+tIS3+iDhOUZo5HwNNb84mQmjPJnOlfoy8GK04Zo69ecT
         ODL6QTgWNtICIh0DhUS6ePzW9hU6TYhMMl1ILdcN8RUqBJ5lys0IrV+qYa38LjXQ8bMQ
         jlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587938; x=1771192738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Br8/Kp0dBiDnoT9vYl1sItOdYWaxT3y8ap5a4tIpuAg=;
        b=MtRJjDfUdUJYYLtQyZqQqEGzsi4gAJvqQgTrHReU/vn3v/ymhTqn51DnVB6c8hnNjM
         28/H23pbpdQjRM54vNBQzaDD25LAcuNBpPKP5JoJswBzRKE2UHt90rxF9+nfBiPoLccZ
         tNRT55Fp5FDqXKOJVEneUGNP7JfxOEi1bsIpent2spB0SOMWZBZwt61Ypq0zu/BGAzUv
         ws8nJ03EGz50AmYMxEqofPEAXm7QIOilQeyExAXgHNopnyPBQi4H3ajZ09KcoKagum5M
         6xlsbQfvSoSJog5SKMUN2GxLM0W1ykP5QsB0rKzsPNX6qliPPIsJLBhPRvi4no2Voejf
         HMpA==
X-Forwarded-Encrypted: i=1; AJvYcCVqhs9sOFb7JwL+E3SyPOnHx0+8ciyra+xZvloLVUQOnat9lCT0f5ys/mEP61wF1uUYGbc9UAYQIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPA1KjLRuwAbTPMO1AvvYV9URYTfndbqSiS3pz/RT9k+IZozo0
	pCYHbEaJawOeQ3GCRUw2hz47XD5k2syaIzI1amhoQU/DRc+lkzutcjZZ
X-Gm-Gg: AZuq6aKOL43Al5ShROmrDImrBD57NTjvvC8ot4W9QkW6aHpOPCEYzOE6hM+xCtnCQh7
	IHMNY1BATOkZfyK11MRHePwga8uq8uBHlhMEWxjEgBS5eZMEXjJeREZqKW5oeN5v7mKhk4OhUMa
	vevHNYswiVLSPEkRMeNvqNNGjQYSrp80TJy9BKJ0NHtd4uf7L5mcGX2C6OAwctPZNccasxSF2Zm
	Iuo6C9QItGROFqNU6Z2hS4L9IfspBMoho/Y5gkLxF0NYHKgqVDVHEZphc0xZpiSbvhtRYVd4WJW
	Z95UNdCQSE/qECIVpRhFr6yxb0IWT7wIHkffpxUa7beg3QoKvS9zWLMGlCBMZlLBdmeGyXjkVu4
	M6npIpoAHJ7AOEoIzP7Pz4efZ3CWiWkrnk5cxR8MtPPT5vh3gAfNFQAGYuZ+1e2pDkPA3Qb4SDg
	lTBmZ3RC1RlX/Qa6Z43HEFUbGenI1ijwSy
X-Received: by 2002:a05:6808:6b8e:b0:450:b215:8f22 with SMTP id 5614622812f47-462fcb81536mr4957989b6e.55.1770587938562;
        Sun, 08 Feb 2026 13:58:58 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4646fb89fsm6346818a34.1.2026.02.08.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:58:58 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 08/20] zswap: prepare zswap for swap virtualization
Date: Sun,  8 Feb 2026 13:58:21 -0800
Message-ID: <20260208215839.87595-9-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zswap tree code, specifically the range partition logic, can no
longer easily be reused for the new virtual swap space design. Use a
simple unified zswap tree in the new implementation for now.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zswap.h |  7 -----
 mm/swapfile.c         |  9 +-----
 mm/zswap.c            | 69 +++++++------------------------------------
 3 files changed, 11 insertions(+), 74 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 30c193a1207e1..1a04caf283dc8 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -28,8 +28,6 @@ unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 int zswap_load(struct folio *folio);
 void zswap_invalidate(swp_entry_t swp);
-int zswap_swapon(int type, unsigned long nr_pages);
-void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
@@ -50,11 +48,6 @@ static inline int zswap_load(struct folio *folio)
 }
 
 static inline void zswap_invalidate(swp_entry_t swp) {}
-static inline int zswap_swapon(int type, unsigned long nr_pages)
-{
-	return 0;
-}
-static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
 static inline void zswap_folio_swapin(struct folio *folio) {}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4b4126d4e2769..3f70df488c1da 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2970,7 +2970,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
 	arch_swap_invalidate_area(p->type);
-	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
@@ -3613,10 +3612,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		}
 	}
 
-	error = zswap_swapon(si->type, maxpages);
-	if (error)
-		goto bad_swap_unlock_inode;
-
 	/*
 	 * Flush any pending IO and dirty mappings before we start using this
 	 * swap device.
@@ -3625,7 +3620,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	error = inode_drain_writes(inode);
 	if (error) {
 		inode->i_flags &= ~S_SWAPFILE;
-		goto free_swap_zswap;
+		goto bad_swap_unlock_inode;
 	}
 
 	mutex_lock(&swapon_mutex);
@@ -3648,8 +3643,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	error = 0;
 	goto out;
-free_swap_zswap:
-	zswap_swapoff(si->type);
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
diff --git a/mm/zswap.c b/mm/zswap.c
index a5a3f068bd1a6..f7313261673ff 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -197,8 +197,6 @@ struct zswap_entry {
 	struct list_head lru;
 };
 
-static struct xarray *zswap_trees[MAX_SWAPFILES];
-static unsigned int nr_zswap_trees[MAX_SWAPFILES];
 
 /* RCU-protected iteration */
 static LIST_HEAD(zswap_pools);
@@ -225,45 +223,35 @@ static bool zswap_has_pool;
 * helpers and fwd declarations
 **********************************/
 
-/* One swap address space for each 64M swap space */
-#define ZSWAP_ADDRESS_SPACE_SHIFT 14
-#define ZSWAP_ADDRESS_SPACE_PAGES (1 << ZSWAP_ADDRESS_SPACE_SHIFT)
-static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
-{
-	return &zswap_trees[swp_type(swp)][swp_offset(swp)
-		>> ZSWAP_ADDRESS_SPACE_SHIFT];
-}
+static DEFINE_XARRAY(zswap_tree);
+
+#define zswap_tree_index(entry)	(entry.val)
 
 static inline void *zswap_entry_store(swp_entry_t swpentry,
 		struct zswap_entry *entry)
 {
-	struct xarray *tree = swap_zswap_tree(swpentry);
-	pgoff_t offset = swp_offset(swpentry);
+	pgoff_t offset = zswap_tree_index(swpentry);
 
-	return xa_store(tree, offset, entry, GFP_KERNEL);
+	return xa_store(&zswap_tree, offset, entry, GFP_KERNEL);
 }
 
 static inline void *zswap_entry_load(swp_entry_t swpentry)
 {
-	struct xarray *tree = swap_zswap_tree(swpentry);
-	pgoff_t offset = swp_offset(swpentry);
+	pgoff_t offset = zswap_tree_index(swpentry);
 
-	return xa_load(tree, offset);
+	return xa_load(&zswap_tree, offset);
 }
 
 static inline void *zswap_entry_erase(swp_entry_t swpentry)
 {
-	struct xarray *tree = swap_zswap_tree(swpentry);
-	pgoff_t offset = swp_offset(swpentry);
+	pgoff_t offset = zswap_tree_index(swpentry);
 
-	return xa_erase(tree, offset);
+	return xa_erase(&zswap_tree, offset);
 }
 
 static inline bool zswap_empty(swp_entry_t swpentry)
 {
-	struct xarray *tree = swap_zswap_tree(swpentry);
-
-	return xa_empty(tree);
+	return xa_empty(&zswap_tree);
 }
 
 #define zswap_pool_debug(msg, p)			\
@@ -1691,43 +1679,6 @@ void zswap_invalidate(swp_entry_t swp)
 		zswap_entry_free(entry);
 }
 
-int zswap_swapon(int type, unsigned long nr_pages)
-{
-	struct xarray *trees, *tree;
-	unsigned int nr, i;
-
-	nr = DIV_ROUND_UP(nr_pages, ZSWAP_ADDRESS_SPACE_PAGES);
-	trees = kvcalloc(nr, sizeof(*tree), GFP_KERNEL);
-	if (!trees) {
-		pr_err("alloc failed, zswap disabled for swap type %d\n", type);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < nr; i++)
-		xa_init(trees + i);
-
-	nr_zswap_trees[type] = nr;
-	zswap_trees[type] = trees;
-	return 0;
-}
-
-void zswap_swapoff(int type)
-{
-	struct xarray *trees = zswap_trees[type];
-	unsigned int i;
-
-	if (!trees)
-		return;
-
-	/* try_to_unuse() invalidated all the entries already */
-	for (i = 0; i < nr_zswap_trees[type]; i++)
-		WARN_ON_ONCE(!xa_empty(trees + i));
-
-	kvfree(trees);
-	nr_zswap_trees[type] = 0;
-	zswap_trees[type] = NULL;
-}
-
 /*********************************
 * debugfs functions
 **********************************/
-- 
2.47.3

