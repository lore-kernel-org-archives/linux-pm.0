Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC36367290;
	Thu,  9 Jul 2026 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564322; cv=fail; b=XKpF1wfneqtgbvu3aE++rZTegbaFl08+hRyMrrm9HbDZU+hknz552/Zi8sxCPxwc0Go4s1p0bwCL+7CE6W9dKyBWh3jPJdJo8TAXDRpF5+yfSKEbJwX5D0V650LrQ5MmupSc2JoELxvQKwsVKFg5i7D8hlgTx0RYwegBT//pFNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564322; c=relaxed/simple;
	bh=TYvuXGXn/k198uc+C09WL6m9KhLidhD+d1DCiamF4+c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g556xQ29I6Eh1QTrDEPhkqvfHqsDuVU7GXs33uO4h4KvCgB73qHkN2mfbrEAywU+lRGZjF53iSGIXIxut9JDDTMgks0C4BJgShosqe3SwOaKyrkspPY+7ir7WmQROjGw5cxyLD6n+19jdsKfWLYgDIJstoeVhdowWNhwHt1nNr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=G/dvRp84; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="G/dvRp84"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlhqSfUsJMn5XfigYSfHEEjBeSDqpm8X7w8/v8T/yHKsQrNytbZZRPo7J4pADNrTHAhwDvHyD0RAEPDIOIzoZNeGsWHS1loSXWQew2NpcnUJuPPaVvmtxNCb5bwTFTlmu698KTnI9Dw7Vc08ikC85qs17knra4VanEosQkK61pjemFXf8sX5PrwV4d+dPfvc3L6+XJqZvyaYbkGJyhjOHuwIxgZzLmyTX98K5a4nciKls/hL3nEY84O4Vk/vzWRVdbbWAXfWyGNdKKiGc1hrRWpYlOSG5XU4NVAaw2zmwylctUw+irQQMwypyIax2F01axFSnptgxsaC//q/5xyRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6xEE7fN9n7qHcsLAF2ADZY5gv4R2AnXqyxxUBpQ2qE=;
 b=Ey8C6bVVgJw1SInCDqAPGyUoszw7aKGH2DycsLXYKUJBmVfcGOd/+Q0X/bIyaUq9RwUJEVeYTBriIy/0Rc7zYzPCgUy/CrxeneEGxUOhqNyINtAM++nTEiDOLkKFzZAW5kB7FC1Amim8VY4cfg68kiTn80/JfR5MHdT1ihVGDcOXYVYLIVQxfZhxUYFPrl1R2ViORH6CWMRXGhr07/mGI4+uVUEgA+E6KJZGq4De7InOXfq/+dvSwNhXTTdUjcNBJUllNVgNB3s7dRVdlGoAhB/Jwls3tTQzCGJNjJUUlXJU1+1F3C8v771OQ2czfFmDNRvWs6uNfPNRDsWIc3NxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6xEE7fN9n7qHcsLAF2ADZY5gv4R2AnXqyxxUBpQ2qE=;
 b=G/dvRp84JGxS3vjslk9MPWT1MOpXsvfYhNWJH1zz4pxdofVSV6nJ6M8k8iCcRX6OuWdsdQHh+y/2dwHuW2R+A5xCHuGvMHWD5Oy7JuSn0wCNadRmh3htrcH+xsgmt844YBhLK0sblsOutRtHyXqAaVDw5Wp+Iq7la1RV2qxkGWlsVUo9fWLXdKObLavZN7SnomZT/mmHaJmycM6RK2MMbSC1RRCXBzSjY6jgVylv87SsBB9aX/7KCnGTQE3NOoPaCw+GbTKQSrECDFRGH+d1RcRDF1Lc5znYxNRJ66RvB/OdLzjvkYlOY9MdELrL5Zd0M+POdaevBBmUspsvzco+aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:58 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:58 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/18] thermal: intel: int340x: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:13 +0800
