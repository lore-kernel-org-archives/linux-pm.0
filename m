Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4AD39E18F;
	Thu, 28 May 2026 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959160; cv=fail; b=LcpRbZ47vvSuqwd92TJHsUKqi9EO8g7JJz8ugxmdraw/6V7JjqWpFletfoFfDk0o1KbDMBRMdle13ZgNvi4DkMddFP2Hj23+AGi5jR3JaL6W7UMjLCo1VTZtT654cVSscxwyP8I4hiL1UsHPLljgj+1+4G7aV+R3uoW8Wudmdrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959160; c=relaxed/simple;
	bh=l7tYl5S5m22mH7gWlLBGUk0sZWVKQjUuQbJO4CPv4PI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0+TEX/UcLgdxuB7uxVX13RqvlEdJnKyXT4gz+VaXg2g4taBFqpwCOgO5LelMI9W0T38ZoKJjPxTB+reXy0qOvf5A7B7YEHVT09bVnm2jqQnae2iOhMz0v594oNSOWYGkrWKMc7PCgRLmUWPn2vt/U9gjllkjBUhRV9c1P3IFv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rbqfRAwW; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rbqfRAwW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StDG+y24Xq7G4WRsk4f4vLCQ9W846YgM/5y65Lx6QJAPLZ/DRrrpUAjqtRDrvOhgGJ2i2XJ9i/Vs/lRu+FpCXi5Z6XX4R1jGN9px0nrOzcmw0g25muMjXILEpV+JnwpjBg4d1EdZCLyOKbKicmSOPPFduAnte24eRgl3msay1+iE14eBh+vcDXKQCnf9udifnNmM4EHu1CxaNPocJ1i080y2niLERSBkskfW3SUD4NSURiDDRbkqhx8JZGuE9fH88Gm/lm3WLOT4ydY7MPEq6ezyWJUoFeJN1szpEtztFjWMPcQWY1RuqJ9mkZ+tFnbYt1WLocX/oUXvGxC7d1790w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rw8KQaEIqUuoUVk3RkBiiqW7nqYAk7a/FflwTp/jwmk=;
 b=q7BUdHVIIduPm8TryS60xezzOUZv/f9sCeVTBUZbuDB+PDmFqEIjgZWqNIRCJKVoymRNMTBG04d9xtkt6l+A4xof+fXJhyxJFQBC1JKhuBUchqdF25e5QKNTg0V4sZsVgcmN+0OUU3glOGNzm13MvjBx4MNl2EJxGG80KShd/dPXdEf/bFjTDvh/x+DNW51FDmtsDlSlRFnX+A0KDDJuQIot9D5Y9P73J15o/IFzo+CMdP7o5whvM8BldOlm6vZmtIHg/V2z2hmHJgzqjXU/nFPAKkUvEkIq1Ti6OsTjHWz+XyjSdBovgemjkiKeQQo3eB5FQAYajTEAyDboM1kmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw8KQaEIqUuoUVk3RkBiiqW7nqYAk7a/FflwTp/jwmk=;
 b=rbqfRAwWxleC1maM7UQdPs2xvxVGb+Egcc8wJ1gLrREAf6W92az1x5D/kFBZ9dqi77aOH9W8lJuEUUPVNBwAGbh6jaltSK9x6Toxb8YksWs2tjbEBIN2/uwqfKMuMPpK6JUNPX1+iKi4CNYWsn+cS0FDNDLpLxdupjT0PBkOYCk=
