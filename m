Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A43BAD93;
	Mon, 10 Aug 2026 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356678; cv=fail; b=QBAmeI6x7+6XyCyhHsWjIKDEtWqv3IghqJEbohICT+yWCb3uoRqUipcWVXK5+iZ4BT0S1u2oztcl00W4/6807z3vZMulM2GuwVeSir5MPfMlfYk8flt4vR/wLM/bdcup89Qe79M/82af9vTWI/RlEVPm40DZaWHWYkPnQAa7YGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356678; c=relaxed/simple;
	bh=uSSE1dr12s7hQqFV5q9Gc99krfcVESyXvolKgtK4azI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bU/K/NnlqGkn6QigQ18INv0rbycv6PtHYxGV481X9u83U6EtlDi51GGweGJl4kastvwgrcLAL3+wsDOd6PQxpX/f2jhCBLFAfvU3181OOSYlYqZ513yCMQYn1LBnrjSjYnwYbBkROYJAB7tXrY3LPMQ9OBsA4ewoNusNzs+Oup4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zTcy/9nh; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zTcy/9nh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWUTAdQ4DmDkhgJmPr9yeo0u/rxDDjkoHmWRJhusHw18iqC46QmC6JSKa7YSkfINkI2cACWp15wXfXpDfUdIuP7nbCnpFVqkO+ExoLe1K6SXSLCjxb6MaN3I3Lj4s/HMh9+1zjdCcxS6JoYZNdMegZNbI73r9vLfJWIM2yIueVvLRMV3bC0JZ4pVoBwpMNTfm8kUwvfqnbEJFYL0+1mRSLNFwCimNnwKvftS2MZfN12GtuJ63GDz9VFmpEWVN8Cq8PX4VmcW+DGg5t2fXmrgGsyxq6DUlgdX9gcu5OapLVQHRNKbCkGx+uKpxijKC4pdQDMvtfcikWaDUwr7vcWCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR2mpYa1hEEEJg8T0wJOEfhD4O5ENdkllff1OnoBpCc=;
 b=JdFgGgEcUvtKEIpew9rAu/yNU6NxWG/4yO5EF8rOvKv5IYjOj6rbg2yaqzAL2qVS5xNfaojqoWuHvJk1og6DY4suBTticP04hPMqHiFRiaSVX68olJ+sgFxTQ1ufEs3ZHntxa3FKm1QG3EcIpzf1KYfR+HVWQ0lbB9B1stmJupZ/rim7D8GAXXdXpm7sDC9pr7Mbqv8gBGyegKgENBL+HELN0zLZzlWLMWq0Z8MEL1aBEuvL5RPZANEBnuI7TEbIRzdqryK3VAL51x4xc0AIxTViKDQlW4PvcnQEKn8R+VROc0uWrCxd84+j8VXDp6XvDvcqQb9UKXEIibLuf59ihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR2mpYa1hEEEJg8T0wJOEfhD4O5ENdkllff1OnoBpCc=;
 b=zTcy/9nhDAN1aqJsyHJE8cjYWj+lEZMWPguB2lrDjxA+Et3qf3+gwhmwWV2+Di1kXmaAZBKtmLaK6u72vGUDvrTK9sUi+Q0LVauzD/4kN4gVoe3ybssdlOuVBA1cHidhLJr1tt0E8YIeDwM/zCqF3dIj+Uq2CUznF3XWblubtgc=
