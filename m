Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FE239085
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2026 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782868662; cv=none; b=NW1L4aHE+PI+U/wlaUv+oM3zJfSOAFCfX/P4yOT30rMZM7nDr95m8S0Gbv1+CRePaNuZ/NDhuEzMOK5GG7srdH0cgzM38rMlegMWx7E+f+YtVY+omGPD0s99pPH7MtES/R8UpKUJ2FOW6WSnoRrzgRIgIQFUa/SFlSPLgkQ1Krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782868662; c=relaxed/simple;
	bh=MYF09Vdc6oklqHC6Wr4T2ymTHa4EE6saYjamUYP1eyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goAftsms0e6b7zB3srMYdsHun5yz5/+PnRJOn9TvgXrtPmvHDngsQ1YpFwr/tG5tapdlncNr/1unYiPTkNs9YtW0CTi5sXlEEkX0dpY68jlwcLrUoZeraCOWEL7VN/0A8urUQ4B63dMtRRrkp27MZsBCFHryMen0oAd6MrpdSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=A3E2ZQem; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="A3E2ZQem"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c965eab27so201163eec.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782868657; x=1783473457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyy8MBwXxNEEgpglO6QxnqIdKjc9GvseuoouQERX99A=;
        b=A3E2ZQemUqcrzGB2EGr7avrL5P7mdQoWmmGeLxwFdVmWorGrfW2jO4b81cB0cXTOEX
         z9cyUZsdqyztmu6CcoTJoVebNofFSv81Q7DgpV7E8Zx7rV8N0bW5+t92Yc5ntnAL6xVD
         Er1wE9JRr8imSfKvXvRofwWl+kvK+dsx5M6xNwgOG7mJDKjyz49r9jlCAB98Ulu7NhdV
         1WFA99m7GHgwM9GYdD7lJNFi88f/QWHKZ1GT5wviTS0dakyOoBOZAGDfCgiTMXwxYTn9
         QsWoMbfuyPJgJrJf/0rGCxB4VSMUVwyB14EprqC6Lt+6jJYI+NA4M5dcQQdy6YVKyWMh
         FndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782868657; x=1783473457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lyy8MBwXxNEEgpglO6QxnqIdKjc9GvseuoouQERX99A=;
        b=fdsGGOvdBz9XKmjuLD0KO3rNy19pgcuAc+72w3QQHcI48+nXHraei+F1nUIvOiI0tB
         ZyF/n05qyxTQYN791/XgOq60Lg1jnuIZwExoHyxaPySCxYbashKDqKew8l/Hlt2YzA5h
         CDGEM21AiLFCCwSOQdSWZysjyZT1mfqo1c9c8jl5EY57gfQKjFAgImUYA1K+SNg8z+x4
         83Cf+Fnw6XDpLekdNWfa/vMgLLmxbH0EA+Xj3al9xeAc4kKsLPrIpfkI7EO7hC1uQEKb
         bwaT/QmiczpMSMLVB5Wgu2y2xl1l/QvzQZc0ieGFbwG97r9cMQ4NzY5ZdqqXqf1Q8kzO
         Ur0w==
X-Forwarded-Encrypted: i=1; AHgh+RrW3SRBdcL404/2BVZ8GFJ3CvIgMGMqieXyPgeCvAKqY5qEJtAkJmGb9hPLl94mm11/BTR+/51ccw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy264Oa5TVFpRA9p+FN+CVDI6Ribu1bz7Tz3h+mMZlDJj0ywFox
	Q5El9LjbdPA8Ckhfg89h3CTuMCiiSsv+726Rm7ox4iSFWmmbgqNVHHISm/NPSejxPCE=
X-Gm-Gg: AfdE7cnl+wN32/uMCcZHwTv/BcwYUJkRqkDA7dcrMnw8UUS9d4h1DICCTbU5vowL+rm
	hZYIZLI79UzYqAdQgaXWgMz/vFulHy918k+TcV7qmp/p0rGYOVCrFTjXU341Onu7LwA7gyqmhnH
	WMyqScWCOA/2s2YlURXdLxyg7d1RDqQccZLuU4i+cviAECEf3WAk4DqNHIzI4tgu3aMooou+nIg
	2iHk2JBGwLTDBPEiJOWNaiNdA9/HFN8Rz5H273YkO+f4Ses4pJxk8bWozRMKmjbo7/9iDVznc49
	il1ack4aWC+mhes0ehbCSEWAZ+2AHUXCltlwv8AWYOOUd6FWcl6CfpwyCYWKE0xRinYmBjHTlVA
	QeZycuTTnJKNMIO5szo4y8478zom25nvSTrMAjnZYjM2z9DEZbfoSLodkqi0nyUGuq2+7Fm2mdW
	Xv90vw2qFkUaQ6jgPj2OU15ZKnu1CPlmNT+tc0azYWJ+dcDpNoLXAQid2XzCCL5n04pbRtrOO3H
	w5EISgnq1uzi0yOMVzAAvChlyFm+i6nxBJK6E0DI3h1XjtJfHJ2
