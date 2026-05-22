Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB7349CE9;
	Fri, 22 May 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465935; cv=fail; b=Me+mRFc0QR1EUoWF42ns99rNncA5MRyeZk8VCFSxlH5xwRyJC2dmNfsdZEcGZ+DjXlAhLiF8Pgtg5K9wrh8kAZ6voQwsusNUUjLTKF81I4Bi+YQcqw4pqnjRdehsgMDGryqXL6w/JhBKhxLmEzDp/+odWSwGqRXQbQF31WCYEsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465935; c=relaxed/simple;
	bh=pOJ7Euij+hQ7DThGI0nSuI5zYo3AYd7h07xMKP/WOMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tC7a+Ed6BL6ZXBqwPp8dPdJBUyhcHtkc1NL/XjkFTyOIFt6tWNKQBoVchDzyZPtCmPhGEULDqk0jxZhGExbKkMGv1HvnswRN6+HF+E/RuoRMLjHBG/dmCd0oabzF+m9eBx1R8NfpGH/fEdQoV2iBW0yo4KX9CBOq2rh6D+ysrcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VRmIdq8H; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VRmIdq8H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfQdfIcSfKpGAxfzI8DQ1k6LdJPB1G3tbuN/OIUVTw5ypUGfFp1NlkQe24hmzJTjCtqfwKCSqH/ffDW6tAGqmKQOayAdF4Q3InW+YweXGFAsei+xJZWN30QfBmyLNpDc5ysXQvtTbEvuTFOzWIEJe+Gv1JDQYLOLXnx2hC5vr+SWqREZcxIbhkH9yEt/jG4FHM2euT+W1J5zuPjUr6hYC6iJqPH8EsHLxw3R56MFjRaYFK6zLlG8eKbw4eRtf7gb1+orYJ9D4+GX3zh05cR/ZRk9xeLK3yqyx6bi3YQMvKs9qgAGVMysfWRgmxISnIIlMQ7Q9ehQLb+tJ0rNef4rHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHIQeo10w53cisGaQ/DGM2zNjioaxgp2GdHG4DN8XrY=;
 b=DhkWkaGEhdGPxxrEch95NCG3tZ1TjcPvfxNvaGU/NlWVIVBdnCM85QTd5o9yovj8e0WTCcqpcLk0J0nu6u9SrzpAUyegex/gvq5CG8fKDHw0hfewtKsraKeDeWR4i7UzAM7DnkD7iDR7oKWak5iEO7PJhAvdWD2/jYYKA/HWSKapi/CiRxbphwvoCSoW6lq78oA2Qi1Ygy4OH19AO/C6af+lFDIejv7ve8uFp8ly9LnjFYB6y6MXhNB1L/DAQLmV5TuerqVYJoKB+O03NTdNvCItGlK5pW7wKbh8ucCp9YIULTGtdcR2k6f+v9RS23EsBVRTS3eA9WLJZj4IC/8WMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHIQeo10w53cisGaQ/DGM2zNjioaxgp2GdHG4DN8XrY=;
 b=VRmIdq8HSju+3vlYgoCcWiFKydlqPnMpm2OTRCQdYyqDX0lYVR4ACZ1V84aYh0YMn9pka9kd6vHWA7xFTPo/rcebgQkA47I6JCfXS42BYkHNpLHhMlshAIUbMVjrHkhDqwZwFFN7XWal9TTOf6jjPrIvqhQaJCWtvx626Ni2XG8Ru7TNdK2OrDNFhZaTURaM2nsXD/0txmRQZUEmPjBtwF2M2GRVpedQYZ56c60BQnLmE9rDHCssx4Ld6KIUJmLe5N4Xz1t+5PlV+jxjNrPdDyupDl90jZlJoN9ICJP0oBorId+XCz+PqT+mrkDDsi1h6GQkvd+ymSG+WCkWVsuTVw==
