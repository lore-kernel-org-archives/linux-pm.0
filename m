Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C095395D99
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873022; cv=none; b=TuqSD+vfEzLcwFmUNPKp085NOpRzRItkox37sysb1FInz1aaR+kM+s+9tPa2ko5e4KwfHmVsxb16a4mXPMzvFjBx4XrNZFBwd3uCeP0bw+3LGhlj8ld/5E3XLLOlLErBiXbV08tpCLoUwJugL6zNRLOM/CeUlog4ixo5L11A9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873022; c=relaxed/simple;
	bh=XUG2nMpJeoG6B9ljhBEIzGZmx65mAIf5essHdmFCXwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISDmjZDMvh48xDnqkxZC3Gzds/uB0WLVS/nHwmWH2YkQuDcpzA49VA/p8HzMfpPILo6zX4jeB0CWLDuNS+m24df/Ti0pB3t71FESlBOXqEnYD2NuDxWz+vvCAxbKsZzDdPlPkZPBdLO21EGKN2d5fOrxFt6GrRtqeD7JQvCjMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1FK5mud; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1FK5mud"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67bc1b08afdso15275eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873019; x=1774477819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNNnmWHnRUZm7wwtDTGZLy0ujBXuugSXcNtRiTK4tAk=;
        b=N1FK5mudQcE3fXighw0xP7NsaVdH4YqhKiHyb7kJO8zob8omU4FgxwVL6E6VFzwLyW
         HdIf4S66cUz1KHWEKh3R2k4mB5fP4wh/RRmQaundb2vgUHxzASh6kZvW+RfZP0UaEyZf
         a4pG1ndpONim1Cvzfv0zY4qf7DLodxDAliP42orDJRgBk77mOhga4Q70rV05epfM7O3g
         yh+brGbHN8nV3/gVsPQfKgslFToDdmvm1+f6PwrpYyoefADU35i6hPAEqr/kPWGQBlW8
         aBdRaj3ZBIAcyVDrmhJURbc3ZJEXC0jRwQ9DYfFXgaDx1SWNTnxBdrV1Jb3Y+zdyvtgo
         EqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873019; x=1774477819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XNNnmWHnRUZm7wwtDTGZLy0ujBXuugSXcNtRiTK4tAk=;
        b=FXSaKnt0JH2RseElyc2sQEopjsO/TihoU94MK/NlGPgPvsp+dhrCMwBT3ULWOHjvPP
         03BXChX6OFc7OmEHx8yFzp5yMwmDlQI++FOWmf63FWAtzltLriUszYIR4OBKRhLfU5tq
         +mQq/kNoRpHD0U4/OczeCE8R8yXy8J5mzwBIxhcU0XyLj2HtzpnAfukMVsKmxHUjRHEU
         z5DGxXEnRlEuIU2lFCFTh83xkWXC9rdI1BiKctPZorCJGqvtfFHNs7XTXFrYx976vQ29
         +iZFbs2qy72DT5sXjrqMyMc7s5bSz54nHQD086y5wA6GHaljMy4aashlNumppWZgTbqh
         IcjA==
X-Forwarded-Encrypted: i=1; AJvYcCVAKd4wyV6LgNdO7XT75CnKbMRqRgB8Bbujp5NOkssAIox9t5NA7vZLVYmHIM0igJgZCif43KeZxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEz492hBK6t2EzwoIpReu8FbsSr3eHpVnqO9rc+7eyTstBQMO2
	xiFaOevmVvrypWKjl4PDMduDdwEzuE9iOdfIH/Gvt/QGqwih2O6JJ8vQ
X-Gm-Gg: ATEYQzxj/auFXpsxxNoK3bc6Msek1/7/L7JjGejrdUs/gy8U/TLBJlvhn5hJqoCsxSZ
	iCG9vc2/gVV1vKE+Fssj9w5t0MSyRzKeetXpcbgdnIVvJ2T4uje06xC/3uVTzkChb88HoJ4/QMV
	H9b2CCZtZiEzAttXvkf5Kq9l+JtjS/m0SEoWS5ZHosHNUxOcaIdyhoXnyQf5YXb5ABmG7ukrZ/0
	XwXKs4DS0Ft+0a1gVCXxePleiP17KeH2cKP5DTEW8WyTum/SLwThu72yD3shfBdJYEGtc4gYUjg
	fRqnf96cQmEckjHewLa5j+qlKjFVxTWjQULjAc4YI1ObiX3xfUQMnlnHGL8HUTIPsuFil59NOqH
	XUPajne3m7UA0as7Z16mVF/vaJKis07cIij84IS0BeoTGit3uNq7IM/4o6lGDuY8WG4RewonTHp
	JVCXEwdP+9N71yoDuPGBGnaEffjrB9OCjxkkyr48BNkA063tMMfGer8G7+
X-Received: by 2002:a05:6820:c89:b0:67b:ad6a:ac10 with SMTP id 006d021491bc7-67c0db1a703mr3715865eaf.50.1773873019226;
        Wed, 18 Mar 2026 15:30:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c0d88c5bbsm2544446eaf.10.2026.03.18.15.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:18 -0700 (PDT)
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
Subject: [PATCH v4 15/21] zswap: do not start zswap shrinker if there is no physical swap slots
Date: Wed, 18 Mar 2026 15:29:46 -0700
Message-ID: <20260318222953.441758-16-nphamcs@gmail.com>
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

When swap is virtualized, we no longer pre-allocate a slot on swapfile
for each zswap entry. Do not start the zswap shrinker if there is no
physical swap slots available.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index c5e1d252cb463..9d1822753d321 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1211,6 +1211,14 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
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

