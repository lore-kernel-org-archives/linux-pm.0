Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304B30C366
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426740; cv=none; b=XSQScWMuJxuPf9h9ChHTxlO1VfunWNm7rxsfoNGGptj4eEsAFDtrJyirhnOOVaZ5b6jMoUz10bbMs8QqIHh6mX0V+WWaxUV7Ntccf9u82HWsUQa5zdMKhhfhWqGBp5lAjh/ks0uR4oLkkhcw8bA8dcVtli9KXabhTj4Ayli9RoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426740; c=relaxed/simple;
	bh=V1rebkYkH0xbbTSdHSmSsIS4Wj4McbCBjLT5yNCpazA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=reUfgyVM2vTeevtugqqoxm3RCDFGoiUBFY4ZbYdpG3XfVLlhP301taeKTE6be6X0Ma8QbzFn+yRI8jz6yrax3oOgSIGP43A9bVRUHM/OERWA+qTvj6Bzx4dFkQxcbDL0pAMfDuPtwT0KtIPruYT5kEJ9YVOOBrq0VVeKthkRtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+xUsyxb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+xUsyxb"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82985f42664so1366360b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774426739; x=1775031539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OYyBTHqBgdWNzLcMu4J26nJ5nXtlUdcoysDntT0XCb4=;
        b=P+xUsyxbTaAzrETj5SzMYIsGM4bSBhIO75vjRqBtBBAvpsrKy4i7pAruHjmkmn5QA3
         xGjXDsRnG1J4CWi+Q2edxe24zLU6CTvDMruqRDtgI7wSqPuB6msRvUMMdQF48q8G0iNe
         dB/lLuJRNqqgUtNQgwq5QG6XyiFucvR4cZy+9jAGptwMedUzRI3s6PdKjRF4Lrd8suW9
         eVIp2sKStqwtHJ+8UXYMX7NVXYaU1q+Xt++02r7mU+VzirkAyZ1FIYpiQNRhVrPKMbos
         ja9X5HFeJVT/wlTYPXZdklOV1iodkVR8BI4yyJotouENhbj8OaTXDnZ45fXKR5SDYzDm
         ItZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774426739; x=1775031539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYyBTHqBgdWNzLcMu4J26nJ5nXtlUdcoysDntT0XCb4=;
        b=r4ZLf9mGGHl0Zfv2lfoWVDUFSGCfDYkDahOtDReMBoI/RnX05hNtbe7aaP0zCL1FhU
         w1sTbeDlmEtTxxuGTbTd7HL+JAOqjuInSrSQWvh0hJaQyucIN3xfMSKB7Pxmr0SPC8IH
         gubZHjQfC3lFZfGsJfWDX02aTjCw+XzHHgvukvoMzUt7B+O+62jCiurqAcele3RpqpAV
         ssQqNfJpBeneGKMe6i7FFEPpK3ZdgHD/dIzpehU3TOIc9obqqYHXIqdfQzYS06VqT756
         HW9xhjpaL0+pHPX+VkAyK9ZUcjN/alfyddPPGOI08QMFXfcTNqWhx/rM4jMQLn1dWd18
         eg4A==
X-Forwarded-Encrypted: i=1; AJvYcCX/Wf5rvqSa2hbG7rjwwXAbzN4A3XrqPohPvAnPF2fj4rxWhrQaLi+CQan26ILCjhyvZEW0Q5YLYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHdUWSTBqeN4TNQ3Fs62g20Z2+061Kz6tMuRdj7l/VjCGczWh
	sngXmklKM8rlCVaPP9Z9/2euElK54sSft5nCe1uo54dzk+5OqjkK2osLWCX4yJ6WwgE=
X-Gm-Gg: ATEYQzxbUj/V1J249xUeogEaaT4aCAT567mXrIX4yRRhdkx3GUJLVzJHsJq6oR48eoQ
	6H48zfmsDk7LFJuXXuHXwADhhXQRMRbJ7eHldljKcb35+W2mvB3vkwl43k5D8EbrAVfRmsZsvEs
	y0eVFcoOJvRmnMIthFI37hphoKR0MWFJDqzixdTr7ccU9nRcLSitfbBzVtK3hwXWvZMTdXeNysL
	xS0XAVMLslUBCuSooBMe7l+KXpdyEIqChg55LIEaJtSyL/PT8Rn6A5rkq+aV0Noqgp2jhCV13s+
	kMwmHj86fKYBhLi8ajiijOxjjknDjHBP1zA+gqnV1DCdc9y1WRLgaU/5uyF/46JhdyZ56lfSiMs
	e1lEDHoC8riBWShfRtkewILp2XgcK+a4gUSKSxE/lkZ+r93RxCFMZXNJETYbEBmGdbTc1dBTAwz
	Zf+579P5+rTNECbDlWZ3qoAj2xsVZJq5FDHF9rQZZm4v3t4USPY2233uY6xh+UJaxagWISzgDDN
	3/O9g==
X-Received: by 2002:a05:6a00:844:b0:824:9ffc:256c with SMTP id d2e1a72fcca58-82c6e0d0d2cmr2445949b3a.43.1774426738715;
        Wed, 25 Mar 2026 01:18:58 -0700 (PDT)
Received: from toolbx.auup.amity.edu.in ([202.12.103.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa9fc6sm15454426b3a.7.2026.03.25.01.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 01:18:58 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: fix error condition for reading st,thermal-flags
Date: Wed, 25 Mar 2026 13:48:42 +0530
Message-ID: <20260325081844.13829-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_property_read_u32 returns 0 on success. The current check returns
-EINVAL if the property is read successfully.

Fix the check by removing ! from of_property_read_u32

Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
* Changes have only been compile tested

 drivers/thermal/spear_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 603dadcd3df5..5e3e9c1f32f8 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -93,7 +93,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret = 0, val;
 
-	if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {
+	if (!np || of_property_read_u32(np, "st,thermal-flags", &val)) {
 		dev_err(&pdev->dev, "Failed: DT Pdata not passed\n");
 		return -EINVAL;
 	}
-- 
2.52.0

