Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7783546EE;
	Fri,  9 Oct 2026 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518456; cv=fail; b=XBZc8rQRkyW3TO0MQZ9Dl+ky62VoXXkUJrxssa+a1QdqHF21zSKMrTFHjUuITXXkl0YKbmap7KHyBWZu7N59EsaEkWifRoamurKkFzc2jmfyWE/cQz0Tx9HG8Uz52kWEvBC8cpsr8m2Od+L5mYHoiuI67hROxzjHpYrBJtcVzwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518456; c=relaxed/simple;
	bh=GPX9GMp1ZUyP6ZS8qmwuDyhYEo7r6iy0zTbnCTnVE24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bD3uyUlp2ZuY6dcLFk863Kmioai/g2gRuAElbH9jvJuh7Ew6F9YuWLW8aWuQIYpTdFdWGuW//KtI4v1JRi5uN1uCzMcOHaccABK1/wo8GIzUySzxItBCkjU+yAy/D/8fop8aa8J5XzdzKG0SCXIkMXq10MdUIGsexS+HSlf5w7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ypYvcA/5; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ypYvcA/5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otiUZNbCKD/KEU0e9cmr/wIzj07mVzfN2nWBoqwqKMaHLXpEX+d6bo0mX/BJEup44xJI7VNwTmfxUuy+fYpsrTLZhwQFh0JmhnJTvIyOY0aCZx9XlgWMBvk1sCcHrLaGLPP5FRXUghv2lKbVVJvRz29Ixbg6NUHtt89gzQecqT+bpVJkyIYMpb3aVNEqbksF5yn7qxYyFQUlwsR8MG2hcvpCRf6S5oC9o4vg/0wD7n3rY40qlZ3YJEtY6xg6l2DPULiZlKSEcjwftEJNXqMOvwzxCg0PwGqgg5xC7IE1obJC88eW+Xd+XoDBBTyXMylVJ2h/cPnYbVNA3/WuK9eoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaLug7Ptv/J/KtiI6wwsZFGeGHlr+bPEGhiyoHE/mGQ=;
 b=agzV/PAOVr9ACb+UqlmOucEHVKqANjZorZZAyTGDtls6moH9yx163KMO4UzKvsEDmxbdQqQcVFLs03kzkRnpWqAnE67rEljNfRA6v/q2w76Hzlux6PhfNA5D9OS03qs7cIdxRSF87pel0W1Zg7b4hnXl6FVgRVuWY0WBgF3QzIKzwJdTMYbu9SOlJroQ0mVde/67nDSeg2HiQ4yi5ObF0m8lFqbVI/eWF5TZioYgBKopo9dJ1rHaC7E7CZr0jIEGvJRmGdwhAPlhOCO0hTYoNUYBA1jaUuxU8NMV/jQvYrfxr9/Jz+QBPzePC9EealpxCBNhZq4ZJ1mrzrwOCfsMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaLug7Ptv/J/KtiI6wwsZFGeGHlr+bPEGhiyoHE/mGQ=;
 b=ypYvcA/5WD5mlEnt8SG8sXIZdFt6QDskGQAfSADfJ4DBgbRXGJeELs7ohoqebnioLpNY4XHyi/G556F5HuYNrO5l9MTgU31qq5I2heUYEswn8PFZ4De+6RUKNm/fTTyDoeq9lWpq5OEqmJ64Njqj7IswgZvrz9lPNGH+s6YH3D4=
