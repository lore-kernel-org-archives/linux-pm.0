Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B71EA7F4
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777870993; cv=none; b=C1NUG7IhT1Pb2jntC6MwrYZAl67OnbmwuvqTfiTKHnO/Af2Joq0NpGx1wWNIUOJdHwJJ7ts3IbaOhl9gEznRQq4qq3yw/HlRO/xgEbX13GxMoRCM8I11MUrF5g0o3zXL9qQTiaXl3r93K9xA+viAFDAQLYEJ86w8QPu5+ZQy34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777870993; c=relaxed/simple;
	bh=agt5GECVqOdh9CtCVZmq7or6bJXZGyJ3eUh17LzI/BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5Zex3DzVjCCChWpXP/jbsZS7eTEfAgLINMk08S6p0eWnbBVGRb12pGaBhQVUvGWK3i0auUR2SeD9M4Wd1L35s8U8ewN3ZzfGAIQMfZdsKCsEqiF9vgapKsSEKGECuFVpj5CWYo5y1YoTSBTX855JFkczgZ+8Ip9+zg7ydGK220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1Jli/iH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1Jli/iH"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-364d72f2986so2336681a91.3
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 22:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777870991; x=1778475791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8oi2Y54Hi+TOCHwR4zL5LgXe3sseiIfUSaKMjLYxQ0=;
        b=f1Jli/iHLPB34HHbJFxYK6lbbBX2HSNG3qMntDl0bG8aUmIKsLFxuAn2cJz15kvUIl
         Sq/2ZDUuIZVNzpxkGEdenxLbBhcTtD1MQFwJoJKECQzugfvSiGZhfpkU7OksnBNfVIOe
         T+UosgyV3rHDRrXi8Jh0QfQszi5sfXFtz1m3vfbIr3aVfk3UVVLstBWVidS0nmpwyrhz
         WwdKm4b0vmbzEr1CMW1b2htpjyl+rV/MF7U+a79H0Wa2OlBptXpu+dbaXMZ1n/3IJhnm
         elG1Q/swSj59dtCJekmB5tKFB38kLtCtwaiDGIKMI/KHwc9Rvtt8Fabo9bMPsE6VMo0m
         vT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777870991; x=1778475791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8oi2Y54Hi+TOCHwR4zL5LgXe3sseiIfUSaKMjLYxQ0=;
        b=fPACc/h3m02fFGx2M86LJ67YqC46FFxtVPI7mXFhW6J07wSTwHN5KhsVEl5QqPBxzG
         HdhtL2GuorPXlrb6WHRyRHgqRVFGerJzhUteKsL0FRr2CdR+yLqhx81vsJhnjpI73t6I
         jqvefAY1HqTO0q/IaavYe+d8SKQ45ZatZW7WQixTWN3DrUn12iTYrTCuxjLBK1nXn/tB
         7g+ZouwL+Np5AgAJSEaGVJiyiGKTeiJ5XxV6ByUt2XIWCq9QFeoWjglph94OudYs+2dp
         ADJ9yBpwzj5Chtk1GDzh38ghjStBHSx6re3brSuShxNz3+t8m1MTJ0XQyznk+JSGYVYe
         OGhQ==
X-Gm-Message-State: AOJu0YzPn/cQRmsdoYw/iI5dZU9w7OJTel1N60MZldg35FFcx+fbUlzD
	4is1mD8vthwpJ3P8Ov2MMP23yUjtHvUNNb1w0VJ/VAybNQ4BNEOg41+x
X-Gm-Gg: AeBDievNndWJXm1pU5AXbaazClbTsCD9EPnowuvMl9QKUCcC20UV8x9n8KT23FR8cOG
	98/e037K25DmtyCKYwg1xsidDuj/Gfua5WRRhhp0FJi6f8axpgM2SGNb2KLF77g5FEYY05pBEWV
	w6putFWSH39fsSDGFwxCc1moveqY9b+vLQzW/gIk7Zx20+iehxxoFyU83716cxxdP4WoyK8kLXf
	4g6fKuANlnWStv3EtFXWgJHwdzWKbEc5CE/1DWeqQjQ2GdhcIPfLPAEP3l8kJIi4ll9D8ewdmRu
	uL8CnuwzinlNfoArD344Kw4ULEkqkR1+sA2vq/Hr6A91ljvG2/IDtg5DHxOg554VqFH1lDLtDS2
	oyBOPVrGxpOCa2lgWkgXGMRqsQZDTvgprlA5vlJWedKOyP9rjM7IMYtrivBb8dTACN0gYsedhAZ
	W3ww==
