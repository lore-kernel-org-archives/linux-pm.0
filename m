Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5A3F65EA;
	Wed,  1 Apr 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040880; cv=fail; b=seTPtu0VfSs5oNzNHO7m4bSEappjBIcSTl6MF+O+CXG5TTXdVDBxu0nZYDkECdlnzVdNSlOVYsbKMmkrcBRx0lf+LxBouL6SSeekkT4a4X1z2otdr3t+5HWywCYK3vO42iClopV1yMWLxA2v6zSLgpgNpPSWXp+j2JfgTH5khuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040880; c=relaxed/simple;
	bh=fpiQcApbZv+mfD0ZlpCEY6fLaeIS9mGmvQDacm378O8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGHpWo8vIwVaDj3waNPIn3P5WcbsjPIJajtZ6v8+X/ar0PL/4Lta4lv8LDY9OFKbspuONwZFzcVTjCgwI7jgYipp63Ot12i+WeipHy+NErEvF1AZNo+TsVl9ZAIJe6k1s1P2cEtxO5bWsjm8hWtOho+KTWLU/QJxxGNFGlNHwn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e0cR38A6; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e0cR38A6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjsKU8p9SAFQKVdRRolF4Z266zPNBCJCBV1En0ZDnN97vbWRhgJ8T2g4IR0UuMGo9sk7bp+6P3iTRyk6Vsc2nok4V6KXsKi9s6ONlpuhrNHMJIn4BsnbVmnYbPY4dL7l4p5c8PDNqP4K81U5FrWHou6szxHek4RFu8zo99yP5Fv5jScrwrZhraVMmca+p6jwz59v33B3fwNf/jMxwwAO/VfgX2RY8pWV7X5URqej0QqLRbQ72I7/nIyEsTcnozOeWJeKwhZvUg1wG22uwdb1k3+SF3Z97Q+/EIzwvjjCg4K+y/1WUkD4/+gorn+SkjwVLnmO5D+E5kqugqcE4u+GeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppq4ZA53pzs1FnikM7y8pAQWPIDw5+pedfUPJpo1TI8=;
 b=EdYJnsrKBEqk4nNunOMHa/VAXoWtGHXI61FEHkpR7u7xFFbN/4U6K9wOF+n03nkggJgkJtoz5AaB7KzaV4VG94UibdZE+UJ6PsYvBLXAzBBqJ//bQ6kXzbmskYzn8YC+C/Xbsua0caVwCouq1bCB/nFLk1PvK4d71D8okVPGvLAGeNs+zkytom0Hfz6thqdWIjaGq0yRUr4hAJxtXbjmc/MWk+511rDL/hxoZz2VrPDFJD8gvd+f5BGMOf6oXtgfjeCpvCZVdNCeXWCoROA1TPik34ej6BNFk63bKCNyRnwC9FP6evIjiesI+P748YTFk8Vl26ZOpvk33IML/+fD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppq4ZA53pzs1FnikM7y8pAQWPIDw5+pedfUPJpo1TI8=;
 b=e0cR38A6NB6Ol5h969P7ED1lhhinlcGo7MypdixAgm1tuBaYqaEbYZEzWetiawV7cc6v3Z6qk6eKI/JE1AIkRRgIfGKxHTpIFROtp1xKHzIALVGxWei7kfBiA6eqyW5Yi2zDl0KjcqfknZynVKFknscxS+W2EqNKG465OQ3ZMOA=
Received: from BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8)
 by CH3PR10MB7703.namprd10.prod.outlook.com (2603:10b6:610:1a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:54:34 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::f8) by BL1PR13CA0003.outlook.office365.com
 (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Wed,
 1 Apr 2026 10:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:54:34 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:33 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:54:33 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631As6KP4132409;
	Wed, 1 Apr 2026 05:54:28 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <krzk@kernel.org>, <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v2 3/6] cpufreq: ti: Add device link to k3-socinfo