Received: from PH7PR10CA0017.namprd10.prod.outlook.com (2603:10b6:510:23d::10)
 by LV0PR12MB764842.namprd12.prod.outlook.com (2603:10b6:408:3b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:00:38 +0000
Received: from CY8PEPF0000004F.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::99) by PH7PR10CA0017.outlook.office365.com
 (2603:10b6:510:23d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 04:00:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000004F.mail.protection.outlook.com (10.167.247.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 04:00:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 23:00:30 -0500
Received: from xhdnaggolla50x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 23:00:26 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
Date: Fri, 9 Oct 2026 09:30:12 +0530
Subject: [PATCH v4 3/6] dmaengine: zynqmp_dma: Guard IRQ handler against
 spurious interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-adma-pm-fix-and-per-channel-reset-v4-3-55f5fe409c55@amd.com>
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
In-Reply-To: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Michal
 Simek" <michal.simek@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Tretter <m.tretter@pengutronix.de>, "Harini
 Katakam" <harini.katakam@amd.com>, Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <git@amd.com>, Golla Nagendra
	<nagendra.golla@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791518416; l=1347;
 i=nagendra.golla@amd.com; s=20261008; h=from:subject:message-id;
 bh=GPX9GMp1ZUyP6ZS8qmwuDyhYEo7r6iy0zTbnCTnVE24=;
 b=hwT1ODu0s6OuHZn5Acthu/rX4XUiFp/l/PyLivwe/pjIlAt0d2VYBpGLMcgpxkoLSb8hGJSyl
 ObsgnbXkI8eAo3gPXDIqqMnHkSX35LAu0Fp7zv3fAsmPDqG67UShcZe
X-Developer-Key: i=nagendra.golla@amd.com; a=ed25519;
 pk=pCRGj/0mb0C3aDMpVVZeyBqOIQZUKGJjCKL4QZTu7nQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000004F:EE_|LV0PR12MB764842:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5a8f5a-ccea-48b6-f3a2-08df25b9e0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|23010399003|376014|36860700016|56012099006|921020|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QuEsMY1cADlcnce0YOBRKe+VLMxPD4SktpLsOXmFZpDvdDXTUHECsae4HVy2hby/iaTa7YTIH4hQpdp+2QpJ5Yu7rhA0Qc1iIrv6LaPT97eujggbtuYJqJCPru6j7q+Pwt7KLW2TIafpCVll9eloLr6Cq4Dob14LUgzR2SAw8e9pzYL+Zle+UFrB4WxsGOMs/TTDO3ab0ZKTstdWTRFCf/DYcjwQLmCJO5nWfjBnilnsfq7xLd8OiApqYWwBN+PZDiWh0dblGVTSu84TTXaUS8A93KtNuasF9nlBFR8NbLVpflR429I7s4CSnp6VY8Qr5qbtBQ2eri/oMxu88/PN6qxx0/afbgq+iNioLKBCzCb14hqeJHWkuwnKjiRVntH/cPGCc/GqiCqEOwHKaXw82S/LP74Dy/wdYYUK0ejM5Gml9osatczRIfudnO+TO2kqtlueJa7IZvjkYK3GTrkYBseF3uU3JXzoLgXe/ENME6AQEBFNRriBUiUlN1EUeCTw0/8Xu2CnjrDEcFWyvkJf0Dp3U2Mrw+SlKrne6aI2F1bKARTccutTwiQDi+014s4j+uUcfYVgQ8GbvU3BdvZluP/VagHk3Ah33RvO50FqRMkhsSazV1lGHnyV44drfgZEvE6Luum4JeomuFVSxqfjERgJ4LHD0cbmzLg8kIE5eV271JLE13yK+tqAw/HuTk6WnHVxXcVPyLJQ5DVkpHf+V0WAz3MdDxTvgSvprKL9EwGuD0CMUrv4+j4EKYiw/UHZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(376014)(36860700016)(56012099006)(921020)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gMRdmfYNu6pXgsRlLUp228ymid1iPFHUIv3ixUCy/gG97gFiX0PKGrr+1Zx1fLLv5Xrv8eDiJZf1APBXO5m1KpEQm2ZdGqCEAHlUn7yslwqhRLVmWjzSDIYYMr0VAnIYqUWH4DSeoamIl1ejgn4RQkyJynmIjDieOcM35nTvYpMj3/qRjzdVRmkpjesXYsiQ3YZfQas9USDGRAlmWMpCMUdgcFAhrjTfLVj96qbAUmjgjDiIk0QXyvqpgnOW6it+a3ItcuKL0X2snK1lnymbak4HAAEc9j680gY96+HLrnm6lG/iSP4yTjoxn2mnTJ7mOzjjKXZs2w9r+hRigncNqKuRZdHLXle1PIulpq91OP4/zPOPlM8/0BD32Jwf9fCc5IUt8R+Z8kk932Y6lVCxhbL5wtLdSvjV7ShW4Xr2NuKf5Tr+CD7a/yjJdng7tVC6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:00:38.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5a8f5a-ccea-48b6-f3a2-08df25b9e0f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000004F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB764842

Use the PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard in
zynqmp_dma_irq_handler() to safely handle spurious interrupts that may
arrive while the device is runtime-suspended.

The guard acquires a runtime PM reference only if the device is active,
returning IRQ_NONE when the device is genuinely runtime-suspended. When
runtime PM is disabled for the device (probe fallback path), the handler
falls through to normal processing since the hardware is still powered.
The reference is released automatically on function exit via the cleanup
infrastructure.

Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index a48106e404e7..b5a5e93e42d5 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -738,6 +738,10 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 	u32 isr, imr, status;
 	irqreturn_t ret = IRQ_NONE;
 
+	PM_RUNTIME_ACQUIRE_IF_ACTIVE(chan->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return IRQ_NONE;
+
 	isr = readl(chan->regs + ZYNQMP_DMA_ISR);
 	imr = readl(chan->regs + ZYNQMP_DMA_IMR);
 	status = isr & ~imr;

-- 
2.43.7

