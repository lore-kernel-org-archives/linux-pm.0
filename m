Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254118;
	b=zExb2XxnAMke5MUZ14VHShD7tRpjssMNG9ccr+xEhFK+agfpeOFrm2nlA7KOIAviXN3o
	 FUvfH9IlBlp5MlOq1GBeV7/6gFZeubA3Tr0OF4mEvCk7QCU+/Y2c0b8jdG+ImpfKHZIaL
	 uTghcfBlcSeBIrhmvwibS6GRgnj/k+l2HKsk0GcqQJEw/R60FfC2jrukUVbyXWaIhoh6e
	 xJLVu1sb/xiY3xUlFxjdqkvu8wjObBQW9Mtr8SfhSTrscRZPF3H8A3UfcMfTb8vWRBRBS
	 BvQ+G2Ct4Q5+Ya0HcQiOigWdwCMszNDfG1aMxaXBZQttSdFdJeddYx9rh1hjH7Ut4xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254118;
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
	bh=OyMZNdmPZhdwkZBt/Dd6TfanVnb5onb6PQe9/Fd8+wg=;
	b=pV1gbB0iTNpLPO92pDmrveEe7ogsG9SpPdMs4DGsJkUbmgkNhF/KSE+zquFCiqkebrX/
	 +JZYq8hzscriiimpd+R5LlAGfoKEQz+FJOwmdpJWem+BaJxFet7vYE1AyA2KC6379Jm3v
	 OiNSa/uBqrnfyhteqNBIE+snmGRvK5a5ghfUrGy7ufV2yPPOI/lS1adKR+vwPfKw1ScHv
	 6HeTCuKqKZeEFgtEudIdGtuxmOAsiksPlDxFxLH4/Ab+r2JiXOqA5Nv2D9kDAlrB2yZEV
	 ArQWxxfuhxIh9GzRLZddxtgD4F4bEoQSpfAkhCGdR6JSaU27Itv9YK/dxTkFZx3Fsew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H0XY7zFq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.8
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819460A2613;
	Mon,  9 Nov 2026 19:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B819460A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H0XY7zFq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mW6R2JSQR7k25txa9UIHaQ+dE9RZ/kw1QYtNQflb9lZ3YA+vGFDdKRjChJoVfOHRbqbsL0/vNdHRam8ZciWFzi5nYAkLro489+oi4fWjpUS4g4Rqo0KeBpR/z8qinAU/AAGR58N4j7CK9aSE4nDqMQv6OXZdL/UGSSRN/MMOpUHcPSrDuoe239+uU5uPRUK3PgWYnqGncpWXyB6I6k6gIV1iz9CV/rOMXcpvVjM+e6KHJyyLjEDI0QvJs38NfxWAjv6RGWWWRxavtXCAknjadib4e1/zGUcH9LOV0r9jomUF89OE1dSNDW8D1DDQ2T5WwsN6fPvmv4rZXvUWuZjblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyMZNdmPZhdwkZBt/Dd6TfanVnb5onb6PQe9/Fd8+wg=;
 b=SsMks4Mb47on4GNWCEBScAAM8piZbmfVzfPidRa05cntwSHCjP4woxwk9y92MgPgpBlRnvHoK5gsMq65Hg5zrpEv4hdAY22jF3BiN7tLPNSyfKTB1olrxf9qqBeYHnFuYFFyM6oSZwHdle1B5FJTlfbBW6xg4cQAL/ojUbIAF1wYwkqBO6awU4HmPtlViBtdFxLClhsAQpmcxskvLs5vGvudRh6dImq+1pSQQ/6CQcpwxW3bji0SAFUJPi/KdIBNYC1A0uKgcBDmzB4Tp4ERLI/HBO3fvBu3uFBlo5WZfFAfsSk/hjZGl2qibeknAwZNNtpiSfvireQgvEpZ8FuHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyMZNdmPZhdwkZBt/Dd6TfanVnb5onb6PQe9/Fd8+wg=;
 b=H0XY7zFqe3IoIWULwjbNf0FGx0kGVAZUhlqlrGXtN0X6jTuyuYVy5QtEcVUA7JnYJ9WgZku8NIq9wz2cn6rqMo0rzFMUceolV9T9TSzmqTpukt+uc+pr8Yd/4eYe/RgddNJ51HnncNkdhoSMLxjak7PL4v15fabUpyqj6Xz3zigx7tv9JvvIEBN2/t5sKTEFIJDYVWZENRnrlV5gquJZhZCfotB6LAkKRlG+NBzETHXL27h97jYIAVuDWtv27e5I3PZjO4dsiotzUS2bsDnh34ZjgZtVmnVK/FLbM057pKj4XVjQ0cy20sFhfTKrnysXZG8SzD8UYjbO1hEVmBbX7A==
