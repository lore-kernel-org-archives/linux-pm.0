Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC9348C76
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936468; cv=none; b=WoMc3N+Si1ybszfHGvQ4l5/SXIXKxlMbv9UY3VZCsrSXCXEEpGJqBWFHZ8ZtBf6JwWpFBtakl1ZZZmYxPxtCskTFBWedMg++a/sVai0KLtSTqH+k8z6IEdfTqfgAqAoZOiX9pJZ+tQ8q0niN0zC0wRupQmOVu+xNLoJU5VEWQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936468; c=relaxed/simple;
	bh=o8E3Y97/uq7/nE5aPAcgxU0XNcCxSrIZSYmd9j2OSmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aqEAyFyfaPWeVmO170kibBxNckG65N+I7gpxYkvkiklpFDu4ti8HWRhlruxd4w9L36dgK7uGP76XozbpndV+/P9Li+33nlnBHfzMKrSr3A3d6aybYs9ZWdykD6r4o2UdPylkyxpd/lylb0sQJ+ZU2yTOKtEeWQrle0FH5DnGpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFSSmdnH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFSSmdnH"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48589798dbbso4522073f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788936462; x=1789541262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOCQAP6K7d2SeDC/l7CuDRVi41UuAMHdzhXPewwMtn8=;
        b=AFSSmdnH0UpLuRXjKo5pt/BrgFkLnAavG+8qLhQEMwimICRqkWiszP/TdB9up1v9Ma
         K0+Y7V1e/CivaW5OJN6FkhBSmD+7a0ojGTHX//KLnLOayU3g0Urkbzpksu8XCOWsDZot
         6BOffL1QqV3562xDjrGGeepc6lqVAb4XkbGzB/M26XFDAlqzi1mWX57hlpEmqwQmPG1j
         hYqjjE3oIQnCn18QrzPol2kqxry7KPg9eddz8mttnb8ihRHqVwbGytMfBu9f0nDVLIEk
         nVC3IhPGbOy3Smdyy6X2sB9nSu231I5PWaa9zKjTpIFdjPuh2t7kcMdKEQc+9FJ5uFug
         yXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788936462; x=1789541262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOCQAP6K7d2SeDC/l7CuDRVi41UuAMHdzhXPewwMtn8=;
        b=qisE3L73Q0uMbDMvHcggcvJG2dPLBnqgMdzjja/dbrxJIaJNs1Qg5+RLlOPQ30yIaj
         RKBzU3QWwrYDhKRyKnUt9Q/pX4SwMPHH0Cu3itjHBB5KaWt7aLumDkZVTOU2R3nGujiP
         rCTPeGpAmdU0hSxdMtR/h1BA/WGrPFPA2Vbi9vzEIxeDhwBLsjjugtVgHJJHNEXryXxL
         UZVDdkpXzDei921XRZMwC8N1Wqr9EedV1dIAVdYcuRl9AEBJpYcc1ULMgDDN4+ZOlp7+
         igMd5DENAjFJvqN/KhGhEeoWOWWB4rPox5LpRw2r5/TJtvgCscz5n0ix6Akjq3rg+fiO
         E7AQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWb5S5eOI2WUtcnVWmdsyANFe5AxYy2vvrnNHagyEN9HPBYQp7Gq5fTvcAuK1LqhlWg1v35RZi5w==@vger.kernel.org
X-Gm-Message-State: AFuF++k3X5p0n2qRCGkX/ohb/m22MNVaqj5tWm/aNbCVMf31tVmcCdRf
	CdeZw1qM71UMmKy5UlbTFmm6A0Egb2hbKAVjpWzJ5/93oFkUNIhx/otAvNdAxS6F
X-Gm-Gg: AYBFou1g6/VKKmRIUgyQKPOZaObXquyq6ddSStgNPuN67QU1yjWCSmGg+mZPsYTkPCm
	1y9TkpLDeG3Idw/rP90i8o+2C2H/0JnawXeYLaeBEPEOfKxALxaF+SyBj8W87uWok6GFwkYOehB
	G7lz4EhUgOFksq0wkOboQLF0g+26tv3UGEEV7SuSzNCxN1lOD9BQh+aot+c+bD3ybZenyTNjv3m
	CMW78XeR1v+wQA1csOWvBwNxtcYQRIBO/7y+whkiNjGNG9ANZEgfw+Q0inVaQW9xmvd1RGAB7Nl
	MRhowuxQRb49yIhf+4uOygfSkA3rYlLL704w27hmn064U3k+ow+wsvFjZywpi7WumG5fu7yiSQg
	tLlrM40zNslvB0wvdUBfiTevFdI2xwyxLIypF9Yz9oZTWcWET5nVRu7dAL5Iid0EOGIn85bQsT3
	BssFbNTVgMJdMo/ZpU3qO5h5swzgPPx1SMW26l4PSXo6vaeSudkeN96jPidy55uyteVyNagT7jY
	16+cyCHz8wQ7JBjCCDwhQC30VP+VYPtWO1e7bim+Mssb6OfmUImzYYI13R3VzuToVccdtY/ZyN9
	3svtlHcFs7EFfJw4+SYxEtHbmofQo/NMFLCthDDolW/xIOtS4qEp
X-Received: by 2002:a5d:5f51:0:b0:485:8a46:704b with SMTP id ffacd0b85a97d-4858a467215mr30855337f8f.29.1788936461723;
        Tue, 08 Sep 2026 23:47:41 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-114-212-219.95.114.pool.telefonica.de. [95.114.212.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b7bfasm42216264f8f.29.2026.09.08.23.47.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 23:47:41 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: Fix maintenance charge table kernel-doc
Date: Wed,  9 Sep 2026 08:46:23 +0200
Message-Id: <20260909064623.90737-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct power_supply_maintenance_charge_table contains
charge_safety_timer_minutes, but its kernel-doc describes
safety_timer_minutes. This leaves the real member undescribed and adds a
nonexistent member to the generated documentation.

Use the member's actual name.

Fixes: d72ce7d32478 ("power: supply: ab8500: Standardize maintenance charging")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/power_supply.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e749d2189335..95d3bc42ea17 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -414,9 +414,9 @@ struct power_supply_vbat_ri_table {
  * @charge_voltage_max_uv: maintenance charging voltage that is usually a bit
  *   lower than the constant_charge_voltage_max_uv. We can apply this settings
  *   charge_current_max_ua until we get back up to this voltage.
- * @safety_timer_minutes: maintenance charging safety timer, with an expiry
- *   time in minutes. We will only use maintenance charging in this setting
- *   for a certain amount of time, then we will first move to the next
+ * @charge_safety_timer_minutes: maintenance charging safety timer, with an
+ *   expiry time in minutes. We will only use maintenance charging in this
+ *   setting for a certain amount of time, then we will first move to the next
  *   maintenance charge current and voltage pair in respective array and wait
  *   for the next safety timer timeout, or, if we reached the last maintencance
  *   charging setting, disable charging until we reach

base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
-- 
2.53.0
