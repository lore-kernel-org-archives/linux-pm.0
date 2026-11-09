Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255239;
	b=Ouc56RPBaglx4C6OThkxpAX86lymDYrHcfEaWSPqyRcuvhUeZxF+XcDxapsZMgJNQ/kx
	 LIPk88kbyHepU6OWWaB7XoOLEGS9vg3eyyE5MgopdeSp4J9e/+lOci3MBlg16pddvq8xX
	 RX7e6786aTEdTnPKj6wERzFvLtLmOUXWI33WwfwFzeD5nL1Ra3xPrmhOcwHbnvm/IZqYe
	 dpA+x3FTDVU1LiDPcgIuCCWo4j1L1dhEPXm6kRYkX/2od7/4XoTLDpEcV+rWq+p7Mfa8S
	 yDWe2m1jx5Sk9vAmBlWyJdsEgGXjHE3zjM/+4p6KyhjaQmpF8voJc3pjyRnxERnILpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255239;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fosjWAx4LwF0Gcs+y1FCI6GVyFDGOkEGG3hMKDHokPg=;
	b=yjSfm+IAHjPX/3ZLeTEOB699RE0+7sS2qcxBKqc8oWHMRt0zcPuLJUE6zcic03CottdL
	 k/RQJahp9XAPoTE9BhY9+VzvmCuUQs6qEs9iQE6THDJWVlU1glYGKaJ3ApiloWnJGKTbI
	 mHFHJhXpBt337jA2GfMxQUEaiG2ouayljfsM6wmj7LcfohlrWCKc7AYSXjsr1DjL1hqWq
	 WFf4YOS2XkpBYt4wpccYTrtO7tAHoOtyVCwAg5/LXLa8N7bXyLIFfWPZcoGlZ20mqzbxs
	 lPZFieqasqllq80dmyeGinD5DgqfGYOfuhq/w31y1/vMfboRmBXqxfSEB78pktVIx9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="qB+qD5/m";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.44
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF482606A321;
	Mon,  9 Nov 2026 20:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF482606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qB+qD5/m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrKhohjKrvNqD7yf3IOH2+XCJh4DYeUdW/VnZX084PMjLPVKpIhSYY9nMlbjmy3f5X0KJXJ5GStnN0NVIWjfdcVaELnk3rV+ZEP8WeOg9Ht8/i5m6ACB3jOIlUdb7GZtGmayLTgQNav0s4AySb1KoLGmZywhoIe8E3xkcPcxg9zVan2wZlWvGoU8xdfcniKiOG2Uv4XV3gJz8/2wGyEOP7uLKW6WhISTKHXUhsRnSCUMBvlhq0TlDvn9ThDroSvI/0bV0qkpRG0Vl2h1o/S6Xtn3/0FnzmUdwKjmozZEc1HnpBktBJd3TgXBzvuJJAJbQbe67IZgUjdJvLVtnDaBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fosjWAx4LwF0Gcs+y1FCI6GVyFDGOkEGG3hMKDHokPg=;
 b=h2LxGrEBke10U7sE640L0EL46V0hpsyj226yJAP35SmDg7p7ScVZBIicHQxsrQTjBN3D/8ndpXGk9Lt6xM4hKbYIzulcMptjoW8DvMX4MOGA0ely6kZxnta8ZlsgmYnpLwzicvdf4H44QJ0gCXKCZf+Z4U3NyF1op9at7yGRFUVlvsGp4qjDGfe+TXFiSO6CKTCSy0+EjJUjq24uN52f7f4c8HJh/qouwpjvt3jOw1bytRleljkOlDtxW40A+ctf+lqesVKtZcy4UcPICZuIr5S6xoNuqA4EQ1qM4hU65XN0Q8l8XhIgkKUMxUM4TZs8uxAfEveOC2cLn+JUOCvi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fosjWAx4LwF0Gcs+y1FCI6GVyFDGOkEGG3hMKDHokPg=;
 b=qB+qD5/mwjet9Tzp9HKGi52DT3VVc1v+fSt9O9q2b+Gl/aQY1lIvK5wjhNLZQsmJHcO+mAYkVOTpq7zHpWUcuLIyDP0v7Hj13dTnirdV9qAnFpIvm3pYMZ9iu6cF42GVJpHOUVNwoVTCOkiDiL2H9ur4tgRISh3kmgW4V2xHWL+EFZ6roLMd8zvoxMiEls9dqePqBx3qTUkFsDkLcTHbInSWS6Etnawxp1nIE1kJyzrKfTuCiMVNkcY6LG5nA/gOmlpTU3zL5yBVjlpk/lo/XPIGzK6o7kjsIyvoqZYSwiNlvC0P+ZEaEjLbRncu35klbMBmpHDZJgnrWUn0sg0Ixw==
