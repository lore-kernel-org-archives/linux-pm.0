Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792498793;
	b=By6NfJxJo1dQur8hb4tNx0a/gQqQ5i6AEnJ76KQp+kfvaAvUw1m0nZ9/OfSgBhm25uiU
	 U/ICM5s2+SxQ87UTRo7drl7S2QrY1x5oGXmq1Dv+hzDrBBsftJX01XBuzvLZb21/lG4QR
	 6jBinUSg2pmctxEDZcknaz2ynDeQLBUCRLGSEdvW6C+mFRYtez7EORe1oJkUnQditodOv
	 qNt7yYekJorkKM3JMtuJCTCRGE6VLG7jkUkz8I4e0wd78ulwf7gerGwrYO46JE+lPDOrE
	 KZDObthfJiLZPwlJ4gmvefqnOh6RZANRGXwKSHvgCAwTZi5sE4NchEPUUvWvtAK0aKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498793;
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
	bh=1hOC+5npXkodcNrt3Qa7XunxEM8Tqd7+DwO3Xmt8vtk=;
	b=AXcCqjrzt5TnXDTrx1VpNe5fmAx+5rjBYs+yAtYlvBOelWpcfghViDD7XV+o3PN8WNZq
	 GObm0IIi5vQiDk+ABK8IDDytGwmXXHLxUCRx5GhCGF09kWr2j4srF4r+9DkI3kF6rmbEs
	 9Mf7s6omK9TuvK20hloCqZS39kWzO+sq/R8pzYs7T634yY3u+WiFPcZEtMn/GaIijXiR1
	 MixrzvJZYwaAa+kRIcoMIlFtv+i2n3q9WkAM6rmKgwe+d5IJ8R3PoBRUrTrL3s6JzcBJe
	 orOQ42NOcTy6izdaJwafGfplfRl1T9i4BhrKLXQ210U/c7NqhaWXQuX6t7nC7BGwXAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rKD03sJ5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.65
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F6606A328;
	Tue, 20 Oct 2026 12:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D0F6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rKD03sJ5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeR9P8QaNDoo2ej38IuNBlGCxzqgMvy2FOH2Op9/BdFxMq4ovONFt8WQT7omCKrUzz5CYm7ukWtBzBPFWvdz5hBj8iXOYUFIuinkPXz1CRAXg2mZz/yzOi+du5eG8e2bGtA5fUUZw8bZ+W/oEIQZQdOAlXmS3slD+TK7rilErH/kMdFy1A0YAoq4htoHwnqHSaEbvybVXQ4GVXCtbvUdJS04HFMG875mhJfgKYA8bK6yfLPUa9zztpxtGMWpjYT0c7qeCDXSW55m5d2LIWsNHGIjrQwd0dNjAA9VRqKlaA2INA5igQyTKhWYJzG9KIR3cSlmsP3k2bJYZnPADVMCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hOC+5npXkodcNrt3Qa7XunxEM8Tqd7+DwO3Xmt8vtk=;
 b=XBv+8tFHNx9DKSiNT/UJ1dqbS9nvx3Ms382Kxxeve8Gvr1H/By0Nk2pTam2alVAI5uJ/XqyDMP0oHkFkqIx0oE5C6z1GpXXabHTHc5APoBuEJXm9S5xjgZQ4DoAf9cWjMilGg/k2DhECAwxUUYFaRQwxRyaebkmsBa70jfyPaV/DxhU8rocJJk0ZWOqa6aDanlEtxstYSF9Z+SyYV9K/ktzkx7j7iG5/EJ7yTN3ehp666TDfTrB6tYXPNMCZGIj2L7sH8au65cdEuN1iom4mcPYDOOpTZIZceFTAOKcuKIvt5hSEXjMZkbqAQocwAph78vLiAk8lCO0XMzmeYKSxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hOC+5npXkodcNrt3Qa7XunxEM8Tqd7+DwO3Xmt8vtk=;
 b=rKD03sJ5IWm36YBCDBKUlkWu1xd8Ti3Ruey2e7uDZYUX7LKcB1E9jp273eLtrAvZyCo11mFOuu/EuRTPJA0pmNNye1t58N+jOEHh3yLChjIH4JZE/F+r+Zv6Xf0Q10JUiFVWHkgY8T3WAledsClrFeXVS4Ovltb/EGCT0BGM48CTdUlIfNB5E+axUCyR5M5DU4ow93n12/K66jwznn/QPDrtgFYZIAnZ9eMMxxCLaQK1gJDk0rYoztxHrWxHgIekvd9I9ULzF4XLiPY0+M6RjieseWNSaH+iMyGkFtwQtQNWECACDCAH17vmLyHxMxNPvimBKhLS+WI29WkpjQh5VA==
