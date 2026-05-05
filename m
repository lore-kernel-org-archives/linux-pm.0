Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0A49218D
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995578; cv=none; b=fQvO52MbY1bSWpx/uVjvsnOKKNfePnWIDAO1Mcg2wMDywrvQICfWvBPsMIPxdKoaYhd76LtYnsOANrjz70tAKkpkutgM8PXXuxq3OPa8Dr4t6dT/9R0x4stLsQS7357aY0+1ZpcaQXKS5+nteGih15xQ+tDj473qph1AuhViU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995578; c=relaxed/simple;
	bh=MJBaUT6A2RIYR2qoIw8yHbgHu52UsZByzeusjHfprfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvIoF56BeuUxpQQDXxj43apAfrWa3fJJ6r7parn5kHQO458wIurktCkk48Q7d13OREo7ZHvj+JqhRVLnhgFrJ3XaJE4hNQTc2wyerCLpjxg2aG89gMMW3Ns2gNC2RAyXS7TrIfhKFjMaRJud4zhLWJiiU85GGkqM4k0Kowx5w6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRUalMev; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRUalMev"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-42fc6923f38so3697089fac.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995575; x=1778600375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIXfyZUJZPSdof5KqpSbjmh+gBcKfo2nAX8OXquADG0=;
        b=PRUalMevVH9h+z3l+p5EldFm6KECfI6+N/2xxVk3UNUFVgHTvK7z0USxRpV7ZyqZUS
         ZJeMkqh88+XhcQ2m6KndcaxxheTYbiiT6dmq9w/XvopCLdjtUIBpk4Dj2q0XuR7ZCa4P
         YkLWHB3BMtDzD/lAwSlyz784cVIeAkysq5vJQ4c7U7F0+gbrVKm9OM6WeWZTjFuRPB8/
         VGJSxmOu3oOgNk4317Y5RVoZptEmF9eC9gbtQ6JhwlPHRQqWp4N/06yovgAasjZUk1OL
         dL7G6GbXTUaE6bCvfKRp/t+d2xVbAqJqqpbIyCbMuIl+fRAe46qRb+tgHNqjylBWbrXR
         1jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995575; x=1778600375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wIXfyZUJZPSdof5KqpSbjmh+gBcKfo2nAX8OXquADG0=;
        b=fUn9qBJJ9qCTp0W7ZnRnvV/m0IzSawdhJH/XLZBzJpEXcZqlP+kzULcLdT1W0ZRRJi
         sN9H9vZqEexWEdONUu7bEpzuGKz5KiuAxdYx+IduKz3TY5DuLT3LlFykQvzt1BKqY5nR
         3LnNNuAuRRb1aqmBQlUpr63eXMcjzkDvr51nh1z/W+TxvRl9qFb3WuYcRwMan6cQpWgQ
         s8Arlg8HlE4TkttJKlrbezc9tH75U78HtcL74mFrukLz31aj/pfcMLiDPEzBg8SDcIii
         BOObEo1xBl7K74MuVXjYHrc6BgBcWIjUxQ8HL5eScYuYn8zNflpR2CMc2/hxmUJ+pxNR
         xdBA==
X-Forwarded-Encrypted: i=1; AFNElJ/qHtruGSzmsA2IWCel3L9bd+ZlC2V6h490yMoKsVJnah9Yymm4BWoLsn0xqhcqc5RKH708oyLZag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwR8mDGH1oDDz6pkDX7EqImzLGHsgNdMFT5tRZj1jTPNSZUnl
	60wKYOjEtNjZ3pnwV6vSbkj9J/OCQ4kB34M1F86iEAW478N0IN/jlOtf
