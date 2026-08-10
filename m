Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5653B9610;
	Mon, 10 Aug 2026 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356684; cv=fail; b=TSvIzb2OBI05WZmkk5tvL5V5bkXa9GbfGRQMe/SJ95IBDIcu21zfuH4WGPTBeplth4mBgdLYXiD++can8g0aAj4enhmTIoytetqlZBBkNTCgZGfzQUjRwBgSyraDUUFiuKLlj3ioBbbKDMnXqChVDiKZcOxPGwHweoiqKGdeTBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356684; c=relaxed/simple;
	bh=M5AqN6vPDShzT1jOwE1H+GetpyOEe1xxYFDAMIRhkTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVi6Y0Bk7IeCjpPsWqKkLAhEMODslIYSnOBXmrTX7RkKggqxPL0/n66IIkAVxKYXSBYs1cZGYGwqFCWgIWt5xFrWolDuvaNtgaz8Q+GKHRTnSyonlyiEb7DNDW0bynvUA3Rfxca3ZP1lwJfML/OMchrVUVweo4XRkqfQE3frhpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kX6Yfjzf; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kX6Yfjzf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiaioyjV7gbSgUxY040Z+QvNC4iKg+NNN/s8LeYO0c6KHbf6aAeEA6H0q7rhAf9oG7A5RsJBKdowFYQMXGBIf4yQU5QiL9zk7cOexIWVRBQgutqtgJ2misAml153TtI0C+zjg1QD+Kg/lSRci8VoRo3exXEI7wGOOYR3FCPXq3e0SA7/Bgjq0u9JxsNDIxF3S0nPG1aZJLHE41sjp3sggawMV++dasVJj+9fU3uSGbeJ26yO5PCdrtwd9M8cAhIdhgAm0HBkUSeL70RJ7wr9tbtL1SGo2nfGs1eqv53l3KA0oNVMi00sZ24jFHGtFkd+OyQEyUHLN2ydNoEYH1XmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycyF+5IHRcwkuQwpWz7twlFJJBn/LQbm4NZIln42zJo=;
 b=rPhgE9pR1fH7dnJ8+6HcEZaPBN+aVDHhB4wAeHb0FUbDIWo2XNYcPEWtROjcw8RhEBXktj3M8JtQZtMk1Z+AGcv281fKEP9XYM1C2/gIQxwdssq4tri5OIK0AwJ4UHz7isnNBqaUD+yXwYOZ2OQ0hPISh/8Qzl7Gw2jhu9LghnddN4LBOyrU0qifRqncFDoz+zFbtfgwIvJUf2CaCoDSBI1JJ5N6BfRF3NCQkyYQkrNeJ/6OZKQiaF+1HY27qFDTMTGal8Bj8PVDaNuZ7cQ93w5fRL2JYqBJqSZjrhNh+tul3xm9tdxYFOSCS6w50UjwSQr/SLRdp8z2vQTh1q9aoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycyF+5IHRcwkuQwpWz7twlFJJBn/LQbm4NZIln42zJo=;
 b=kX6YfjzfR+/XfVXihi+ZKr2vYkAk8/Jx7uVrL6MKbrw3z+GFFAJB1ADhhNdR7yPRLTX7kNV4xxUwVlQftDd5EtRO+87k9E76FoFJ5kCfCGAD3SHYAgdwuGoXP8O8pW2hAtTeIMabRM2L4EsbRnvg51ToCrDuPOFAouAinBY4QFY=