Received: from MW4PR03CA0163.namprd03.prod.outlook.com (2603:10b6:303:8d::18)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 20:13:53 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::a7) by MW4PR03CA0163.outlook.office365.com
 (2603:10b6:303:8d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 20:13:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 20:13:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 12:13:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 12:13:25 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 12:13:19 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v10 3/3] cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
Date: Tue, 10 Nov 2026 01:43:17 +0530
Message-ID: <20261109195400.3600561-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109195400.3600561-1-sumitg@nvidia.com>
References: <20261109195400.3600561-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 090e8516-585b-4814-a585-08df3e9df9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|7416014|22082099003|18002099003|6133799003|10067099003|921020|261028144727099003|11063799006|56012099006|261102123227099003|261022075727099003|261022105027099003|261022113327099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	x/OLHWtZEZPf619zaLRpZIv9kHUPtKYhSjJpmdFbdxoQ29z+js5i6ucOKtjF6stKhqCH3VVBT4qwXevnX22Q71qDNvOGuWuVakhjBIOwV7HYkGsS7KrVUD0CVZFqQtmGIa/tQUj7caXHQM38QQUL0ARmPJn+xh6ZER/r300gc6E/9dA0M02XcC40EWiVFCh7vfuVdTvB/U1cBGOD3oFcufPida26UYY8XCh2+/MrwE+mVWJ0MN7Z0zdhqA2JwTlJoGl0eDAq4MWtZ4zPOtbLR3Lib3smkRKj+Tn4JMaDfiE7zXSFfEl6BaCyAdJK0f6i90gNEp9FuF8bGo7KztwY78zYLiZigRr0KhGzn8nN+SPx31m3OmZ5hLuHYbl1/nTXi36XZEgCHbAxe5boU7ttCc6+6p8mFClAsHIxF8BDQmuakxL5SCm0z+vuRDW+Pbb9tneF9grsOhzg7drm7dqMui3rqGRSR4Y64QvCztg49KwmFzQ3qUO1sN7jFChVgj2xGuW03bWU7O6I1lwxiWzH41FiVgLby89G+5rMRMhHtNtqpALEyZvBCH9M/UPeTLjcTye+MMwTAtEX63aZKNCH07vlr0SmBICuqswwLfiI4LkHV6FStJngnaYb8zeH3/+pAs3ZvPMazQN9u3x8LL8WeDdhj+ppbj5nIZPad2kqegsy1Brc9BlBEPhxGa162hj9i7kva+9ihtqH5RJCBUj89l0DnzSPRSvUioBCo2WTUwDZr6QxGRA/iOrdZtes53a5
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(921020)(261028144727099003)(11063799006)(56012099006)(261102123227099003)(261022075727099003)(261022105027099003)(261022113327099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y4JctDZPr/MMdxw1RSKqEoNUjuBGiOd2HrO85TvR2Ua5jikv14dYCbY0egI3XP3F/qwtOuaw6xOE5gU5HgqEjqgZUPP4t6bwYqtzOqbKPaCSN/IlSUXuzFCHy77MCHfNUy24n4DWBVfXCZhLjdbaAnYbR8cffsdLOp6btqFn5eBaQ6nHVsq0k1yiCjUg9cR+rZpKozgA0nNWBRxoRPjSiaXhHVX49yd7Wc2R9OLU2CUhd1qyHRhkD0krWRCf+RwZ1VQGDRfzLp0sYyE0zROBc2zAVGHmt+4/UF4N8eTmd2e3e2eii7CFOc8nmv6Frr+W41E6oBJKwmrB+sCudYsvU4gtK/TeNVJ/CV5qL6daKJVnKEaqT0JcQeEHdUAJHxnI9H2rZt9DBo84/oUe4eAhKGJBkQ9I6Af23/sJwFk06UNxdRnzS2jkSEOypVqSB++N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 20:13:53.3145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e8516-585b-4814-a585-08df3e9df9f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820

Boost is the performance range above nominal, so lowering the OSPM
Nominal Performance enlarges the boost range and drops the non-boost
ceiling. Keep the policy limits consistent with the register.

Add cppc_cpufreq_effective_nominal(), which returns the OSPM Nominal
Performance when set and the platform nominal otherwise. Use it for the
non-boost ceiling in set_boost(), and to update the policy limits when
ospm_nominal_freq is written.

The cpufreq core caps scaling_max_freq with a per-policy QoS request,
boost_freq_req, that it sets to cpuinfo.max_freq and refreshes only when
boost is toggled. A write to ospm_nominal_freq changes cpuinfo.max_freq
without toggling boost, so cppc_cpufreq_update_nominal_limits() updates
the request itself, rather than leaving scaling_max_freq at the old
nominal.

When boost is enabled the ceiling is highest_perf, not the nominal, so
the update is skipped. set_boost() applies the new nominal when boost is
turned off.

A platform with highest_perf == nominal_perf has no boost range at boot.
Lowering the OSPM nominal from sysfs can create one. The core, however,
adds its boost FREQ_QOS_MAX request only at policy setup, and only if
boost_supported is already set. Set boost_supported in init() when the
OSPM register is supported and highest_perf > lowest_perf. Boost can
then be enabled after the nominal is lowered.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  4 ++
 drivers/cpufreq/cppc_cpufreq.c                | 72 ++++++++++++++++++-
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 6af7fa86e44c..d219fc27a0c9 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -362,6 +362,10 @@ Description:	OSPM Nominal Performance (kHz)
 		Write a value in kHz, between the frequencies corresponding to
 		Lowest Performance and Nominal Performance.
 
+		While boost is disabled, cpuinfo_max_freq is set to this value
+		and scaling_max_freq cannot go above it. While boost is
+		enabled, cpuinfo_max_freq is the Highest Performance frequency.
+
 		The register cannot be read back, so a read returns the last
 		value written, rounded to a performance level. It returns
 		"<unset>" before the first write. Reads and writes fail with
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 662397526433..7cac31de7325 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -915,6 +915,29 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 }
 