X-Gm-Gg: AeBDiesveWs05atejZnmLp6HYoIpkVqfwAczAfSKE0fXLKkphRHAgorwsYWvcVE6Px7
	cHbDMRZa8B2f5OIOcKdf2UStxX7akqF5utWaEBo9NZVEPjlenXaLlIPoKDmDg/YSgQ81ko1z2Iq
	xgAqzU+4JfG9XI5eHnJasPRIp5vOv023lVQcMESsAjKfu6dp9R4WqucwubwQEh5QNSbHP45jR+i
	5Ns5QoyQlEXTkN0iS61Ii72ES4H1By4wlMLrxYtiB5jccTRdSg4riD8BQfFsinUi9Z7Jg9da9o5
	SPS1VJAqXnUfQI6ZAEMRNIZ6SpX81Tk2uWpjkH86PMLcxEhSW1gGpvoal9bCnFo5JVPENd/Sxlv
	3H8QyKXH+ubKn9KUtTJCpUMUZ32cnTp+ER7PypaEVSZtZTr6vUkUTCpmpzkWtBIeEI4JV78mRJI
	oRyA8owLHXmGQk0/LNGXU/GAM8UwCRGwjv29rrJIIj1PlaiUKsbXcXl78=
X-Received: by 2002:a05:6870:c188:b0:42d:8229:ba3d with SMTP id 586e51a60fabf-434d0d61313mr2042459fac.11.1777995574917;
        Tue, 05 May 2026 08:39:34 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434549540b2sm14234808fac.6.2026.05.05.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:34 -0700 (PDT)
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
Subject: [PATCH v6 17/22] swapfile: remove zeromap bitmap
Date: Tue,  5 May 2026 08:38:46 -0700
Message-ID: <20260505153854.1612033-18-nphamcs@gmail.com>
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
index 12dd9621b637..4d152fa811f2 100644
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
index c6a91c657877..ce1254733e96 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2276,8 +2276,7 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 
 static void setup_swap_info(struct swap_info_struct *si, int prio,
 			    unsigned char *swap_map,
-			    struct swap_cluster_info *cluster_info,
-			    unsigned long *zeromap)
+			    struct swap_cluster_info *cluster_info)
 {
 	si->prio = prio;
 	/*
@@ -2288,7 +2287,6 @@ static void setup_swap_info(struct swap_info_struct *si, int prio,
 	si->avail_list.prio = -si->prio;
 	si->swap_map = swap_map;
 	si->cluster_info = cluster_info;
-	si->zeromap = zeromap;
 }
 
 static void _enable_swap_info(struct swap_info_struct *si)
@@ -2306,12 +2304,11 @@ static void _enable_swap_info(struct swap_info_struct *si)
 
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
@@ -2329,7 +2326,7 @@ static void reinsert_swap_info(struct swap_info_struct *si)
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info, si->zeromap);
+	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info);
 	_enable_swap_info(si);
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
@@ -2400,7 +2397,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
 	unsigned char *swap_map;
-	unsigned long *zeromap;
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -2495,8 +2491,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->swap_file = NULL;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
-	zeromap = p->zeromap;
-	p->zeromap = NULL;
 	maxpages = p->max;
 	cluster_info = p->cluster_info;
 	p->max = 0;
@@ -2508,7 +2502,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
-	kvfree(zeromap);
 	free_cluster_info(cluster_info, maxpages);
 
 	inode = mapping->host;
@@ -2972,7 +2965,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	sector_t span;
 	unsigned long maxpages;
 	unsigned char *swap_map = NULL;
-	unsigned long *zeromap = NULL;
 	struct swap_cluster_info *cluster_info = NULL;
 	struct folio *folio = NULL;
 	struct inode *inode = NULL;
@@ -3078,17 +3070,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
 
@@ -3155,7 +3136,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	prio = DEF_SWAP_PRIO;
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio = swap_flags & SWAP_FLAG_PRIO_MASK;
-	enable_swap_info(si, prio, swap_map, cluster_info, zeromap);
+	enable_swap_info(si, prio, swap_map, cluster_info);
 
 	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K(si->pages), name->name, si->prio, nr_extents,
@@ -3183,7 +3164,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->flags = 0;
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
-	kvfree(zeromap);
 	if (cluster_info)
 		free_cluster_info(cluster_info, maxpages);
 	if (inced_nr_rotate_swap)
-- 
2.52.0

