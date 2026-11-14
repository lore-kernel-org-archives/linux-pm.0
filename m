Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640233;
	b=pqdqtm+q/5VZu7cYACbCCCk8RzTEPtJZpqQLnXPrwdOkLfwF19xfHtxIF4BM4kxVuexl
	 +qOD9K7pzghsf6RFSULlarRPmfRnBMAHKUja0cdFHsjlmOOyAEbWFYJf8/h0Bz1Tzp7Kq
	 D0Vv4kwO5xn10CSBtHZ3yIDXctky/P4iWrZyfQ8rcbnBiXRGqliGu1jWuUAVawAM7GR8e
	 uW1Nw86pykY0C1WufTQOH/90SdsSSSdpLQVsJaYet38Suec7b64tLTjvy2+Og5+WuZpG5
	 KhLgSi6x6o4a2kErvfaYj6boTB4Gbr6v49QnhWTdQhZEvfUex/KJfr4FQek3YV/mpYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5RFbW7qtEXFgFx3OLZ5ldAh4JcKSI5CeWW5dNwakgac=;
	b=ZEoPuQjv9H8M+5Yi2KP6Ll95VWdo1WtLeti678Mb1mfdrkQEH8xZi5VhgCnORuouHfv4
	 vBJiH6uQRWNWPFHfp1xvSWb0I+RK5lDlJggwYJWWfaZKMDt3ZDVGt/ZyrH+EK0V8tV+kH
	 73xMPDmWebFT0nEl/WYJwLtkm2yTfOBOq6Z0Ea7NToOYJieegyct0yeFPd+JOKZ51YElD
	 LOkMTn+OQMCLIW7B+GyGm9VRxDXjsBvo3FNwBtocY/Z47FNrKeQT/7HM8bT939yyygMlK
	 CNkhBded8HyR5hwTSb8nbMxMcFhvDAWo4CpnMgTNwWpVwtXGBwf2IIlpCRhd+E/KT2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=aYTqeqR1;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3F606A8BA
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8A3F606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=aYTqeqR1
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5363316fa0cso29203201cf.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640232; x=1795245032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5RFbW7qtEXFgFx3OLZ5ldAh4JcKSI5CeWW5dNwakgac=;
        b=aYTqeqR1QHe8QpAIw4zANCLk10EO7obolkqxMkp9DPfIkMFw2Yu2fjhAnJ09UU8hR/
         cVC+8ZSzQc+BFhDmDy8wS/qiWhSXgONleHejwLtT91Sxp2WJRPZI2Z9bkbme334BaM0u
         C2pnJmA+cU6J1FOJv/hMz7Y4KevWZvZIbMY5Felqq7yHaQdpBcoKyY5wT8VVyuTttiYw
         OxRGFdB7pysoV2G5TxFa0F8PGc7R7ZmJb2L8IASwu9vqYMUuZf2EsuX/nUuU1GaXQikv
         LHS4yrDCtlFhl6fmPgB+giZFdRjpe0Gyc+FV5hUIkgjVtyZyFFbZGkgcScs/YV32wrBe
         E6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640232; x=1795245032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5RFbW7qtEXFgFx3OLZ5ldAh4JcKSI5CeWW5dNwakgac=;
        b=oskHqp4i4uXpF+sOTjR3aXHQ78hW4+zQdy2DkX2akoCHH0EOVr6H5AEDB2iDBCN3Cm
         hokIBs9Xs2aR2p3dSr5D3mwA0WR3y0CSn5riI0WE/9hpcrExA6YGWRic2WYKDaH9zh8i
         OD64UGu4XP430nMqBUvCsltopAJNUKKNa9aTG0XxMVZqkgfNxt/aPyfmzlu+gOqGZCJz
         2USLaNyGozX1HyRMGMReABd7b1uCw9sbZmoxC5EdVywsiqVo+zQ9ke2a0bvg5cH9Do12
         4e7CpE10Y8VW836B0pehPhS4rnjKJcIK62iW5+l52hh7hPIqka+CQUIF+OV/B7zP0XUK
         Iprw==
