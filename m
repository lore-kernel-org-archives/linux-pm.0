Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB339C637
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873027; cv=none; b=qHgfuP9mzkhRRhqWwHDQ59vi84IKEwNY3Q1PpDJmZWW1LPlUPznK8N6RO1GI9HUgLabEU3PsmWbcgOvXbcWcrAI9iwFoSKFVqyWSs68SJ8xfZATNZyu7v2cbp6PoB2H3N8AfoTU9xGWvB5ckUq1u7PqhuRhlsHyhPryRD2b78zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873027; c=relaxed/simple;
	bh=qex24j/fvB5i2Hxp1YyD8djSdhK+3xIGWCRj2JuMS4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqmhh32QESegN6UeodvnxD4b4sPiVbYBR+VY7W53Ktg/ivpsiBNh0kaV0uqPk+mzSFAQVTlUCuYzxeItlmxYNKJeW7/uZuZ8Sw3PAUnF/Xz1iBj4cB2EERhNKGy8+YY9xCTaqWB1j6b7KDi6JziCWAWwbSOSWPZGxOvZjv9r9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPFLMiRj; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPFLMiRj"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4042fe53946so191947fac.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873023; x=1774477823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LyvvsB8h9QhouSf22weZV/t1lxO86Z5/SzpfGB0vfc=;
        b=LPFLMiRjp/Vh3Ey0gniZZWilBC2NdVWSiUdP2K8UBYnb8wT/zBh83oZIL4VrzT3PBf
         3Wi+J1qVvUDFSn5TBRSxfe5NSwjj4gGHQIhOe8JvmGkLWiW3qm9E6iHBsWySZzNbXFEX
         c5Yqp9gBDgLXJ6TONv5CtLEpFWxGMhlzH1uQl7L5EqkNav+H4FEhiyupqDsJUTTzv9qx
         TQeXwDWvT4A+IIblNfDs1TX/g7hnx2MdmT3a8cGjGRHNcGmDQhpG8uQ7jWHL4KWOvtIm
         bFTnvDG+cLVLvvMxukrYPzpijVIX+ez+Wb0j80l8SK1tOvYzRLOiFcnYRNYJkiS3Qy5D
         1KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873023; x=1774477823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7LyvvsB8h9QhouSf22weZV/t1lxO86Z5/SzpfGB0vfc=;
        b=oEVPJwUzmdDWoJhC0WnhkOWgctvCeFxG3IvqviKS4W0AxK4YvicDm8uk9DeXFVRGG7
         ej6QViTiKMkl3Al47f72UxwV5YaLMkILxSF366wboSRNauWe4NRJDKyYmX2Tc7WahC7z
         aMWncKcoLdtA5CLmslhtenDVeJfUoJbTt/C2Ru2CmHYhP70gTJOuS6RFvkxdoXEOB3Ec
         GtGOK+tz6GWrgWV4QFP3OXYn8OxtlazGED4Lbxgzf1YFNmhcJntNBKw8rv6xaywYZ5yS
         IK0dgXMdo8CQJxROImDKzPLCFA5zXt6WeZ8CJTfuMB7DC8MSlUnRUWPi5d6yHMIaPnoY
         gbbA==
X-Forwarded-Encrypted: i=1; AJvYcCVpLdjI4BR0c2sBNsbS5YpiLoR9hupp+SHThz+nG653cQeNzI86UGEmVIvyP2AOauJhCYkDEQmKBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfilhvsAxkTquLKHLKfd6ZqAFbdY67lYlD7qyThq/lJspe1A88
	4VOGBoc8dNpe6koX/cM+M0/rfrXzO7F2DS0oPtl/WYfdS3P11t7ZM1wk
X-Gm-Gg: ATEYQzyt4HpS7h/sGR/0YXJu2dbezAQzKuOfW0FINH44P7IFWWIuO2BRrkLkoUDG2tf
	fdTbGGDrVws3UbWDCtwFvd92pJtzvX6XpYf4olShbdodJn0Yx04YKMY/rdAlg9GzL5rq3xnxNz/
	JYQWtA9dWhIiSdtQtycy9tyXZVi90x7uvFGWztf5WBVr8aIti3bMvB7IZt9ont4DivwDCN1jHW8
	pnaETLz+5I1Wy1ecbmgrTaomZfwU+rMpmzirkjkLqNXbk1rQrEN5U0/VjCat1ckrbeiUm/3IbkE
	WqmCW4KN7KeV30rS3NuMAcBvTUZjCJqHD7hWO5uQ8jrm+zD7eUk0dcG4B1mYj8GWw9FGv6tqF+b
	7fxL3D451sDbHxufDe6Q1pcejkDYPxZhl8pz584smEZdiWw+M/blLguXixh8UwscGWU4FfhKF9O
	6fIioIA2lsmc8x9Kad66Xz2HepaacocYN9Nnk3wVBS5DsylQ==
