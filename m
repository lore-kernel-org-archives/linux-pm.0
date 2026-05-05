Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C648C8DE
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995577; cv=none; b=QyexpAVnlTZiySJAkrsshHFaS7CxH3ASDb/zxk+6PsNYURAyL1qTpz58mUKWcijHBHHxRNExULnhwhb6aB5VGY124OoaMHqKcSQQHP7kKGa4uWwdr5dHlBYgXyOlSL2/ovi7IxDAL9aJqM5/xF9VS3vfXMZAYmbFxlZLnT/LX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995577; c=relaxed/simple;
	bh=pUn9b9LUhmis+nxUstyTj7eYl6B+eZR5n7i3p7grHPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G66Qis37vsrLMeSxmTJEHUfXD7M0RTPSIrxjbTKcLWVjl8cgIr+G57PAbDbru77vVHCjMiMtOPSNEL3CdqAInvbT+IUhdfYYaFsd4LpHjolX5N7OGB/fn+stj+84NmSZrJRYBPxQQUOfZm39tXZ7iXqSJATEVoHaA3lzuKvSOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC7KU6nY; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC7KU6nY"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43496e6a964so1829425fac.2
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995573; x=1778600373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spNG7IJraDg4T5BsvCQ+9NVFqbAOm2jy1KvenC+2iQ4=;
        b=iC7KU6nYG/tY8Ny1bm8Kpi+rZ3yzy0iLcf6xFHKPhzDCygHcclsBRTj+j8CWXrD4V0
         4OOFblwHDbetkaTTs54VPGCRZtV/ibx6fwX8jdItj5VOfanC3Qj5a1grJPHXIwQRZjgI
         /ogGxc2K+GMblW2HD4dawSW2f7v9Rrt9GeQ4ZKmo+6HYUV2bgrk/Ce+JkUdXbyobaVry
         98uvKXNfH8HgpKrKITI2K2rKRxDLz91SmtcDP5CcVG5m4007VOlPd30hfHLzqahEzOj9
         zjFL8ECPVudXzxJ+AB41c39WzHGc//X+s6TiqcSqSb2Tn/m7ooXERBwgG6NPe+QUGJy1
         RO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995573; x=1778600373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spNG7IJraDg4T5BsvCQ+9NVFqbAOm2jy1KvenC+2iQ4=;
        b=F4hRLCSCh2Q6Ab0EZfBqwhbbbPXGL9z8EbGcDOgu5xZBQYmJhVNGUuJwrZa2JDW+sx
         q5sa2V0NKhzmwuRsmGTmFQ7xGW793NMm5p/SH5s3ZNNI0ZlEsg6x26iUHm+ZGrgunmCQ
         XdFW0l6Yz6Ks81M8GqIfHNcpdcJ3Z++qSrxDSKvnceUh9hqwfmjomcWmouQ9oPmpjjgj
         k5J/xpZrEu+s17VC/Mz9Ew0gOGvjA5COofCJxuUbte9W2QpMcQ4SyejmhirmFhGKgRFu
         pEIFtkc+4mA/bqYqQh/cvT/j6CrzFm/LDaqTmvUnjY3cPpyAtSkRgyWflxlGnbOfiApz
         V0iw==
X-Forwarded-Encrypted: i=1; AFNElJ+9JbiYgGvQQUCohCIAAD1A9TEjItZG4HO/WxQK44Zh2XAW4cK0kp6EB6M4RMcDqpq3z30DNlfv8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YybA0TPzZdBXuf2cVNfk0Nr1dRjCJK0v3fRe9Xd1jhZEMp/uzPN
	hK0SuRYBwtFDFRI+a+IdtMEXJp1vFdBKynm06WlhUxdm5vcX1n17iS+H