X-Forwarded-Encrypted: i=1; AL+hErF0PgNUV9CfCepVWrOu7PQe3SkzLK3tCGpSIqY5UPAGdONgr1UYF8grUI7FrzagsS2nSi5dNED11Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+iRs4PqjXRKtv8v/O8B/xbdeTcNl44qcy2uK28z2+Mz2Nj2wsP
	6rd6ZAlvGV91qPVbRpc1VOs/BHmQw3LDLinOqYIxjqql/aKSNsv9oQAMOXBQtl5ZTDk=
X-Gm-Gg: AYBFou0TpkP5cq1KdFh84s/dWMF/RjCdHpGLtlqwRGRms9NgUwfLmXu6U9KlUJkJY+4
	oioSr5zlZj02eC8/DpqkfVNm9c0m/3WXWDOXr8W7XPqkV3Ax6kcOPM5eYI7uyRfWROAwft75HY0
	JlZ72VwzuF3uRfW6K12KWDZgoPt0EgGS8hBQxi1ZM0sBNBucKDbLuZFRWXDVPs+zUXsqyw/qSeg
	wOo3zUy4smJZClpKeL1/NmSXiDYRRrthMcsGjutyJFEaB+CvYYK18NKhfhUryKMhpN14GZ8qFG1
	heHYzxz/yG4CWWANukN912pyceiqDQXOIEng3ljYcIF44pUNjH6htaGbtYRG4trMJsptxrSyg7k
	x+LElRceCG1rOATIQi3ESb/K9oAfjwsfFVMKrI4fbiPaNnR/Do5zxBdrVgloh7pkQsMQUdw1D58
	lHWbe2d9ccIN3PXpjCyYyTPzai4sS73fImNKo332oBVvbpEP20zdKKjCzp9QQD7qbkKKyYUjvRd
	ve9YKq1ly+F/tpLhupVJywOJEvK3gf5T+6sW5cFSijxAQ4Zc4kxpmo306otAvu2jk/Hk6VycfrT
	N+lsVPR3hZ2jiKxE9iPm3lh/8SLmZxBR2vV9yhkXC7Ykko0IaOWnV+vrR8NMi0iRt7SESivKqGT
	ibxzIBr7cCMyybvDNqDI/tYSBRJpiVR41cCTG
X-Received: by 2002:a05:622a:58c:b0:535:a5fb:6459 with SMTP id d75a77b69052e-55ac8e98474mr80004781cf.68.1794640231712;
        Fri, 13 Nov 2026 23:10:31 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:31 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 13/22] mm/hugetlb: restrict pool growth to common memory
Date: Sat, 14 Nov 2026 02:09:50 -0500
Message-ID: <20261114070959.3490008-14-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fresh HugeTLB pool folios come from ordinary allocations, which only
N_MEMORY_COMMON nodes serve.

Restrict HugeTLB allocations and pool-growth to N_MEMORY_COMMON nodes.

Keep the original allowed mask for pool shrinking and demotion so
existing pool folios can still be found on any online-memory node.

The result of this change is that hugepage allocations will fail on
nodes without N_MEMORY_COMMON.  This restriction can be loosened later
when/if it grows a user.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hugetlb.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cb2de24affdc4..cc1468f68901b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3452,13 +3452,13 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
 			folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-					&node_states[N_MEMORY], NULL);
+					&node_states[N_MEMORY_COMMON], NULL);
 			if (!folio && !list_empty(&folio_list) &&
 			    hugetlb_vmemmap_optimizable(h)) {
 				prep_and_add_allocated_folios(h, &folio_list);
 				INIT_LIST_HEAD(&folio_list);
 				folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-						&node_states[N_MEMORY], NULL);
