Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC939E191;
	Wed, 18 Mar 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827450; cv=fail; b=F5i6taxs0dxAxmsV6wccz2d81bhhfhYgwEG/w1gimklk968YkC5NVb2d33qWWRdCjPrQ8n0Hx8zfsgejGRaPFYcMM1T7r5FA6Lj10N2O0KL4UJbVS1zi66DPqBUUE0ii3L81qtM1pdBeX8zIdG/oanZ9gD74i+aTggP4yNDJWBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827450; c=relaxed/simple;
	bh=oGlctU1FFKr/O6U6sI+DXUfeVfIOoybeOre6gDPTSWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rX6Y6rMOz17V+zZjjV9fC4QeMbH/ZmV+AESqA+UuRV9DGNj4wiTkhx5lpe5QLJNmnNtFvIvv/eLfg5YJ/CoOh/c8fByStnAwOLMRhfxq6+CvLbnGUJSldbuUoWyz4Omm9CnTHdvJJ7trluZvsr6xdtiEKGukeXahx5ii3707ZHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ufK7hwbh; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ufK7hwbh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou1Q5wQcL0cjFsopKyXQ99zuvF76kwsYd9SxWnICByYpvzXCrAjhbbofBpvy9waURAIwRTiVo0Hm+qZ4zM90nhr/0osz2A72HDB1mjEXcvCMYzzTvFaaKkaQRKkld+SaYK5ZsGW1GuIO5fzecXLeg0XWN01qPw824ixp3VJEIQarMBDWGJMZ6YDy7xVT+WwA4by1laToJm77EH8RIGq//mGoQPIsy58hWh555w2Sv8lwgdK56GXuuL2B09q8fd1alAdVm9cj8/nEiaxZ4xI47QYzXEeK88ukUQX/ZVL7M/GOAhVNe+btHSoThnWGYSH0q2HODBMb6eO3IUCGPj3Rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDQd83oGBxmPEzNX0/4pJgYceWXd4uZ+q/2mPlmKYNk=;
 b=a9oEH43TkjwFJ6wPyjH1WJfhGK70ybZWkU6Uu8XfGfM/eVyFIKKwD/4qgZp1ggZWc8DGgvps/MX2Hn3xOuRy/rmhWn3v26Q0rdC+SC/WeIuCsj0UoOiUJ7UEf+fcMgIGkk0aIh+FfSP8l1YKT/xxU5mH5tPaaP/MZeU6o37XeRF4AVY2soJhkcOUoqdI6OfibNM8rO8Y19QzDxq55MzZZQDlOA++XPOrz9MC48JOFrZhoaGNMX1nftv4y9G0ky6PR9lFdG1qXZx4J9MPOMcwhxTnk0mzZ3Z4hWQe6kjjfcBEkoC+AgIrcgVzoVUij0DIzidA0XCVSmlb/RVgsMPe4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDQd83oGBxmPEzNX0/4pJgYceWXd4uZ+q/2mPlmKYNk=;
 b=ufK7hwbhpR453XJGeB+k8Lh9SrOcL2+b+KGdib/BF2R+erKZ5HpX6rNROx8XRzdDgG8z0R25wY1QHLm+pVka58JxrKpJw8fjVAHe7uTiUMHuZsD9qy/Oz0STogJ7byqAYsBQpbcvhYcIXwCKcf+nMam6M2+yox33gWXOvPeS3OFA4BXPQQaNb0JRPg9xedur+RCg76L3kvGYait9r8g4MxOiU+b22ik8BRO+Hf2gNO7C8JAZm2fyMzH0LrQJOAeqdAsZ7DzXuMNPWp6ds9Oa1fVtMtRfoiZCSSdgepF1YyhA29HrosWd0rUzxxVkRk7gNX+cbL2jEEcgHZGmNbHMFw==
