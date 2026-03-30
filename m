Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFE2D97B7;
	Mon, 30 Mar 2026 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872111; cv=fail; b=Mvo3xp+pu6YLoGU9+Y0WTPFFLov4XjeS3Vz00bY/tagPq8EElHjpoySjYprjif5ewbQDMK42KalZFMinNwJTGyDmXYUAT9qQ1FqKPb+7K943b4B92TcAvDjdCEJWHKd38PUFmMTdqzNaRY/LRZCIJgNwoCHJguhlElA94Kn/Mrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872111; c=relaxed/simple;
	bh=cfmdnrS/oAx/T48/yu4KVqn9Gn+Z/fw7ZFNnyt7C4oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VT7bkxXekVFBQg7I/Z7W5JU3D8ycutAE0aWXBbv4M5xIkMumJQBB1RztMnm/2N0YcVdYSMJSDfFQ5HyccS7IaTQo924F/a7VsIlneEn1d5r2aiVQHz/Gxt0sVylbC5vUxLiAhdMuJau2U84aKI6kF4DpUA1wGAa6zPRMcqU1ZUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k/i+kjaR; arc=fail smtp.client-ip=40.93.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k/i+kjaR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSnLLYXqCLAlpl4z7yx6SHRMKLcFAMA6Rdv+6EbM77RTqKK9pWpGIYYFbmtavpotrUAk+jiaMqbOx6SUk6D4W/MdL/wdtr5GGWeRPNqNd82EU2S7e9k2mHLZCFOqpOgd9IKEGtdnODYGT4o8Ppt+qsmOGDczPz+wpqSM5JgeS7eNLwvtVBwXilEystI5xtwSj4RIwmZoIcUJiuEbtF8bOzEJ0oqU2mkuEPhJMqZ3txfQwgsWANPx0CPguWL74szISUYGZKRWAAAyGJ2yGtxhPLwjcYZLfkWGdxwaTWrVe1ZGfZuJS8DulSD40F3+nLERv84Kln27BEwchlSg6c0tOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyGUdfru8BhZNF6lOXOajU5NYmjRGLG+nMElz4Hnr4Q=;
 b=NQnsMrHjWsLTeK83f86RKvIJuPKgH85Kfeo/Kfb3CsckgVCqiXcu+bLKRwclZl+6dfYKd9AvP7CUi2PJVKf/Hb+LAJP8ocdJVH8zWt6s7iTwE8qKABm5I6MoVJi9ppB6xQCS3HomucwZi6TfXuJrKydZR8EG3SC15rFbxIupPTTzhV+mGMMcmVGSI87pqoCbG35P4JulTEJDhKryvTUfIPqrN6gKnJAGJ29DmmXTwtEFj9Pn7KStC6qu4F9eWuVdoLuuXsxwIrUExbE9yd+y4uQ+1Yl9LNgC25G5yPWrmRGX+L1YE5LXv8hvRs7OssfDAh5PTSPocu4ZKKPBtsmPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyGUdfru8BhZNF6lOXOajU5NYmjRGLG+nMElz4Hnr4Q=;
 b=k/i+kjaRGYPaVAKlv5FhqNIJzoSPKToBJys5y9RvyfDgTmTnFJJhI70aEKv0+FvbQIxrSxLW2DaYKNWp09fviwS7rLINd91d4lMwNYVac4wRPtpZzSSXrE/mEzSI3p7ojjEknGlDSK5KYX2+gyyjbvWlTpKBgdQ8jKnsvk8rZVQ=
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by PH7PR10MB6281.namprd10.prod.outlook.com (2603:10b6:510:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:01:47 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::32) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 12:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 12:01:47 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:01:44 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:01:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:01:44 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62UC18tH242506;
	Mon, 30 Mar 2026 07:01:39 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH 5/5] cpufreq: ti: Add device link to k3-socinfo