Received: from CY5PR15CA0193.namprd15.prod.outlook.com (2603:10b6:930:82::21)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 19:55:08 +0000
Received: from CY7PEPF000000EE.namprd04.prod.outlook.com
 (2603:10b6:930:82:cafe::80) by CY5PR15CA0193.outlook.office365.com
 (2603:10b6:930:82::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 19:55:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY7PEPF000000EE.mail.protection.outlook.com (10.167.247.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 19:55:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:54:49 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 11:54:48 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 11:54:42 -0800
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
Subject: [PATCH v10 2/3] cpufreq: CPPC: Add ospm_nominal_freq attribute
Date: Tue, 10 Nov 2026 01:23:59 +0530
Message-ID: <20261109195400.3600561-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EE:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d34306-d037-4467-b264-08df3e9b5b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|376014|23010399003|82310400026|921020|56012099006|11063799006|261021123027099003|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7rTHBIQcR5Ocuf14wImW7kcOA5sdY8zYChyBwn/wfdvQ9tkZHFUyJ48QVyokSbLddv2jZGft48tgwVlzVoXSycoOLqKOBXslp81kiMvgwrgbaCznim/CQMr+WIoqMXMIQyjcLETqujtacaplL4C/wAehY/RtbUweoHYhsK2DXauoiyC459C2rAcosabAhUaVKy6jnP/pe36Ex+a/bqjFBm83nqDUzvd959cAE9zKm9vYUPTIq9mDqAiXzQCyNC/yHWxYy1X4y3tqkWupowqp3IW8I6Aeoj33O5sOKEy5dnzga+GlHGp27pi4Ok3LsXW/dbL2rWEbKMCAlD1+/pD6aeezBP0kG1EdDfe0dREf9qk9eJrrAoxWY0VbTmwkHl832w6LyQ+LZm3idowOo26CZeiqJaDWAECRokufH5uLmAqjR4Y02wFPzqYyI7YfitqZW986EJEv/QfwEkP62NvlKPlZeuDafaTe/eDrcj9x/KnVG/7NvrvZB6oV3CmOxrIvF7dgRarU6xQYcXJyvzle4mB6yeJz8KUGQaabaBhpxO8svxi7g1EETEGb8ljMdUhMCzd4A8YXqbkXDbA/q3xfJVSVXIe6QvA7WMWNUFaUDhS+3cMbRy/sI8leT3EfnlicmVsiOllMUELpg53r793gppFxOn+ay/hUzmBsIg2i6c0V+TSkjA/gPRaKWG6imZ5m/iUXfarewFVQeKEgLk1XYH95qBkiVcjlhIUfMbDz1XbiYN5PUyCDWVMBJ+F42x52
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(921020)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q2m5qi+3XqF85A5ClGZENtgJQsPfCRlkmmeY6QZ/DGi5ZK10o4vBwpHksmctA5tJr43l+gI9Ypkrr5GT8PcvOsF1BJzLbIVsBlU2m1ArTTLsnxiHiCDBX7IkQJrPUDFCEmhnHSHT6g7QHDp0F0GZmnEyviJu8wxkvaYKANg/4rMgs7mnOkq2vGQADmNQEnTEEAYHRBAxQE/2RGEoQXIgmvCoTQBW7HErCHbtlQStRVrJdt95cjUhcF1m6Khonh2zjNUuy4rFtdIHbEN8xuVu5UVRrqTnMWjaF3xoFtas/Ifyig0j1CeV8UtGwTQ+ZVVrgLbdHp+uMVNV7N3Tkh2xEqlUNM3yU9H2r80LNBIVoW+EavE64vH7jbLIJ1yJRzPtY1HC973Hfw8GDgSxO3Tdd//YtIh7sWzBK5A+KbVPGZp+wc7ptTDYWRyhdT6Bsv/p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:55:08.0702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d34306-d037-4467-b264-08df3e9b5b44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000EE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568

OSPM Nominal Performance (ACPI 6.6, Section 8.4.6.1.2.6) lets the OS
request a nominal performance level below the platform-reported one. The
platform treats performance above that level as boosted and below it as
throttled. A lower value moves that boundary down, so more levels count
as boost.

Expose it as a per-policy cpufreq attribute in kHz, matching the unit
convention of the other frequency attributes:

  /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq

Writes are converted with cppc_khz_to_perf() and rejected unless they
fall in [Lowest Performance, Nominal Performance]. The register cannot
be read back, so a read returns the last value written, or "<unset>"
before the first write.

Also track the register in the OSPM-set save/restore table, so a
requested value survives CPU hotplug and suspend/resume. The store
handler records the request rather than init() capturing a firmware
value, so the driver writes the register only once the OS has set it.
CPU offline and driver unload write the platform-reported Nominal
Performance to the register.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  27 +++++
 drivers/cpufreq/cppc_cpufreq.c                | 101 ++++++++++++++++--
 2 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 545687ebadcc..6af7fa86e44c 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -350,6 +350,33 @@ Description:	Performance Limited
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
+Date:		October 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	OSPM Nominal Performance (kHz)
+
+		OSPM uses this attribute to request a nominal performance level
+		lower than the platform-reported nominal. The platform treats
+		performance above this level as boost and below as throttle.
+
+		Write a value in kHz, between the frequencies corresponding to
+		Lowest Performance and Nominal Performance.
+
+		The register cannot be read back, so a read returns the last
+		value written, rounded to a performance level. It returns
+		"<unset>" before the first write. Reads and writes fail with
+		-EOPNOTSUPP if the platform does not implement the register.
+
+		Note that tasks may be migrated from one CPU to another by the
+		scheduler's load-balancing algorithm, and if different OSPM
+		Nominal Performance values are set for those CPUs (through
+		different cpufreq policies), that may lead to undesirable
+		outcomes. To avoid such issues it is better to set the same
+		value across all policies, or to pin every task potentially
+		sensitive to it to a specific CPU.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
 KernelVersion:	2.6.27
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 76cb803617f5..662397526433 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -34,11 +34,13 @@ static struct cpufreq_driver cppc_cpufreq_driver;
  * reapplied from online() across CPU hotplug, and the firmware value is
  * restored from offline().
  *
- * Autonomous Selection (auto_sel) is kept first, as the registers after it
- * only have meaning while it is enabled.
+ * Autonomous Selection (auto_sel) splits the list: the registers before it are
+ * independent of it, and those after it have meaning only while autonomous
+ * selection is enabled. Place a new register on the matching side.
  */
 enum cppc_saved_reg_id {
-	CPPC_SAVED_AUTO_SEL,
+	CPPC_SAVED_OSPM_NOMINAL_PERF,
+	CPPC_SAVED_AUTO_SEL,	/* Entries below need auto_sel enabled. */
 	CPPC_SAVED_EPP,
 	CPPC_SAVED_AUTO_ACT_WINDOW,
 	CPPC_NR_SAVED_REGS,
@@ -51,6 +53,11 @@ struct cppc_saved_reg {
 };
 
 static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
+	/* The register is write-only, so the driver tracks the requested value. */
+	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
+		.name = "ospm_nominal_perf",
+		.set = cppc_set_ospm_nominal_perf,
+	},
 	[CPPC_SAVED_AUTO_SEL] = {
 		.name = "auto_sel",
 		.get = cppc_get_auto_sel,
@@ -83,6 +90,9 @@ enum cppc_saved_type {
  *   CPPC_SAVED_REQUESTED - value the OS asked for, reapplied at online().
  *                          It starts as the firmware value and changes only
  *                          when a write from the OS succeeds.
+ *
+ * A write-only register cannot be read back. init() leaves both values unset,
+ * and its store handler sets them.
  */
 struct cppc_policy_state {
 	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
@@ -135,11 +145,19 @@ static int cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
 	int i, ret;
 
 	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
-		ret = cppc_saved_regs[i].get(cpu, &val);
-		if (ret == -EOPNOTSUPP)
+		const struct cppc_saved_reg *reg = &cppc_saved_regs[i];
+
+		if (!reg->get) {
+			/* A write-only register has no value to read. */
 			val = U64_MAX;
-		else if (ret)
-			return ret;
+		} else {
+			ret = reg->get(cpu, &val);
+			/* Leave a register the platform does not implement unset. */
+			if (ret == -EOPNOTSUPP)
+				val = U64_MAX;
+			else if (ret)
+				return ret;
+		}
 
 		st->regs[i][CPPC_SAVED_FIRMWARE] = val;
 		st->regs[i][CPPC_SAVED_REQUESTED] = val;
@@ -198,6 +216,12 @@ static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
 	u64 auto_sel, val;
 	int i;
 
+	/* Registers before auto_sel do not depend on it. */
+	for (i = 0; i < CPPC_SAVED_AUTO_SEL; i++) {
+		val = st->regs[i][saved_type];
+		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
+	}
+
 	auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][saved_type];
 
 	if (auto_sel)
@@ -1470,11 +1494,73 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
 CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
 			 cppc_set_perf_limited)
 
+static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
+{
+	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 perf;
+
+	if (!cppc_ospm_nominal_perf_supported(policy->cpu))
+		return -EOPNOTSUPP;
+
+	/* The register cannot be read back, so report the tracked request. */
+	perf = st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_REQUESTED];
+	if (perf == U64_MAX)
+		return sysfs_emit(buf, "<unset>\n");
+
+	return sysfs_emit(buf, "%u\n",
+			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
+}
+
+static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
+				       const char *buf, size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_policy_state *st;
+	unsigned int freq_khz;
+	u32 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+	if (perf < cpu_data->perf_caps.lowest_perf ||
+	    perf > cpu_data->perf_caps.nominal_perf)
+		return -EINVAL;
+
+	ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
+	if (ret)
+		return ret;
+
+	/*
+	 * The OS can write this register but cannot read it back.
+	 *
+	 * The register lets the OS ask for a nominal level below the platform
+	 * Nominal Performance. offline() and driver unload write the platform
+	 * Nominal in place of the requested value. This removes the lower
+	 * level the OS asked for. The value from before the first OS write
+	 * cannot be read, so the driver cannot restore it. online() writes
+	 * the requested value again.
+	 *
+	 * Set both values here and not at init(). The driver then writes the
+	 * register only after the OS has set it.
+	 */
+	st = cppc_cpufreq_policy_state(policy);
+	st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_REQUESTED] = perf;
+	st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_FIRMWARE] =
+		cpu_data->perf_caps.nominal_perf;
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
 cpufreq_freq_attr_rw(perf_limited);
+cpufreq_freq_attr_rw(ospm_nominal_freq);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
@@ -1482,6 +1568,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&auto_act_window,
 	&energy_performance_preference_val,
 	&perf_limited,
+	&ospm_nominal_freq,
 	NULL,
 };
 
-- 
2.34.1