Received: from BLAPR03CA0056.namprd03.prod.outlook.com (2603:10b6:208:32d::31)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:50:37 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::18) by BLAPR03CA0056.outlook.office365.com
 (2603:10b6:208:32d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 09:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Wed, 18 Mar 2026 09:50:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 02:50:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 02:50:21 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 02:50:18 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: CPPC: Check cpc_read() return values consistently
Date: Wed, 18 Mar 2026 15:20:05 +0530
Message-ID: <20260318095005.2437960-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b6ff61-f8d9-4dfc-7eff-08de84d3cee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fN+kwWh7/3BBBWq4/dmdw3aK8xtxzGP8ZZ4Gc4KCObM7n+YUsn6XP62/JdLCy8lN8IMuo8xnC6y8V7agaBwQqGj4uiWfOdKOJUJ6QBpWjsocke2ZzcaF+jLwXPEmEiiGIThKfXjW/7eeVWHWgmhuXnAFcQ9klnnlZt/TelYDbeseNarkVqMczQP044mwfZsZwZgE+Jk++OYyONd4jcPQjNoeZPBXRqhk9fMGkj1DaywgrDPDhRnJeKnhLbwWs/Z2z5W3eCAwQY5v8ey7lwUdZ9IUOafEonR5+vgzwcy7O7FnoCvvrbawNPuI16oWIUzwlyLagmgecL1ZIWakRaAzl9cUHlrg4DUEQzqhOW42JJhjIrX61bmur6YeE0Qw3q4TDDmLM9NI6N602vxL9w4aOVFDPzCNcUoDveDYYs3JOPvbsNLtaeslRq00rdkDHye1DFC6x5OpGKZTtKMpr6NWeee5X7G7k9HmudihSlBtKQDYXm2O4EFYorccS7H82gx2dQdkQxaDtskQA1BeHtadPlTviDEOuWDK1QG2Z59n1YfE4kS+4MX+hTLu6egxHIcnaYyKlK2uaD9aYF/2FyYkXZi8fChXEFMS3sFg7Fa4jBDwWp7xnyI8HIib1URqSm2gTOjNlpeht1vcLx7oh0j3xbdl24KFDMce3v+MSJoFVvnDh91TuUGvwOntFnkkTWJpOHzL1tb5l87aBao8LlbBFhrWpdRvNSslr4y0GjO6CCzjAwAoVjIYR4F7n/UpKqxos/X9lxi688TeHYizh1dlfg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4XTKGr21SlCESGQAF8ZyYz5oY+mtLWmsShhsGnNNUvKDVTQDKn79G/R9gJPKSL6SK5SNajqOS/qbpcJKkJy+44WjsbynNLCIJC7mhK6nVO2wOrjH2Iaxh/IRkkhTJCEzum4B7f2EP2DEb9aLLycSWtkCXw6l+EA7JW2Ue6zL6eoO1iDiG/G+BrrfPZYEnuKBcDBH9/8eJxw7pK1jpvsTNdqVwE6zRCNh6gJpe5hRtf5I/GK48WGKlRr+nQ2Bh9CgpGWa3o3CHZpqb5q9NMRyzXWMUzFKM9V+sjdilXfc3rd0lTwQ4tMSN2DssMTU5Q0DGjX+EBXEhpJFOiJOMGQZs6fX+yECxR6kb7QOylek006bJkLS1H12Yc70tshTxQIlTvGTlw6Z3ZKz6CPzyqSlPBf0b9l8UB0t9YjsAEzKq/0vZqOfMXx7oQMMDPCtX8ze
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:50:37.5559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b6ff61-f8d9-4dfc-7eff-08de84d3cee7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459

Callers of cpc_read() ignore its return value, which can lead
to using uninitialized or stale values when the read fails.

Fix this by consistently checking cpc_read() return values in
cppc_get_perf_caps(), cppc_get_perf_ctrs(), and cppc_get_perf().

Depends-on: https://lore.kernel.org/lkml/20260206142658.72583-2-sumitg@nvidia.com/

Link: https://lore.kernel.org/lkml/48bdf87e-39f1-402f-a7dc-1a0e1e7a819d@nvidia.com/
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 99 +++++++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 5ad922eb937a..053fc6765a59 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1394,45 +1394,66 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		}
 	}
 
-	cpc_read(cpunum, highest_reg, &high);
+	ret = cpc_read(cpunum, highest_reg, &high);
+	if (ret)
+		goto out_err;
 	perf_caps->highest_perf = high;
 
-	cpc_read(cpunum, lowest_reg, &low);
+	ret = cpc_read(cpunum, lowest_reg, &low);
+	if (ret)
+		goto out_err;
 	perf_caps->lowest_perf = low;
 
-	cpc_read(cpunum, nominal_reg, &nom);
+	ret = cpc_read(cpunum, nominal_reg, &nom);
+	if (ret)
+		goto out_err;
 	perf_caps->nominal_perf = nom;
 
 	/*
 	 * If reference perf register is not supported then we should
 	 * use the nominal perf value
 	 */
-	if (CPC_SUPPORTED(reference_reg))
-		cpc_read(cpunum, reference_reg, &ref);
-	else
+	if (CPC_SUPPORTED(reference_reg)) {
+		ret = cpc_read(cpunum, reference_reg, &ref);
+		if (ret)
+			goto out_err;
+	} else {
 		ref = nom;
+	}
 	perf_caps->reference_perf = ref;
 
 	if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||
 	    IS_NULL_REG(&guaranteed_reg->cpc_entry.reg)) {
 		perf_caps->guaranteed_perf = 0;
 	} else {
-		cpc_read(cpunum, guaranteed_reg, &guaranteed);
+		ret = cpc_read(cpunum, guaranteed_reg, &guaranteed);
+		if (ret)
+			goto out_err;
 		perf_caps->guaranteed_perf = guaranteed;
 	}
 
