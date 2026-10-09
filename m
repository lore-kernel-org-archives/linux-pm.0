Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA4390600;
	Fri,  9 Oct 2026 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518448; cv=fail; b=jLAIM/97C2pXl5OtMIrax0hm2ZR7iIXjcQW4TTjA4KlXTHmoW2iZO1PBnFyCYfF4qrGQUoYw/wlrUsR0nb2HoqyJovTlhVXve1H1ntNsNXiid2WVuOg3LXMHO/fvoFnu3xt9iPFP/Q5XSVwVCTOJXz+pFSaF2CRssotG1fn0YrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518448; c=relaxed/simple;
	bh=MOGW8cYAjJ1Xy30Xiiqc3T6JnHaPCQF7M4n7sqiE0MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NoWpxOqyLb3zKpUXjKjiOH6N6pZ2SvwBjYciRxp5Wnbi8ePoT4ft2mNRHX09ftv6UrIxU4XANEZHrNLyWi10qpyZXJ8eImBkXU8gm0DOyXZK5vFGG3PrEcmaJFLKi3ZURBLwRv+QUa1HEiwx+d+1UddK+6EHRhktfbvr12h6d4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DEJ9X5/z; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEJ9X5/z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wpm7IaT/+BbwSJU/nMva6VIWkPXBO3AAGadZqfio2u4+uMLGcxtb7Ju3bdDB4+dU25mWGA0IJHC+aF8PkUOoCHvGUr0C0gYt2Hqo6XoWab/VU7UH8u4mjh4nIbqNAIiXLZKP5WpvH5nHl4ory4dh7f6znTBdoJDdT5HzpvmP095t/CGlkU3YAKNJwH3XkMhxrTKA3yyM9GhdldpT7whdLRWhkshRufnehsYN5zSMBFq8cuYcLsxhuIoZJxmqFDRLCzcmZDDUsqXb5SViLqW5P+QwM54gkgU5Y+hkfJd7vVBngWn8Da1mGmz9c22tWvmxypakPq1/TrXRQol3ibqqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfVGxv48QEgQb6dKnAvE/N/w2Rke0DbpcvctM8Hspvw=;
 b=Z2Qb0aL86JA102XJYc0DFF+nBqGTP+v8f8mB8z5pmD2ZiJHrMDI3+okmcYmXAVephlWKO2UM8Conhoha5KqB8sMT4fwfhiqn2TTZ95E2Q0IPQsEuSusDMPj4DTwwGvwtov4s7aYDw8pDoL7czc5VT66/Z0Xz9jn6RGiApzET8LRnvHbab2zv5vEbroJT4sDVG3tvMtmRveY+v1idhHCuWnuB8eTmn4jrTgqUXvFilBHVgWVzoD5iNZTkwvOrG6q9Hg656wPTFZMTDm96fvmBvOpboJmPymm+Z6q1/cdE2zbwYWJlbzxxOuobiJCo0P8j67kdvyn+Jt36rX8FXmfYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfVGxv48QEgQb6dKnAvE/N/w2Rke0DbpcvctM8Hspvw=;
 b=DEJ9X5/zv0x1bJ0xlCvP6110jxag+c90t++KeXnx0A7O/+jZIufsHz7AYSatom/YZJiZMKpcpj9zBKrjiqrYkxbZEysO8P8EdvyWpeR74VcpzmmVgqMBE+LeDiT7QbJIrQRP1k6pGHWB+/2lQggxpw3k17rH+vkteo/HdJJ0KjA=
Received: from DS1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::14) by
 SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 9 Oct
 2026 04:00:34 +0000
