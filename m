Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142D3624C5
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003810; cv=none; b=FX0LI1Bg1v+Kc5Repuifa2qF7MAq9oyD+6lmkYjI45OMqf2qf4H2taSZ5QPqs8io/LyS13b4AOsd7guMFyJIdlxgdfz1tPVX2hHUoishWa2ikSv6Uugn5WZgp9jeh+zc2pCCPUd8w/t4xd5XoUh8sAOEZtvM+eL2GnmoHxKgWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003810; c=relaxed/simple;
	bh=jiqdTPG4am84a711SHTa1ilvl5OD893KyijxO1MvI0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFTFUV+6a8Wfd/5pxWRCqhbUtE6n5tgrG1Hsy8hvn0SgoHwaIZwZ97HJzy0XaWsYGccKY6kIPD1UZ/v/1CeOZeyj8QpeeXOmB7JWRdS3fvEGV5J9nfHJzQ6EnSkaS/dnKCuY5OvNLF3dMQPPIolE0tjLhz57Vl8/QNV/pZDewDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMXGI6YE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMXGI6YE"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e582b3bcaaso11226175a34.3
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003806; x=1780608606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4CJlSs8AXl7ZfYRtAD893brHtGG85Zp/rm/ajAW6HQ=;
        b=LMXGI6YEeF0agqyES1/hpONwDszZp689VQZspTvH3yimMD9MIvK2saNzK4shirMYrW
         Q9iwtiKkXTG9cctkw2AE0Kt0/1e8lhO6x2g0csSBBVzCxXuA8vhcy6VTQ635WOm33PzS
         HLd09AuzuypPVkkUbv9ri+KKmgsZXLHJsdNakqfew/PZZBgVlsuX/GAr+LUvHFPuvii3
         RQh4Fs8lzEYHHsa/F0qS7KFpgBaW6VmRKp4GNndic4Z5qauuNvMfPlslFN7Glv3FHej8
         /Y9ev4XI0R6EGVX263hL7QGEHgEkg8UPYLkrZTqzvt1mdHFU87P2wk9zJtfB/C/8mobq
         f1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003806; x=1780608606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4CJlSs8AXl7ZfYRtAD893brHtGG85Zp/rm/ajAW6HQ=;
        b=ZO1c5Uqf0EnYPmlChMokjZNrewjyTC0Pl5HJESKA4mfjC2sDbTWWQ16cs+z+C/o+le
         APe8lRF4o7JfpyqR0WIMRv6Cmp8ogKZTO4BDvaT8dYU/pFa8MC4OpT3l8f2fToE2UfG5
         AAqSIiP+umx/kOgUKhAq1BPO0gskhsm/rJvZQGduw8haGykd+gqFgkV8TFDxbImD8Ce+
         HdaOELW2MaKM1ZuSxvPXpELf9FPSBpvPHzLiEaDdq/bOMW/YvMTVFjEXLphTm7JBvcmU
         RzzzL2YuFf6HlXZwd60sI+pu0IW73APJhZ5HXNC1jb2LKBs0bXDac4lwf3z1a1zrHwzt
         AEnw==
X-Forwarded-Encrypted: i=1; AFNElJ/BPYX84GxMTdAl56zWI5wlmT2p20uiqv/x0dfwYnx8SN6Sn7QquuesBtF+4QI2w8YfFzppZLLe9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfT7P+4PBYYT6cjl4yQHHF517tF6AGexT+rT/D+0RxND6K7Gs
	1h3ybczFZ0qwNh0y2JZdqE2LiCWVNOFZ62Xxi+QKFOkhqtjw1vQWqJLS
