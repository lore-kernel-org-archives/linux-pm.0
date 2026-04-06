Received: from outbound.mr.icloud.com (p-west2-cluster1-host1-snip4-10.eps.apple.com [57.103.68.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D9C331211
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509116; cv=none; b=JXviPo3uInWYA/3kmHe4PiO83vuA2CGPzUZp+dX7m3beXpV0RjtEh0cn/xk39frx+U1PLoNsZD9lhxuOX/42oIV1hM+y1wPxJDFROKCXqKXJB0wiAHxtaozcKYR2FVGb3YQFmamT+0k1fs04M1ciftPqX4JpddByO6y7Mxkg3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509116; c=relaxed/simple;
	bh=/tUqSsPKZYI38NvYBzErNoEFI2yH5ZSUmcQTH3Qwi9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImVedsCJnRcJuaRwfc6/cJCmGjVojxRXitwc/7tObOLWY2UGBbXrG/HIv21ruHjf8JxmnCivLNPVZFGdUJlzK0yrmlaJJVeJfTBoAwrOTwMvh0Z45DaSlf0v9GlBjmF+jJPnQa0RYO1x2C76giNIVvx2Gcu7XcbLZNpilADXMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xobzwW0M; arc=none smtp.client-ip=57.103.68.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xobzwW0M"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 84A881800136;
	Mon, 06 Apr 2026 20:58:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509114; x=1778101114; bh=XsNV3TeKt94qcgOcH6jwCfpUMGvag3PrVJzWeNIntVI=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=xobzwW0M45IeuldRnbFLXStVmFhQYaXKxsCIB/VRTQOXIRxSn8GO3jkmp6bjaKHacp8Lvy6f4WYjyjuxIeXdXZBOWeP6cWse8rQdEhoU7igKDtXs0MwuqgAEV9eJ8gs9PAMHBVbR95EzCyntDX9fTqV7d6ShME4UeITtdVJVjG7x9TKpWEce6pkpqb55k9dabSN3vedIqxGNhtsHuZYBveQu2ylnOWbvGISHnzDSDTLjNPk6FRx0pFSuUyVXD2Axkq3majJvDXmz1zxaUEtfSUkEl73kAW8N8p9MmcgyUEYkhzamvhMfmXXOvvQ4G1GN11unhnu9ww89q7/WrdiSMA==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id DFA081800276;
	Mon, 06 Apr 2026 20:58:29 +0000 (UTC)
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
Subject: [PATCH v1 4/9] power: supply: max17042_battery: Route MAX17055 SOC alerts through dSOCi
Date: Mon,  6 Apr 2026 16:57:52 -0400
Message-ID: <20260406205759.493288-5-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406205759.493288-1-vincent.cloutier@icloud.com>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5vwB6PRpmNOSe-fltnZDeZbQa4voeYgk
X-Proofpoint-ORIG-GUID: 5vwB6PRpmNOSe-fltnZDeZbQa4voeYgk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfX+N+/519gCEeo
 IDddyQjinOWk2XX+398mG/GJt9/NzApESSNQBzmEWZWculmXjmVIvettDqMT/5xYVTjXL6zhmvm
 3B1vGirCyunHCEnYImN7gENy9sH+SsZFTYIxPaOW/xT94dXYJznolWlccGki50VwQ72orMZdXuL
 NH7DqzZlZYnGvxDrpnc0BmH0AmXIOMDqH6VsMfyAGs4D5dVjx9PDszZ1u24VYqt5k5TWIcGedMk
 UtYeDvLzDADv22FEBgImViMbDh8ppijYU+UmTTeDzO4VNMRDkWYQLyFXEuTTortoUQi7Ji+xPR8
 951WYU6WX84KnIYIozCdr2romITn5cliP6855T0OeyoCN+iOZGALlpkWJd8ojA=
X-Authority-Info-Out: v=2.4 cv=W9w1lBWk c=1 sm=1 tr=0 ts=69d41e78
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JV5nDvsLFxwd1KHQqJAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060206

From: Vincent Cloutier <vincent@cloutier.co>

Use MAX17055 dSOCi for ordinary 1% state-of-charge notifications and leave SALRT configured for the critical low-battery threshold instead of reprogramming the SALRT window on every alert.

Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 39 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 31007ba122e5..09bb1babb0d6 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -27,6 +27,7 @@
 /* Status register bits */
 #define STATUS_POR_BIT         (1 << 1)
 #define STATUS_BST_BIT         (1 << 3)
+#define STATUS_DSOCI_BIT       (1 << 7)
 #define STATUS_VMN_BIT         (1 << 8)
 #define STATUS_TMN_BIT         (1 << 9)
 #define STATUS_SMN_BIT         (1 << 10)
@@ -38,6 +39,7 @@
 
 /* Interrupt mask bits */
 #define CFG_ALRT_BIT_ENBL	(1 << 2)
+#define CFG2_DSOCI_BIT_ENBL	(1 << 7)
 
 #define VFSOC0_LOCK		0x0000
 #define VFSOC0_UNLOCK		0x0080
@@ -52,6 +54,8 @@
 
 #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
 
+#define MAX17042_CRITICAL_SOC		0x03
+
 #define MAX17042_CURRENT_LSB		1562500ll /* 1.5625µV/Rsense */
 #define MAX17042_CAPACITY_LSB		5000000ll /* 5.0µVH/Rsense */
 #define MAX17042_TIME_LSB		5625 / 1000 /* s */
@@ -871,6 +875,34 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	regmap_write(map, MAX17042_SALRT_Th, soc_tr);
 }
 
+static void max17042_set_critical_soc_threshold(struct max17042_chip *chip)
+{
+	struct regmap *map = chip->regmap;
+	u32 soc;
+
+	if (chip->pdata->enable_current_sense)
+		regmap_read(map, MAX17042_RepSOC, &soc);
+	else
+		regmap_read(map, MAX17042_VFSOC, &soc);
+
+	regmap_write(map, MAX17042_SALRT_Th,
+		     ((soc >> 8) >= MAX17042_CRITICAL_SOC) ?
+		     0xff00 + MAX17042_CRITICAL_SOC : 0xff00);
+}
+
+static void max17042_enable_soc_alerts(struct max17042_chip *chip)
+{
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
+		regmap_update_bits(chip->regmap, MAX17055_Config2,
+				   CFG2_DSOCI_BIT_ENBL,
+				   CFG2_DSOCI_BIT_ENBL);
+		max17042_set_critical_soc_threshold(chip);
+		return;
+	}
+
+	max17042_set_soc_threshold(chip, 1);
+}
+
 static irqreturn_t max17042_thread_handler(int id, void *dev)
 {
 	struct max17042_chip *chip = dev;
@@ -881,9 +913,10 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 	if (ret)
 		return IRQ_HANDLED;
 
-	if ((val & STATUS_SMN_BIT) || (val & STATUS_SMX_BIT)) {
+	if ((val & STATUS_SMN_BIT) || (val & STATUS_SMX_BIT) ||
+	    (val & STATUS_DSOCI_BIT)) {
 		dev_dbg(chip->dev, "SOC threshold INTR\n");
-		max17042_set_soc_threshold(chip, 1);
+		max17042_enable_soc_alerts(chip);
 	}
 
 	/* we implicitly handle all alerts via power_supply_changed */
@@ -1111,7 +1144,7 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 			regmap_update_bits(chip->regmap, MAX17042_CONFIG,
 					CFG_ALRT_BIT_ENBL,
 					CFG_ALRT_BIT_ENBL);
-			max17042_set_soc_threshold(chip, 1);
+			max17042_enable_soc_alerts(chip);
 		} else {
 			irq = 0;
 			if (ret != -EBUSY)
-- 
2.53.0
