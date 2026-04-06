Received: from outbound.mr.icloud.com (p-west2-cluster1-host6-snip4-6.eps.apple.com [57.103.68.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3E30FF1D
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509123; cv=none; b=Z+dGhtUzsq4auXzyDDAMCwnjamC6rFp3/4TIXoG/xS8IuP+TyEGS1hZLQTkVSI6a3ZRhfYO+VXaT4Sd+S12xobIvlb96k77UGistcJllDSHGoEiaKUgx6bzYYjGEnK4ahe3tLcIrmzjp8hFyIB/D3vTpAi2FoXjp2S26wIHP/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509123; c=relaxed/simple;
	bh=VGF9CdON+K8pKfnZszUFSZhF5E+/A8ZhNaLUjjqtSNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVN3Syq74+CNFRb4KiZodaJbPSFHjVu5uBk6c8Tez0Oqi5SlI19q5DP1pUXKn0Btak+1Z90rGWWtToFXJJ0HsjEA6IPV4CXu/GRgjKcH2EFvkax/13d+NOI9sjsOZJYTe6tT8EOvyIh6LXhyNN8QpZ3vstcey0yqsboda+0oAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tN3Di2ud; arc=none smtp.client-ip=57.103.68.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tN3Di2ud"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 4521F180024F;
	Mon, 06 Apr 2026 20:58:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509121; x=1778101121; bh=VgFfxoY/ooFYi0cIyI+4Ozs8g/oWwJGlqR9ylRYHt+A=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=tN3Di2ud9E16b/LBYUFXkUjyU7d0EztOubO77CRw7YAQrvXrtcokLP2Kb/C/eUBzY5i7fFulzrwYOU/ofYTCbS/3lhCv7q54SmCAhDPZ/+tipDHcQaqkfkUDPUXc8ULDfE9FI1T3+kFT3i55CWB8g/l3Q1HLzkMgDDRC2T1ZEUDNM8P9cXHgkUKO8NYXrVYQJzyp5wFe3kmwfDT8r72eXrVXT4ddOzQdATN92eebwRjnpZNdiUd31ifTeB4FFRyLBTwRRcjxuRCG7TFTBNRYSkNHnnkqp2gD8+5iE/otNPu93E1iAat+OTfnPFpgzbWUC9lyHFIDnvhOSjdD7UqE8g==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 0B595180026F;
	Mon, 06 Apr 2026 20:58:38 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v1 7/9] power: supply: max17042_battery: use ModelCfg refresh on max17055
Date: Mon,  6 Apr 2026 16:57:55 -0400
Message-ID: <20260406205759.493288-8-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406205759.493288-1-vincent.cloutier@icloud.com>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yPX3nI8D5QENh65DtjW4-UsiffUqYEAu
X-Proofpoint-ORIG-GUID: yPX3nI8D5QENh65DtjW4-UsiffUqYEAu
X-Authority-Info-Out: v=2.4 cv=dcKNHHXe c=1 sm=1 tr=0 ts=69d41e80
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=9q-Kekzt8HrGINVsJWkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfX5gXypzwAl7ir
 d7ynI/0LGQPdZzbMoQolwKCF6dLT5umJvMbf7QZjhIw1eZNNr2NRvFm7AlvNb5x1P35rwiru3wV
 Vng1Ky33GeVv36z1Fcgwbh4kzztpl5KFk0CEzpplOTfgC+sy0dybMYdsfuUDv8TZqesP+99VrBZ
 hNnXZdrwI5zN73wI1jAFv6S5SoMA/gO0m4pFU2z2EvedWfI5CnE/0ledr1Ef+F2jhakLVRKdFsU
 IABCdG0yOi6XQevEuWLnmNtfstwlJA0fHbikukeCyaBtfcvkeogxh495FS4gC7QQCzmjDnfEFGG
 EEkPUA5P0GgcR4cLXdvePgT9grEkN42h/K0KBE0HQLwTjp6PYN2Rkv8Wac2O5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060206

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Unlike other models, max17055 doesn't require cell characterization data
and operates on a smaller set of input variables (`DesignCap`, `VEmpty`,
`IChgTerm`, and `ModelCfg`). Those values can be filled in through
`max17042_override_por_values()`, but the refresh bit has to be set
afterward in order to make them apply.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 66 +++++++++++++++----------
 include/linux/power/max17042_battery.h  |  3 ++
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index a96427bf07d0..793164bd55d9 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -811,6 +811,9 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)) {
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
 	}