Date: Wed, 1 Apr 2026 16:24:01 +0530
Message-ID: <20260401105404.1194717-4-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401105404.1194717-1-a-kaur@ti.com>
References: <20260401105404.1194717-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CH3PR10MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: f541022d-f114-4b7e-4f39-08de8fdd0f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|22082099003|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info:
	DyldzcDPmCBeBHJC0dhFp569MKG2h1wbI7zbHmjib8cAQRoEGrslGp3mkfkxiuwLnpe4tMKJQtS7YW3LXDEildg8T8j5i3HFDFTtU0aH3VPB9us3w4h5NdNY11JspnkIjBaB/yPWRLLqQpc3dCvhKFvyvCu5NfUExG/otO21pE61rsjGlaislL5fl/R7fgWHlnRdrbgeqDUqOPMfGu+YM4rcihi+FtmhEpNxWPVs58sKup/4wuh0A36xM2Yq+Yg4vE+C0uykDUaK1BZ+h7zrCPko06OStjwACb6KoWq5A0tN9tL3Uu8jtmFOultfCVaw1YT051Ku10OhPiE5M8HjGqfgUrzsVeGecbjkR+mBK9IyLLDmT94a/js68MEy5+QEY+3LJZIYfLTq6l5EF7/0UoMHUTGsD+CkHHuLbmwzU670kFP+s8y7cuDKAIyjvjfUKkWJzbJPZZr5efmMOqt/bCuvMIQfN6Zv1Wkg7bPEmkyiFcJPiMrJJ/2WDE4lk2spH3WIXEMtjYiSulvpsnMkM4wYQvjOPpf+qQ37vMPLgsxT6ghCyfQWkckacpyflS1yM1bvkQEKVQOQb++0n7kXfQg98z0a/bZ7+hcB995ns3vIb8z0CY0KTG5QUis4I2qBRvJjY2EVAtmsFZ43sRadfxmW1YpZqxFG7E9fSuVlmVFjc4Gys4azsxD6F6uDaw1LE8k2RHhpaOiEiJclJ1c4dVywo3EG6eOiPh+Fe9ptSXEwo0Q9EJV9lppYo91BmSur5ZCMXJfvfAGhKLadNOFsuqXzOWS0RGJ3LU35ccAxq55T/R3dRNpfWLZRyhXdQAV2
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JhYh9iRny89BUfdsQcrn4lIQ6LxqTLXjvcpDhnLOGBoIrSjw/l0k0z6EIcHyg0XuMrHoPHinDzUJU0dachJDKoSHi3ywrSD1tQDIN8Z3Ihy+PU1TymU2CYDSfkR+ZegjFLFx/kA6FxvsDBwrnIyF4eqIR3F2dYD7j24WyJ7uCaKNbeKOZGkVuH/QuoiwBTbBeRQ+kW/w+Q1BeIKChVzeEcpy11Qb0eK7XPvEBMt/3FKqfCImgH0z432H1XJj8tsOar1VjoxZ78IT+CiLr3D59CDDuZ2/AMYTe9jdngeBObTHkVXI8AbV+dpLN/Sjq2B3BmF+IJzfjbR6+EloyffuLMpWriZCcLlsnVP8jlRTlPb+7aM2Zb408KZY89IM8p/mkAOg+DsNkJVC0GPodLkUFsMEpZnxTFvzS2Y93+XkxzwqAZHHEyjcIswRmF34gaMf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:54:34.1945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f541022d-f114-4b7e-4f39-08de8fdd0f77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7703

Create explicit device link from CPU device to k3-socinfo when the OPP
table specifies ti,soc-info property. This prevents unbinding k3-socinfo
while ti-cpufreq is using it for SoC revision detection.
This complements the EPROBE_DEFER handling that ensures initial probe
ordering.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 88f7912ef6a8..7bd45b367b36 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
@@ -111,6 +112,7 @@ struct ti_cpufreq_data {
 	struct device_node *opp_node;
 	struct regmap *syscon;
 	const struct ti_cpufreq_soc_data *soc_data;
+	struct device_link *soc_link;
 };
 
 static unsigned long amx3_efuse_xlate(struct ti_cpufreq_data *opp_data,
@@ -542,6 +544,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	opp_data->soc_data = match->data;
+	platform_set_drvdata(pdev, opp_data);
 
 	opp_data->cpu_dev = get_cpu_device(0);
 	if (!opp_data->cpu_dev) {
@@ -560,6 +563,42 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail_put_node;
 
+	/* Create device link to k3-socinfo if specified in DT */
+	if (opp_data->soc_data == &am625_soc_data ||
+	    opp_data->soc_data == &am62a7_soc_data ||
+	    opp_data->soc_data == &am62l3_soc_data ||
+	    opp_data->soc_data == &am62p5_soc_data) {
+		struct device_node *socinfo_np;
+
+		socinfo_np = of_parse_phandle(opp_data->opp_node, "ti,soc-info", 0);
+		if (socinfo_np) {
+			struct platform_device *socinfo_pdev;
+			struct device_link *link;
+
+			socinfo_pdev = of_find_device_by_node(socinfo_np);
+			of_node_put(socinfo_np);
+
+			if (!socinfo_pdev) {
+				ret = -EPROBE_DEFER;
+				goto fail_put_node;
+			}
+
+			if (!socinfo_pdev->dev.driver) {
+				put_device(&socinfo_pdev->dev);
+				ret = -EPROBE_DEFER;
+				goto fail_put_node;
+			}
+
+			link = device_link_add(opp_data->cpu_dev,
+					       &socinfo_pdev->dev,
+					       DL_FLAG_STATELESS);
+			if (link)
+				opp_data->soc_link = link;
+
+			put_device(&socinfo_pdev->dev);
+		}
+	}
+
 	/*
 	 * OPPs determine whether or not they are supported based on
 	 * two metrics:
@@ -600,6 +639,18 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void ti_cpufreq_remove(struct platform_device *pdev)
+{
+	struct ti_cpufreq_data *opp_data = platform_get_drvdata(pdev);
+
+	/*
+	 * Device link is automatically removed with DL_FLAG_AUTOREMOVE_CONSUMER,
+	 * but explicitly delete it for safety.
+	 */
+	if (opp_data && opp_data->soc_link)
+		device_link_del(opp_data->soc_link);
+}
+
 static int __init ti_cpufreq_init(void)
 {
 	const struct of_device_id *match;
@@ -616,6 +667,7 @@ module_init(ti_cpufreq_init);
 
 static struct platform_driver ti_cpufreq_driver = {
 	.probe = ti_cpufreq_probe,
+	.remove = ti_cpufreq_remove,
 	.driver = {
 		.name = "ti-cpufreq",
 	},
-- 
2.34.1