Received: from BN0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:e8::32)
 by IA4PR12MB957498.namprd12.prod.outlook.com (2603:10b6:207:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:19:26 +0000
Received: from MN7PEPF00000151.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::1) by BN0PR04CA0057.outlook.office365.com
 (2603:10b6:408:e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 12:19:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN7PEPF00000151.mail.protection.outlook.com (10.167.254.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 12:19:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 05:19:07 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 05:19:06 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 05:19:00 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v6 1/5] ACPI: CPPC: Order performance-control updates
Date: Tue, 20 Oct 2026 17:48:42 +0530
Message-ID: <20261020121846.691218-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020121846.691218-1-sumitg@nvidia.com>
References: <20261020121846.691218-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN7PEPF00000151:EE_|IA4PR12MB957498:EE_
X-MS-Office365-Filtering-Correlation-Id: 623890e4-2f4c-4cc3-acae-08df2ea46210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|376014|1800799024|36860700016|6133799003|18002099003|22082099003|10067099003|261009223027099003|11063799006|5023799004|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	zrelWTealFug9ECHkZc5nnjJ0EylYMDWMFU6lGPZtwycdCqp11QLki0/ZAWoG8/FsJ4XGzGOpQWsQtgQSWE06JoNenGJ8DH23Q48FfgJBpjotXC6nmZ+gNVr56STJXXnDYg6k6A2Gja2IAhRMIxA5QVJ5f/aV1rFB8VfmO2QT/jbbnjc24qJCtqXIZDPqbkbwLLCDamjdX9znqTL5NHwtKbC2YA9J8mLz5W6VWPnE+0uew7U1+rDYCXlTyns/UJitQZ0du+m1jXqJKLEuZJaGwLSkYnyIfUDZQis5mlzFy89Q8XUKSYGfMvw+QktrqqkSMxuk2TWpTBpTXNCVKKOFFtO59ntbY2sP/b1CfYzR+itwUJp8SToi2MshscbfE4SVbfl3uls5RKjW76i/REZaAI5nMVDc5U/a5Hr7cC9yAzXP2o6FD2LfZoLEuA+s8YU6jZUoVO3b6rNr8FOj28zZ55IYG9uMv8JfAUeFYZRo+7kxfwRtLbgcRi8pMcaJq2xEqzzgnZmAUb1rNpk8ydJQ2NbvoRMd34LKv1x7tG6zw+tzbbfVLnqWW+IHfTtXxDUg1jFr6IyKF49/T4PTrUi8GDFQhH0ffHYWANTMimVpQ3xHEdWqm6QVVzArRZWjYpHd1wgiKaIjNnwfg4ZfF4STsZSrDkmRormvPKCo6vq8sdKVJLc7UUC/wzcv32vzlEPWQJBwquffH81vmW1qRNaC4m/oquoAn+b7RolUVkAGuJqRpAn2GvSEth4aLmMKrji
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(5023799004)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/+o32Pn35Pim3ES4RVD/nLpoRwwIgQ8EWAC8cV8cfHbl2BeqbNn+Y+mvSlKUka48MmGFis/+yzwuMYreAogZmVrNMK4YbYkgGU+WrxYfWjmVCQ0W3x5c/MxEqdPlnmn1p0/fqovqHjHxUTzhH3T/239L3XMY8BMZ/yiwGsJrxMn44HEKT2DDb372T+BirOO1fN09yCD8LK6mHeVHOrtUmYhxGkCDcck2RXtSoQfU+/wZ11vTg5SKa4ao4Nq+X5vkHRjPyK6QJvhNp1XnV6IDGXd/cvfZNXN20/ppVix0Xo6bGZZTtoLatFGXUOKC+zizTCB/SgrNqfvb1TVpnSkxESVSmR+4c4oHaj1zfX/Br3+MQT0W2GW0otqcWq47EtHJ/QHTxyN3rUYeRFLl8Xmg4nyiBbJ2iOXaQbt9Qw9+BSszp5k1PxR91m5W0MzAXTYZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:19:26.2851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623890e4-2f4c-4cc3-acae-08df2ea46210
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF00000151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB957498

From: Christian Loehle <christian.loehle@arm.com>

The ACPI specification requires Minimum Performance to remain below
Maximum Performance. When autonomous selection is disabled, Desired
Performance must also remain within those limits.

cppc_set_perf() writes the three controls in a fixed order. This can expose
an invalid tuple after firmware resets the controls or while policy bounds
move across the current desired value.

Read the live limits. Apply non-atomic updates in three phases: widen the
interval, update Desired Performance, then narrow it. Submit PCC controls
in each phase together. Keep the existing single-command path when the
complete tuple is in PCC, reject invalid requests, and stop after the first
failed access.

Make cppc_cpufreq fast switches include the limits only when they differ
from the last successful request. Invalidate the cache across resume and
after a failed request, since firmware may have reset the controls or an
earlier phase of a failed update may have reached the platform. Publish
slow-path limits only after the complete request succeeds.

At policy teardown, lower Minimum Performance together with Desired
Performance so the final request remains valid. On initialization, clamp
Desired Performance to the live interval left by firmware or an earlier
driver instance.

Fixes: 76531df5e13b ("ACPI: CPPC: Add min and max perf register writing support")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
[sumitg:
 - In cppc_read_perf_limits(), skip an unimplemented MIN or MAX register,
   and do not fail when the live MIN is above MAX, as the requested limits
   replace it.
 - In init(), request the full range when the live MAX is zero or below
   MIN, to avoid a cppc_cpufreq probe failure.
 - Clamp Desired to MIN and MAX in set_target(), fast_switch() and
   store_auto_select(), as cppc_set_perf() rejects it outside them.
   cppc_khz_to_perf() can round the minimum frequency to lowest_perf - 1.]
Link: https://lore.kernel.org/all/01d7f07e-839c-428b-833d-713ed2128f4d@nvidia.com/
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 294 ++++++++++++++++++++++++++-------
 drivers/cpufreq/cppc_cpufreq.c | 118 +++++++++++--
 include/acpi/cppc_acpi.h       |   1 +
 3 files changed, 337 insertions(+), 76 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 80e2e6b32ce3..8d38924e0750 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -3471,11 +3471,212 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf);
 
