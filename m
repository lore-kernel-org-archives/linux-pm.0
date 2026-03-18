Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596932E5B27
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873000; cv=none; b=fOEzTvpeQmE7wl0iaqMVoP22LXoCGlpOwww1v/c/ckOVnb+yU2UDi9Au7SCJTILcd5DhzAyK1m2eiEEATXG2lIA5qJ+oobSZCGTMfSLR+9zoGNvRGR6QT/kPCdfCJpFqpUAU4/DjYjQRYjQIaDkIXgcCT/59QDlt0dfsCrOV1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873000; c=relaxed/simple;
	bh=E7IvwqT01r9Y9AARhPTA4kVsR7QTb37BUUQJU1OMnqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhqhafGl4uLch05ukxctWo8U8T7q5dlvEWx9HEGN3vMpBx9zOSIszAGwoB4wb0qRC7bxIhCxDcFTexRGoIHHgJ7MmX9LY8AJBioBVFgLUoqWiQZLGA4Z3FgzIFk6DU+rTliXKbuBYAoGzl0m0P1bHO4hK5SY5UiIUOq7IRNAWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ5NQ5TP; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ5NQ5TP"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40974bf7781so1008177fac.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773872997; x=1774477797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQz9gXtG0BjRbamDLXajf4zSV33YchOog2Zf6fZXOug=;
        b=IQ5NQ5TPksFfcPor3JfPJ8aYfq0xx8nRd29UIfQw10u8vIU0Hopyf9WpnHff+55Cav
         Hkf44AQEAcYfyGDr0DFFXOsN4zC1o8aBWV5H6zkpwlzYhvniu78hi68znf1kKLRJb1hA
         z6z7Y6Kjvevm3qdgmCFOuKtEDQuv9Y5d1VDhq1u5uG0Bc2hempmUpZ9R/thlxhMBdBVs
         s3bI6l/K+H1/bebyUhbGdIdMkxIXy8mtKbpfFoFkVEzUbBQDWoIb7Z1TVlmgsR2bkpVx
         FzEA9fPw3dflWBH2+uKHg2QhcvD08Qb4vSYzbGIup4hBWsjYdbG89NpizUeWDaLHvxVk
         HvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773872997; x=1774477797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQz9gXtG0BjRbamDLXajf4zSV33YchOog2Zf6fZXOug=;
        b=HtsJ/0G3ZLW+VAE4N7mikNY79ftfYLCUPjPeHBCFbktaZ36jmtrJgFNOPNMtHyXnRm
         bDVJ+Bz9It/ZHamHTbIiZABIuRPzleGRWppKfXuqhANNHCDEB0DzULTqcgko4l+kJLbp
         ZTNo7F6ik/buu+UR48BgdPYruRemSoJymy5lkvU9V5apTvhCDxNX4uHYW2ZRUxPaC2bI
         PD8i451hXLkXyVt7Ha6t6ZPCXAd1I/Zi18o7dSlMjGKN6n4izOK/mRnxw5AP2EEtCK6K
         2q3Cb+e3hQmX9B34dQLleChYbtGGL6fEbHqRSDgVyjt2IRMU1EbqLH1fZ2EynSQYDpUC
         Zwlw==
X-Forwarded-Encrypted: i=1; AJvYcCUIB5knoVtnzr/b/WoMGHRFeDR4uF6VBrBrqBgxQq42SApRvJjMQKLULBoYIzfk5Kwx0LauQu75KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsndsrHZ+wnapI+w00SN+jAd11h0FCtC4OS/226WXEzsEGRH+
	ehRwjLb0xCGGTin4d5vo/abd12htuZKxJBQnbnqVfHkahWgXgIKkEZAK
X-Gm-Gg: ATEYQzynX63U12q7zowwXVpQVglTfoetVj6r3difXQSJkZ9y3El9mvgNjvq+OY1jSVs
	4VLLiWo0qbo89nC+HrQ4xqIlrNcXE/xo9w/GDetDnxdAx/wW+SckKBd94+hF8DHGqVlBT1TvFlq
	FjI7+9PD2tJc6jzBVeDepyp0GqAbyebPL4j6MqTh2+8gxBqu88F67lYw4HxyDOZxRggkdx/O/Iu
	cI+IFEb04OCUUbTwaHfaiAELpdp1F208PIb3lwCpmthZCq6/UY73oSq2iFV9/iukAleejQ4XoCN
	alG0Sf7KoMVoycUvNHdxUnxMIp+VLVQKlYGDFkFqd91WIyY5y+Q7M3jVEsYO1I/417eVNY/T+SP
	lUz50lsKHaCI/BGjNrI3n/LGTfChAVcNOmJQCvcYhfroQ5zdGZ0wN0WwyhTOFXQK/zpjYk1bhMK
	7HE6yTHUhUZfwR3zozLA0OvoE4ACK9pq9Ek6fewHgzsV4jiA==
