Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8333B42E3;
	Mon, 10 Aug 2026 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356671; cv=fail; b=Fo3rvhwW4r+qamnMDyYSw80MC/i6jGgZNuQzETwAn3V8DrC4MNdkUKJ2fewaXvt5y1vbsO1R9beT1VAwz2jYL0QCR86Zj9KK7j7Qc5FcoXWXdR/tW55Ku/S0jpLeJVlPFcTTWoyezFs/JJE8Uit8gbe6QEiIsUXmOq2gd4+Nt44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356671; c=relaxed/simple;
	bh=++5vCM3L0XVwuyZAuwtFmNM8HR5LWP7tV4l8YHHeF38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvuQdJDRmgV/ashUykjqtQ3CzwF9BTRF9mtzmZmh2U6OJcQfyjwceCYhj/UHv/JNxiTzXA9oo9v8YFje/CKeiGhl6QlitaoLbezPWVEeQAyTJxeLTcYv+FBY87FvIB/TgIlCusVRoHFuC3pCk/b+4G2Cn9Niv/I4XA93INwHDK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b5bAW+lK; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b5bAW+lK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xob2xNUjPJl3bZVpaD6gL0BucoBM7VydbSKX2xo1aBbZRyaUTV/AllrFyVeMEkfVVsUqNIZ8Mr56zvZIpm9pjpIQxStVQEK3AvpLMeaYbCNg84U7HYWDkB6Eh3cV/0NFeZ4REQeLs2JqSWZ7NLNlTh7/rbe4T9p2RAmej9/QqQDhlLU/5JTcGhbZhhY8Oc5z4mc82fMwWwEqYRnEcE2SvkgnINFY4sbLq3dWOkWCvtbDBQVz16RIJS6dLopkOm/lADZiuiXXEXwnTnrI9pSnF8yqsb5Y5Yddw829DWEKAW5gDQ5BRR4MQmrR5QpNSdB32lc+YOwoRkeDkXyVI1I8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Il8a+a/QXWQplt0OgEQaM0OnSHmRfhZtUkpBsOMr70=;
 b=jjWJU1GY2OM31Y3WKNqzDuwIUGGwlRnpGaqPCyRwvZj12GVxs3JdBlyZnQ3FpyACDDz0/XWLBn6eViuzguAuIVWMDnjE7On3rY0a3kpf1PRV7HPAZ58CdBJRImaIP3LwpLU0WabCIv4hyKnoYn3Q358D51HIyEDBaaT4mz4vYE7etTDuPLLb/kcHU5kt/doGLL9tJ7KsA94XW8tRKw5WG9c6kWDidf3wye0reuYn7spW+pcX/UVE0a5/1jAoLyMasDeh5QEf92GzD49KfUR5qs5IX/TIPZjkYA5PGMDOzFxuzPAYF0+FsrouUD4JOS3UUoTg3jw0DZZYdOey7iDJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Il8a+a/QXWQplt0OgEQaM0OnSHmRfhZtUkpBsOMr70=;
 b=b5bAW+lKoulU6aKtCSJ/UWUyzbXgVqDq4wkCB3sp/b6VBPKvGMR9prIUFu6O42zOFJLZeeWpORr1I8jC7jj1wCL8tvxwnEYtMKRPAvbPeUg5W3gFsbOv86sCWDS9SBuiYCjSf2NH00+Fer4DwKQOn9ngOjF35FmcQAZUupWO3JM=
