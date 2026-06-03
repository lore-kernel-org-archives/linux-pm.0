Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A303FC5BE;
	Wed,  3 Jun 2026 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471501; cv=fail; b=qfouqPbKuc0VMR+u73V1rBB7xAJJgvEmhjUTC3QQaBOuqfXx/opTSs3LMGTj02mazhyzH3E8Kh84PDlpaSETcUWffw4cVvaySRKUnEbP/CU1MUeO7bk3p8Pqlzy/6FD/qnQCJkYjbegHFS3wFG1JSAehMLF/gxRZp6LbQB5wZog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471501; c=relaxed/simple;
	bh=okKDghy7l5/TxyU8n2SwRNWLVprOmqSxnRKbtTS7Ew8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JO7XjZm8rA+MYu9NqsqEqIJUpOmecPjUWJrdB9QCpkhKc9riXapuWvl1+fsNe2Ul7W/plSA4GChp5/8xBnMHJLZDj9MdSKNgU4gQw5a9k9SsAkfHW1foY7+/JUC31iU8bgoaKNEIKf5BfEBDTUX2Fj/ns4HHKPFNSS7UxdYftp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KZ8WpTz7; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KZ8WpTz7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDC3AkICWXw7S8zok4XErn5F2zXr+ow4ZseOsciPecnwSQlAiO/tETqbMC26gpsviqONGSEdOZwXU9daAsN7UnNS3C8ZoZvS4adwkfAmR4w+5jxkAFk5qjhs7S8GXMyChZXnjP0NLwK6auDr5E1k//BZcnFa3YMsgjGH+Z0Dh0wHk0PAASQmWEksC5RKnlM/rXDfjtprAsEHKaVQ55JsazjZh1krNbH2p21Jw12GsJHx+TMcplsBoJ0JeBDwAx1v7SREYQE2sK8O/KQ/BIkg4STEUqKxnBAqJftnofIwnoLhP+v9ZKlgL9ItwR/Z44SLI0c8hiyDhnQLKOOdaVf4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6j1EBGicFVCpsvycDD0RiGlOLhNSa1UulELD0cCDlE=;
 b=Kt4kgv7FQY0vS1IFHuPY1MZYcKEBHc0V2SSFQmpDBqAP9obYfI5xreXmMnFJajuZ9sLkuhytlTicEcHI/kAA0aL84xIPGAdfTF8lALVD4NDZQjZ+2cyxZ2sKxiYwkAPVXbVlm4kNfgJFPgqUhPV80RAC71CB0UL47OZYLOhQmbPzR/giyCChynGlxUy/Cx1BNNUl1wrkHrx0Iy2UMf9+LC4/grMsb08hAHDIJ7cfUeC48VOr1zE+dfvT3EwMA+MOvEjYCUyVD0Wzk0hGR0d/dPsDCl1YZZ+nkESTIKPNtNuiMkzy0msVak4bJHZEqCUP7UgU5Sukv1fRE2t/DmWRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6j1EBGicFVCpsvycDD0RiGlOLhNSa1UulELD0cCDlE=;
 b=KZ8WpTz7+rm5Y1bE3X3hL7ogPHrAZElONuNf7Af+9+55ZR9osMJGitB+vFzYFX9Hp9QDF2Oq8H8gGVxNPeMpo+V+z2xSU+LxhaOA1hAOrVX3uncTmHz/r1U1wlqm13SFQ7LUUFm2A4+oWY3QYQjj8N0vMHc+A+AVZKsxuNrpRUA=