+/*
+ * Return the non-boost performance ceiling. This is the OSPM Nominal
+ * Performance the driver last requested, or the platform-reported Nominal
+ * Performance if none was requested.
+ *
+ * The register is write-only, so the requested value comes from the
+ * software-tracked state rather than from hardware.
+ */
+static u32 cppc_cpufreq_effective_nominal(struct cpufreq_policy *policy)
+{
+	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 ospm_nominal;
+
+	ospm_nominal = st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_REQUESTED];
+
+	/* U64_MAX means OSPM has not selected a nominal level. */
+	if (ospm_nominal == U64_MAX)
+		return cpu_data->perf_caps.nominal_perf;
+
+	return (u32)ospm_nominal;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -974,9 +997,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
-	 * is supported.
+	 * is supported. A writable OSPM Nominal Performance register can also
+	 * open a boost range at runtime by lowering the nominal, so assume
+	 * boost is supported in that case too, letting the core register its
+	 * QoS request up front.
 	 */
-	if (caps->highest_perf > caps->nominal_perf)
+	if (caps->highest_perf > caps->nominal_perf ||
+	    (caps->highest_perf > caps->lowest_perf &&
+	     cppc_ospm_nominal_perf_supported(cpu)))
 		policy->boost_supported = true;
 
 	/*
@@ -1280,11 +1308,12 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u32 nominal = cppc_cpufreq_effective_nominal(policy);
 
 	if (state)
 		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
+		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, nominal);
 
 	return 0;
 }
@@ -1494,6 +1523,41 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
 CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
 			 cppc_set_perf_limited)
 
+/*
+ * While boost is disabled, the nominal is the ceiling. Set cpuinfo.max_freq to
+ * it and update the core's boost_freq_req to match. The core only syncs
+ * boost_freq_req when boost is enabled or disabled, so a plain nominal change
+ * must update it here. Without that, raising the nominal again would leave the
+ * stale request capping the policy.
+ *
+ * Refresh the limits directly rather than leave it to the QoS notifier, which
+ * only schedules the update, so the new ceiling is in place once the write
+ * returns. The sysfs store path holds policy->rwsem, which the refresh needs.
+ */
+static void cppc_cpufreq_update_nominal_limits(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u32 nominal;
+	int ret;
+
+	if (policy->boost_enabled)
+		return;
+
+	nominal = cppc_cpufreq_effective_nominal(policy);
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(&cpu_data->perf_caps,
+						    nominal);
+
+	if (freq_qos_request_active(&policy->boost_freq_req)) {
+		ret = freq_qos_update_request(&policy->boost_freq_req,
+					      policy->cpuinfo.max_freq);
+		if (ret < 0)
+			pr_debug("Failed to update boost limit on CPU%u (%d)\n",
+				 policy->cpu, ret);
+	}
+
+	refresh_frequency_limits(policy);
+}
+
 static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
 {
 	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
@@ -1552,6 +1616,8 @@ static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
 	st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_FIRMWARE] =
 		cpu_data->perf_caps.nominal_perf;
 
+	cppc_cpufreq_update_nominal_limits(policy);
+
 	return count;
 }
 
-- 
2.34.1