X-Gm-Gg: Acq92OEXkFFdvcz+J3Gg9IVKsum+R+Zao1n3CKquMql/U1qHoh5H1qWxGLmj9SxPzOh
	SLQGENqPFNES+7UMSTi2Ddh0cxHIXuslG/kJ8xs235/yuS/yB9qudRT2MvbZyN+V+4UB4pVsxXD
	o9HZI0OLJhkpFKHiEbisGrwH14GnztqKTDb/fjWuxZMgLfTOvJlr+oYfAnojb8ruRM7aczbFD7h
	J1MGfS8wVFVdjVRzyGoM8B+XRBhEvaX1v89tvH5TykilPaHhgZR2lSQP4QoqyLZwfTDXxBODBCo
	nvepsUvRzV6RpbwltWgXTj8s96/hFOpYbzc7At9kuPK0qkjuhpizOzExGEEHR5Fn52IFZ2H8Tlh
	6oVgyKDh5zbN1ZjwFrwIZIz7mOc+XqtScwK8x7kTzZ1adlbYEdCCKfmKEeVF95mCDRl7dF5Wm9l
	+cAoxkKUf14Nq+KkiBUb3j6RO/86Z4VGRdtJlXt1mTlJOfAxfm/U+8PaTo
X-Received: by 2002:a05:6830:6314:b0:7dc:2f4f:17b4 with SMTP id 46e09a7af769-7e694fbdd5bmr187572a34.21.1780003806180;
        Thu, 28 May 2026 14:30:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6952991c2sm135613a34.26.2026.05.28.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:30:05 -0700 (PDT)
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
Subject: [RFC PATCH 5/5] mm, swap: add debugfs counters for vswap
Date: Thu, 28 May 2026 14:29:29 -0700
Message-ID: <20260528212955.1912856-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528212955.1912856-1-nphamcs@gmail.com>
References: <20260528212955.1912856-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add /sys/kernel/debug/vswap/ with two counters:

- used: number of virtual swap slots currently allocated
- alloc_reject: cumulative count of failed vswap allocations

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index be901fb741e5..3740ab764405 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/debugfs.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
@@ -132,6 +133,9 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.lock = INIT_LOCAL_LOCK(),
 };
 
+static atomic_t __maybe_unused vswap_used = ATOMIC_INIT(0);
+static atomic_t __maybe_unused vswap_alloc_reject = ATOMIC_INIT(0);
+
 #ifdef CONFIG_VSWAP
 struct percpu_vswap_cluster {
 	unsigned long offset[SWAP_NR_ORDERS];
@@ -1993,11 +1997,13 @@ static bool vswap_alloc(struct folio *folio)
 	if (folio_test_swapcache(folio)) {
 		/* alloc_swap_scan_cluster updated percpu offset already */
 		local_unlock(&percpu_vswap_cluster.lock);
+		atomic_add(folio_nr_pages(folio), &vswap_used);
 		return true;
 	}
 
 	this_cpu_write(percpu_vswap_cluster.offset[order], SWAP_ENTRY_INVALID);
 	local_unlock(&percpu_vswap_cluster.lock);
+	atomic_add(folio_nr_pages(folio), &vswap_alloc_reject);
 	return false;
 }
 #endif
@@ -2554,8 +2560,10 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 
 	VM_WARN_ON(ci->count < nr_pages);
 
-	if (is_vswap)
+	if (is_vswap) {
 		vswap_release_backing(ci, ci_start, nr_pages);
+		atomic_sub(nr_pages, &vswap_used);
+	}
 
 	ci->count -= nr_pages;
 	do {
@@ -4793,6 +4801,7 @@ struct swap_info_struct *vswap_si;
 static int __init vswap_init(void)
 {
 	struct swap_info_struct *si;
+	struct dentry *root;
 	unsigned long maxpages;
 	int err;
 
@@ -4819,6 +4828,11 @@ static int __init vswap_init(void)
 	mutex_unlock(&swapon_mutex);
 
 	vswap_si = si;
+
+	root = debugfs_create_dir("vswap", NULL);
+	debugfs_create_atomic_t("used", 0444, root, &vswap_used);
+	debugfs_create_atomic_t("alloc_reject", 0444, root, &vswap_alloc_reject);
+
 	pr_info("vswap: created virtual swap device (%lu pages)\n", maxpages);
 	return 0;
 
-- 
2.53.0-Meta