X-Received: by 2002:a05:6871:a18e:b0:417:3689:a380 with SMTP id 586e51a60fabf-41befea5a0emr635307fac.16.1773872997245;
        Wed, 18 Mar 2026 15:29:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2cbcdb4sm4009222fac.13.2026.03.18.15.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:29:56 -0700 (PDT)
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
Subject: [PATCH v4 02/21] swap: rearrange the swap header file
Date: Wed, 18 Mar 2026 15:29:33 -0700
Message-ID: <20260318222953.441758-3-nphamcs@gmail.com>
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

In the swap header file (include/linux/swap.h), group the swap API into
the following categories:

1. Lifecycle swap functions (i.e the function that changes the reference
   count of the swap entry).

2. Swap cache API.

3. Physical swapfile allocator and swap device API.

Also remove extern in the functions that are rearranged.

This is purely a clean up. No functional change intended.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 53 +++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 38ca3df687160..aa29d8ac542d1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -423,20 +423,34 @@ extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
-		unsigned long nr_pages, sector_t start_block);
-int generic_swapfile_activate(struct swap_info_struct *, struct file *,
-		sector_t *);
-
+/* Lifecycle swap API (mm/swapfile.c) */
+int folio_alloc_swap(struct folio *folio);
+bool folio_free_swap(struct folio *folio);
+void put_swap_folio(struct folio *folio, swp_entry_t entry);
+void swap_shmem_alloc(swp_entry_t, int);
+int swap_duplicate(swp_entry_t);
+int swapcache_prepare(swp_entry_t entry, int nr);
+void swap_free_nr(swp_entry_t entry, int nr_pages);
+void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+int __swap_count(swp_entry_t entry);
+bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
+int swp_swapcount(swp_entry_t entry);
+
+/* Swap cache API (mm/swap_state.c) */
 static inline unsigned long total_swapcache_pages(void)
 {
 	return global_node_page_state(NR_SWAPCACHE);
 }
-
-void free_swap_cache(struct folio *folio);
 void free_folio_and_swap_cache(struct folio *folio);
 void free_pages_and_swap_cache(struct encoded_page **, int);
-/* linux/mm/swapfile.c */
+void free_swap_cache(struct folio *folio);
+
+/* Physical swap allocator and swap device API (mm/swapfile.c) */
+int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
+		unsigned long nr_pages, sector_t start_block);
+int generic_swapfile_activate(struct swap_info_struct *, struct file *,
+		sector_t *);
+
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
 extern atomic_t nr_rotate_swap;
@@ -452,26 +466,15 @@ static inline long get_nr_swap_pages(void)
 	return atomic_long_read(&nr_swap_pages);
 }
 
-extern void si_swapinfo(struct sysinfo *);
-int folio_alloc_swap(struct folio *folio);
-bool folio_free_swap(struct folio *folio);
-void put_swap_folio(struct folio *folio, swp_entry_t entry);
-extern swp_entry_t get_swap_page_of_type(int);
-extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t, int);
-extern int swap_duplicate(swp_entry_t);
-extern int swapcache_prepare(swp_entry_t entry, int nr);
-extern void swap_free_nr(swp_entry_t entry, int nr_pages);
-extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+void si_swapinfo(struct sysinfo *);
+swp_entry_t get_swap_page_of_type(int);
+int add_swap_count_continuation(swp_entry_t, gfp_t);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
-extern unsigned int count_swap_pages(int, int);
-extern sector_t swapdev_block(int, pgoff_t);
-extern int __swap_count(swp_entry_t entry);
-extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
-extern int swp_swapcount(swp_entry_t entry);
+unsigned int count_swap_pages(int, int);
+sector_t swapdev_block(int, pgoff_t);
 struct backing_dev_info;
-extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
 static inline void put_swap_device(struct swap_info_struct *si)
-- 
2.52.0