Received: from CY8PEPF00000052.namprd05.prod.outlook.com
 (2603:10b6:8:242:cafe::71) by DS1P221CA0024.outlook.office365.com
 (2603:10b6:8:242::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 04:00:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000052.mail.protection.outlook.com (10.167.247.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 04:00:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 23:00:21 -0500
Received: from xhdnaggolla50x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 23:00:16 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
Date: Fri, 9 Oct 2026 09:30:10 +0530
Subject: [PATCH v4 1/6] dmaengine: zynqmp_dma: Use PM guard for probe-time
 runtime PM reference
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-adma-pm-fix-and-per-channel-reset-v4-1-55f5fe409c55@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791518416; l=5567;
 i=nagendra.golla@amd.com; s=20261008; h=from:subject:message-id;
 bh=MOGW8cYAjJ1Xy30Xiiqc3T6JnHaPCQF7M4n7sqiE0MQ=;
 b=/Xc8OXqm8zYevsDRIcpDAqxm3eT3jKq2aW7huHGR8pe9rV3NZ3NybtGb/JXPSvYyKK4Ld+tFw
 MDJLfO2v7nMDyciJ/VLHcfBvyn3O3R7vTWmy82w5ExLJvP0V0q0W9xY
X-Developer-Key: i=nagendra.golla@amd.com; a=ed25519;
 pk=pCRGj/0mb0C3aDMpVVZeyBqOIQZUKGJjCKL4QZTu7nQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000052:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 169b139b-8665-4db4-1c87-08df25b9de8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|36860700016|376014|82310400026|22082099003|11063799006|10067099003|56012099006|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lk1Lxg1KseJ6wN9aCSacrZtcCjYYtrcpf3L9GuWi+9XwPf6wT5fyBz+sNdhD+UYhINkZnmwSatu9ZUz8iLDVWZjNJAWaaSuN9DGIBqhCXPETOOyOquhIwVhzO/N51uDqFvuB8dp7AMBjX6Fa7GMUYHJdYrZVr5goxDqvAf1jZCxp9D6pDF6/tqhJQZUAHnB1B5h+srAkecIPETdDnMg6z08H5mrtg2Tc2FlL4RmP7KOfOjd9g//rkWSCwbeeOo+aqjaNhUmgl2iv84HO39B1PYp1zHd2rREmXLZr+MioIeNHVkQbO0d1Ydk0FtZ1lN6dVg/SnHAuJZBbYctEADFfHmcmmClFfBBg6vS/T8YMqLdfAljxh8HO2SlIoha5sCgev2HIAFJ+51mUNMbQo9Jc2fQ1cfGYRsMMP09tI/xq+92kWyiBQCdy6LDCxrXV42025lqzQs2Sr4gRQLW1QCK9vhyiJMwlkhLnh96hAbrZtgDEJyn5tHWrTazF+DBggrIgxD0bYT3RsQnm+x9XfDWMDo+idIJnRh96VyAw7IX9LJ9fsz2lJpQaw1sKNGolEownJn5RJW5Sa54nbnrXCErsv+DvCH3FMVUdQN6PxDr/QmQO7QlSaKWPUbRLoyXVcLvboyy9yqQ5RgyC9vy66WS3FgYhUiz/248D7i71nCh6Qx5674lP5OH2Ei3FMUPU+b1OYnT3SkdTK5Dk49fiTnppfuVsaW+fgQPGXupB8csGkC7MkmX465qXCWC78aUzwhZ8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(11063799006)(10067099003)(56012099006)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QL+qD2qjVGTV3ijpIgo99TTrbprh4HL0I0DIwMZoA3UbhchAhyNSF6sdt4MDLkWuEEBOz4UUjiv6hOBU5RHUMyoAAP9MWNKFGcRqG/r9ZsfAhNgbAWtalzchQ9ll3CAwokH+d27tOJ68u1JG3uOblIcYd9O1oWlTynUMpBUkjfOOhSE7ZAOzA8E5QOH+dn9U0/BiZyyNHfJN9g2BXdEqgCwggn0mCT0A7IuyfZiSlg1mb2Twen+aIFTERLXITklzp8sWfkv6U3bpwQ2KVZmP4WWyLzOd/Ori3JahcOn0AvkFkJb4GUeFbanl1ARd942yMG4lxT+csYUUHgYhfm8bNw0dykDl72O0N5Eg0NhUgrKp4NqwScfk7s5zyv3CBZwGNpxnrvOWN1cPNkBNihKrh7Lpg4ZnmUx5CY4U+5wMWDrwJ32t3kgxc5+A58yxhVfR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:00:34.1973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 169b139b-8665-4db4-1c87-08df25b9de8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000052.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811

Replace pm_runtime_resume_and_get() with the PM_RUNTIME_ACQUIRE_AUTOSUSPEND
guard to manage the probe-time runtime PM reference lifecycle. If the guard
acquire fails, fail probe immediately so a broken device is never
registered.

When runtime PM is not enabled for the device, call
zynqmp_dma_runtime_resume() directly after pm_runtime_enable() to bring the
clocks up for probe.

On probe failure after a successful guard acquire, drop the reference with
zynqmp_dma_probe_pm_put(), inhibit the guard destructor with
retain_and_null_ptr(), and gate the clocks through
zynqmp_dma_probe_fail(). When runtime PM is enabled,
zynqmp_dma_probe_pm_put() uses pm_runtime_put_sync_suspend(). When runtime
PM is not enabled for the device, balance the guard usage counter with
pm_runtime_put_noidle() and gate the clocks with
zynqmp_dma_runtime_suspend(). Runtime PM does not suspend a device that
is already disabled, so pair every direct zynqmp_dma_runtime_suspend()
call with pm_runtime_set_suspended() to keep the runtime PM status in
sync with the clocks.

On probe success, release the probe-time reference with
pm_runtime_put_sync_autosuspend() when runtime PM is enabled for the
device. When runtime PM is not enabled for the device, balance the guard
usage counter with pm_runtime_put_noidle() only and leave the clocks
enabled so that later channel allocation can use the hardware. Inhibit the
guard destructor with retain_and_null_ptr(pm).

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 68 ++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 3b7dfa53f972..a48106e404e7 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/cleanup.h>
 #include <linux/pm_runtime.h>
 
 #include "../dmaengine.h"
@@ -1077,6 +1078,29 @@ static const struct dev_pm_ops zynqmp_dma_dev_pm_ops = {
 			   zynqmp_dma_runtime_resume, NULL)
 };
 
+static void zynqmp_dma_probe_pm_put(struct device *dev)
+{
+	if (pm_runtime_enabled(dev))
+		pm_runtime_put_sync_suspend(dev);
+	else
+		pm_runtime_put_noidle(dev);
+}
+
+static int zynqmp_dma_probe_fail(struct zynqmp_dma_device *zdev, int ret)
+{
+	bool rpm_disabled = !pm_runtime_enabled(zdev->dev);
+
+	zynqmp_dma_chan_remove(zdev->chan);
+	zynqmp_dma_probe_pm_put(zdev->dev);
+	pm_runtime_disable(zdev->dev);
+	if (rpm_disabled || !pm_runtime_status_suspended(zdev->dev)) {
+		zynqmp_dma_runtime_suspend(zdev->dev);
+		pm_runtime_set_suspended(zdev->dev);
+	}
+
+	return ret;
+}
+
 /**
  * zynqmp_dma_probe - Driver probe function
  * @pdev: Pointer to the platform_device structure
@@ -1087,7 +1111,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 {
 	struct zynqmp_dma_device *zdev;
 	struct dma_device *p;
-	int ret;
+	int ret, pm_err;
 
 	zdev = devm_kzalloc(&pdev->dev, sizeof(*zdev), GFP_KERNEL);
 	if (!zdev)
@@ -1128,21 +1152,30 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(zdev->dev);
 	pm_runtime_enable(zdev->dev);
-	ret = pm_runtime_resume_and_get(zdev->dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "device wakeup failed.\n");
-		pm_runtime_disable(zdev->dev);
-	}
 	if (!pm_runtime_enabled(zdev->dev)) {
 		ret = zynqmp_dma_runtime_resume(zdev->dev);
-		if (ret)
+		if (ret) {
+			pm_runtime_disable(zdev->dev);
 			return ret;
+		}
+	}
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(zdev->dev, pm);
+	pm_err = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (pm_err) {
+		retain_and_null_ptr(pm);
+		pm_runtime_disable(zdev->dev);
+		if (!pm_runtime_status_suspended(zdev->dev)) {
+			zynqmp_dma_runtime_suspend(zdev->dev);
+			pm_runtime_set_suspended(zdev->dev);
+		}
+		return dev_err_probe(&pdev->dev, pm_err, "device wakeup failed\n");
 	}
 
 	ret = zynqmp_dma_chan_probe(zdev, pdev);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
-		goto free_chan_resources;
+		retain_and_null_ptr(pm);
+		return zynqmp_dma_probe_fail(zdev, ret);
 	}
 
 	p->dst_addr_widths = BIT(zdev->chan->bus_width / 8);
@@ -1151,7 +1184,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&zdev->common);
 	if (ret) {
 		dev_err(zdev->dev, "failed to register the dma device\n");
-		goto free_chan_resources;
+		retain_and_null_ptr(pm);
+		return zynqmp_dma_probe_fail(zdev, ret);
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1159,19 +1193,17 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "Unable to register DMA to DT\n");
 		dma_async_device_unregister(&zdev->common);
-		goto free_chan_resources;
+		retain_and_null_ptr(pm);
+		return zynqmp_dma_probe_fail(zdev, ret);
 	}
 
-	pm_runtime_put_sync_autosuspend(zdev->dev);
+	if (pm_runtime_enabled(zdev->dev))
+		pm_runtime_put_sync_autosuspend(zdev->dev);
+	else
+		pm_runtime_put_noidle(zdev->dev);
+	retain_and_null_ptr(pm);
 
 	return 0;
-
-free_chan_resources:
-	zynqmp_dma_chan_remove(zdev->chan);
-	if (!pm_runtime_enabled(zdev->dev))
-		zynqmp_dma_runtime_suspend(zdev->dev);
-	pm_runtime_disable(zdev->dev);
-	return ret;
 }
 
 /**

-- 
2.43.7