Received: from CH0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:610:b1::31)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:11:05 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::70) by CH0PR13CA0026.outlook.office365.com
 (2603:10b6:610:b1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 10:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:11:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:05:16 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 05:05:12 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<rafael@kernel.org>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <nagendra.golla@amd.com>
Subject: [PATCH V3 5/6] dmaengine: zynqmp_dma: Add new compatible string for Versal Net
Date: Mon, 10 Aug 2026 15:34:51 +0530
Message-ID: <20260810100452.426320-6-nagendra.golla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 6000b4f1-be88-4066-d47f-08def6c7b0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	teE3TbpwcwfykRMQ1SV3+D3MzXsiM91Ovd/ao4Q3I0s1XdrFl2qK+rCJo9jbeY5Z9Kt/4jWPzPjWvnKfRNrAmz3wZ6eiFOpZ+VTyp7uRF2hBgwP+U69m+C1qMCpRoihYOCCyqzKj++iDH4gtKUiNwaEQAf28M5un8uMX/J0M1IfinrdMbKHcEX8iOFDncMvHzlXb1G05W4heVilc2Ljim4jONfEvmASb0nFvu8IRR7kchWAo8tNdYgBFtqkTKiFrEfNPBJAHys3I+DMP21SGz46Jbwf30YCB4FBZAmDOArPpae7Y+AhIt8QceIrIeT92GdZTOAxpEafV+xEsz2sKXyy0cNnR7vAMdfW2Gj5w/hSXwXHnOm1tBROtEm7EZ7mrQkdmrw4ldMg5lnRHwwRm5w9f2dahO9zajjYyB2I8167n/baVYtUvwWQuo8GLaI1dEdln7p4dr2NLpPb5zXXuUm6NKrCI1+Yq74jOKwTXepz+FmIY3+Dk4NpOMDNOeakb82jJcdDI16DuB+iZQ1RDr9cOVWS5dzi9HXDXhX8Lzz20+lWqrGW9/z66tbdenbTTivFnOIctbaKQLzNxqyrByChH8yOZhtLlm/XxQqOrDFLtDiS/BNWISMxA4jNC0kBJjOXq0SCW8O9Nm84hUGori+L+T+MsVEETk4jr+RoVBLyz0F9xfxgKwjGA7SDkMljwPrJ7/chFZqWiKLFjuAX7/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9HGHeNR9RUAUq2TYQepJSuQ1panvYISiddWCpfY47yZyiKdi7aXPJTu0+nxX5yWfZXuhJdA/tfCH51d7UprkW/g7xzquWkmG6ZBIKur8RwTKgvmUIy+aQq9xG1H5uKnvqvu5xfkPbKxg3h1bo7hj5AFboPOJtrwePEDlzGI+rNlcqZI/zJopjVN8mkc7ITb+Q5FYaPfroVe0UlIjPtUR/ryGcP4nbHN2+ZOMDSiBE4mZdWmUyilSZuAD2mjm4IOoau7TMi2lceqjnTXDfDZavbF20bP92Dag0gsmFSCgmEMrlwS/Olq5xmpLYXn8N335d8asTCxtIjjK2hA7j/mA5HqwmgiLKbCCl1Ylpec0k4DVj06V0QZNQ2JZURM8M+xys+GUhBCQt6Nwfz7hVyE5JMhopSe5CnAeMs5r7xAiKpeOuFEYqMo4lYwRQTZ95ZiG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:11:05.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6000b4f1-be88-4066-d47f-08def6c7b0ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

Versal Net previously used the legacy xlnx,zynqmp-dma-1.0 compatible
string. Add amd,versal-net-dma-1.0 to the of_device_id match table
with SoC-specific match data via versal_net_dma_config.

Introduce a has_reset field in zynqmp_dma_config to indicate whether
the compatible requires a per-channel reset during probe.

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
Changes in V3:
- New patch: add amd,versal-net-dma-1.0 to the driver match table with
  versal_net_dma_config (has_reset=true, offset=0) 
---

 drivers/dma/xilinx/zynqmp_dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index b03171e37e27..7561416b8e62 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -259,13 +259,20 @@ struct zynqmp_dma_device {
 };
 
 struct zynqmp_dma_config {
+	bool has_reset;
 	u32 offset;
 };
 
 static const struct zynqmp_dma_config versal2_dma_config = {
+	.has_reset = true,
 	.offset = IRQ_REG_OFFSET,
 };
 
+/* offset = 0: Versal Net uses base IRQ register address */
+static const struct zynqmp_dma_config versal_net_dma_config = {
+	.has_reset = true,
+};
+
 static inline void zynqmp_dma_writeq(struct zynqmp_dma_chan *chan, u32 reg,
 				     u64 value)
 {
@@ -1184,6 +1191,7 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
 
 static const struct of_device_id zynqmp_dma_of_match[] = {
 	{ .compatible = "amd,versal2-dma-1.0", .data = &versal2_dma_config },
+	{ .compatible = "amd,versal-net-dma-1.0", .data = &versal_net_dma_config },
 	{ .compatible = "xlnx,zynqmp-dma-1.0", },
 	{}
 };
-- 
2.43.7