Received: from BL1PR13CA0340.namprd13.prod.outlook.com (2603:10b6:208:2c6::15)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 16:03:27 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::4) by BL1PR13CA0340.outlook.office365.com
 (2603:10b6:208:2c6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.9 via Frontend Transport; Fri, 22
 May 2026 16:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 16:03:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 22 May
 2026 09:03:06 -0700
Received: from moonraker.home (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 22 May
 2026 09:03:05 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Ulf Hansson <ulfh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>
Subject: [PATCH] pmdomain: tegra: Add support for multi-socket platforms
Date: Fri, 22 May 2026 17:02:51 +0100
Message-ID: <20260522160251.76862-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c734b67-7427-4aa5-fd6f-08deb81ba8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zCitlJaHQFINUi8ECe+/CZtFXo500HTz2CtLzD31fXIBp/fz5bHtExBS+gtzQMP5DLTwoflRBpCSy6S3bd8FQBJu2Y5XhxhX0G/33pIZt2mM3bms/mk9BKvA6uHiYzp5A6CLem0gdrl4fPyKRP2ebCBJ7WNGaMp2sWmUT70Fp2wsg9hRNglci6/iCnld+ytdbnemYqKPjRmU3c4IHzb6VWRf2m7sKMPEzDe4F3M/4Q4V8g+0DN2EZ7SHmM5FDw+RcIXWIiXCnw8oAeVRvwx2uC3LM3JGj+XGb2z6HqHLKVy+Rj1P6V9qugz68cAJfXKZhbKTr4VPLosrkd7YQm6+q/ZvuqRCmkAuxvixfMHBV3R11FZe4r9piPD2HpU64Uo3yyBHvAToMBPlaEkQqsfpB9NCusT3c730DK8yMSzacJsmU4Zp5E9eaUCfSyr958rKJKl0oF/oK1Z9GVYQem0c11x9Znrv5fMesBA6D3vygEZk/7om/WhEAI5P3vz4SWX6SpLvB1icamvjUtSu4RCr0uqU9TaaUtOIKuE0rNT0fjQjQBN+pnoit2XPl+NL5Vj2UlyTum9fhe3qaeJDk2YJkt6PDCb2Dk1/BfyX9RT/NhdpBN7TsfL0bLLV5ZsAd1iz/g/U2DWXqhuLmrEyJuTEpeTu6atWt/LRL0geYUkTsxflVIw07jImA12QgpNnzPI3PSJq8Eo3FEEMWiWWNh3fHj+wmR91u81w5NbY1MI+ads=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0U4Vf22FshTx76Fgy7uPcQWwPP7/inO8cQwmkVM5IMSnRo+BdDzd9P+v19vB+bgoFnz93mSsHb8VNlJZnTA2+k0dLs7PItm4UHhhZOqshlNaHILWdte+eBRd5nZb2Ua6zUgvUPFrayOhc9+ofkARlXWDeztJYpzBHspeejs4+tv8OByF+KidTOCBB8AmCPdN4pJMEsIpJVvWeegPRfh5r7PYLGh9ouVDA6SA7tHjGgf6j23m3PjTgAOYGrPfAV8VppK/rjlH0s3JQhKNv09UBigC7EBFaWYIYkglYGBqKH9uOXO7t2aU1amVHQ4j4fYZ91suWkO7xBBnEcBtHeYAtR/XSdZh9gFwE0E6pvA3G+Sr7D6C/w1ZVec4xIXJ58s7FEZvvOcH3iSWITh0zpTra4RdXyUOyNBySx6lC39ajL/0p24TiD9Q5lfG0FUzHAYp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:03:26.4553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c734b67-7427-4aa5-fd6f-08deb81ba8a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882

On multi-socket platforms each socket has its own BPMP that is
registered with the kernel. For such platforms append the NUMA ID for
each socket to the BPMP powergate name to ensure there is a unique name
for each power-domain. Note that we only append the NUMA ID for
powergates that return a valid name because an invalid name indicates
that the powergate ID is not supported.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pmdomain/tegra/powergate-bpmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
index 8cde4f384846..1faaa92a5b02 100644
--- a/drivers/pmdomain/tegra/powergate-bpmp.c
+++ b/drivers/pmdomain/tegra/powergate-bpmp.c
@@ -137,6 +137,11 @@ static char *tegra_bpmp_powergate_get_name(struct tegra_bpmp *bpmp,
 	if (err < 0 || msg.rx.ret < 0)
 		return NULL;
 
+	if (response.get_name.name[0] != '\0' &&
+	    dev_to_node(bpmp->dev) != NUMA_NO_NODE)
+		return kasprintf(GFP_KERNEL, "%s.%d", response.get_name.name,
+				 dev_to_node(bpmp->dev));
+
 	return kstrdup(response.get_name.name, GFP_KERNEL);
 }
 
-- 
2.43.0