Received: from BN9PR03CA0185.namprd03.prod.outlook.com (2603:10b6:408:f9::10)
 by PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 09:05:56 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::19) by BN9PR03CA0185.outlook.office365.com
 (2603:10b6:408:f9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 09:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 09:05:53 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 04:05:21 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 04:05:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 28 May 2026 04:05:21 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64S95C5V1741887;
	Thu, 28 May 2026 04:05:18 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <zhongqiu.han@oss.qualcomm.com>, <praneeth@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v4 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
Date: Thu, 28 May 2026 14:35:10 +0530
Message-ID: <20260528090510.829513-2-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528090510.829513-1-a-kaur@ti.com>
References: <20260528090510.829513-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef70891-2e3b-413e-2bc9-08debc985267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	GEJjWF3pjqn24sUYjyPacmd556959cxm7cqeifAaj4xTvy2JH3IVx8qUOcpwZ5wnoQtqY/odZfwOjinQu+R5wz/sOkTQxdmK/RZSCjaSlTVj2vIcOxukNy51Iot+YrNqFy/XWlMOKPCAOPdjlyKzp/OfAB09p6mI7L5inVCNDkRjS6PcgPDNsDHALB4ykkcZRrCPBFWTE8dwZ0NIsjuw1V1ZD9F6W2tU78X/KfX8hKTF53rl8kR3zg9s7Cg1HzVMldNwaR1HCcCjShVko2Em2K7OjoYRaD6r+/UzXGTSIjKZUZUMdL5F7dIuU7xnspFSnbuw/58fdZ9Svf9YzcaGGgGMfPEaf5psjQ89H8R3EkmxbB7jB+YtKQcAgeLQlZDSOCdUjc9o/bp4pvF96q+eMDlxUUwVdfKditoZAwL6aB1rVLTOIac3C2y0glD7AbcU8dUAn0AR2L7/ExWjLy2R/l8KWemQsO743AvK6JquZkzW6kONw7Ma2l8Ce4D+aXUZWxkeyYXdKTSbij6/LjyWWm3nEQ/lTZlzlwQbEOv4NJU9LVoKeTFxTolAgA/jdEiRlYQdycLQbudOyKtSI/Nm3Z+wzsNNdCDhdLnkzX1LdYxcAgzYp0cY4tFDz98W3aO6uL2vX/TSnFwbQZMLr7G+7gj/ebzJYxmA7ANsbkksP77lvNHIAIVzQE3S81P5EHU+iCQRabvCBXwtL3BDJp1uTz/zNyu+hz8MFqEKYMdb3Mk=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CUB0hRA6U8d19jZYgnuY2P0wBpJmPQapKGOq17unvKNZCj4V8Xml+AQIA34Pmc+kBnhTi1g+15qV+9LHljO4y67Lo5GO0fXx8zz6CfQztfIZkprl6AyN/08k/cBrtzxUhIxi1NI2c6tTbH9feq5IOxHcpjXkndAmV8bcNPQK1WI+oAI2gbMEXKeMoex64UJ++fFyAxefw7+ChuShwZfRyPPoBbkOtzv5WZ9/6kOv46ZpC9CpUaRQ3MYHABGzm7Fk6aEInGj23AlCV9E/WEhaREUJNXrTfxoxhh8FoHV6Ih4tCgzZ8XdpJHd3mawsvKFAObFmJoNKkfwMtC7ICpC1JG7fBs2dqlxQCmokMeABxNynfcy6TADaCdgbe5apUBvsU0qmmaaGJgXpcODeBE6cKsKmu4rV1LTlqY9iIX/AfYAthKVU7N16lB3kwvSvGgkC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:05:53.5487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef70891-2e3b-413e-2bc9-08debc985267
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632

On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
device before soc_device_match() can return valid revision
information. If ti-cpufreq probes before k3-socinfo,
soc_device_match() returns NULL, leading to incorrect CPU frequency
scaling behavior.
Defer probe when k3-socinfo hasn't registered the SoC device yet.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index a01abc1622eb..8219751da175 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -99,6 +99,7 @@ struct ti_cpufreq_soc_data {
 	unsigned long efuse_shift;
 	unsigned long rev_offset;
 	bool multi_regulator;
+	bool needs_k3_socinfo;
 /* Backward compatibility hack: Might have missing syscon */
 #define TI_QUIRK_SYSCON_MAY_BE_MISSING	0x1
 /* Backward compatibility hack: new syscon size is 1 register wide */
@@ -347,6 +348,7 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
 	.multi_regulator = false,
+	.needs_k3_socinfo = true,
 	.quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
 };
 
@@ -356,6 +358,7 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
 	.multi_regulator = false,
+	.needs_k3_socinfo = true,
 };
 
 static struct ti_cpufreq_soc_data am62l3_soc_data = {
@@ -364,6 +367,7 @@ static struct ti_cpufreq_soc_data am62l3_soc_data = {
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
 	.multi_regulator = false,
+	.needs_k3_socinfo = true,
 };
 
 static struct ti_cpufreq_soc_data am62p5_soc_data = {
@@ -372,6 +376,7 @@ static struct ti_cpufreq_soc_data am62p5_soc_data = {
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
 	.multi_regulator = false,
+	.needs_k3_socinfo = true,
 };
 
 /**
@@ -443,6 +448,12 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 		goto done;
 	}

+	/* Defer if k3-socinfo hasn't registered the SoC device yet */
+	if (opp_data->soc_data->needs_k3_socinfo) {
+		dev_dbg(opp_data->cpu_dev,
+			"SoC info not ready yet, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
+
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
 			  &revision);
 	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
-- 
2.34.1

