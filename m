Received: from outbound.ms.icloud.com (ms-2002c-snip4-4.eps.apple.com [57.103.74.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE527E1A1
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114891; cv=none; b=mT0ZHGMxGQsO1rG2o4GyyXLxJKdlUQeGyYoBRtTjkMZz+7h0Qd3uRfQR+bXVyonflEQoOoa1Sp9/MASssRx3D0ZWxNF7BiUifPu9MUL65QHFVZNvWPuHZQKa34xEfXKpzXlmT+KhxcdvnppV9MViJybDRb8MwgNHk8KBiek0XeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114891; c=relaxed/simple;
	bh=eO+NtEhEjrPXe9aamB/hGe5OwgGqp4Yqp8aY6bhwvpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTx9a8M/PBRDH2WKiozAStmFOaGf7o6k73MaLL1EnlXrT1MJpp+6mZ9kYxTJnw8gCWD6RoTrs0mAvEqLipY5Cmd3cp1RXnXj8HfbLLCLXG0OVoHZlozIAi2k/eFubtNO6YawIfhvx+Zi/HUY9lsfcVkI+6ma/1DJIx0pT5ONu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hnWzOXq6; arc=none smtp.client-ip=57.103.74.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hnWzOXq6"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id E69D618000ED;
	Mon, 27 Jul 2026 01:14:46 +0000 (UTC)
X-ICL-RepId: 019fa123-82b8-7278-9f84-e4d1613e27d4
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgtdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114889; x=1787706889; bh=cLwRHuCPpcQTSnu/wvQsGQ2j+9/y48wZ6FfSqqNzPHo=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=hnWzOXq6h4R3sWxxxPMDqAwRxhHMOg5TSQ5BenwvEMjgjyES0LEu2dj+TRxVumUKJ3qXHo1Y23GxxpeWEDgBSI0um+dohsf85NgtxZkOspnPDEAas5i3lgvemsobogo3rpupVn2Onb/ILAzVaPASH4rygKC7Dz6weUYSzyttmObFFNGwJRXbzC/OymkGAjo9F5ugJp4Tb29kP3VI7TrHWmfDShTiYcByJg43W6M/HrgoKmF/X0nM3p1BjquM1fpQtVvc6SmZkyujvG5zvv+GT+5Uegn4+vEHwMYMZLGygA5WpQK9DDeBR2V71enoD/jOjL1NqpQ8LiVjnycvu4Vf3Q==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id DC41F180010D;
	Mon, 27 Jul 2026 01:14:44 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v4 08/11] power: supply: max17042_battery: Follow MAX17055 POR sequence
Date: Sun, 26 Jul 2026 21:13:06 -0400
Message-ID: <20260727011319.621794-9-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX3wnYMwzbA2dS
 V4cB8gbDQ1OaSJNwW/qoXHI/7elBLFEtf/CfrKtsV47wQyOTJv1l+OAcHvcIvJjYwlhLOuKDMf4
 ugAPOvxWzH44JmscdKQ7rSeDmvSyMvfjif7S3yVdxLLtDTd9XkRzr0O08mIf8v6wzveTDeanyiU
 4FeSm7qGnyv5MEOEzf2/PUd76/JJdYrsFG6G3bvsAcqXJYUFEw5+O4Dg1kbyzo1GFqVSO2Z4A8G
 iQBD4J3XMGQXarCDIV5kVm1PdPNZ+32ox7SAepKC2v6dIxxhQM+PBQR0MXfwMsP29dq2KDZFgMV
 jm90T582CAkUSeHTkHun6eUxa5kb1j4V8cJe1VkOxVBSdcTY2KIJTMSMs7O4ro=
X-Proofpoint-GUID: y8mhHBP-5CxYvQd7wb52cRURTjnZZ_-z
X-Proofpoint-ORIG-GUID: y8mhHBP-5CxYvQd7wb52cRURTjnZZ_-z
X-Authority-Info-Out: v=2.4 cv=LNFrgZW9 c=1 sm=1 tr=0 ts=6a66b108
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OMfKiUHk28nV30N0MGsA:9

From: Vincent Cloutier <vincent@cloutier.co>

Wait until the MAX17055 is ready, leave hibernate around EZ Config,
and wait for ModelCfg.Refresh to clear as required by the power-on reset
initialization flow.

Restore HibCfg on every exit path. Keep failed restoration state so a
retry restores hibernate before starting a new initialization transaction.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 91 ++++++++++++++++++++++---
 include/linux/power/max17042_battery.h  |  1 +
 2 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 600b2689f316..33a2cc378b46 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -64,7 +64,12 @@
 
 #define MAX17055_DPACC_FACTOR		44138
 #define MAX17055_DPACC_VCHG_FACTOR	51200
+#define MAX17055_FSTAT_DNR_BIT		BIT(0)
+#define MAX17055_DNR_POLL_US		10000
+#define MAX17055_DNR_TIMEOUT_US		2000000
 #define MAX17055_INIT_RETRY_DELAY_MS	10000
+#define MAX17055_REFRESH_POLL_US		10000
+#define MAX17055_REFRESH_TIMEOUT_US	1000000
 
 struct max17042_chip {
 	struct device *dev;
@@ -78,6 +83,8 @@ struct max17042_chip {
 	bool   enable_current_sense;
 	bool   enable_por_init;
 	bool   init_complete;
+	bool   hib_restore_pending;
+	u16    hib_cfg;
 	unsigned int r_sns;
 	int    vmin;	/* in millivolts */
 	int    vmax;	/* in millivolts */
@@ -934,19 +941,86 @@ static int max17055_override_battery_values(struct max17042_chip *chip)
 	return max17055_write_verify_reg(map, MAX17042_dPacc, (u16)dpacc);
 }
 
+static int max17055_restore_hibernate(struct max17042_chip *chip)
+{
+	int restore_hib_ret;
+	int soft_wakeup_ret;
+
+	soft_wakeup_ret = regmap_write(chip->regmap, MAX17055_SoftWakeup, 0);
+	restore_hib_ret = max17055_write_verify_reg(chip->regmap,
+						    MAX17055_HibCfg,
+						    chip->hib_cfg);
+	if (!soft_wakeup_ret && !restore_hib_ret)
+		chip->hib_restore_pending = false;
+
+	return soft_wakeup_ret ?: restore_hib_ret;
+}
+
 static int max17055_init_chip(struct max17042_chip *chip)
 {
+	struct regmap *map = chip->regmap;
+	unsigned int hib_cfg;
+	unsigned int model_cfg;
+	unsigned int fstat;
+	int restore_ret;
 	int ret;
 
+	if (chip->hib_restore_pending) {
+		ret = max17055_restore_hibernate(chip);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read_poll_timeout(map, MAX17042_FSTAT, fstat,
+				       !(fstat & MAX17055_FSTAT_DNR_BIT),
+				       MAX17055_DNR_POLL_US,
+				       MAX17055_DNR_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, MAX17055_HibCfg, &hib_cfg);
+	if (ret)
+		return ret;
+
+	chip->hib_cfg = hib_cfg;
+	chip->hib_restore_pending = true;
+
+	ret = regmap_write(map, MAX17055_SoftWakeup, 0x0090);
+	if (ret)
+		goto restore_hibernate;
+
+	ret = max17055_write_verify_reg(map, MAX17055_HibCfg, 0);
+	if (ret)
+		goto restore_hibernate;
+
+	ret = regmap_write(map, MAX17055_SoftWakeup, 0);
+	if (ret)
+		goto restore_hibernate;
+
 	max17042_override_por_values(chip);
 
 	ret = max17055_override_battery_values(chip);
 	if (ret)
-		return ret;
+		goto restore_hibernate;
 
-	return regmap_write_bits(chip->regmap, MAX17055_ModelCfg,
-				 MAX17055_MODELCFG_REFRESH_BIT,
-				 MAX17055_MODELCFG_REFRESH_BIT);
+	ret = regmap_write_bits(map, MAX17055_ModelCfg,
+				MAX17055_MODELCFG_REFRESH_BIT,
+				MAX17055_MODELCFG_REFRESH_BIT);
+	if (ret)
+		goto restore_hibernate;
+
+	ret = regmap_read_poll_timeout(map, MAX17055_ModelCfg, model_cfg,
+				       !(model_cfg &
+					 MAX17055_MODELCFG_REFRESH_BIT),
+				       MAX17055_REFRESH_POLL_US,
+				       MAX17055_REFRESH_TIMEOUT_US);
+
+restore_hibernate:
+	restore_ret = max17055_restore_hibernate(chip);
+	if (restore_ret)
+		return restore_ret;
+
+	return ret;
 }
 
 static int max17042_init_chip(struct max17042_chip *chip)
@@ -960,15 +1034,10 @@ static int max17042_init_chip(struct max17042_chip *chip)
 			return ret;
 	} else {
 		max17042_override_por_values(chip);
-	}
 
-	/* After Power up, the MAX17042 requires 500mS in order
-	 * to perform signal debouncing and initial SOC reporting
-	 */
-	msleep(500);
+		/* Allow signal debouncing and initial SOC reporting. */
+		msleep(500);
 
-	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055) {
-		/* Initialize configuration */
 		max17042_write_config_regs(chip);
 
 		/* write cell characterization data */
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 61af6fe2f4fe..810e068eafd2 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -125,6 +125,7 @@ enum max17055_register {
 
 	MAX17055_ConvgCfg	= 0x49,
 	MAX17055_VFRemCap	= 0x4A,
+	MAX17055_SoftWakeup	= 0x60,
 
 	MAX17055_STATUS2	= 0xB0,
 	MAX17055_POWER		= 0xB1,
-- 
2.55.0