X-Gm-Gg: AeBDietPIOYCkSntR7wGcEBGBPJJhmIPc64CUf8h+JWQPF4L5lBOaUFZz4+6UmXXYDQ
	2wnJ22kjVWw+7RUBlU3oTI6VgGftyvLur3t8zRAz3JEYDcGB1fhIQoAmcVuBrOpNbYj8+cKgI34
	MDfc2Y41mn634ZZ5eCu/bHJLlXdW+z6aWLgkvKm7Sksx4QfhwjIrRU67PHQYTvgLqPBBs/sJho7
	ZYFt2OigjZkyb+77O8upLtfc3xr5X38ZT22G015ijtbxkB2Qpe2HLetZHZL7DStG0tJ1GD+o+AZ
	C+vSzF70Jw+BPExtf/DEgT8Lj6yTgIno+Kdaw0DIN5LlcT/359FbkK3LSotRC9Vzg25YL/RcZjm
	aLoB9/v2PdaO0TU7I0hPdTdZRIFSFfOgWVZONiOqa+TNW+/fdEGu9Xj1H8LucG6CaGF0WbG7D9N
	ws7DKxdvz/8fktEafhqu0rL88IqNl8THKdD8gccvoFRt87sztOYOQT2Iy6oB13z/JWLJ8=
X-Received: by 2002:a05:6820:3109:b0:694:8ad6:245f with SMTP id 006d021491bc7-69697dd52eemr7034578eaf.43.1777995573227;
        Tue, 05 May 2026 08:39:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d324a4sm13945195fac.14.2026.05.05.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:32 -0700 (PDT)
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
Subject: [PATCH v6 16/22] swap: do not unnecessarily pin readahead swap entries
Date: Tue,  5 May 2026 08:38:45 -0700
Message-ID: <20260505153854.1612033-17-nphamcs@gmail.com>
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

When we perform swap readahead, the target entry is already pinned by
the caller. No need to pin swap entries in the readahead window that
belongs in the same virtual swap cluster as the target swap entry.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap.h       |  1 +
 mm/swap_state.c | 22 +++++++++-------------
 mm/vswap.c      | 10 ++++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index d46b2f243f83..f3f2afc6751b 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -156,6 +156,7 @@ void swap_cache_lock(swp_entry_t entry);
 void swap_cache_unlock(swp_entry_t entry);
 void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 			   unsigned long vswap, int nr);
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2);
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 7fe4d9529e4a..39daea7bed66 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -553,22 +553,18 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		/*
-		 * Readahead entry may come from a device that we are not
-		 * holding a reference to, try to grab a reference, or skip.
-		 *
-		 * XXX: for now, always try to pin the swap entries in the
-		 * readahead window to avoid the annoying conversion to physical
-		 * swap slots. Once we move all swap metadata to virtual swap
-		 * layer, we can simply compare the clusters of the target
-		 * swap entry and the current swap entry, and pin the latter
-		 * swap entry's cluster if it differ from the former's.
+		 * The target entry is already pinned - if the readahead entry
+		 * belongs to the same cluster, it's already protected.
 		 */
-		swapoff_locked = tryget_swap_entry(entry, &si);
-		if (!swapoff_locked)
-			continue;
+		if (!vswap_same_cluster(entry, targ_entry)) {
+			swapoff_locked = tryget_swap_entry(entry, &si);
+			if (!swapoff_locked)
+				continue;
+		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
-		put_swap_entry(entry, si);
+		if (swapoff_locked)
+			put_swap_entry(entry, si);
 		if (!folio)
 			continue;
 		if (page_allocated) {
diff --git a/mm/vswap.c b/mm/vswap.c
index 01c336ae252c..195ba3520e54 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -1542,6 +1542,16 @@ void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si)
 	rcu_read_unlock();
 }
 
+/*
+ * Check if two virtual swap entries belong to the same vswap cluster.
+ * Useful for optimizing readahead when entries in the same cluster
+ * share protection from a pinned target entry.
+ */
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2)
+{
+	return VSWAP_CLUSTER_IDX(entry1) == VSWAP_CLUSTER_IDX(entry2);
+}
+
 static int vswap_cpu_dead(unsigned int cpu)
 {
 	struct vswap_cluster *cluster;
-- 
2.52.0