X-Received: by 2002:a05:6870:ac09:b0:409:77a9:f951 with SMTP id 586e51a60fabf-41bd3f3e873mr3474315fac.11.1773873023263;
        Wed, 18 Mar 2026 15:30:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2d4cb20sm3817722fac.17.2026.03.18.15.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:22 -0700 (PDT)
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
Subject: [PATCH v4 17/21] swapfile: remove zeromap bitmap
Date: Wed, 18 Mar 2026 15:29:48 -0700
Message-ID: <20260318222953.441758-18-nphamcs@gmail.com>
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

Zero swap entries are now treated as a separate, decoupled backend in
the virtual swap layer. The zeromap bitmap of physical swapfile is no
longer used - remove it. This does not have any behavioral change, and
save 1 bit per swap page in terms of memory overhead.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 30 +++++-------------------------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index fa73696733744..cc1ca4ac2946d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -260,7 +260,6 @@ struct swap_info_struct {
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
-	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head full_clusters; /* full clusters list */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 32aa080d96a4d..aeb3575df8a0b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2320,8 +2320,7 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 
 static void setup_swap_info(struct swap_info_struct *si, int prio,
 			    unsigned char *swap_map,
-			    struct swap_cluster_info *cluster_info,
-			    unsigned long *zeromap)
+			    struct swap_cluster_info *cluster_info)
 {
 	si->prio = prio;
 	/*
@@ -2332,7 +2331,6 @@ static void setup_swap_info(struct swap_info_struct *si, int prio,
 	si->avail_list.prio = -si->prio;
 	si->swap_map = swap_map;
 	si->cluster_info = cluster_info;
-	si->zeromap = zeromap;
 }
 
 static void _enable_swap_info(struct swap_info_struct *si)
@@ -2350,12 +2348,11 @@ static void _enable_swap_info(struct swap_info_struct *si)
 
 static void enable_swap_info(struct swap_info_struct *si, int prio,
 				unsigned char *swap_map,
-				struct swap_cluster_info *cluster_info,
-				unsigned long *zeromap)
+				struct swap_cluster_info *cluster_info)
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, prio, swap_map, cluster_info, zeromap);
+	setup_swap_info(si, prio, swap_map, cluster_info);
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
 	/*
@@ -2373,7 +2370,7 @@ static void reinsert_swap_info(struct swap_info_struct *si)
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info, si->zeromap);
+	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info);
 	_enable_swap_info(si);
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
@@ -2444,7 +2441,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
 	unsigned char *swap_map;
-	unsigned long *zeromap;
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -2539,8 +2535,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->swap_file = NULL;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
-	zeromap = p->zeromap;
-	p->zeromap = NULL;
 	maxpages = p->max;
 	cluster_info = p->cluster_info;
 	p->max = 0;
@@ -2552,7 +2546,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
-	kvfree(zeromap);
 	free_cluster_info(cluster_info, maxpages);
 
 	inode = mapping->host;
@@ -3016,7 +3009,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	sector_t span;
 	unsigned long maxpages;
 	unsigned char *swap_map = NULL;
-	unsigned long *zeromap = NULL;
 	struct swap_cluster_info *cluster_info = NULL;
 	struct folio *folio = NULL;
 	struct inode *inode = NULL;
@@ -3122,17 +3114,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	/*
-	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
-	 * be above MAX_PAGE_ORDER incase of a large swap file.
-	 */
-	zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
-				    GFP_KERNEL | __GFP_ZERO);
-	if (!zeromap) {
-		error = -ENOMEM;
-		goto bad_swap_unlock_inode;
-	}
-
 	if (si->bdev && bdev_stable_writes(si->bdev))
 		si->flags |= SWP_STABLE_WRITES;
 
@@ -3199,7 +3180,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	prio = DEF_SWAP_PRIO;
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio = swap_flags & SWAP_FLAG_PRIO_MASK;
-	enable_swap_info(si, prio, swap_map, cluster_info, zeromap);
+	enable_swap_info(si, prio, swap_map, cluster_info);
 
 	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K(si->pages), name->name, si->prio, nr_extents,
@@ -3227,7 +3208,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->flags = 0;
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
-	kvfree(zeromap);
 	if (cluster_info)
 		free_cluster_info(cluster_info, maxpages);
 	if (inced_nr_rotate_swap)
-- 
2.52.0

