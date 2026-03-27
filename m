Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C51DFE12
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602341; cv=none; b=H5DaUh9IKEltJk11WeqqbBSiKSa2LugSVEViDLNX4Y5osznAuqnWcOK53+jUCJMl3ATHqeIbSvcG5WMJOIiTSKuwd666FZjNrXln+kilQpBzRzzLc+hAxt5gPaM3FifUia7dPQ4w9SghSavcT1g8urWKo40VgxcJfQWbpl/x794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602341; c=relaxed/simple;
	bh=iPyv5IYlDNVCZISXWMfrOwvgL4SKc7iIpzuF0gcSDsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwoZAIuyvfgIwgLNVadRcubq4z6ZwhLtDaBJsetoTFheYQWdEFhFmfFQnXjsm2RdTgVYiAoA/be9+tqFdKwMwVuaQCxXAKIhWI7I5AF3yGLoONAKFlH1cXlSID2WhN24NL4CVvTWtwz0fwp2HZba1smPDFtxUHO7mrIONUGJBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU2eFBgz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU2eFBgz"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b062069f80so11076535ad.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774602340; x=1775207140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPPZ5j067D2XHcRsSiauJ3ctRc5sWeqt0BIIAF/OocQ=;
        b=DU2eFBgzOKkRxDYSCP6+ZxLA9+Dy/nR2SqnHyd/P3GuJhof1crItQT59fdEHxHbVR9
         SBcmKtMqirb3j810QAIq30cLPXQbycnEKfcp77QyaFiWtwhSlqcjFzL7N4mkosopExAB
         G0cI2iFFfbFhX052r5ITk1rVeW3elE8gydBAwo50ONa54XyfMgpuLfVn2tnQh+DDMVKN
         NTg5D8ueSAbKIl5qqKqAb+6dxdv5oXjh4jNWvpfZLiEjOiR/vN6tOnzOV3C54fByJTF+
         5IaA5m52+dwWP4Sb54Krp6Mau/DOL3S7s+E+mMgl8G87VZOo6Iop6CG33u7zpQ+CMbSw
         KGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774602340; x=1775207140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPPZ5j067D2XHcRsSiauJ3ctRc5sWeqt0BIIAF/OocQ=;
        b=c2fZxMRFuRqMwPQf9E1j4834RQCE9WDc/pZHBCOm59OXIWnffg7yjnEWjUHvGvYf7C
         3+pfwFbhekrVmRUO0btJO5A00XRLQzIJEVO2tghsOO9Qp9BvYwp0RGElqgFGN8Wl0tzk
         nWT9US/z5ora7wG6ESYiJKJ40X4hRKgMc70Tf6EPrwsfxj8k5klP6Q1hjUj+SpdlyBDg
         N7V20NfY0zV9rNWVTgF2PiO8jdNx0XDNT+0u1mt62dBiAGcGDccDhWzLxTg7ebzbHrHV
         J9jwjK/QniXkpKb/nhwtVPftWWR5+6p691K02MI/OHxD6BbvBSOxPo81yXKlYlY+I4Bw
         Ms9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY+RyVzXVC1CiwBkXaJG685DTPXJDW8YWymbCDeaez3QlVho5n+/2YH95SoPIVMshQQ6gfp9axkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/6BHIVJYNwmDjYRnSveJzIQTYE+TK/uU0Q8fX1SQpB2KWEnT
	VIWg4n2qnjXjkg5kqmDXzGYzJzwH2ZpGatm/mYfSLp6a7QTmNbvMfMC17V2h7t+A17zf70mL
X-Gm-Gg: ATEYQzzU+lsD2ZJPbO9xgDH/qLhqhrxKDlOv+N9ZQbbgLSbgwgaZtgj+Sj7Tz5qWANq
	SJTHiACAMOxFh/yaBnvx3cSpekAcei3ESGQmj8z1lbtCeR3aNJxb2s1YOD9nmG73KbyzXXuliq6
	BwU0WEd9YWAJUCvujkLqk0plZ8o9uhWA1rTKSSF3ZnJKWyELgfrU8UvXQ9OBDbq5UhpDzue2BFg
	lVUwJcoYghaq0oDGaYoNABMefkszg4IhVDrt0moRE2w6+xqegt+fwhKK4qRkIBvrEmtR4VXGq92
	M8YdnrnQTD30vbZ+o2kqNjJ+QimxbVg06QQwCnFl01jpfXFEybhmwFVWvwFxL+jr+m8iHEUgBUX
	Dux/iHywXS4BkU7dQbrSM5q0mSfi4cEbMWJp2pA0Zxnr5NVyCWGWR3AtBJeiD/SnPuRl7mOYsU3
	ZvLkBFjLKBf2BrRKzJwiEVmrs09sKqyKuqYeUF5BrDxyFPp7ZCrV0RS6P2YBAfpe/yApGDaTNnd
	BU=
X-Received: by 2002:a17:902:c946:b0:2b0:7a27:bb2b with SMTP id d9443c01a7336-2b0cdcc6df4mr21500755ad.34.1774602339718;
        Fri, 27 Mar 2026 02:05:39 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e643sm57767015ad.41.2026.03.27.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:05:38 -0700 (PDT)
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
Subject: [PATCH v2] thermal: fix error condition for reading st,thermal-flags
Date: Fri, 27 Mar 2026 14:35:24 +0530
Message-ID: <20260327090526.59330-1-krishnagopi487@gmail.com>
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

Fixes: b9c7aff481f1 ("drivers/thermal/spear_thermal.c: add Device Tree probing capability")
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changes since v1:
- Add Fixes and Reviewed-by tags

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
2.53.0