+enum cppc_perf_update {
+	CPPC_UPDATE_DESIRED	= BIT(0),
+	CPPC_UPDATE_MIN		= BIT(1),
+	CPPC_UPDATE_MAX		= BIT(2),
+};
+
+/* The caller holds pcc_lock for write if either limit is in PCC. */
+static int cppc_read_perf_limits(int cpu, u32 *min_perf, u32 *max_perf)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *min_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	struct cpc_register_resource *max_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	u64 min = 0, max = U32_MAX;
+	int ret;
+
+	if (!cpc_is_readable(min_reg) || !cpc_is_readable(max_reg))
+		return -EOPNOTSUPP;
+
+	/* Firmware may have reset the controls, so read the live limits. */
+	if (CPC_IN_PCC(min_reg) || CPC_IN_PCC(max_reg)) {
+		ret = send_pcc_cmd(per_cpu(cpu_pcc_subspace_idx, cpu), CMD_READ);
+		if (ret)
+			return ret;
+	}
+
+	/* An absent optional limit leaves that side of the interval open. */
+	if (CPC_SUPPORTED(min_reg)) {
+		ret = cpc_read(cpu, min_reg, &min);
+		if (ret)
+			return ret;
+	}
+	if (CPC_SUPPORTED(max_reg)) {
+		ret = cpc_read(cpu, max_reg, &max);
+		if (ret)
+			return ret;
+	}
+	if (min > U32_MAX || max > U32_MAX)
+		return -EFAULT;
+	if (min > max)
+		pr_debug("CPU:%d live MIN_PERF %llu above MAX_PERF %llu\n",
+			 cpu, min, max);
+
+	*min_perf = min;
+	*max_perf = max;
+	return 0;
+}
+
+static bool cppc_perf_updates_in_pcc(int cpu, unsigned int updates)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
+	return ((updates & CPPC_UPDATE_DESIRED) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[DESIRED_PERF])) ||
+	       ((updates & CPPC_UPDATE_MIN) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[MIN_PERF])) ||
+	       ((updates & CPPC_UPDATE_MAX) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[MAX_PERF]));
+}
+
+/* The caller holds pcc_lock for write if an updated control is in PCC. */
+static int cppc_write_perf_controls(int cpu,
+				    struct cppc_perf_ctrls *perf_ctrls,
+				    unsigned int updates, bool sync_desired)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg =
+		&cpc_desc->cpc_regs[DESIRED_PERF];
+	struct cpc_register_resource *min_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	struct cpc_register_resource *max_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	struct cppc_pcc_data *pcc_ss_data;
+	int pcc_ss_id, ret;
+	bool pcc_update = false;
+
+	/* Direct writes precede the PCC command in each ordered phase. */
+	if ((updates & CPPC_UPDATE_DESIRED) && !CPC_IN_PCC(desired_reg)) {
+		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		if (ret)
+			return ret;
+	}
+	if ((updates & CPPC_UPDATE_MIN) && !CPC_IN_PCC(min_reg)) {
+		ret = cpc_write(cpu, min_reg, perf_ctrls->min_perf);
+		if (ret)
+			return ret;
+	}
+	if ((updates & CPPC_UPDATE_MAX) && !CPC_IN_PCC(max_reg)) {
+		ret = cpc_write(cpu, max_reg, perf_ctrls->max_perf);
+		if (ret)
+			return ret;
+	}
+
+	/* Keep Desired Performance valid in every intermediate PCC command. */
+	if (((updates & CPPC_UPDATE_DESIRED) || sync_desired) &&
+	    CPC_IN_PCC(desired_reg)) {
+		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if ((updates & CPPC_UPDATE_MIN) && CPC_IN_PCC(min_reg)) {
+		ret = cpc_write(cpu, min_reg, perf_ctrls->min_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if ((updates & CPPC_UPDATE_MAX) && CPC_IN_PCC(max_reg)) {
+		ret = cpc_write(cpu, max_reg, perf_ctrls->max_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if (!pcc_update)
+		return 0;
+
+	pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	pcc_ss_data = pcc_data[pcc_ss_id];
+	WRITE_ONCE(pcc_ss_data->pending_pcc_write_cmd, true);
+	cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
+	cpc_desc->write_cmd_status = 0;
+	return send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+}
+
+/*
+ * Move from the live interval to the requested interval without exposing an
+ * invalid control tuple: widen, update Desired Performance, then narrow.
+ */
+static int cppc_write_ordered_perf(int cpu,
+				   struct cppc_perf_ctrls *perf_ctrls,
+				   bool desired_update, bool min_update,
+				   bool max_update)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg =
+		&cpc_desc->cpc_regs[DESIRED_PERF];
+	unsigned int widen = 0, narrow = 0;
+	u32 current_min, current_max;
+	u32 target_min, target_max;
+	bool desired_done = false;
+	bool sync_desired;
+	int ret;
+
+	ret = cppc_read_perf_limits(cpu, &current_min, &current_max);
+	if (ret)
+		return ret;
+
+	target_min = min_update ? perf_ctrls->min_perf : current_min;
+	target_max = max_update ? perf_ctrls->max_perf : current_max;
+
+	/*
+	 * Check only the new interval. If the live one is inverted, this
+	 * update fixes it.
+	 */
+	if (target_min > target_max)
+		return -EINVAL;
+
+	if (desired_update && perf_ctrls->desired_perf &&
+	    (perf_ctrls->desired_perf < target_min ||
+	     perf_ctrls->desired_perf > target_max))
+		return -EINVAL;
+
+	if (min_update) {
+		if (perf_ctrls->min_perf < current_min)
+			widen |= CPPC_UPDATE_MIN;
+		else
+			narrow |= CPPC_UPDATE_MIN;
+	}
+	if (max_update) {
+		if (perf_ctrls->max_perf > current_max)
+			widen |= CPPC_UPDATE_MAX;
+		else
+			narrow |= CPPC_UPDATE_MAX;
+	}
+
+	if (widen) {
+		sync_desired = desired_update && CPC_IN_PCC(desired_reg) &&
+			cppc_perf_updates_in_pcc(cpu, widen);
+		ret = cppc_write_perf_controls(cpu, perf_ctrls, widen,
+					       sync_desired);
+		if (ret)
+			return ret;
+		desired_done = sync_desired;
+	}
+
+	if (desired_update && !desired_done) {
+		ret = cppc_write_perf_controls(cpu, perf_ctrls,
+					       CPPC_UPDATE_DESIRED, false);
+		if (ret)
+			return ret;
+	}
+
+	if (!narrow)
+		return 0;
+
+	sync_desired = desired_update && CPC_IN_PCC(desired_reg) &&
+		cppc_perf_updates_in_pcc(cpu, narrow);
+	return cppc_write_perf_controls(cpu, perf_ctrls, narrow, sync_desired);
+}
+
 /**
  * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
  *
+ * Callers must serialize updates to the same CPU's performance controls.
+ * Limit updates preserve MIN <= MAX, including intermediate states on
+ * directly accessed registers. An error may leave an earlier write applied.
+ *
  * Return: 0 for success, -ERRNO otherwise.
  */
 int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
@@ -3502,10 +3703,22 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 		     (perf_ctrls->min_perf || perf_ctrls->min_perf_valid);
 	max_update = cpc_is_writable(max_perf_reg) &&
 		     perf_ctrls->max_perf;
+
+	if (min_update && max_update &&
+	    perf_ctrls->min_perf > perf_ctrls->max_perf)
+		return -EINVAL;
+
+	if (desired_update && perf_ctrls->desired_perf &&
+	    min_update && max_update &&
+	    (perf_ctrls->desired_perf < perf_ctrls->min_perf ||
+	     perf_ctrls->desired_perf > perf_ctrls->max_perf))
+		return -EINVAL;
+
 	desired_pcc = desired_update && CPC_IN_PCC(desired_reg);
 	min_pcc = min_update && CPC_IN_PCC(min_perf_reg);
 	max_pcc = max_update && CPC_IN_PCC(max_perf_reg);
 	pcc_update = desired_pcc || min_pcc || max_pcc;
+
 	pcc_layout = (cpc_is_writable(desired_reg) && CPC_IN_PCC(desired_reg)) ||
 		     (cpc_is_writable(min_perf_reg) && CPC_IN_PCC(min_perf_reg)) ||
 		     (cpc_is_writable(max_perf_reg) && CPC_IN_PCC(max_perf_reg));
@@ -3531,9 +3744,10 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * A mixed layout cannot batch fallible direct writes safely: another
 	 * CPU's staged PCC values may no longer match if a direct write fails.
 	 * Serialize the complete mixed transaction and drain an older batch
-	 * before changing a direct control.
+	 * before changing a direct control. A single PCC limit update also
+	 * needs the exclusive lock to read and check the unchanged limit.
 	 */
-	if (mixed_layout) {
+	if (mixed_layout || (pcc_update && min_update != max_update)) {
 		down_write(&pcc_ss_data->pcc_lock);
 		if (pcc_ss_data->pending_pcc_write_cmd) {
 			ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
@@ -3547,50 +3761,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 				goto out_mixed_unlock;
 		}
 
-		if (desired_update && !desired_pcc) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (min_update && !min_pcc) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (max_update && !max_pcc) {
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-
-		if (desired_pcc) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (min_pcc) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (max_pcc) {
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-
-		if (pcc_update) {
-			WRITE_ONCE(pcc_ss_data->pending_pcc_write_cmd, true);
-			cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
-			cpc_desc->write_cmd_status = 0;
-			ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
-		}
+		if (min_update || max_update)
+			ret = cppc_write_ordered_perf(cpu, perf_ctrls,
+						      desired_update,
+						      min_update, max_update);
+		else if (desired_update)
+			ret = cppc_write_perf_controls(cpu, perf_ctrls,
+						       CPPC_UPDATE_DESIRED,
+						       false);
 
 out_mixed_unlock:
 		up_write(&pcc_ss_data->pcc_lock);
@@ -3599,22 +3777,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 
 	/* A request without PCC updates has no payload to coordinate. */
 	if (!pcc_update) {
-		if (desired_update) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				return ret;
-		}
-		if (min_update) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				return ret;
-		}
-		if (max_update)
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-		return ret;
+		if (min_update || max_update)
+			return cppc_write_ordered_perf(cpu, perf_ctrls,
+						       desired_update,
+						       min_update, max_update);
+		if (desired_update)
+			return cpc_write(cpu, desired_reg,
+					 perf_ctrls->desired_perf);
+		return 0;
 	}
 
 	down_read(&pcc_ss_data->pcc_lock); /* BEGIN Phase-I */
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4ea444ff889e..709363e6d98d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -335,47 +335,92 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int relation)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = {};
 	unsigned int cpu = policy->cpu;
 	struct cpufreq_freqs freqs;
+	u32 desired_perf;
 	int ret = 0;
 
-	cpu_data->perf_ctrls.desired_perf =
-			cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &perf_ctrls.min_perf,
+				     &perf_ctrls.max_perf);
+	perf_ctrls.min_perf_valid = true;
+
+	/*
+	 * cppc_set_perf() rejects a Desired value outside [MIN, MAX].
+	 * Rounding can put it just outside at the ends of the range. The
+	 * policy limits may also change after the governor picked
+	 * target_freq.
+	 */
+	perf_ctrls.desired_perf = clamp(desired_perf, perf_ctrls.min_perf,
+					perf_ctrls.max_perf);
 
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf(cpu, &perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
-	if (ret)
+	if (ret) {
+		WRITE_ONCE(cpu_data->perf_limits_valid, false);
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
 			 cpu, ret);
+		return ret;
+	}
 
-	return ret;
+	WRITE_ONCE(cpu_data->perf_ctrls.desired_perf,
+		   perf_ctrls.desired_perf);
+	WRITE_ONCE(cpu_data->perf_ctrls.min_perf, perf_ctrls.min_perf);
+	WRITE_ONCE(cpu_data->perf_ctrls.max_perf, perf_ctrls.max_perf);
+	WRITE_ONCE(cpu_data->perf_limits_valid, true);
+
+	return 0;
 }
 
 static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = {};
 	unsigned int cpu = policy->cpu;
-	u32 desired_perf;
+	u32 desired_perf, min_perf, max_perf;
+	bool update_limits;
 	int ret;
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	cpu_data->perf_ctrls.desired_perf = desired_perf;
-	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &min_perf, &max_perf);
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	/*
+	 * cppc_set_perf() rejects a Desired value outside [MIN, MAX], and
+	 * rounding or a policy limit change can put it there.
+	 */
+	desired_perf = clamp(desired_perf, min_perf, max_perf);
+	perf_ctrls.desired_perf = desired_perf;
+	update_limits = !READ_ONCE(cpu_data->perf_limits_valid) ||
+			min_perf != READ_ONCE(cpu_data->perf_ctrls.min_perf) ||
+			max_perf != READ_ONCE(cpu_data->perf_ctrls.max_perf);
+	if (update_limits) {
+		perf_ctrls.min_perf = min_perf;
+		perf_ctrls.max_perf = max_perf;
+		perf_ctrls.min_perf_valid = true;
+	}
+
+	ret = cppc_set_perf(cpu, &perf_ctrls);
 	if (ret) {
+		WRITE_ONCE(cpu_data->perf_limits_valid, false);
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
 			 cpu, ret);
 		return 0;
 	}
 
