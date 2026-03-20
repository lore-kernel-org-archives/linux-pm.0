Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E73F1646
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034891; cv=none; b=Ix1DTF9e6BCz4pLgyXTnR7MI4S63TJzw96AQJXtZsZArLRUkeStJzHd9n/KD5CRdX4TsEeXCdpN60tGG+rgLzZUrxgDfdXEK+SqwTpkT2EMSf+NQHHQcTQjtyfFYljDA96TxydTnc6L6PcouNZfQ/XSWdB9icAtfEzuTLJ97Psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034891; c=relaxed/simple;
	bh=qex24j/fvB5i2Hxp1YyD8djSdhK+3xIGWCRj2JuMS4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGzBxzz2EqusXAo/BxMc7VPnit3bSMs8iulaz1BFYhufpeawYH1U3LW7NdSKJaHYad4MSq4Ls8aWwdObqEWvHcLWAQX8mdw3A3SlGQdd1B0uC2XWfBv2sMNvxUFOQq8R3I5Jphhb9hZCZs+7+R7CyULVCNgb4DtLq4UEX6CG7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAWdKSgB; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAWdKSgB"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-67c22b05346so694455eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034883; x=1774639683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LyvvsB8h9QhouSf22weZV/t1lxO86Z5/SzpfGB0vfc=;
        b=SAWdKSgBfresKLdtiUP9d4x0zrYaY1XrzflOVmYA6mUntCJa1ml4UPiK77qcsS675B
         FUBlDr8nFlchIQz92pUDrher1KQIkqk3MVXz0oIYrkCQvpb4zNFxuySSqGIDBQm6a8JD
         DZhXxxlYa5wGq7e4SVNDpLNtg/ByvISIQhOh2s+DgaBVlYi5v9+HcW4rdOWEfHWP2un4
         WuCURFTool7mpVAOzKzRFFAiUawylixxF/M6Q+Df50yilMv+I4p0z/f9+JSd3tjT+My5
         4v94xO8vr+qAMM1J6ZdKVeJKIJGvruMK7WwolQSDGeWL1C7+EztEjrFnQFdn5cpMZYiI
         VVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034883; x=1774639683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7LyvvsB8h9QhouSf22weZV/t1lxO86Z5/SzpfGB0vfc=;
        b=D6IR61q4l988qUrT0eOtY1MDhTxeVzF9gFK9Pjin5fzvRniKlrDkJltdDDcoTAlov3
         rhyez88dv/JuJiwfVah6caTwcYr5JCFvLr/VY96eedQ3If4PJyGyEJbqRtkgCO1UNEha
         M5BhSEGqz3+WXXAq2tL6ljv3l0FzgjS1XkeQZAy5C9uQ4Ewa2FfEkpZvfeUc/tQY7/7p
         101qCiFguSwApfT+IpKH/C0LDWdZVDyIv7UiZW/5vV2r2kbvtC19pX7mMGPPrFbRY67j
         R2QJWa10kyRVDMQeS7nAmtaOF759ogc8vwsD6owKEN8TA0E7w9Qtc5wNPwVVZcxp7KL/
         PRYA==
X-Forwarded-Encrypted: i=1; AJvYcCWbfZWop2Yptpgk5u6oOYN/vxMGdyWvhQO1nD2pIOF/6dIbA3wxfePt1GX5ETcn9WM/2dmVhO2Chg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdR3pQlqCG5pySUquaV3j5jdog3myB/XvpElf8g6abQq+zlUWs
	S9Nhn//HvWmtxgNrl6thdFo9QKg658ZMvAQK6Ho1KRNzTl+KHYLNxrW4
X-Gm-Gg: ATEYQzyQuEY0qwmcnJ0b4PDH7yhWiQFn5DdC+nziKXtAx/t21+98K5Gd5ORyGc1tJ7z
	1dz+N/ZthpTlXuRl8QB+Yc2xjs42Diketr8Nu0R/FhaYWhJXsLoARGD38AKCepWgzxd7+ZYn0Wn
	pqF4IWbVR4RwNr2M1+zD7R5W0SWw3RyBiD9rJoQ1B2cSunUachh2Md9o03/wFtwRPPld1UnxpnH
	bhqyHTTTikqO7J2HGI63ZKUOlozdrvV07Wz7AqJq5lJ+lPw1qs9UNoB8U471mqOQSQe3IIwl0T0
	qCwXvmimlVxG5bWLlcmZkRD2QvUdOLOD/beG+o5PMd3z8bovaz/sJcft+aANDH91vK66VqOyl6x
	I/GmL/agrM/+6BdcrSgTDSJSnPW/AuKBMhigcCKO7tfbxK9F5pPRinN0ItRC0oNAwBD6nxAiXPn
	9edozAsjGoOIa7EAjaVSl42Tl+60S0j3xSI4c3Ga0WQz7GCg==
X-Received: by 2002:a4a:e90b:0:b0:67b:af79:4c1c with SMTP id 006d021491bc7-67c22bbb20bmr3072207eaf.2.1774034882969;
        Fri, 20 Mar 2026 12:28:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c251a58dfsm1621782eaf.0.2026.03.20.12.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:28:02 -0700 (PDT)
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
Subject: [PATCH v5 17/21] swapfile: remove zeromap bitmap
Date: Fri, 20 Mar 2026 12:27:31 -0700
Message-ID: <20260320192735.748051-18-nphamcs@gmail.com>
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

