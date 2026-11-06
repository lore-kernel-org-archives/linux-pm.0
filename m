Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993710;
	b=tXaP3mZJY6/TUWZGLZfxzNIhnVzZogacdGhyhXHUhSQEHZyc0kmB+f+X5D4eaTUpkyKj
	 DG+rmVRm1Mk/f0tRXxq8QxvdlLQCAFZPN7HXC9s9TmtBwbW0jzzOFx8YYZE7BZAPsoWAB
	 UNx4zzRmojUzXw9HKBrhLMpqnTzLEdLyd0AVAtuheNkXs+JnS8CeCzR15TXVHyIyIALZU
	 z/ZnLQltEKBSYadq0Rby2EA+qFj1768WSOI6i+kTsG0IsCW7/t2Eua3uyyNSGmUXiClZV
	 RyknI1Z4CV9Sf2Fme+jKe6KsEC6jqf5nhqT2VjthWgM5JNlYMcA0/m1kGXcB6dVqSuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993710;
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
	b=v6k43OFUYmI/wml0aRxQ0KMVMyVkQunE284zV2SYbHX5sd9D+NFa8wmnheZSCiNaBWzD
	 oKmHKxph3HlpnI7ROztFKFHMMh0OMMYrH7A9+1Xc0KULe6g43F54bDS6/cnrevkx0se3G
	 DJcc35B8zKl2lWsXNe4Mqn2WJN+N2/mG6wrxS0yZ7yjbjywFsi0Ef2yB7cH0QbI0es+Vv
	 C08zR3ZTi0GbwRapeqHXMW5gWpudSiosw8130pv5YLwARH8ELggGDr7MnIaPm9hsLLofu
	 y4kB6RV7yJ6JUtVkgAFiwRIsD4x/PjSFgu58OyYloremOyqomMcN2WHBBVpN/ryvE7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g9kHSQhf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220C606D802;
	Fri,  6 Nov 2026 19:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E220C606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g9kHSQhf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWNjw82D4ElPsWj4ag6zGg8mE5/C+OHUSE7xFycUSrVpCIon3RN7BwYEf3J8pyD5Ex3MHRWTGYpoZFbscvFS1GshEq9voCLF/JB2YntjNV8bm6nb1/vjkXziPCqusPGSn8ycAb0VNE6gTJloKrWIPrTFr6L3CV5iLWoUNKxwS1dqXpyx+4INnFivZp8+Q7mH58wIr72zMMT5WDdvTn6vQff1MUFFadWWY5nDUZZSkauUW6ddI/AqcNDvi4upDw1fGmmj2R0qTBafogSHW7iSuJkvGS2QquWJd713fdXTRSebZyIE00CRGaL9QF+ArZNnr9Y+CZsop+Zl6BNSY2UBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fosjWAx4LwF0Gcs+y1FCI6GVyFDGOkEGG3hMKDHokPg=;
 b=uXMU6OJDLzBJNxVloqJBr4q+hCu9yWNV4aQ0ZxAtIKK7gTS0Qbc478wAw4/LOad5DG3hh2u0Py4Rb+L2B94c6pjrybMrROplkO4sZb7D3seNCu+ckwbHaAqdcMY8Yn4/JZI+qIW2WFAXdRtt30egjEf/Er+W7g9xiHGeQ/Qt5jL2Vwyy7EpWNRyXXnGfHrylLrtmdgOOVY9EMHrS8k5JZPl3CFzKy13he8GKMznhopAxGguxLclFBp1moKd6VzKQ4y1j3Lk0qh5IM2mVXgRdaoYGOl5x1utRMWyF4W373spV3hPJYOEpilNXinsrdVr6qWUxesq1sLGdXmWtm8FFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fosjWAx4LwF0Gcs+y1FCI6GVyFDGOkEGG3hMKDHokPg=;
 b=g9kHSQhfFgLLet5ALELy8B2ZZ5gDwRJ9Av06iX7ZE3mE3UXsyukEkcJWTtUJd0rlW3HoO5bHZus3vsBhcth12shGAzQOxNr8Mxzwva3biryfdRPIZXgVszYwrJHaivyhqThhepbFKXHj1VXE9JqjP68CNkWZW2a0RFlBAwaPFzB2h8YBR2D9wRhiCWX7ThpgmTTuS3x5NDhsqwlU/utZv9vr5pcCQ5HqJaV6Ar5KIY1A6AoPwUMOn9OMnpQh7J1lUXmnWSSk/bV4WnKtaVoC1uLt4h+rJNAc3g0KlnqL/ZGmHYEGHdHZKgN6bqAem42qpZ4w396GPLx3U+Gyog+eSw==
