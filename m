Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12BC3AEF35
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780779917; cv=none; b=j6tm+YTrDYHROlLytmCQU4V4iHDiD1Q5z1ryNeSwJ0ry5ViThmKHvN6sn5tycV7dDP4ZbRoKRcp5sdmU2GUrsJqzSs5wnZLFf6cpg3tyFe3vMn89sEA7XS0C0kt0SmqCLyxLTzaGVXGfgVZPLSIcmQiK5t2ZYrA09JM4t9iH/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780779917; c=relaxed/simple;
	bh=BGb9waaNK1EldJePN16LIuSFT5rJ8WYNrMTO4IbV1rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbIJEFs9rZo7v1iWv7nhRSai1ljwPnuXeMakmCM16J46UuQ4nQwAd71KWDdak/FKAIIDAZG3m0XS5buGtEyMXwd/y2gCmjGc1fu02TL1fSqESdsg6xdfMWs8jOmMRgLbOFXKa+TzEEefPte230KT6YcNuq1QMRyzXShRWM3VIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4KOun9B; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4KOun9B"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so26246985e9.3
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780779915; x=1781384715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i80MS7gMup7gz9Mxu/SD6lHpAYvsK+GiD4OzJ+0Tgc=;
        b=G4KOun9BLy0ouJOE3fXSKB6LpX2HENKdBQ4Gx/lNIXhC0EryfZolfPqNPcTZyDg9kt
         rj1ElCZWAK67QicwnMTMQQcPNIjDKONu09EF2FYx2HHFGTCqcVHTUemnRLuy0s7zCw8M
         IsABAvVd3ErkG1KFWHJygUEQwJAJq7fT9EQWR9sYNN3ssi7vcn98HZAugpFPUaphO2gU
         o3z/9aWngDXXEhRW7Qd710HrLUvcXaHq0OeaczN6Kvn0RWVZzCFziFblKuqamtQoj+Jb
         u/hzB+M/zwbiknaK239c6rjGrVgfijqWo91Rh1H5iX2HrQm35fyyIIRHh64UvX30Gewb
         ElaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780779915; x=1781384715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3i80MS7gMup7gz9Mxu/SD6lHpAYvsK+GiD4OzJ+0Tgc=;
        b=r8EGULo3OxphWAy4kX6qlDJR2dE6b7h4Y4Rsj3QP+lnjNUW6AZLuOBY7x/32fDNc4e
         qktpAmndYBAeV0+ErVmrKCSyPjzMHYPx5br7Kp2SMd9Nr4srz/dejmFi0ucWzx0c3uDz
         jWpsixx9F/sSs7yLAlcLraHzR2fvrDebc8vAYlNlmZbwS4JYPEVqkemFfsg0Mmigxxbz
         looBbO9vcZPGxZeRWTO4B6uoV2vYcEVAqWCZUPJpAzmCDc0SvLAh3jl6pcccvH6CUHUv
         9Ay85WJZZv5iTDb17g6hncxn37X47jvrHtd8gfDnzEQ1OJ7+y3SAK8CJjO1QGy6zKtou
         PbxA==
X-Gm-Message-State: AOJu0YyVL3IW36HVoHh/VMt4FY5d9ElkLB+N+Ql3cUFf45RE4kn08+Rd
	/zjkAlEaSMJDpU5sZOmcexoYAqUus6G1n+BopX1QZPSl+pn3b72eUw98
X-Gm-Gg: Acq92OEUeb/iOuAy+wyOPAHqYTJHQgH0Gjqx8Cd2CgVdU0oIfDafwLsqcjsPMXKzbWX
	R/hsZZVSDGh8S1mIB+3hGRU6+Vd5ftAk2Vu+fb7upqRoIZ9//b29HxzfUJCjLn1m6HIEKRKKcnz
	vSjViqlrwQ4mDOrdvu14QZvF/KbJA4NvbUJtDZJQKC+v2YDPebhZIqMkgk2tcB+o9E7LR5WhiqI
	Ny7YksXMy3EK/S6YrBF/zcknHw8bWFscVNpVjI2rZbta7ptclLRBJDsHBvjzMWFzp/LEX062LXg
	8xvLnYHMx/KIhMW371PgOHEF+6YP5ZXzEE4j6rUKEuyhq0B6Vr0jbPeik4CKwvEhZAXuVm9scVT
	o8sfO8E2QvvtO+hZzmrhSjSbrvP8e924k0S4soSS7Z9DaT/T4HtaRVwmqYzlVFWobdp/Y3iLHFO
	KS+B+enJbNlGH7EPSBetgIGJirTQavLijXE/qjld3qs3w/GliaCVAorA==
X-Received: by 2002:a05:600c:5010:b0:490:4b89:535d with SMTP id 5b1f17b1804b1-490c25af94fmr160559615e9.1.1780779915041;
        Sat, 06 Jun 2026 14:05:15 -0700 (PDT)
Received: from ws-linux01 ([86.124.200.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fb24sm39444226f8f.34.2026.06.06.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:05:14 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] thermal: sysfs: Replace sscanf() with kstrtoul()
Date: Sun,  7 Jun 2026 00:04:20 +0300
Message-ID: <20260606210420.2311145-3-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
References: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sscanf() with kstrtoul() in cur_state_store(), as kstrto<type>
is preferred over single variable sscanf.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 9f2f25a6da37..b44abfc997ed 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -536,11 +536,9 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	unsigned long state;
 	int result;
 
-	if (sscanf(buf, "%ld\n", &state) != 1)
-		return -EINVAL;
-
-	if ((long)state < 0)
-		return -EINVAL;
+	result = kstrtoul(buf, 10, &state);
+	if (result < 0)
+		return result;
 
 	/* Requested state should be less than max_state + 1 */
 	if (state > cdev->max_state)
-- 
2.53.0

