Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F92D0605
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 03:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163148; cv=none; b=X/XggxEJAmRAvyTc2FgBwwLMAFrm43inqz2zsNOOgVZl8fNrwsH2NyT7CpjdJQ5OAENq4ikNFvdYGtzuyHZVfOVpVj4F83S5UfeAmf9Gvvvcr83XXVhXcou+1k3BzZDDfXzW+7TfsBZBOFsrzfDyvRc5jKdUWuxEIns+WlypIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163148; c=relaxed/simple;
	bh=R7AGsufwE1ILFr9lSL9MwQ6HbZ9H4nnI+NEq4pE0vMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqYmcb7oK5BUYLIeG0RMmcRfQZExMC0WHkM/cTh0Yhki/NlRAnjEOg+y0Zo5oKRJiANRwjOlW67T6lFCnxv8qlqVhHUYM2k1cncYspv7062arUzxaY4yct3wnwNshLaJV85DANPKM9Ir3Jqu+avEFp7FahjSoUHZbbicTFEUvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q13fHl35; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q13fHl35"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3697421c2a8so1442730a91.1
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779163146; x=1779767946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fW1AgmzhuxyMQmeqXtNPx4zy/ikoRVa6wowBqPei6s=;
        b=q13fHl35FFBkSRXo/TDgto+3q9v1uCQbyilL9xwYhOmmykTyEfoiLy+VszMlnv0I1d
         nQQ4ZGp2tUY9TgyltS465FwLpYIEHDuEXOrl2b6eBpeu0rdREbt/gbZhHa8m30k1TIdA
         oozHufJzvfZ67qUjcI1Hm+DMt84D8v1DKKHMDCutEbkO41S755at4cYDk/3/YrfhIglG
         lbgBdEeMgKEI/bY0Gl5guDiVjwep7OCsC5ktOJrv76FVoDoSkPwP3Q04sVvgKMUldSgO
         6mA/sxrkyT8pj7KxTtP/RBUaYTVU3mLylxQZeJh6rL1xPGVzcdFEZrM3/VER6TA9Jo/Z
         hTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779163146; x=1779767946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fW1AgmzhuxyMQmeqXtNPx4zy/ikoRVa6wowBqPei6s=;
        b=D0RSbUb1nyybLyksXqyRcDvCLoZTlVxFMxvkvJlIqPO09PuEvEJEYMbLWGfMCG6X3w
         hka0USXaMBkzGmeLLCMbUP84YYb+hhe3WsQOkDO3B3ts7Bqp4D3tfPL9pce1SsMSA0XJ
         swiqB44Jtau0dKRCgG96qCsU/ueUCoq3vIkQzIe06gIozAKAgDp9ZmmQ3yCTvJ7pqN4E
         J/sxvGMaVwnIUXywOQtJ4LlIPTgD+6idNlwpXqVZyqCPfeXFKoYI1ZVR6CN/R73ngoWD
         7sqaVr5oPT92/KKOT41X0ax2AzVgMtaPaEiDZgl0VeRgqt2Ewe4yV3MBdjBKpwrJY/yl
         uPgw==
X-Gm-Message-State: AOJu0Yyd2P2hy648ZkJLlJKPMSt07t79o+Xu3DprX7GqPGh3PQ7n5r3c
	/rKAcZRjVX1j2RrScJ6Iy4Rmzas2LbhZDdSKl4yuo0XcrEeyOCB/EXxjNBBi1mCL
X-Gm-Gg: Acq92OG8Iigm54Qb7QuhZ23h9MqST6wr775mLDLCJBoWUvQ209bX8iaXvT5z5ddzXTl
	/BVZlmUH3O3kcM17BxXO4gcmcZ47Li0dHioah/YR38xp6BvSiCWg9H+XmbakuX44vz7sq7iJXHZ
	zu8VPo4opbz7ASEMbct24ZXWUsCaNeNq67B5CLijqnz0ezWTaHfWeWcFzwU92OFkPV8tK8eNa7A
	44nGWN5v6UpDYyQCFshsnNl8SgUx9Ff7mwwkYo8nrlnyL8QILOFRPJ8HBR4Qk23zbHJaRagjJXv
	7UG20Cc+HZy6Lm9pN6pOBm3HgrPA3PDQoOntvx+60P1oCzEADBQ5CUipBrKAf7DBu4Vly8/oMsv
	kIG4NqszT7E3hlRuc72AobRjQoU1jT5sciGyqa651KM1KLTMUX1CuFmsu+m0j8Vu7DRkFNQQ68X
	c8uyJkL7GyS0e8pujYQK7RxvI8asOcfedipZRA2PFamFbvSyfXeEU/CDaOMXfy8H/eqnRO/DeFc
	bT1R8+BgUk82HaVc8IyGai65ATuGwGEeNzHCSaViOPh5w==
X-Received: by 2002:a17:90b:5904:b0:368:f179:ba07 with SMTP id 98e67ed59e1d1-36951a1cb7dmr17952173a91.9.1779163145792;
        Mon, 18 May 2026 20:59:05 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424a6sm16385679a91.1.2026.05.18.20.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 20:59:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: amlogic: Allow COMPILE_TEST
Date: Mon, 18 May 2026 20:58:47 -0700
Message-ID: <20260519035847.1461957-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate OF as a hard requirement and allow ARCH_MESON || COMPILE_TEST
so the driver can be built on non-Meson architectures for testing.

Assisted-by: Claude:Sonnet-4.6
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/thermal/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b10080d61860..8051d6510296 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -435,7 +435,8 @@ endmenu
 config AMLOGIC_THERMAL
 	tristate "Amlogic Thermal Support"
 	default ARCH_MESON
-	depends on OF && ARCH_MESON
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on OF
 	help
 	  If you say yes here you get support for Amlogic Thermal
 	  for G12 SoC Family.
-- 
2.54.0