Received: from CH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::16)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 19:35:05 +0000
Received: from BN5PEPF0004698C.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::71) by CH0P220CA0024.outlook.office365.com
 (2603:10b6:610:ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 19:35:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN5PEPF0004698C.mail.protection.outlook.com (10.167.245.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 19:35:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 11:34:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:34:48 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 11:34:42 -0800
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
Subject: [PATCH v9 8/8] cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
Date: Sat, 7 Nov 2026 01:03:04 +0530
Message-ID: <20261106193304.3347374-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106193304.3347374-1-sumitg@nvidia.com>
References: <20261106193304.3347374-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698C:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b7c197-6936-4ef2-b93b-08df3c3d0e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|921020|11063799006|56012099006|261021123027099003|261021121427099003|261022075727099003|261022113327099003|261009223027099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RwgjN6u5w6f//dUrqfaRck80D5B58/EUxQzt/967ELFQ2OUvhZvGLLn7rJPxNVoV66mzoa1uLvcYSOyJQwN9LywoTa8viDyKi+skCG7NxiTkcm3Za07GL82TfL8P1wJuirFnML46wh/pwncLS1NEtusVFKONJ81gzbPEAOFoGxnlai9algtkhD+K2/l+yw+sR4O4VAiV9ru1B36uM6VFQtIl3KgGZ9NY4Df2fok2mbUWbN22/uWF2CG8Hs0Q2KEaT4h1wetMqMAtD6KIYYMnnBM+rofejh3JxeL/PGmM7uGCRGOh3ysh+QlNu6kszFX9PEGZ4TlkT/qvttj20Eu8FO67CUpFaG3TCZ4jGoRwMjUFcb7p4ilRDFAYv7cLy4gUzDkg2tP5Nvu9xl3Ee8phcYiQP64fKgqhFrVFEP2k9ktGZVHIXhxEkOeqN53dBYWtlh7HwG08Z7FmllVpy54xlzbi+v0JQmOibxGe9mEirqXIhEOYThZQueAarp1ALl2dsVMhhU+RwmkSBytJyLrO7zxt6WDgROrQfR7Bke8SHRVqYGTAcVjGCvpBxEKiC0Msy0CX3+5ABhvx8tkzefzPYZqZMSG3P7hkCghSjHl6ZFRMTPsFR6PQIi1ECu0DFNY2SvnfQUAGq44kHp/VlUTZJ/gEW0hfgJqdvPzV39dP7OfZVgsF1pQzk9gLLTv/y6np+MRBY60pNFFntSBXGQc63zWDIiTaVNID++pieUik/Ck2WeB2Ezl1/w1FSN0xeO+0
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022113327099003)(261009223027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GN8BC+EjrMQFyuPeX5xONjqodSxveZBTP7skXxk3oVPtoftr/iIVWlcF7BzhyF1QFwIUK0kK89gJLiAU2IQallVS+xemQzDo6OLU7zocszhTMymNr+BltADqMMa9M67jmUduRqv6jSMevCIwscE9vQgvf5wHvAvyZr6pSSKypkFqUBvZL17XDrV5SSvHn8rYPfvz8Dy4B68fBMkuBTYQM2OxKOhF7LjQETPEQIcwMFlcDr4+uxmWUGXSnkEa7/D8slFKK/WXPbJ4gleJKKPs+0p7sJeJ/Pmh+S3xINnSRqdj7Ze76vLBac6l0Oyjb21vRam130pFnzZSbl8ONqNHZY2YS8MM84sV/uiV8iZAHzzpaASUT65wioAS4QYfkq9UGoVZZExuOzJX2V+036zO8WltIURIpczjjwcaxxFQznjATYDvLBkeA6Eib0V2Rrju
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:35:04.1655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b7c197-6936-4ef2-b93b-08df3c3d0e7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

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

