Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3933D3D07
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034869; cv=none; b=FjSI+L2FyWY3b/8rvkg9isr5ti0sh5uyUE8ep8qtnbh6FyMSn1/c5PGfpGJ1G9u5btMJnoG8FCRa0EW/YPdhMXopTyhjObtLxQsSfedBLMnXClNfCL0ce51QoQdp0GNtVACIJOlUJhT/tbecEnsk4AO5ayibmSI9OxrEq8b9/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034869; c=relaxed/simple;
	bh=p2EM42jZS59AXKFtUANlEILN4sRBHLRYcGgRVQjo4YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5fmsqoLS0NaXJ3OeCIW7QdB55KyBjMHQRYq1V0TFn6Wq/ZRY+vYZErz+h2kx+Izybn8C5HwZ+RSDlNf13BplUo8yhFpVuscLiS9AW7ZeSziKGx4Z/QFJP/5bS1b0lORhgX4hnoOV+RfAwofA8Igf4ah9/5odewygMGrOMAenRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFvIcVCu; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFvIcVCu"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d751ef36ccso473131a34.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034867; x=1774639667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=augNyOBtiYJ0dgm3cOulQaqdWfbdzgL3KEY1IT/V5Xs=;
        b=PFvIcVCu2sG2GtvWxUB/Xx3Mr9+x29qpOB/mobLSCm5kqHDsvLyyDb30UDOM1LhXGp
         VO/RZL92lG+6yJ0rUp+WAu/Lr4bgEBY1ZISndY9ZuMvL2K9k0NEKRDxe4rQYW3zuwI2a
         bttBgnc6kgiUMIm1o/hn4ZHubpPBuBcWdGX5YvQfNBgJ6Zq+RST6ZsO6lNZA4e197Yln
         jxFuXll2PiXV8iQlOW+U224kKemm5F2s/+lyH5beKFgm2rWMRYvOzsA0x0Bn5lMLdDOx
         vWa7uSfIIhTS7k8mocDUfTFhPq2Z/uFsSWIi+RLHm+YdNKH1MK2inUX5YHeNiLf2Epd2
         EmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034867; x=1774639667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=augNyOBtiYJ0dgm3cOulQaqdWfbdzgL3KEY1IT/V5Xs=;
        b=EitXMBYwTll/by1XdCrQl8ilcayLmNgP7m74Wg0dViah6Cg+/HhtQu4A7Ol4NJxpgp
         08/ZXUjIFs0HIkqmAlywES0enYD4re7GTodwg7WRx6FECXu72r3UC/zU26gWWB0pAlXw
         b74tDNqgcvouNkhfJL5VwHahNsk0W4+0xFfvndTkACMSPVnJsP9XO5tNwKmZTE6HQL+6
         gpe+SBQWyoWrLyWUv+WAzT5Ok/c61esNAD5VY+2TVhs+/Ef+YGLJcoRQu2yPRuzqLNoj
         HH0/0Djk09pjAZrraCSxA9YgYErBQqJvDol4LFS5dCXQPwYKIRyzyo41WpSpthcGv39J
         va1g==
X-Forwarded-Encrypted: i=1; AJvYcCUk8Of0jSK2PfzHGVzlq5LSSE9uPFbla3PWtB4IueMLdFz1diJYIWxzuL1F9gVz/YQ6IpqROFA/qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFclBGoYu5Z2oIgmpfrfMvnJtNNllT/uDTfJK65zil9DoCG1v
	vKFNdCtqPlNaBXrSHKelB7jRdTPnKVvkl6vs1tbiTmexgyAAZ+LDkkeD
X-Gm-Gg: ATEYQzzNiB3UnSWh8c7t0w6n83DFh2g2yb2qzQ8dwgBOXGoXypklliQu+Fdib4byJce
	qHvnL2xW40xTssnDHL/yGltol+HDaVRXXM8WT6IsA6cvmNOjDejdMYr6AtxrqN5+9vD1wPwD11g
	/oDen4MHWloYyILemWUMMRXiXvsVbwg4hASCXEQJnVZGgREXwGcZFyMdj6H+nCMUrhY1NX+vU6W
	N48U42uDwWB6Tt67YLefKw3n5XUaZ7SZcB9pdXsxLGTn5UwNLz/MHlsHSvgQbZk6UJLvp8ZsIbu
	LKH2sxqM1S32WPkVC1KTsZIQiM876ps5PWTjA+0Fkrn3D/PqheOBT6b9PYkpuq7iZ6DRKL8/5cc
	bd2rvEpylE+sXoHeg5/FXfNfFtG1jAdSzQ2FTENJAQuOKUhSHEqJSxHU0E8Jz6Qyz2lidvDVfpa
	osus6nbSPIuM92b+ud/aRL6/TwmMF+oYEz098gYb9HvQ0moQ==
X-Received: by 2002:a05:6808:190d:b0:466:f054:c3b6 with SMTP id 5614622812f47-467e5fe7105mr2485514b6e.59.1774034866661;
        Fri, 20 Mar 2026 12:27:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d19abfsm1824746b6e.2.2026.03.20.12.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:46 -0700 (PDT)
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
Subject: [PATCH v5 07/21] mm: create scaffolds for the new virtual swap implementation
Date: Fri, 20 Mar 2026 12:27:21 -0700
Message-ID: <20260320192735.748051-8-nphamcs@gmail.com>
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
index d3780bb330378..042dbc06c3d3c 100644
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
index 918b47da55f44..df0771903a952 100644
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
index 2d0570a16e5be..67fa4586e7e18 100644
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
index e2e9f55bea3bb..29ec666be4204 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -882,6 +882,12 @@ static int __init swap_init(void)
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
index 0000000000000..e68234f053fc9
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