+	WRITE_ONCE(cpu_data->perf_ctrls.desired_perf, desired_perf);
+	if (update_limits) {
+		WRITE_ONCE(cpu_data->perf_ctrls.min_perf, min_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.max_perf, max_perf);
+		WRITE_ONCE(cpu_data->perf_limits_valid, true);
+	}
+
 	return target_freq;
 }
 
@@ -670,6 +715,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	u32 desired_perf;
 	int ret;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
@@ -728,16 +774,39 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (caps->highest_perf > caps->nominal_perf)
 		policy->boost_supported = true;
 
-	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
-	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
+	/*
+	 * The request starts from the live limits, which may be unusable.
+	 * Firmware may leave them zeroed. An interrupted earlier update may
+	 * have left MIN above MAX. cppc_set_perf() would reject either, so
+	 * request the full range instead.
+	 */
+	if (!cpu_data->perf_ctrls.max_perf ||
+	    cpu_data->perf_ctrls.min_perf > cpu_data->perf_ctrls.max_perf) {
+		cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
+		cpu_data->perf_ctrls.min_perf_valid = true;
+		cpu_data->perf_ctrls.max_perf = caps->highest_perf;
+	}
+
+	/*
+	 * Keep the initial request within controls left by an earlier driver
+	 * instance or firmware. The governor will update the full tuple later.
+	 */
+	desired_perf = caps->highest_perf;
+	if (cpu_data->perf_ctrls.max_perf)
+		desired_perf = min(desired_perf, cpu_data->perf_ctrls.max_perf);
+	if (cpu_data->perf_ctrls.min_perf_valid)
+		desired_perf = max(desired_perf, cpu_data->perf_ctrls.min_perf);
+
+	policy->cur = cppc_perf_to_khz(caps, desired_perf);
+	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
+			 desired_perf, cpu, ret);
 		goto out;
 	}
