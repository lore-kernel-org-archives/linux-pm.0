Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74648C8CA
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995576; cv=none; b=Tl0H78ePwjPRmOatKHPsKHMmmBlFwv1U/NNXDcpBTvTOG5C+oExifLgbLp9dmstTjAytVrF+jxzzE+d8NQj2ZpPHbjCo5hkAPLw6mh5v2gR2Fu23nejUYNdOX7eT3bzW+hEe0DfeBN+7OHVXf8DJLpI5DnTl5s9azonuaPUDBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995576; c=relaxed/simple;
	bh=WJv7TbTBHsX/A9NDJmolsXLXY2Rt5GLjEbUFUMhf4TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9iCAX0uY4pPlvAiNnURhSlNYcWnAZObqXsIdqLUAOs5Y6sm4nBalBNF55vQU4Jloc40wrohZnVkIwRXwuZiGwtrAGtsYvKU6nx5HoKo+Di2jq77ypaw5HGep/xAdhyMK9jHQU3qUzy1nZImsDTeLu+QK8BNmbEcJxo7rgV9QTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN32cNin; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN32cNin"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4233e152457so4151353fac.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995571; x=1778600371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O97PAflqjjtCiKkA3gTz4fMVjeIt3GdTmnKsTZ8H7Z8=;
        b=cN32cNintGy2+tB7v2MIB9ZIOITD2tfOWGVEA09gxvIhPKazxQfqL9DCB7daniMBb1
         qfFMeL7QI4bOk7GZmjHBSQR+gOtKehWxoY1ikc5kxnWaJ+h1GQ1YrnHt4ljs+7O2IOeb
         ntrooqYPXibYLljXw+rgTXod8/DngJwpzIy53BjMxy/bOtcgD7IuxiWleJT6vfJyoKAX
         2t4cihlAtmrTZ97OUXnOUR4tbtJV9cwRIxwxiJ964Fg1AxKxoQ+z2/hLTj01wbR4foET
         uAXXaq2Kmd+Ru8VMtXx8BTbTzt2C4JZ2Z1bc/bCXKVW8Vt1ddHDAFnkmiExWijHShWFL
         Fzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995571; x=1778600371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O97PAflqjjtCiKkA3gTz4fMVjeIt3GdTmnKsTZ8H7Z8=;
        b=CQvcEaJ8FXeWtJQEqMCDW7gitAArgu7ZIcU+3Z/NfykphST6MBdJtSGsWv5OVDon4Y
         tsNU8orlVHJYjVpmmiBHMpTDW2sWfTGExZS7EzfyLsZncq6dvnfDMPl6/LBDpHm0LS4A
         4HNBmyYVIUy2p+6SBXeQrSC74T+YZetVnijMDKDJvEj6586uutFxGbzgvrWkAo+luPLS
         LQRx+VJjcDrR8SN2ZSHAwAXZDiHs6Cva/7nBPlhfUY0kuKGCjmEt4sK790lQo+5MaxHP
         SKiAEhGb2iuQEafpJbgIPqTZHo/t+OjfFYcc2gZ0UWMLFO1ZNffgGDNwQBumhfLacXx2
         uq9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9BEYQ14W13ocG8Bl60I/qK9vXN6KsuXwXkG8qQqrAn1ZcJVlOrEJlmiDf7xBFPocNEbQegPtYePg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99y0FmjyVcBeU0kKTJSF6SBKIa76PDzM2n1164Bro5ThRqB6d
	nr/Wc9TkXzUyvAJl8Nus/JillrK9KJvbWK7pU7CSlbSSTQQ0JtfLx1b2
X-Gm-Gg: AeBDievbEpmIBqIPjL4hi5iEhLWpd9p36Zee2aWrLx2Ttl2UcNPkg2WExFVR1ujntOM
	4d9/GiO5/SEqze1ow8CBQyqzaLC52nOU0uTLcHT540atH+NC9BQosRjoOTMViDT/lKMaQCkHaLB
	j/HyUKSDbDRMsMW1pwwpUIhg88n50LFP2kmgjs8Kihm6SxpV1UFbnjx/t9AhMGbBo/W9MBftLC8
	VmZPw1u5fSKb2G+dqj8dyIUGRwaART4Nv7+aUlGcyUTOJy+b95C3JaQjtF98CSVnPjtdHYukd5+
	T6X9mMbQekMCHWmuRFwIPvnNgvy/o3veT830lusWHBb0uOYD12gzRE8F01Ajm7L4WpqB6j3duGd
	E527jGbUmfaxtqOqRZX2F1Iw0U5tPsnyGZJUEtSqY6eUi8gqIPHAXv9Ci3aoBPh+q/ylMliLBwo
	l01zTiSezVMeaUXM2dJmS6oUyieXdxuGIYIuHNT79oCZE8+fU9mhBATns=
X-Received: by 2002:a05:6871:3861:b0:417:a283:9c81 with SMTP id 586e51a60fabf-43476281571mr7457002fac.35.1777995571187;
        Tue, 05 May 2026 08:39:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d35e5bsm13955814fac.15.2026.05.05.08.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:30 -0700 (PDT)
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
Subject: [PATCH v6 15/22] zswap: do not start zswap shrinker if there is no physical swap slots
Date: Tue,  5 May 2026 08:38:44 -0700
Message-ID: <20260505153854.1612033-16-nphamcs@gmail.com>
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

When swap is virtualized, we no longer pre-allocate a slot on swapfile
for each zswap entry. Do not start the zswap shrinker if there is no
physical swap slots available.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index e8aa9201ea30..751687b7e2b9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1214,6 +1214,14 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
 
+	/*
+	 * When swap is virtualized, we do not have any swap slots on swapfile
+	 * preallocated for zswap objects. If there is no slot available, we
+	 * cannot writeback and should just bail out here.
+	 */
+	if (!get_nr_swap_pages())
+		return 0;
+
 	/*
 	 * The shrinker resumes swap writeback, which will enter block
 	 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
-- 
2.52.0