X-Received: by 2002:a05:7300:3214:b0:2f1:6252:f8fe with SMTP id 5a478bee46e88-30ef07fec74mr2369207eec.3.1782868656805;
        Tue, 30 Jun 2026 18:17:36 -0700 (PDT)
Received: from wolf-skin.semfio.usp.br ([2001:12d0:800:a:9ec7:d3ff:fef2:7ce6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3205993sm13517061eec.24.2026.06.30.18.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 18:17:36 -0700 (PDT)
From: "Bryan B. Lima" <bblima@usp.br>
To: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: gustavoscorrea@usp.br,
	bblima@usp.br,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: armada: Use bitfield and bitmask macros
Date: Tue, 30 Jun 2026 22:07:18 -0300
Message-ID: <20260701010802.99029-1-bblima@usp.br>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual bitfield manipulations with FIELD_MODIFY() and define
constants with BIT() and GENMASK() to make code more readable.

Also, remove offset and shift constants for clarity in use of bitfield
macros.

Signed-off-by: Bryan B. Lima <bblima@usp.br>
Co-developed-by: Gustavo S. Correa <gustavoscorrea@usp.br>
Signed-off-by: Gustavo S. Correa <gustavoscorrea@usp.br>
---
 drivers/thermal/armada_thermal.c | 100 ++++++++++++++-----------------
 1 file changed, 44 insertions(+), 56 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2fbdb534f61..be6240984002 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -20,41 +20,35 @@
 #include <linux/interrupt.h>
 
 /* Thermal Manager Control and Status Register */
-#define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
-#define PMU_TM_DISABLE_OFFS		0
-#define PMU_TM_DISABLE_MASK		(0x1 << PMU_TM_DISABLE_OFFS)
-#define PMU_TDC0_REF_CAL_CNT_OFFS	11
-#define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff << PMU_TDC0_REF_CAL_CNT_OFFS)
-#define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
-#define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
-
-#define A375_UNIT_CONTROL_SHIFT		27
-#define A375_UNIT_CONTROL_MASK		0x7
+#define PMU_TDC0_SW_RST_MASK		BIT(1)
+#define PMU_TM_DISABLE_MASK		BIT(0)
+#define PMU_TDC0_REF_CAL_CNT_MASK	GENMASK(19, 11)
+#define PMU_TDC0_OTF_CAL_MASK		BIT(30)
+#define PMU_TDC0_START_CAL_MASK		BIT(25)
+
+#define A375_UNIT_CONTROL_MASK		GENMASK(29, 27)
 #define A375_READOUT_INVERT		BIT(15)
 #define A375_HW_RESETn			BIT(8)
 
 /* Errata fields */
-#define CONTROL0_TSEN_TC_TRIM_MASK	0x7
+#define CONTROL0_TSEN_TC_TRIM_MASK	GENMASK(2, 0)
 #define CONTROL0_TSEN_TC_TRIM_VAL	0x3
 
 #define CONTROL0_TSEN_START		BIT(0)
 #define CONTROL0_TSEN_RESET		BIT(1)
 #define CONTROL0_TSEN_ENABLE		BIT(2)
 #define CONTROL0_TSEN_AVG_BYPASS	BIT(6)
-#define CONTROL0_TSEN_CHAN_SHIFT	13
-#define CONTROL0_TSEN_CHAN_MASK		0xF
-#define CONTROL0_TSEN_OSR_SHIFT		24
-#define CONTROL0_TSEN_OSR_MAX		0x3
-#define CONTROL0_TSEN_MODE_SHIFT	30
+#define CONTROL0_TSEN_CHAN_MASK		GENMASK(16, 13)
+#define CONTROL0_TSEN_OSR_MASK		GENMASK(25, 24)
+#define CONTROL0_TSEN_OSR_MAX		FIELD_MAX(CONTROL0_TSEN_OSR_MASK)
+#define CONTROL0_TSEN_MODE_MASK		GENMASK(31, 30)
 #define CONTROL0_TSEN_MODE_EXTERNAL	0x2
-#define CONTROL0_TSEN_MODE_MASK		0x3
 
-#define CONTROL1_TSEN_AVG_MASK		0x7
+#define CONTROL1_TSEN_AVG_MASK		GENMASK(2, 0)
 #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
 #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
 #define CONTROL1_TSEN_INT_EN		BIT(25)
-#define CONTROL1_TSEN_SELECT_OFF	21
-#define CONTROL1_TSEN_SELECT_MASK	0x3
+#define CONTROL1_TSEN_SELECT_MASK	GENMASK(22, 21)
 
 #define STATUS_POLL_PERIOD_US		1000
 #define STATUS_POLL_TIMEOUT_US		100000
@@ -140,23 +134,21 @@ static void armadaxp_init(struct platform_device *pdev,
 	u32 reg;
 
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
-	reg |= PMU_TDC0_OTF_CAL_MASK;
+	FIELD_MODIFY(PMU_TDC0_OTF_CAL_MASK, &reg, 1);
 
 	/* Reference calibration value */
-	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
-	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
+	FIELD_MODIFY(PMU_TDC0_REF_CAL_CNT_MASK, &reg, 0xf1);
 
 	/* Reset the sensor */
-	reg |= PMU_TDC0_SW_RST_MASK;
-
+	FIELD_MODIFY(PMU_TDC0_SW_RST_MASK, &reg, 1);
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 
-	reg &= ~PMU_TDC0_SW_RST_MASK;
+	FIELD_MODIFY(PMU_TDC0_SW_RST_MASK, &reg, 0);
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 
 	/* Enable the sensor */
 	regmap_read(priv->syscon, data->syscon_status_off, &reg);
-	reg &= ~PMU_TM_DISABLE_MASK;
+	FIELD_MODIFY(PMU_TM_DISABLE_MASK, &reg, 0);
 	regmap_write(priv->syscon, data->syscon_status_off, reg);
 }
 
@@ -167,14 +159,13 @@ static void armada370_init(struct platform_device *pdev,
 	u32 reg;
 
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
-	reg |= PMU_TDC0_OTF_CAL_MASK;
+	FIELD_MODIFY(PMU_TDC0_OTF_CAL_MASK, &reg, 1);
 
 	/* Reference calibration value */
-	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
-	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
+	FIELD_MODIFY(PMU_TDC0_REF_CAL_CNT_MASK, &reg, 0xf1);
 
 	/* Reset the sensor */
-	reg &= ~PMU_TDC0_START_CAL_MASK;
+	FIELD_MODIFY(PMU_TDC0_START_CAL_MASK, &reg, 0);
 
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 
@@ -188,14 +179,14 @@ static void armada375_init(struct platform_device *pdev,
 	u32 reg;
 
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
-	reg &= ~(A375_UNIT_CONTROL_MASK << A375_UNIT_CONTROL_SHIFT);
-	reg &= ~A375_READOUT_INVERT;
-	reg &= ~A375_HW_RESETn;
+	FIELD_MODIFY(A375_UNIT_CONTROL_MASK, &reg, 0);
+	FIELD_MODIFY(A375_READOUT_INVERT, &reg, 0);
+	FIELD_MODIFY(A375_HW_RESETn, &reg, 0);
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 
 	msleep(20);
 
-	reg |= A375_HW_RESETn;
+	FIELD_MODIFY(A375_HW_RESETn, &reg, 1);
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 
 	msleep(50);
@@ -220,14 +211,13 @@ static void armada380_init(struct platform_device *pdev,
 
 	/* Disable the HW/SW reset */
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
-	reg |= CONTROL1_EXT_TSEN_HW_RESETn;
-	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
+	FIELD_MODIFY(CONTROL1_EXT_TSEN_HW_RESETn, &reg, 1);
+	FIELD_MODIFY(CONTROL1_EXT_TSEN_SW_RESET, &reg, 0);
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 
 	/* Set Tsen Tc Trim to correct default value (errata #132698) */
 	regmap_read(priv->syscon, data->syscon_control0_off, &reg);
-	reg &= ~CONTROL0_TSEN_TC_TRIM_MASK;
-	reg |= CONTROL0_TSEN_TC_TRIM_VAL;
+	FIELD_MODIFY(CONTROL0_TSEN_TC_TRIM_MASK, &reg, CONTROL0_TSEN_TC_TRIM_VAL);
 	regmap_write(priv->syscon, data->syscon_control0_off, reg);
 }
 
@@ -238,14 +228,15 @@ static void armada_ap80x_init(struct platform_device *pdev,
 	u32 reg;
 
 	regmap_read(priv->syscon, data->syscon_control0_off, &reg);
-	reg &= ~CONTROL0_TSEN_RESET;
-	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
+	FIELD_MODIFY(CONTROL0_TSEN_RESET, &reg, 0);
+	FIELD_MODIFY(CONTROL0_TSEN_START, &reg, 1);
+	FIELD_MODIFY(CONTROL0_TSEN_ENABLE, &reg, 1);
 
 	/* Sample every ~2ms */
-	reg |= CONTROL0_TSEN_OSR_MAX << CONTROL0_TSEN_OSR_SHIFT;
+	FIELD_MODIFY(CONTROL0_TSEN_OSR_MASK, &reg, CONTROL0_TSEN_OSR_MAX);
 
 	/* Enable average (2 samples by default) */
-	reg &= ~CONTROL0_TSEN_AVG_BYPASS;
+	FIELD_MODIFY(CONTROL0_TSEN_AVG_BYPASS, &reg, 0);
 
 	regmap_write(priv->syscon, data->syscon_control0_off, reg);
 }
@@ -260,13 +251,12 @@ static void armada_cp110_init(struct platform_device *pdev,
 
 	/* Sample every ~2ms */
 	regmap_read(priv->syscon, data->syscon_control0_off, &reg);
-	reg |= CONTROL0_TSEN_OSR_MAX << CONTROL0_TSEN_OSR_SHIFT;
+	FIELD_MODIFY(CONTROL0_TSEN_OSR_MASK, &reg, CONTROL0_TSEN_OSR_MAX);
 	regmap_write(priv->syscon, data->syscon_control0_off, reg);
 
 	/* Average the output value over 2^1 = 2 samples */
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
-	reg &= ~CONTROL1_TSEN_AVG_MASK;
-	reg |= 1;
+	FIELD_MODIFY(CONTROL1_TSEN_AVG_MASK, &reg, 1);
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 }
 
@@ -313,7 +303,7 @@ armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
 	u32 reg;
 
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
-	reg &= ~CONTROL1_TSEN_INT_EN;
+	FIELD_MODIFY(CONTROL1_TSEN_INT_EN, &reg, 0);
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 }
 
@@ -331,20 +321,18 @@ static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
 
 	/* Stop the measurements */
 	regmap_read(priv->syscon, data->syscon_control0_off, &ctrl0);
-	ctrl0 &= ~CONTROL0_TSEN_START;
+	FIELD_MODIFY(CONTROL0_TSEN_START, &ctrl0, 0);
 	regmap_write(priv->syscon, data->syscon_control0_off, ctrl0);
 
-	/* Reset the mode, internal sensor will be automatically selected */
-	ctrl0 &= ~(CONTROL0_TSEN_MODE_MASK << CONTROL0_TSEN_MODE_SHIFT);
-
 	/* Other channels are external and should be selected accordingly */
 	if (channel) {
 		/* Change the mode to external */
-		ctrl0 |= CONTROL0_TSEN_MODE_EXTERNAL <<
-			 CONTROL0_TSEN_MODE_SHIFT;
+		FIELD_MODIFY(CONTROL0_TSEN_MODE_MASK, &ctrl0, CONTROL0_TSEN_MODE_EXTERNAL);
 		/* Select the sensor */
-		ctrl0 &= ~(CONTROL0_TSEN_CHAN_MASK << CONTROL0_TSEN_CHAN_SHIFT);
-		ctrl0 |= (channel - 1) << CONTROL0_TSEN_CHAN_SHIFT;
+		FIELD_MODIFY(CONTROL0_TSEN_CHAN_MASK, &ctrl0, channel - 1);
+	} else {
+		/* Reset the mode, internal sensor will be automatically selected */
+		FIELD_MODIFY(CONTROL0_TSEN_MODE_MASK, &ctrl0, 0);
 	}
 
 	/* Actually set the mode/channel */
@@ -352,7 +340,7 @@ static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
 	priv->current_channel = channel;
 
 	/* Re-start the measurements */
-	ctrl0 |= CONTROL0_TSEN_START;
+	FIELD_MODIFY(CONTROL0_TSEN_START, &ctrl0, 1);
 	regmap_write(priv->syscon, data->syscon_control0_off, ctrl0);
 
 	/*
-- 
2.55.0