Received: from BY3PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:39b::31)
 by DS4PPFBEE2AA13E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:24:56 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1a) by BY3PR05CA0056.outlook.office365.com
 (2603:10b6:a03:39b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 07:24:56 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 02:24:49 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 02:24:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 3 Jun 2026 02:24:49 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6537OeDl730260;
	Wed, 3 Jun 2026 02:24:46 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <zhongqiu.han@oss.qualcomm.com>, <praneeth@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v5 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
Date: Wed, 3 Jun 2026 12:54:38 +0530
Message-ID: <20260603072438.1199527-2-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603072438.1199527-1-a-kaur@ti.com>
References: <20260603072438.1199527-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS4PPFBEE2AA13E:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a3faa0-ed9b-4d2a-686b-08dec141369b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VopYcNl/M5m4xlrKJv2w1JkMRARaDrodYShGvbUIgh30TmHvJIYOzheRKqdgBXH3W3qhus5dqG+1xteyHWVMA29xnNpmMEV37+7gbmTxKI+7aViEM1JqYBLqcULh0+FNeC7ie2jc8g+BpizBYd0ayHHNTyobDB0xv/mavB3NmRlRZsL9Xu0FMimCwCpx/4DIE5qFjriQPWnoA3K5VLrH3HGT3oQWBFjIKLJHTcEsWhinxiNdBKcDN6SuxYi1ohP8v5S+n2hWu9XvAF5S40N54OY2mrj+EEY6c+AfacRiGvrJl4tHIVy+gHrO66NCz8IkJIBOOcfd5zjSGk+hRWLZXvo3lh+xA7okReRTDTbWNTaj8/O0au170Gm1Oe1I5lhVTHBao+UlL6ZTWJbG4/IabC8PGFbMNoyNpV8MxIJciYDXTc4JxTAwwHmfi7qu9BqML2JF++TWYQ67zuplatOH+Yy+qlj8IC6c6pco98Vj2D9UyYuwVGaBjEc/xVwHtHDEVHnLkxwx+eKZCKbb9Ancjw373h/Hxn6Laj++hgFH2n/gTPp95ut7jC4TWngcGa/YGVojjAypUPiTEsm3yoK1E4rAMAPhOKb0/XK5H44YVBwCE0E4v1aiSXNHGSccPekEYDhDp4EDKYn8ZR2eviEfrNGw78xWk3l8CKkyWr0XfEWaJqmsqdYW5VN6xODACkXSkQLb6M0PcP+FsfAdBZn7dZ4dTKZUPcOCPV3J2Jt4t60=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bmERiI4awViAoAmMTE/jbW1EzzMxCv+IaYCO21niyTXuILHJg8czpZIpZlKdaOJJ+1N8lKBebpGp472bxIrcvVeaSEJolD+3nNHRMFGsi8483+ABFvcdXBaxd5Sf3bgzQuFXz/UtJUIdZvOVu9bJNoPJo/ZtWQfpCiCrJb/EBtn60K/kguBcZikp00h6CXyHDuaQlUhHx+Y9Q353BInBdpYrc518m1tmhhLDaIjPV9nxbn96LfI8WPKgBW630XkM08778OLokn9Y+8/6rppMrQXqs60786pm/n7u9bSW5lCGL04dGdc7GZuYSMmBqaU9XcZ6YHzvzF9Zdv92YlsHfaoYeLK046M3Af3NVR15oPkU/BDOhA3nnCB0QRgXl2cdYwNWj7D35W+8UouRYktoeJbF2qHBfaFIG314eIjQ7rHhfxr1DDwZOaaRxhEhY6v4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:24:56.5024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a3faa0-ed9b-4d2a-686b-08dec141369b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFBEE2AA13E

On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
device before soc_device_match() can return valid revision
information. If ti-cpufreq probes before k3-socinfo,
soc_device_match() returns NULL, leading to incorrect CPU frequency
scaling behavior.

Add a needs_k3_socinfo flag to ti_cpufreq_soc_data (similar to
the existing multi_regulator pattern) to defer probe when k3-socinfo
hasn't registered the SoC device yet.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index a01abc1622eb..f2c8d9e3a1b5 100644
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
@@ -443,6 +448,11 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 		goto done;
 	}

+	/* Defer if k3-socinfo hasn't registered the SoC device yet */
+	if (opp_data->soc_data->needs_k3_socinfo)
+		return dev_err_probe(opp_data->cpu_dev, -EPROBE_DEFER,
+				     "SoC device not registered by k3-socinfo\n");
+
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
 			  &revision);
 	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
--
2.34.1