Message-Id: <20260709023048.599150-11-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709023048.599150-1-panchuang@vivo.com>
References: <20260709023048.599150-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e0d64f-c974-4206-d30e-08dedd623ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	Gla7IxQr2+ebbnW4PsRQMifAz7fJx9Bchqboyiff/IpEQe6TWIQ8dJY7p2VCEOIVvqZ19anrCyK4q4qyoeldE8r/Mmr3bgoLehO+CjC2stOFG5vsv3P72uCX3R43kpFedtlSqNhG5cQWjRPXB6OWhDIqEcSi4vZ7Lqa3PUmdES+NmKLI/lsdLJmULtRKV1Mopzcex+EVUiKGfWr5ne/n+rE9LI5x2KMaeGtsKmN+xD+2QjnTyuv1Jlr2Z6nqz8Aki671PZIbiFARvO7NjEcPdlxdUdHi+DPyFRfAxGmfIVDQVzfTF7nGRrPc+cqZPiiAR7rWy/I23PpOPl25IzMH0OI4dnBEc28bcrthiPz2Sz/6kurxGy4/7cSLp9AZx4jPVetsLcYOmoX1pwe1OuEZgfPC/DGlJ9g7MucnlUuNEXkjw45yri/0zdShq+E3kYVCO4YOTdkH2VvKBDBvFkCM66aWrDfCJK5b+CtOFBAhqkiigHoJ+uT3EVmGsOQ+LgaIjfAunBbqu/le/Chob7B1XJOROwOWzvqDiB5KkfAdis9Yh+BmcH1T3vBZzLd2r+OURdfuxUwHH34kw4wZgqRnaEneJ2y1gqlbrRmGDddlICYVraO4KfmwAgkap5PcM49GiyfX+mmR85/LPeaWTeAvqDFB1YgEgm0rXClseOD2QK5LGIpf5UMFxx5n9yiEQw4fshgwX5YOWJw2cTZoqRk9B0RXgZRLgeSATsdCrWdYWUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?58qowJbpURi5LwCRdp7yd8bHRUWnjjZIYQjUmxigrQelc5ySgFzV2kZvDWd2?=
 =?us-ascii?Q?B7qTBNwvVcZQqUSEngYoossR9wU8chR/P3zMpgItTwMd7rVuJsduHNpEKipK?=
 =?us-ascii?Q?xWcQx+RGHRXH3dns8Mt+PEVb/wG541uj38oUsJQ/fuyGPc4xXHvqY0Ko1YBH?=
 =?us-ascii?Q?hXJFtmjoL40sNLc+0s16SDTruIKGfZSIbMr0uw1139hIhiBYuLckZ0mbn/Bl?=
 =?us-ascii?Q?RDSBeVOC7GoIqcaGxFcFCCEhOLoHxWn7G1vWA5skgFhcYP+3WIJagGhcPSmt?=
 =?us-ascii?Q?nqetErkL7dmjPeJl15klWLhZD3M04B9eoMVvRZsz1PGN/Q49UI2VMzscBeyq?=
 =?us-ascii?Q?yluT5lujODe+JAF+h0veMppES0Y0hsfeiaHmPTKAPPa6O27j0reyUnV6XUBJ?=
 =?us-ascii?Q?jW0I/nURU0SKr/lrEQN/QU2/kUYani60UlkGKYjBk9hr7cb3D20o2PoqSJhu?=
 =?us-ascii?Q?MuxdhujZ8i8T4JXw1Wcst0bNz2fxI2e/r77SiepOK7SXLiTZRQRgRGXCxyS4?=
 =?us-ascii?Q?CJ0I3AkS/mKP6YV8Lhfq2+J05JSMrgCq5iBck6Xv1WrnPlhiYSbSp19UJ1Tm?=
 =?us-ascii?Q?cYInmRzqp+FDDDWlR+G8agWbiMUhdXbZzsaMXDQnxZthcMIuAhY7hbkZoD6S?=
 =?us-ascii?Q?qDaAb0CdHiurb5Rw3Az98GRNP6/nf5nDPhcwodHgJXSsWStr3M2WnDibrTPC?=
 =?us-ascii?Q?JpI1JxENHETI1MUfk7uFTa8pA7gs28rbfafqkNVWzTbMF+2LQxC+gAnEbXky?=
 =?us-ascii?Q?nzRZNXE+EQ0XFgzkCwyV5OOpmSFv99ZAPTs2LsJV6tkNlq9j9cy4FMDAuzdy?=
 =?us-ascii?Q?pI/EnSHhBZ1EdX7vVFje6wHRDecZcK038do3v2YD8BjrPEkWemTrWIybG+lz?=
 =?us-ascii?Q?8heaR+SLZ0JCQKgrs7q5cP4o6LB5ohxEIU6fJfhJKLeOkjwptBKpsT0M4qe5?=
 =?us-ascii?Q?8GyoqfznhdzT8GfMWbddk0qIwnpedCvSnAfMG6Qm5JWsZUZjkon+uHlqJCD/?=
 =?us-ascii?Q?9v07D7trYSWiq9ZAJlU1nsl0nyASYx/dbHy043+F+GWpoGuhhMmUiyZjZlEh?=
 =?us-ascii?Q?bsq7c5j3B9mncMiKrzVxKZgoRxU1ZZKob1HePPLWSDrKopJEt9zI0QIEL05f?=
 =?us-ascii?Q?F9KtMmANkHmr+fr2pz5Mvrou7Z0qFfv2AuFYCz7viAQF4r52ss4KpFsY28dD?=
 =?us-ascii?Q?cbkydTTNNdkcoeL73tE6B7qnc3pXDRqmuY+sYLK4fMuJ5W0GjNtjut+/s4ec?=
 =?us-ascii?Q?q0okJyyJrxEHAuKHLMhSqLlAnvbwqwBG0Pu8zMlxNd3GPufyaJOwNLxRZrX7?=
 =?us-ascii?Q?2ux+N9nAmV8DFbCb6hqihHRV81bRKkTfKSsxe2zrqOrSYuUC3zDHRSACAhSn?=
 =?us-ascii?Q?fy8cSu3xZ2KtAc9zzK2Pmw1M6Oi5Zkv/qN6/TuSoCu27mTPOSo1azkEWAhj1?=
 =?us-ascii?Q?gic3IgcFrmjeK7EmAwVNZasu66Ul6Lhw0/Pps59d5nTrU8SDl5waVTu/t1u+?=
 =?us-ascii?Q?YkDHn9efBtec0HEi2UyvHCJfn0jfhrZwWpzru9mfBjDk7fTwW64mXFIiOis5?=
 =?us-ascii?Q?Dws7IIyjOxHOtlS01NEI/ixsQ2HFTd9sxdHizVWZAYqDWlsM9ZNlgKKirwe5?=
 =?us-ascii?Q?Sv1SEwVjBeKH4GCBdsJ2OvrFiuyKkgTdz5MHLFl957PNpn9FxJvodq6W94Kw?=
 =?us-ascii?Q?0gRBvD6RHhxCvjaBsjvlzqOadeSQCIv9d5DXFSTbENnAyZ9cRH1w8Bk1ZBuA?=
 =?us-ascii?Q?DJNEWQQaPQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e0d64f-c974-4206-d30e-08dedd623ffa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:58.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIYGoVplNpXcr/O8Sa9R1S3zJMFMWMeANlumxEVi1rXd4aZZ9V1CjhL+f69D/MLL/TkBEy8XVu6mVgS3SC2kLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c  | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index c693d934103a..c5131423ec9b 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -308,10 +308,8 @@ static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci
 		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
 						proc_thermal_irq_thread_handler,
 						0, KBUILD_MODNAME, pci_info);
-		if (ret) {
-			dev_err(&pdev->dev, "Request IRQ %d failed\n", irq);
+		if (ret)
 			goto err_free_msi_vectors;
-		}
 
 		proc_thermal_msi_map[i] = irq;
 	}
@@ -394,10 +392,8 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
 						proc_thermal_irq_thread_handler, irq_flag,
 						KBUILD_MODNAME, pci_info);
-		if (ret) {
-			dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
+		if (ret)
 			goto err_ret_tzone;
-		}
 	}
 
 	ret = thermal_zone_device_enable(pci_info->tzone);
-- 
2.34.1