+	cpu_data->perf_limits_valid = true;
 
 	cppc_cpufreq_cpu_fie_init(policy);
 	return 0;
@@ -757,6 +826,8 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	cppc_cpufreq_cpu_fie_exit(policy);
 
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
+	cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
+	cpu_data->perf_ctrls.min_perf_valid = true;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret)
@@ -766,6 +837,16 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	cppc_cpufreq_put_cpu_data(policy);
 }
 
+static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+
+	/* The platform may have reset the controls during suspend. */
+	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+
+	return 0;
+}
+
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -910,6 +991,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	cpu_data->perf_ctrls.auto_sel = val;
 
 	if (val) {
+		u32 old_desired_perf = cpu_data->perf_ctrls.desired_perf;
 		u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
 		u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
 
@@ -919,15 +1001,22 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 		 * uses the correct performance bounds immediately.
 		 */
 		cppc_cpufreq_update_perf_limits(cpu_data, policy);
+		/* The cached Desired may be outside the new MIN and MAX. */
+		cpu_data->perf_ctrls.desired_perf =
+			clamp(old_desired_perf, cpu_data->perf_ctrls.min_perf,
+			      cpu_data->perf_ctrls.max_perf);
 
 		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
 		if (ret) {
+			WRITE_ONCE(cpu_data->perf_limits_valid, false);
+			cpu_data->perf_ctrls.desired_perf = old_desired_perf;
 			cpu_data->perf_ctrls.min_perf = old_min_perf;
 			cpu_data->perf_ctrls.max_perf = old_max_perf;
 			cppc_set_auto_sel(policy->cpu, old_auto_sel);
 			cpu_data->perf_ctrls.auto_sel = old_auto_sel;
 			return ret;
 		}
+		WRITE_ONCE(cpu_data->perf_limits_valid, true);
 	}
 
 	return count;
@@ -1060,6 +1149,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
+	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 5bcdb0e553b9..4495ee4ab71e 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -165,6 +165,7 @@ struct cppc_cpudata {
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
+	bool perf_limits_valid;
 };
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-- 
2.34.1