Date: Mon, 30 Mar 2026 17:31:05 +0530
Message-ID: <20260330120105.2985200-6-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330120105.2985200-1-a-kaur@ti.com>
References: <20260330120105.2985200-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR10MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a57cb02-ffa2-409b-5ab4-08de8e541e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	2FZqYSZ+07za4BEh0autsA/UcOQSMsXMrx6xY/1fSJy+sY1XtHh7PDIBeXtKoBh5t+kYt1XSLchvd8ENOhvXTB0yMT+7M6wOxjhnaqPNADuj6BEbT4q4p0XISo9OdyiMZhybpkfcdHJT3EpJ9viUWdkjJypJ2hmL6hffn52Chocpl1XG7DGHBvf1vcPo9ufiLYZh94s1QY81p7+98FgV/xBmNc8f53upgEughyfHTVVYwDGx5HNffV+6U5qZVpRN7QdysbiULHRaUDC18JT13apYG3SBT6R4nYQkRlQ8H2vG21DZDpyyGx0DiGwsk9IppFTnh0lQXMV/fqoqDQYKCWgW6CPDlpN07HqiuJrbwqLjHZYN43KevzSIeMxaf6xwAbvM4xYmQp8YLpjNy2an6QbDVqVKtbQlZl/E4X2zxCv77JcWDjHG7DICdGlN4dORp+ig/ot6FDYiM4e2t9xOZm1sRvu/RYCh4VF9W2hOXhSc5D3V2xrENfRNucDZhxknV5+gXyi0zmHb9HhWu8MxRjYoMoNrgrAe02CqkHNnUhiMI0Ze6X5M8udqKYPQDvfU5fmNY4+ohIP53lLxoVAYQhVI6bnfeGd80ikNUwaPnCNLp34Cl7JZvgo0t9SNKc3apIfVQ7f4jrT7Cnph1V/Vqe2NsziMU5EkJO0IvKEx06saAddV8cmBfMh1u1HM/YL85KFYWnZa2qJ1JQvOv35f1K72yHIiwfxpo85OPIz+LKA9uTZiadeGOTU7pNPZWZpzStAh5dx30mnAjgYzCbNc/2EtI9rnzTvQ/UhOxmHO/UkVRelXqJE3Hyd3xr2vwixw
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W8V15dIAEUGF2F/Yn/dMPHaD+v2gvGSlzXJIplJcU5tBbpDPMIcLIMLpUK3Xz5qZ24PRQgCQ+c7Ma6feniDGJjmzj3rUlrp0FLUYNwn7iWFq/ZHufHsjfH65N+ul6ROvXrV6nPREZMpK4iXG5+OrNqK0tHF5yhu4DgXPhMRltz+l2SXb2YVqNxO6vy+sHwdToQGbO6YaBbSHis49iCOFeSjbhfL09oGhZgXZNROobdGZWolwNMenyfVv5bV04cgAM69GJta+iAWGh8loKMdiZkzcfANpbaWwR+jDVl9LfEg8DOj8vtKf8I37/oXnY1efDM8LxnKWfXHIhfDOh1Xc9rJJTAxya+Q0aUjoo4tiM2ggQsgUIWwFSm3RH3vmVmhERNVAr2LGkxuEjezHJEQ6HFK66NCnY68KtcqbDdE203Xx4+yCRDbcn9H3H5RQpABJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:01:47.1024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a57cb02-ffa2-409b-5ab4-08de8e541e71
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6281

Create explicit device link when OPP table has ti,soc-info property.
Prevents unbinding k3-socinfo while ti-cpufreq is using it.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 88f7912ef6a8..60c34b0da0c5 100644
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
@@ -600,6 +639,14 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void ti_cpufreq_remove(struct platform_device *pdev)
+{
+	struct ti_cpufreq_data *opp_data = platform_get_drvdata(pdev);
+
+	if (opp_data && opp_data->soc_link)
+		device_link_del(opp_data->soc_link);
+}
+
 static int __init ti_cpufreq_init(void)
 {
 	const struct of_device_id *match;
@@ -616,6 +663,7 @@ module_init(ti_cpufreq_init);
 
 static struct platform_driver ti_cpufreq_driver = {
 	.probe = ti_cpufreq_probe,
+	.remove = ti_cpufreq_remove,
 	.driver = {
 		.name = "ti-cpufreq",
 	},
-- 
2.34.1