Received: from SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29)
 by LVXPR12MB999196.namprd12.prod.outlook.com (2603:10b6:408:3dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:11:12 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::61) by SJ0PR03CA0144.outlook.office365.com
 (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:11:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:05:00 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 05:04:57 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<rafael@kernel.org>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <nagendra.golla@amd.com>
Subject: [PATCH V3 1/6] dmaengine: zynqmp_dma: Fix PM usage count handling in probe error path
Date: Mon, 10 Aug 2026 15:34:47 +0530
Message-ID: <20260810100452.426320-2-nagendra.golla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|LVXPR12MB999196:EE_
X-MS-Office365-Filtering-Correlation-Id: a03330cd-236f-4e6a-28f4-08def6c7b428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5ySd0e15CLP2F0shQwAI0E+pbMitKqZ1pJysabMBUHmnfMONdaAmTILVcYGwX5F4+Xo1lZZDbnKTe4Ac6AbDbqc5Y9B2uzL2joZY/PWC7BmolywrTHA4jYlMkJ/V8Nmr/FYpvcMOUNrQofNoL1RfgjOTHz2WUl+GEluPYC9odrFR34zi4NmY7pg262iR7e4iMx9HlAvFn21t15mSarr8M2uDKGbGc2/EU6jgQJCEv8e1+DCFuQUykqA2diNJ4hHS2Vy/mRV/CN5lteySVmRqkruexNVbVuRxUe5px/bqGpx6PVyhwMemiQUXAHwX2oo9KQfcN1ICWaZnXcIeGTVfHFE2ALPjroD8OYg9mcpVl0tzvcAvsoYBPNgg8KiEm9aPSIj3e/KHdHRGlvlA32HYDbsjb7vqrk9/n+/P4guPH6g+b1WgT2qgPtVf3rTspDYqetwppqaWd0DcFGKZPESqVs6VR/0i/AR7VC6VTUcWwSVuYsfLFbycaqNQi54HxA8fT6bynvvcphhiNFae9AUHKUHi1srOMmRmWn2OjWPQnjvTmsmQFCb96+J7v62i8kl0hKlSKzPnWU38F+Y+lArYJDcPBjsZv8p2EJW+yn7TdzIreKci7QPyrxuZOgMaO2U37KtEKWwnXerHd5npxLUN2PmBOxl2JZaD72j0UBxlEvu/NebITjrzEMjjlZR0Yo1wXZ2UQ53dQVETVHbj9RxfDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B2e+6lhlh5lBtxUGexigJHD1BwyrBjQnxUT2BPNjGTyOHlP+vs3L4dKNGJJNFPhk2bkhizJk9G14s7sRiM3g4BreC+Fs32VN6wVG2wh+t2dFEHR4KBVn2cpH9z69UcwuC+T0uL6uOdrNddGrQoqHPf3RRnif9pDJ/NO9np48SbTiIWehVA6eKdSlrZxaA63cgUv+BCgGVDkDA5eKGC3vK4SlilxkSMfCXdxn/KwQRdOhQEjVYBvNtiQ1FafMA/Dv0HsYjhoQaYO38X4ktmXT+6hnpmrKmnLLYuBBUYdC1ox0/AU8wUr1G5UNloOulx8QSOZ7CnSHONZsfaOj0kHQvZIv0EfspJSfk5or7OZJfuCzipKmTxpfDtBrW+VVgm81fKujgmL6iLgpjSk0nRe9lpbEvjIqz0EI5pyCALF6CyA5v1NjbJZCPWOQZE0/BIWJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:11:11.3543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03330cd-236f-4e6a-28f4-08def6c7b428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999196

When pm_runtime_resume_and_get() succeeds during probe, it increments
the usage count and enables clocks. If a later step (e.g., channel
probe) fails, the error path only called pm_runtime_disable() without
a matching pm_runtime_put_sync(), leaking the reference and the clock
enable.

Add an else branch to drop the usage count acquired by
pm_runtime_resume_and_get() when runtime PM is still enabled, letting
the PM core suspend/disable clocks on the success-then-later-failure
path.

Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
Changes in V3:
- New patch: split from V2 2/3 per Frank Li's review to keep the PM usage
  count fix separate from the per-channel reset changes
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f6a812e49ddc..87986f65d24c 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1152,6 +1152,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 err_disable_pm:
 	if (!pm_runtime_enabled(zdev->dev))
 		zynqmp_dma_runtime_suspend(zdev->dev);
+	else
+		pm_runtime_put_sync(zdev->dev);
 	pm_runtime_disable(zdev->dev);
 	return ret;
 }
-- 
2.43.7