+						&node_states[N_MEMORY_COMMON], NULL);
 			}
 			if (!folio)
 				break;
@@ -3528,7 +3528,7 @@ static void __init hugetlb_pages_alloc_boot_node(unsigned long start, unsigned l
 			prep_and_add_allocated_folios(h, &folio_list);
 			INIT_LIST_HEAD(&folio_list);
 		}
-		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY_COMMON],
 						&node_alloc_noretry, &next_node);
 		if (!folio)
 			break;
@@ -3672,13 +3672,12 @@ static void __init hugetlb_init_hstates(void)
 
 	for_each_hstate(h) {
 		/*
-		 * Always reset to first_memory_node here, even if
-		 * next_nid_to_alloc was set before - we can't
-		 * reference hugetlb_bootmem_nodes after init, and
-		 * first_memory_node is right for all further allocations.
+		 * Always reset the allocation cursor here, even if it was set
+		 * before: hugetlb_bootmem_nodes cannot be referenced after init,
+		 * and further pool allocations use common memory.
 		 */
-		h->next_nid_to_alloc = first_memory_node;
-		h->next_nid_to_free = first_memory_node;
+		h->next_nid_to_alloc = first_node_state(N_MEMORY_COMMON);
+		h->next_nid_to_free = first_node_state(N_MEMORY_COMMON);
 
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
@@ -3802,23 +3801,21 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	unsigned long allocated;
 	struct folio *folio;
 	LIST_HEAD(page_list);
-	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
+	NODEMASK_ALLOC(struct nodemask_scratch, scratch, GFP_KERNEL);
 
-	/*
-	 * Bit mask controlling how hard we retry per-node allocations.
-	 * If we can not allocate the bit mask, do not attempt to allocate
-	 * the requested huge pages.
-	 */
-	if (node_alloc_noretry)
-		nodes_clear(*node_alloc_noretry);
-	else
+	/* Scratch masks for allocation eligibility and per-node retries. */
+	if (!scratch)
 		return -ENOMEM;
+	nodes_clear(scratch->mask2);
 
 	/*
 	 * resize_lock mutex prevents concurrent adjustments to number of
 	 * pages in hstate via the proc/sysfs interfaces.
 	 */
 	mutex_lock(&h->resize_lock);
+
+	/* Fresh pool pages come from the ordinary allocation domain. */
+	nodes_and(scratch->mask1, *nodes_allowed, node_states[N_MEMORY_COMMON]);
 	flush_free_hpage_work(h);
 	spin_lock_irq(&hugetlb_lock);
 
@@ -3855,7 +3852,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock_irq(&hugetlb_lock);
 			mutex_unlock(&h->resize_lock);
-			NODEMASK_FREE(node_alloc_noretry);
+			NODEMASK_FREE(scratch);
 			return -EINVAL;
 		}
 		/* Fall through to decrease pool */
@@ -3873,7 +3870,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * within all the constraints specified by the sysctls.
 	 */
 	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
-		if (!adjust_pool_surplus(h, nodes_allowed, -1))
+		if (!adjust_pool_surplus(h, &scratch->mask1, -1))
 			break;
 	}
 
@@ -3889,9 +3886,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		folio = alloc_pool_huge_folio(h, nodes_allowed,
-						node_alloc_noretry,
-						&h->next_nid_to_alloc);
+		folio = alloc_pool_huge_folio(h, &scratch->mask1, &scratch->mask2,
+					      &h->next_nid_to_alloc);
 		if (!folio) {
 			prep_and_add_allocated_folios(h, &page_list);
 			spin_lock_irq(&hugetlb_lock);
@@ -3978,7 +3974,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	spin_unlock_irq(&hugetlb_lock);
 	mutex_unlock(&h->resize_lock);
 
-	NODEMASK_FREE(node_alloc_noretry);
+	NODEMASK_FREE(scratch);
 
 	return 0;
 }
-- 
2.53.1-Meta

