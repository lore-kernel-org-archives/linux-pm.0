Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693C48B38C
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995554; cv=none; b=avV9qRTeR5FCBIRbW4cfQwDN9C0cbJ4kS7tROry1qHPbaQWTQ1Yy87Bvl5zN8t8SHK+9muTr6exinNQP57qNB3oaJODMZzuQCW4qfCCMd79hmW5N2vfmtes3nQSuKxcn5YVxPmEZo5bq6yZF/EJMwa6FyQzNarvEK8Dm+mRoOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995554; c=relaxed/simple;
	bh=I5srizcHGCgPUxo7oRZ08vip5kw+l6siD1GuafibzoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNnh3XJUEA9BRpDe7ensCv8clr68/nIj9UnAy0oEIfbS9JwlNLS1qQn2oEHs4mR0I7zLvPNgNznU1afU+qDYu9GnwIq4abzqskj+44R46cZdUh+TtYS2lXNVBlSubo8Lw961zi+2uXCpToq64RWverlVRcXJoYmM6LkLtPntUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/pmov+B; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/pmov+B"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbccf6a23dso4774912a34.2
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995552; x=1778600352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlimKByHfZpD1p9OKEabB2ERI5Qs+G3kPUHC9/pb+w8=;
        b=a/pmov+Be6KTdl1Oc3hZyCs8SmV2u54grQwwBa1O/svdjLSKjK6br0kZKZo56lvrRi
         q19DET7E0YH0AaXLkdKd9agrkqehJY+jJVk7RV7ChtyoHyXIA2fOl1Wps9dgsz470XwQ
         4CeUoj4IMOhJjA+YIBFb1cN0Lo4vdW+4y5KQbSJVsXY0QqfQYXT3mMv4vDyrCuqfYmk4
         r0S6cTKct6yTpFET85iGUVehvfa+J53E9MubmKccXkBk/jDS9qLDk0U1ENHalKw/O4T7
         gBhp05J6212klcz5QaQKxSihgHX8Vr9KvzxlFXpnx3X+6MDaaPEAOY6GQV2fB3w7mvgr
         Pfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995552; x=1778600352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NlimKByHfZpD1p9OKEabB2ERI5Qs+G3kPUHC9/pb+w8=;
        b=VzD7/MCaohwrKIfFtgViWabdImsZndnI5IZ6bcxd8fcqi68YdzNX7wc+S5c884tekW
         41BD8smBu2jXsjgbZexafrJ8tCZ3z6CjFGp6YgtHTwiNbf2V724Y0KeFiC4Hs6eYJhSP
         Mfj4ev1pO7G9SAwPSUeggdYSdS7XPF9vQhablWLoiXmKNJn5HaOqbE6dmFBVCamqZaCp
         +y3v0l+nBpnnklWX7lwVI9UfxjP+KHke0SCZWEJ3xRTelLSSbgw0SmxQL58lFULKBhpa
         MjCYa6fu18a6RmWb2cLTPPNtR4FsmexFTuFZbBVCyuxfCgVLTK4kijkqdHop6sljZDyV
         yp2w==
X-Forwarded-Encrypted: i=1; AFNElJ98mxLD3d9ZTPq4bCLSwIJNtBHV8li6E8VkLjmsV7TxxxOY/WIrl/lUsE3LTS++Rten39p0urt/Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEm0FZOvaVipXa+J+kFIDAeTUEUGDRrDrVAmG9rjwegyRsdlQ
	3f7I6xxIDUODV2NH/hVVGJnZw/pEFENlxYAqQBXhjSlJJpSLU8wVUX7t
X-Gm-Gg: AeBDieuN+Bbx1rvn9KOuDCSKNXQKmLqujBXtlAAR9d1Zc4hSRz2omhK1J4Kt2E1i9+V
	5xyUu9ITVxvAKnHj5QGrGi+vcHv6geCSinEdlr/9NoTHrS08MHQFZR+1PgWNkUDrLSi6r7WN06Y
	O8IOZ80CCfhEFY4YItcuUmQwzc0Ht8HKCBlofQ99tLdj/QttogDOfqQXHs1fybCp2HtPPFPaBNp
	ii394OhtErciTDGbaN2TY2OWx1/w5F2+E8r6755w7PHEnUDihX6SIZCla1r0+daWCmlSJ49U7Vp
	DtQLTjhHEN1DFck05cwJo9hPmZo1Mtxq8xb0qSqwsh9/36VTX4bxVNHiob3DTNjgXh1oa3Cq3mr
	OMCbDOXsnpxPxnz72HdlHeeYsLpp0HjWlXnkvWVBOArjSHpv2gh6uad8X19VjA5EiyoEQOAiTMZ
	1tZCDdK5X0ZZ36eki9qMMGsBmw3oKTiebVKIVYq9hO32cfKGjXq3VebjQu