-	cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
+	ret = cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
+	if (ret)
+		goto out_err;
 	perf_caps->lowest_nonlinear_perf = min_nonlinear;
 
-	if (!high || !low || !nom || !ref || !min_nonlinear)
+	if (!high || !low || !nom || !ref || !min_nonlinear) {
 		ret = -EFAULT;
+		goto out_err;
+	}
 
 	/* Read optional lowest and nominal frequencies if present */
-	if (CPC_SUPPORTED(low_freq_reg))
-		cpc_read(cpunum, low_freq_reg, &low_f);
+	if (CPC_SUPPORTED(low_freq_reg)) {
+		ret = cpc_read(cpunum, low_freq_reg, &low_f);
+		if (ret)
+			goto out_err;
+	}
 
-	if (CPC_SUPPORTED(nom_freq_reg))
-		cpc_read(cpunum, nom_freq_reg, &nom_f);
+	if (CPC_SUPPORTED(nom_freq_reg)) {
+		ret = cpc_read(cpunum, nom_freq_reg, &nom_f);
+		if (ret)
+			goto out_err;
+	}
 
 	perf_caps->lowest_freq = low_f;
 	perf_caps->nominal_freq = nom_f;
@@ -1526,16 +1547,25 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	cpc_read(cpunum, delivered_reg, &delivered);
-	cpc_read(cpunum, reference_reg, &reference);
+	ret = cpc_read(cpunum, delivered_reg, &delivered);
+	if (ret)
+		goto out_err;
+
+	ret = cpc_read(cpunum, reference_reg, &reference);
+	if (ret)
+		goto out_err;
+
 	/*
 	 * Per spec, if ctr_wrap_time optional register is unsupported, then the
 	 * performance counters are assumed to never wrap during the lifetime of
 	 * platform
 	 */
 	ctr_wrap_time = (u64)(~((u64)0));
-	if (CPC_SUPPORTED(ctr_wrap_reg))
-		cpc_read(cpunum, ctr_wrap_reg, &ctr_wrap_time);
+	if (CPC_SUPPORTED(ctr_wrap_reg)) {
+		ret = cpc_read(cpunum, ctr_wrap_reg, &ctr_wrap_time);
+		if (ret)
+			goto out_err;
+	}
 
 	if (!delivered || !reference) {
 		ret = -EFAULT;
@@ -1811,24 +1841,39 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	}
 
 	/* Read optional elements if present */
-	if (CPC_SUPPORTED(max_perf_reg))
-		cpc_read(cpu, max_perf_reg, &max);
+	if (CPC_SUPPORTED(max_perf_reg)) {
+		ret = cpc_read(cpu, max_perf_reg, &max);
+		if (ret)
+			goto out_err;
+	}
 	perf_ctrls->max_perf = max;
 
-	if (CPC_SUPPORTED(min_perf_reg))
-		cpc_read(cpu, min_perf_reg, &min);
+	if (CPC_SUPPORTED(min_perf_reg)) {
+		ret = cpc_read(cpu, min_perf_reg, &min);
+		if (ret)
+			goto out_err;
+	}
 	perf_ctrls->min_perf = min;
 
-	if (CPC_SUPPORTED(desired_perf_reg))
-		cpc_read(cpu, desired_perf_reg, &desired_perf);
+	if (CPC_SUPPORTED(desired_perf_reg)) {
+		ret = cpc_read(cpu, desired_perf_reg, &desired_perf);
+		if (ret)
+			goto out_err;
+	}
 	perf_ctrls->desired_perf = desired_perf;
 
-	if (CPC_SUPPORTED(energy_perf_reg))
-		cpc_read(cpu, energy_perf_reg, &energy_perf);
+	if (CPC_SUPPORTED(energy_perf_reg)) {
+		ret = cpc_read(cpu, energy_perf_reg, &energy_perf);
+		if (ret)
+			goto out_err;
+	}
 	perf_ctrls->energy_perf = energy_perf;
 
-	if (CPC_SUPPORTED(auto_sel_reg))
-		cpc_read(cpu, auto_sel_reg, &auto_sel);
+	if (CPC_SUPPORTED(auto_sel_reg)) {
+		ret = cpc_read(cpu, auto_sel_reg, &auto_sel);
+		if (ret)
+			goto out_err;
+	}
 	perf_ctrls->auto_sel = (bool)auto_sel;
 
 out_err:
-- 
2.34.1

