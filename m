Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CE3EA96A
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303981; cv=none; b=nP8fA8FJrMS5YWx+HHJDlIeYKSw6bT3NHOPszCB8AEyEkyra6r5yl5ESbCGbyqgyACB69F2uacJwI/g30s6hjxLmhUqGGRq8+xDQTLZKnv4KSVAx+aWhIX/cXcPpeMcDmrjALGzNce2hZk2alSZCHLvz3/gzTAM1z8Ir9OtsCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303981; c=relaxed/simple;
	bh=qwRW5YP/OsxI03pqmCcnKn2ESNhEIHF0NnfugvT2Rec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPKnullwO1+bXt8ZXdb3eUhZn3+lZO+qEd6ynDong6M05Np97l2GWbtb4cx4Cs/jddosTMyZHmlZlurTBZRamLnJibZ3aJS20t4op7KPikVwqv4O2V3ploQn4N890fxHi1uGA7r7dxwCBEvlHC5mZIZ0U3ryBlj90/qQoo8MsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUDsGS5N; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUDsGS5N"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so1444765e87.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789303977; x=1789908777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRE517es95kbkROai5n0sLeTok/JKNa+OL5tekr+lZM=;
        b=LUDsGS5N3P5+jgUabSqC4MAmSG4JN9jMk2LeMPwAYvkDOUrPFNsgtRFwKOUTswHTTv
         QU18CJ8xfEs4GoaihrflAWKUh2xwbxk+wJlxrdLBpbSdIO1lqVnIFGttvHZbSXWD6nKG
         WOh42QWCIgUikzXX+Erm385/7m2AUNx3ED4j+vdMBO/T8KxevlB7AZQqIq6TQvx1zNXs
         ettfrt0RzxHJKxdS910GrE2HNSjQ2jBiN6ajLs99gclNjAz9qwSxjiQ9ZDapBIdMX7ww
         JuzLB6+S/5Xdrbw5NPo1ZwlRon2cDzJsd/dCwtHT/d1wEGXEJNauK7VnmUV6q9dWZzKm
         X9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789303977; x=1789908777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRE517es95kbkROai5n0sLeTok/JKNa+OL5tekr+lZM=;
        b=sSdrJv0z5u4PO54BB3HB4HnXAGXTLR/ZuFmBmzc90p9h5tXvpB9oi1dTVN3vV3zRcI
         i75zIy5SZXeL09z67NjTAA3DMcYCRGHUdM7NE63gOG/QLC37dXRSy2uSNndJTYNwavp4
         IZoEWvgTWWrXPbvJCxNZhQ3QW7o3KQ6rwoQ5CZkfhmcpRdDPAAr0splKuC5Jq/pwYNsk
         t0WxBCj0UetGF9R8SvTYgNR0LjVIjw0QJPNg0tlrNN5/ykuBB9zoKNNpaDtriqpqas+V
         xp4gNrrkJt+A+guAwNG4Qg1yy7UFDzxCXIhZnVFfT3MjW5NJ/xwLrU/V2SlFfY9v33kR
         dcEQ==
X-Forwarded-Encrypted: i=1; AKwUvByQsiwJa2oygro8N2rL6zUJxzeIG7eEcs64+3+HkZ+8XnTqwhWoLTPm5ku3hHyvltehLEGZSHfknw==@vger.kernel.org
X-Gm-Message-State: AFuF++mvFCLtR+LNAwvO/3QACrLsC5T37gPIzAmwBMW1wR4k+bFzge37
	tKsfIFETzPBSuwXoplkyg2fRcZF330PjORaeEFJloWUCi8PcJvMsukE=
X-Gm-Gg: AYBFou1NKMrVd/nosh0X2C009EE6ZBuwBMa/kSoovaKLHIf9bdV7nYo2F4d4TB7iKhf
	ccm8tAjvTyDbauqyL80XGkX3dPVKTyHeFaicDbqS4fbiA6Qtho/+FI6+F/CG4lidq1BJMz1FnrT
	nblWf0S3h5u6jEwiHD1+PzaoLJbLLSSxcw+aRdXWqSwHdGWxoe/qjSjoUCgrqzTi/bZRUaEvrBB
	zntTUJHKVI8DO7X/wTSuQUhH3gkHssoj6v9VVCFkKNtXlINMi1cbjR0QFvnN+8x+YzUOzIR28Pd
	XWJR6h4BVfZp04TeWQo0q7gykLCGdpQligWW+PT1PHoIuuYAkMStTEraPqrvNmQVZY7mJOdrS4k
	wgAUmcMW3DwX2njwtvvFDFjUNCeeazuqkqKfFwMAx7xiWD6EWiIAsWUuBRE+U25N5H15QDzPK4N
	PN3LXxwfNAMqwOQ/xzfmi8PJEaoCIOZNcT747nYqIIoz842ePf2bTRlWKXT5ClfA7b25ppJwzc
X-Received: by 2002:a05:6512:39c5:b0:5b8:99a2:9f2d with SMTP id 2adb3069b0e04-5b8a0325821mr4604271e87.17.1789303977336;
        Sun, 13 Sep 2026 05:52:57 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0469a8esm1762844e87.50.2026.09.13.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:52:57 -0700 (PDT)
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
Subject: [PATCH 1/4] thermal/drivers/airoha: Fix AN7583 ADC mux field mapping
Date: Sun, 13 Sep 2026 15:52:23 +0100
Message-ID: <20260913145226.34643-2-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145226.34643-1-sochnev.v.74@gmail.com>
References: <20260913145226.34643-1-sochnev.v.74@gmail.com>
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