X-Received: by 2002:a05:6830:8d1:b0:7dc:a256:5e2e with SMTP id 46e09a7af769-7dee121b678mr8066698a34.1.1777995552105;
        Tue, 05 May 2026 08:39:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca7a9036sm9855829a34.4.2026.05.05.08.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:11 -0700 (PDT)
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
Subject: [PATCH v6 07/22] mm: create scaffolds for the new virtual swap implementation
Date: Tue,  5 May 2026 08:38:36 -0700
Message-ID: <20260505153854.1612033-8-nphamcs@gmail.com>
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

In prepration for the implementation of swap virtualization, add new
scaffolds for the new code: a new mm/vswap.c source file, which
currently only holds the logic to set up the (for now, empty) vswap
debugfs directory. Hook this up in the swap setup step in
mm/swap_state.c, and set up vswap compilation in the Makefile.

Other than the debugfs directory, no behavioral change intended.

Finally, make Johannes a swap reviewer, given that he has contributed
majorly to the developments of virtual swap.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS          |  2 ++
 include/linux/swap.h |  3 +++
 mm/Makefile          |  2 +-
 mm/swap_state.c      |  6 ++++++
 mm/vswap.c           | 35 +++++++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 mm/vswap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d3780bb33037..042dbc06c3d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16728,6 +16728,7 @@ R:	Kemeng Shi <shikemeng@huaweicloud.com>
 R:	Nhat Pham <nphamcs@gmail.com>
 R:	Baoquan He <bhe@redhat.com>
 R:	Barry Song <baohua@kernel.org>
+R:	Johannes Weiner <hannes@cmpxchg.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/swap.h
@@ -16739,6 +16740,7 @@ F:	mm/swap.h
 F:	mm/swap_table.h
 F:	mm/swap_state.c
 F:	mm/swapfile.c
+F:	mm/vswap.c
 
 MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE)
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 918b47da55f4..df0771903a95 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -423,6 +423,9 @@ extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
+/* Virtual swap space API (mm/vswap.c) */
+int vswap_init(void);
+
 /* Lifecycle swap API (mm/swapfile.c) */
 int folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
diff --git a/mm/Makefile b/mm/Makefile
index 2d0570a16e5b..67fa4586e7e1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -75,7 +75,7 @@ ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
 endif
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o vswap.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o hugetlb_sysfs.o hugetlb_sysctl.o
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 6714d59fb108..fca17e7e7ae6 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -883,6 +883,12 @@ static int __init swap_init(void)
 	int err;
 	struct kobject *swap_kobj;
 
+	err = vswap_init();
+	if (err) {
+		pr_err("failed to initialize virtual swap space\n");
+		return err;
+	}
+
 	swap_kobj = kobject_create_and_add("swap", mm_kobj);
 	if (!swap_kobj) {
 		pr_err("failed to create swap kobject\n");
diff --git a/mm/vswap.c b/mm/vswap.c
new file mode 100644
index 000000000000..e68234f053fc
--- /dev/null
+++ b/mm/vswap.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual swap space
+ *
+ * Copyright (C) 2024 Meta Platforms, Inc., Nhat Pham
+ */
+#include <linux/swap.h>
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static struct dentry *vswap_debugfs_root;
+
+static int vswap_debug_fs_init(void)
+{
+	if (!debugfs_initialized())
+		return -ENODEV;
+
+	vswap_debugfs_root = debugfs_create_dir("vswap", NULL);
+	return 0;
+}
+#else
+static int vswap_debug_fs_init(void)
+{
+	return 0;
+}
+#endif
+
+int vswap_init(void)
+{
+	if (vswap_debug_fs_init())
+		pr_warn("Failed to initialize vswap debugfs\n");
+
+	return 0;
+}
-- 
2.52.0