+
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
+		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
 }
 
 static int max17042_init_chip(struct max17042_chip *chip)
@@ -819,44 +822,53 @@ static int max17042_init_chip(struct max17042_chip *chip)
 	int ret;
 
 	max17042_override_por_values(chip);
+
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
+		regmap_write_bits(map, MAX17055_ModelCfg,
+				  MAX17055_MODELCFG_REFRESH_BIT,
+				  MAX17055_MODELCFG_REFRESH_BIT);
+	}
+
 	/* After Power up, the MAX17042 requires 500mS in order
 	 * to perform signal debouncing and initial SOC reporting
 	 */
 	msleep(500);
 
-	/* Initialize configuration */
-	max17042_write_config_regs(chip);
+	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055) {
+		/* Initialize configuration */
+		max17042_write_config_regs(chip);
 
-	/* write cell characterization data */
-	ret = max17042_init_model(chip);
-	if (ret) {
-		dev_err(chip->dev, "%s init failed\n",
-			__func__);
-		return -EIO;
-	}
+		/* write cell characterization data */
+		ret = max17042_init_model(chip);
+		if (ret) {
+			dev_err(chip->dev, "%s init failed\n",
+				__func__);
+			return -EIO;
+		}
 
-	ret = max17042_verify_model_lock(chip);
-	if (ret) {
-		dev_err(chip->dev, "%s lock verify failed\n",
-			__func__);
-		return -EIO;
-	}
-	/* write custom parameters */
-	max17042_write_custom_regs(chip);
+		ret = max17042_verify_model_lock(chip);
+		if (ret) {
+			dev_err(chip->dev, "%s lock verify failed\n",
+				__func__);
+			return -EIO;
+		}
+		/* write custom parameters */
+		max17042_write_custom_regs(chip);
 
-	/* update capacity params */
-	max17042_update_capacity_regs(chip);
+		/* update capacity params */
+		max17042_update_capacity_regs(chip);
 
-	/* delay must be atleast 350mS to allow VFSOC
-	 * to be calculated from the new configuration
-	 */
-	msleep(350);
+		/* delay must be atleast 350mS to allow VFSOC
+		 * to be calculated from the new configuration
+		 */
+		msleep(350);
 
-	/* reset vfsoc0 reg */
-	max17042_reset_vfsoc0_reg(chip);
+		/* reset vfsoc0 reg */
+		max17042_reset_vfsoc0_reg(chip);
 
-	/* load new capacity params */
-	max17042_load_new_capacity_params(chip);
+		/* load new capacity params */
+		max17042_load_new_capacity_params(chip);
+	}
 
 	/* Init complete, Clear the POR bit */
 	regmap_update_bits(map, MAX17042_STATUS, STATUS_POR_BIT, 0x0);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 36817da50548..6b6e01d3e499 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -23,6 +23,8 @@
 
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
+#define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
+
 enum max17042_register {
 	MAX17042_STATUS		= 0x00,
 	MAX17042_VALRT_Th	= 0x01,
@@ -198,6 +200,7 @@ struct max17042_config_data {
 	u16	full_soc_thresh;	/* 0x13 */
 	u16	design_cap;	/* 0x18 */
 	u16	ichgt_term;	/* 0x1E */
+	u16	model_cfg;	/* 0xDB */
 
 	/* MG3 config */
 	u16	at_rate;	/* 0x04 */
-- 
2.53.0
