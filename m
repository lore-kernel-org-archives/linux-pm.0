Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAD47A894
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492401; cv=none; b=DaY7a/IbJNxR+a1Yx1i88fJxvdhc5+CsjrqDydFSbVf6WmExRvlIUEUrWaJtn3edaT9b4OxCF7lcxohoXNl9mhnOnQROQG3RJ4HCgd5iWjPgw5inl88jTB+h22S4pPc1Bk8F8xc/SL9/YNq8B3u2WFGcWuMyyvOgx/EQWzVA4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492401; c=relaxed/simple;
	bh=qwRW5YP/OsxI03pqmCcnKn2ESNhEIHF0NnfugvT2Rec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGZA3qLtZAm6zh6TES09EbV7b6FVJ89UjhQIi2egcwMkihCmQnwyeh9TZVlea284RKbG2pqQWMewm3clTviT8I+J47YgtvhOD2kVNPFPeXsyyRQTPd/+DeXTZVaOCNmfN2AfQRy6HiWqg+2Gr7jOMCLfU+gyYcCbL7qRw26AjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ7N3x24; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ7N3x24"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b5f21afe8cso1277812e87.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492397; x=1790097197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRE517es95kbkROai5n0sLeTok/JKNa+OL5tekr+lZM=;
        b=LZ7N3x24VKcV0Ep6KtvOpO7XcqBkoZUL7mgIyqmHjklZEud0H+kvh+7GjgMV0BjloA
         GdNS/49XZCqE+LXfF7GoP3umOsKOGxh9pSIWAItjzK0MtPoeAJ/lUF1aw3ohVbfIQK65
         oC/v0dfPARqSdbFaEAAX5dOK6gP2er5jqiP46389pHD6mcU4IDKxebda7sliIvbgjepn
         A2vdvziOd0Cj3k5Fj43P0fgUOjA5gJZL1hXNm7QfEXmGa7yaf8RKJ/pCJAs6QN9VTpAr
         LGrsgWSsQ0583W3oRu5rpVcSB2pvh5G4kIsw+kU5RJmZJlKFPfV+hzx9Ssq2zvroza/b
         kJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492397; x=1790097197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRE517es95kbkROai5n0sLeTok/JKNa+OL5tekr+lZM=;
        b=RHnrasfime3TDIpv2XxwqzEd+691KyGdvyhCT5g2nJGvzJweFUHkt90FT1RANJhlzx
         W1uKDgrwakgRGsSzhmmozVb0tZTSm6DbgY7xjXbTDrjt240XFFZRs0lmk9FldwyjWYni
         1UA/01PWz9sKBabebyexBpZvReEtRJ1sdczlugYfMchMNvahBs1ahVci6TGndgybBWaY
         /dQRxUjYfUc6wsuzhKLorWVI4pGr9YhHR8pvssxtnYHkh3HmV3OFCtDbhAmcT382/luK
         hUxSYCavqV+nxjRej71fwKWoLA89kISiI7/GqEx02cUduvFvjK5TT1YWs8dlKpOjVKIa
         Rg9w==
X-Forwarded-Encrypted: i=1; AKwUvBwbieHZBnvrafvv4gBCJZsoRAcyggz4zLDA4/vHOj/P9ZV+t4A15qzimD6soxWO2jbzogDy0xey1Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kKuxOyq6z44E1ezM+nWveSYy+Jcu61pItmePNwL02KJ6w8/xRz
	RBisoqjuRLCp5U74k4poKWzMkz+Ri12PNF4jBTB5sXc81rBwS6Iwu8w=