Received: from MW4PR03CA0336.namprd03.prod.outlook.com (2603:10b6:303:dc::11)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:11:17 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::21) by MW4PR03CA0336.outlook.office365.com
 (2603:10b6:303:dc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:11:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:05:20 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 05:05:16 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<rafael@kernel.org>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <nagendra.golla@amd.com>
Subject: [PATCH V3 6/6] dmaengine: zynqmp_dma: Add per-channel reset support
Date: Mon, 10 Aug 2026 15:34:52 +0530
Message-ID: <20260810100452.426320-7-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810100452.426320-1-nagendra.golla@amd.com>
References: <20260810100452.426320-1-nagendra.golla@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 88716c31-c584-4f97-22b1-08def6c7b76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7RnBIL4zU9yw/hLsCC+ArRjbwjgiY8dDb4k9lRs4l1nveOtmzwCtDDQPEON2xffdPsr6wrWlFbvOOkSjyU3k3terS4cvy3a4oVt7G5Lly19nDrNdZVzGWIRvTmn/Ay9Bh//K8gxwwzzCmOH7vfFMlz6NT9nKAsUXu6TD66rF2/xON/aEp3YNvCfqQc5Is1y2KoETDOVICRx/B33vibS+8/4MzbeEw/GLVq0xW9nsDe1S9GKD9FIGAMb+lBSueP9ADoJnkKJKzBAvKNMY24MX4qJVsv3Z9LwD0djTH13ASsKQsAvjSrhZardFeDZsVOEoa0iwySXIx0wKzD4l/tZ/a4jgQVHLj/qfFQiTc20oiJbQy6w5hvxpOTtBqZ8m0YNWbQnLbtAyR9D4Cr1TcaZjhi0eWKpDoW1nHG/Fo5cfDCsAUf2Ipl24A6c8kjmsIVPDsDl16zks1SP5XiNbb4jxcHd4QjYC77tlrzGwMS1s4WN1hWFvus9XXGfTXcJSKAIPIxGx0rD2LuJru7rg24+CJNVk+opovdqV0DM+kqL/oXbkA0DjvZ7cj+TM1I618YtjQPSA1FKFEAMlKPWhAaicGdAt5Q46xLVmqYSArgZzFyVi3Tm2lAKLouzvMg+AiAYroatHhsqujFzpGoFiCpP0p8ALj7Pte040QYnHCzgGgbcAbL09foMp7NbdJkOLKBz0TseflPvgqRzuDf3rxIwPKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PolPHrNw5Ibvhz6H2+S9JY64fV5zacPSRY2S9iY3wqyIvUPX50o6vSFbPDea5lZCM7d7w5XNcFVMl782dqpznS8aMmxPEgaXW7fI+xyity3+wi4JiU7UyXb3tFmoi14mzNxpjjcy+KD7WOokDp9crrBEEfgGY3cAE9PzGs7lp3Wvp13GKLV+YGQ9O5fLJkDzccKqIfD3j9mwuMZTVnGcxR6qc2tUr1iNuxz8ueyjF+R3R8uxtBPTm5Ci8j2k2/IMzfrs7rqsRuJEW0ORUC8mJTYU9Ibk0ChSbcZGzU+n0G3yna6Sd1v89GpSIQX3OkfK0UXU8oCAq2+3AQH+JMVWHPVuKy8RuutVSgrNJrfFhLiA4+IZHSyP5F61Nx/DuqFgW6jue42EbTHK4/IN/5dTblnOjUJP0CUdW4d0UhVNriebmTxy2bz7nuG7Z/yYd1g0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:11:16.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88716c31-c584-4f97-22b1-08def6c7b76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

Versal Gen2 and Versal Net expose a dedicated reset line per ZDMA
channel. Use device_reset() to trigger a mandatory reset pulse on the
channel during probe when match data indicates reset is supported.

The has_reset field in zynqmp_dma_config controls whether reset is
performed for a given compatible. For Versal Net and Versal Gen2,
has_reset is set to true, so device_reset() is called and probe fails
if the resets property is missing in the device tree. For legacy SoCs,
match_data is NULL and has_reset defaults to false,so the reset path
is skipped entirely.

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
Changes in V3:
- Introduce has_reset flag in zynqmp_dma_config to gate the reset path
  per-compatible instead of calling device_reset() unconditionally
- Move the of_device_get_match_data() call before the reset block so
  has_reset can be checked in the same code path that reads irq_offset
---
 drivers/dma/xilinx/zynqmp_dma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 7561416b8e62..7ec6598ea587 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "../dmaengine.h"
 
@@ -928,6 +929,14 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 	if (IS_ERR(chan->regs))
 		return PTR_ERR(chan->regs);
 
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (match_data && match_data->has_reset) {
+		err = device_reset(&pdev->dev);
+		if (err)
+			return dev_err_probe(&pdev->dev, err,
+					     "failed to reset channel\n");
+	}
+
 	chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
 	chan->dst_burst_len = ZYNQMP_DMA_MAX_DST_BURST_LEN;
 	chan->src_burst_len = ZYNQMP_DMA_MAX_SRC_BURST_LEN;
@@ -943,7 +952,6 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 		return -EINVAL;
 	}
 
-	match_data = of_device_get_match_data(&pdev->dev);
 	if (match_data)
 		chan->irq_offset = match_data->offset;
 
-- 
2.43.7

