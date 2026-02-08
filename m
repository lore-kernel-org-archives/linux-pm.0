Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3D35FF58
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587955; cv=none; b=nWjf7Np380HsgEqSNrLmAF2SbpSLFcv2ZckDj9mXwGnX6pjQusDXEWJy/lb2wISFIoY7b6ouMoGsPEvM30C9+TJCf3mEaPgUvu74BHxtI4+knv1KDVx4BO/LXzQZ9xft/kPQwQnC9hqd5XqyWdEKFKLUV6hk+RShM/GkP7cBaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587955; c=relaxed/simple;
	bh=XBmrk0o39FAOIaDvlicMy3Eh3cFwDg1bVSNwmZISXsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDlHrOUug9yemeUESjCB61VO/S8xd32k+WUUPfwySot3QsFfAOPx/1/MnXTG9BlkToD9cgFKMRX7nnH+BtiPBWWV/ZvCvXG/hvH2BMvS0h6VMKnp1txZLN19cvBLsotnhv03SujOzukEQKksTtrQsOq2pAcWLNaG+ScVYhMb9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfpipKKC; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfpipKKC"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-66f343a30ddso583329eaf.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587954; x=1771192754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QY06q/ir2j1hW+S2SjYAeivUq/qdnGKxDWe/px5J+A=;
        b=FfpipKKCVpCqx7HM3BYiH/RMENXLSiIR/koRgxvzc0aEp5P9xmN9glHJwl8q2XaKHZ
         dcckmxhxAPICg0IQe3X0r4r8iUR4Xuz/gGZ33/nZ7uTyUCFjtF1TO+0JlCTXC6YxGM1/
         WVqJtenzA4TS0JTlwjdQD+dj48Gerb4OgoMt1Dx6J4arQkRjDZGjwUSPbdHPwYjzXftz
         Z76+33cpHzq2aWrLh2jFkYDNSA+ocGivVuBHJZc0tdR7ob3swV1fECOPqZ8fFdTUShpZ
         QuZz+vjdwRZGV2kzem/qq0xI+RfM6dQtbWW2XIp43UGUwWpjiLyTVJlQEMQbrvSknzLT
         q13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587954; x=1771192754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QY06q/ir2j1hW+S2SjYAeivUq/qdnGKxDWe/px5J+A=;
        b=fgEjUsHo6oBpw38Zhx9NhX33rKDLcQVWzHmVoyF3GuzUF8gqAs9MLnzc4HByqEwZ0X
         UeVLknkCh/rcdTk+hmkOj6nVFi8TYsMuCVIuIy8ai9GhCy88oxeRGFP3LV+upMzkYTC+
         ZjyZ0W9IESGHWPNiGuBhJRG9dddgaVnAAkVdCII9qSg0A/ZXUq2ymdkkzUXN9tqPyPv5
         o1gS8a8a3jxcmKXbuvo60iaQhmnXqlHVX183FC5jspbRCv0HeCGvxM6BPeEPFW8VFmbu
         qjwZR6QHlXvaH5jf5Lpjx1JqFB7lwWEHoJOKAGsdr+XVbKXFNct5h99mil96JKYQqkiB
         P3mA==
X-Forwarded-Encrypted: i=1; AJvYcCUy7vwb69WVOL+UMeTzmBYzXM1k0G6gAkHzt4+3SgXW6ssRKajgGoplrpGyRwNqpb7vtHiZJUT2Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7uqUOG+0OdRsRK19+99pQQ6bXo7cwtqaYhEOih59JjfjP+6D
	50xlctRoawZTgX1R/v6aHeUZEGZc0cqQqJCcS80UNgTbf/S5AECeAKDh
X-Gm-Gg: AZuq6aKru+VtIrzV1dP2mU97m8vIf3NKCaSaXgZshsq6D/geobl8bY1UbHSJiLS/TsR
	Wv/t4wOK392IJESjBJT2Bn7Zq9PBd2vvmdnu52YYJu29SmtCPmJ6qxUddsZt9RljkwqMLe1frwS
	tUX4YvfEB/K7jQMb/jO1dhGdhJQsCk9A2jgsGFdFaxspApSub18vRvFP1L7VdWsNCgFPmb0roty
	3JwQ29wY1Oex2Ed6M6IodUvcm4SsWFAk501Cqd7488GPCI4lzZEfwtbYULNK1+Ltv3X69gYrTQn
	Xfzd+v6t1ztupICZwQqHyZiY+6Kr1erGRapO3J76d/nLraNLR0QXhrhhOV5C6oAA9t4HCeX1fJV
	onHtuaOSGySUPAL+mrH8haiNFhwIOcRgUH3wTpl3Az8CHlGy0Sc3psp7jndhOmKkb89v5esj6Hb
	GWAJKyPNd3BLGPl+cjiQ3MDBOFyntw5gL7S53xmCae1zw=
X-Received: by 2002:a05:6820:16a6:b0:659:9a49:8f50 with SMTP id 006d021491bc7-66d32bfa23emr4293572eaf.21.1770587954007;
        Sun, 08 Feb 2026 13:59:14 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d391ae639sm4737086eaf.7.2026.02.08.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:59:12 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 15/20] zswap: do not start zswap shrinker if there is no physical swap slots
Date: Sun,  8 Feb 2026 13:58:28 -0800
Message-ID: <20260208215839.87595-16-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
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
2.47.3