X-Gm-Gg: AYBFou1Ux2z1DxWuOuV+NHW4YSTDNzlbt4IohF59xWvMS4O0XO1W7y73rSgyJxYLFxY
	EPX/jTAW9uQBex/S+EZwRAbVlZEA8eGITSE1d9IsoqiUZ1JCeBE5he5L/JF3R5HtOLwB+LepdbR
	sNIavv8S16aocxl0BrJizdDueLgRv5+yXupX9lQOjJNmD1PHBYmnWC/B0SE1bazlFR8oj2uTE/i
	9iWbpQdtCHX5L8gROR0GRlvBSR9qYTgmtHxtR6Sv/9cz/kFavGnl/d50iDUVBsRg0Cb1tkHZFV6
	t0xxHe8/8XaTlHpg9ZYOSa9iIpEreLAuEzAbkZE2PImbpuoNVc1LJtvweW8mjj8hnfiVfif1mtL
	C0Rtkizrlew0aFgP/gw3JNXlgXKwpVnYZTu3o2c51VWBYN2hkTkYU4hmDAZTQnQKxivXeIa5vVF
	XR387qLOzRXf4pMo5tcfZ81YniZ8LKq6doEjmdcAWTp5olYnsZo6SFKrPF7LQbpQ==
X-Received: by 2002:a05:6512:10d1:b0:5b6:10bc:dc44 with SMTP id 2adb3069b0e04-5b8b2a86711mr1243660e87.27.1789492396486;
        Tue, 15 Sep 2026 10:13:16 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57eb908sm91791e87.79.2026.09.15.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:13:16 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH v2 1/4] thermal/drivers/airoha: Fix AN7583 ADC mux field mapping
Date: Tue, 15 Sep 2026 20:11:28 +0100
Message-ID: <20260915191131.25214-2-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915191131.25214-1-sochnev.v.74@gmail.com>
References: <20260915191131.25214-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On AN7583, bits 3:1 of 0x2e4 select the sensor (0 bandgap, 5 GbE, 6 CPU)
and bits 3:2 of 0x2a0 select the diode (0 D0, 1 ZERO, 2 D1). The driver
names them the other way round: MUX_TADC is 0x2e4, MUX_SENSOR is 0x2a0.

v5 of the AN7583 series swapped the airoha_set_thermal_mux() arguments
to match these names. The diode index now goes to the sensor selector,
so the zone reads mux positions 1, 0 and 2 (PAD_AVS, bandgap, core
voltage) instead of the bandgap diodes. On a Nokia XG-040G-MF the result
crosses the critical trip and the board powers off during boot.

Swap the field definitions. MUX_TADC then selects the diode, as on
EN7581, and the existing call order is correct.

Fixes: b20d9782756a ("thermal/drivers/airoha: Add support for AN7583 Thermal Sensor")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 77b3a1af271f..2934d6aba0ed 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -18,10 +18,10 @@
 #define EN7581_DOUT_TADC			0x2f8
 #define   EN7581_DOUT_TADC_MASK			GENMASK(15, 0)
 
-#define AN7583_MUX_SENSOR			0x2a0
+#define AN7583_MUX_TADC				0x2a0
 #define   AN7583_LOAD_ADJ			GENMASK(3, 2)
-#define AN7583_MUX_TADC				0x2e4
-#define   AN7583_MUX_TADC_MASK			GENMASK(3, 1)
+#define AN7583_MUX_SENSOR			0x2e4
+#define   AN7583_MUX_SENSOR_MASK		GENMASK(3, 1)
 #define AN7583_DOUT_TADC			0x2f0
 
 /* PTP_THERMAL regs */
@@ -634,8 +634,8 @@ static const struct thermal_zone_device_ops an7583_tz_ops = {
 
 static const struct reg_field an7583_chip_scu_fields[AIROHA_THERMAL_FIELD_MAX] = {
 	[AIROHA_THERMAL_DOUT_TADC] = REG_FIELD(AN7583_DOUT_TADC, 0, 31),
-	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(AN7583_MUX_TADC, 1, 3),
-	[AIROHA_THERMAL_MUX_SENSOR] = REG_FIELD(AN7583_MUX_SENSOR, 2, 3),
+	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(AN7583_MUX_TADC, 2, 3),
+	[AIROHA_THERMAL_MUX_SENSOR] = REG_FIELD(AN7583_MUX_SENSOR, 1, 3),
 };
 
 static int an7583_thermal_probe(struct platform_device *pdev,
-- 
2.55.0