X-Received: by 2002:a17:90b:35cf:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-3650cec0ce2mr8747896a91.20.1777870991576;
        Sun, 03 May 2026 22:03:11 -0700 (PDT)
Received: from archlinux ([2605:e440:15::152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365437b50b0sm2662908a91.0.2026.05.03.22.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 22:03:11 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Allwinner: A523: add support for A523 THS0/1 controllers
Date: Mon,  4 May 2026 13:02:40 +0800
Message-ID: <20260504050245.646078-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds temperature sensor support for the Allwinner A523
family of processors (same die with H728/A527/T527)

Based on 7.1-rc1.

Changes v4~v3:
1) dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
 - gpadc replaced to mod clock

x) thermal/drivers/sun8i: add gpadc clock
 - removed

2) thermal/drivers/sun8i: replace devm_reset_control_get to
 - no functional changes

3) thermal/drivers/sun8i: get calibration data from two nvmem cells
 - no functional changes

4) thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
 - gpadc replaced to mod clock

5) arm64: dts: allwinner: A523: Add thermal sensors and zones
 - gpadc replaced to mod clock

v3 https://lore.kernel.org/linux-sunxi/20251025043129.160454-1-iuncuim@gmail.com
Changes v3~v2:
x) dt-bindings: nvmem: SID: Add binding for A523 SID controller
 - previously accepted, therefore removed from this version

1) dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
 - added changes as requested by Rob

2) thermal/drivers/sun8i: add gpadc clock
 - removed undescribed changes spaces to tabs

3) thermal/drivers/sun8i: replace devm_reset_control_get to
 - changed the commit description to the version suggested by wens
 - added reviewed-by tag

4) thermal/drivers/sun8i: get calibration data from two nvmem cells
 - added spaces in the description block before "*"

5) thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
 - added alignment of functions in compliance with open parenthesis

x) arm64: dts: allwinner: A523: Add SID controller node
 - previously accepted, therefore removed from this version

6) arm64: dts: allwinner: A523: Add thermal sensors and zones
 - no functional changes

Changes v2~v1:
1) dt-bindings: nvmem: SID: Add binding for A523 SID controller
 - added new patch

2) dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
 - changed clock order
 - added additional nvmem cell with calibration data
 - added requirements for new controllers
 - added description

3) thermal/drivers/sun8i: add gpadc clock
 - removed unnecessary call to clk_prepare_enable() since
 devm_clk_get_enabled()includes this

4) thermal/drivers/sun8i: replace devm_reset_control_get to
 - original function replaced with devm_reset_control_get_shared_deasserted()
 - removed some of the repetitive code executed by 
 devm_reset_control_get_shared_deasserted()

5) thermal/drivers/sun8i: get calibration data from two nvmem cells
 - added possibility to get calibration data from two independent cells

6) thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
 - removed magic digits
 - changed description of calibration data procedure for A523
 - changed numbers of array elements with calibration data

7) arm64: dts: allwinner: A523: Add SID controller node
 - fix typo (sun50i->sun55i)

8) arm64: dts: allwinner: A523: Add thermal sensors and zones
 - cell with calibration data divided into two
 - added passive trips for gpu
 - added information that information obtained from BSP

v1: https://lore.kernel.org/linux-sunxi/20250411003827.782544-1-iuncuim@gmail.com

Mikhail Kalashnikov (5):
  dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
  thermal/drivers/sun8i: replace devm_reset_control_get  to
    devm_reset_control_get_shared_deasserted
  thermal/drivers/sun8i: get calibration data from two nvmem cells
  thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
  Allwinner: A523: add support for A523 THS0/1 controllers

 .../thermal/allwinner,sun8i-a83t-ths.yaml     |  54 ++++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 154 ++++++++++++
 drivers/thermal/sun8i_thermal.c               | 226 ++++++++++++++----
 3 files changed, 391 insertions(+), 43 deletions(-)

-- 
2.54.0

