Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793381349;
	b=4qu6ojRBTSR5fg+UrtbCAME6p5yN0BERc0WEAqJ1THSguBmINyGQEJTJ/rp/4U8hz0SN
	 jLFCi8tMVZtClW+raH90YufI/wuwldEk4+Jt2mErYsV2iBxItiYlYBX9EWZGgIdbn5nGF
	 Omb3KO1vgUxB+f/SkOcCZnlXXUMW45nU0fSBvOYo+EMAXhQetkaMWjejZ8/AcaFM0P9ep
	 bk2+rcfWd7Ega1yNiHu8l1sMxhUNzwcz2DM4A5/PewsUW0RrcCzhtL3dRMszPMjTpot0W
	 Lk+LheUwNmcIbr36Ff+8FeXoPbK5z9KqVsZASe95QaaKOzySmib87Ic052KjqUT9SOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381349;
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
	bh=ClY/jEwmJVeHe1FSFyYKU+jCY5E+iAJPiRZ9WNOcT1g=;
	b=COFeMVVUFmkb5HLjRlWz9lGSz4aJhXMP6JtP41+dDdpgUadtxFPcfK9w0FDz3klZzYe8
	 wQi77B6Jfh0K8iDUKibQjDY/5dnA6VprC1O2sV1+oCyR6TzkzwfHYGPwTy0zfhd6lLNEj
	 kHCK+GdVVcwdrXg3U1jnDALMHdWMeTWQ0sNAU+Pik1LPyq7NhBDUhB3yalUsdRhqw92o7
	 1Cs+W9pjna50dn7yVCZVHDpWPt1vfDaHDSwd7NU7vuRGA2Lce6Kv2MMxorj9UKveyp4Nj
	 ZQBMcrSarcuGZpa1pICsIrcm9+ekf+vV1hHWq20f8NLLoGIhCRpf8U46Wp8qFKaHZOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=orxUVfTT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.1
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF06606A31F;
	Fri, 30 Oct 2026 17:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF06606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=orxUVfTT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lb7eP1Uv6LZrNEe7LXYjAlK0j30DAz3oXoIIGM8xbFKT6yoIJDzxr19hoX15NzWYv1sHJ1m4hCr7uXHBNVVIK52WzL8PHnP8lsJfJcMase/pOoIE0MMozfTO+r+5pt2OBl1gxf7kW+sZfOX5WTDdUyJalmk09NTKqzGOfWI4egNBWTwznVs47qOGXMWCtbpsomkoUxcugERAgU4Nz1zj2rinm2yvCV8NL+9LsdLuNKg9arIv/PKBkzhJi1ZiYVTq29cZJIctHvMV774o4FgHWhXIGGYo+J5PgLqLeLMeTy1OlK9MmU3v7OhWHjlCCPi38c7krluwRg+ExjC5roUrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClY/jEwmJVeHe1FSFyYKU+jCY5E+iAJPiRZ9WNOcT1g=;
 b=pRfQ1VxYOSL2+XAJ4j43XkO43AAnFt34Lfdq2IBDNRmJvOu8RTxgihO2gZypGmhiO8Bf3J9zAuoPbnL4QKWiFiAOmnY8CqqirfcobK9twl6qNZwPrs5DdyvALj3Y9Ske403qNald03VleOMOHmUzzOwrpP3Y/Qa0TFmb3r7vwqPT2fnwxyncdNl6vvPjVyziKLaE1/6tNnQKJ3bu+5gT845xuIF1jfknpoxUNPHUFY+Mj6lARaUwAM/SH5fTklKFMrkr9wXWhu88BM78AI/vb+xqLyqWrtDNpswislJFKSviia5Wp/3W6YqL9HnAfCd1IK+eSiozg+f+fWGnsYgPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClY/jEwmJVeHe1FSFyYKU+jCY5E+iAJPiRZ9WNOcT1g=;
 b=orxUVfTTm2xieUP/yarFx/uA89zLnirQJOYif8I7AXGXzkNqMm2GlH/6G1DQub5Mc2Z3eD6Jxz2unCeWsrg9kiSS8CtpTXW6xE9WiyuUzc7N3OCiOmi5MSxEoesgwsOzQgu9OT7lsehxfZ1K/MH6z5UuO7Af8YRd6X/WvD5SEngcnQvyrAoE4pw2iJxcp80KmN/xg07dUDYOViuKEQ2OyCXGrb5V7vV6KBIF+i6OYQSdzIw/PUzrgnXMzDAfurulLGJ2gZpug36BAVPD+iB86gM8GcjKsfNR9+qGbcMSj/7+LSlCTTFhxXWwUD/2zm2biKXWjh0lNBut/NPVrOMwrQ==
Received: from BN9PR03CA0250.namprd03.prod.outlook.com (2603:10b6:408:ff::15)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 17:29:01 +0000
Received: from BN3PEPF00022BCF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::94) by BN9PR03CA0250.outlook.office365.com
 (2603:10b6:408:ff::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 30 Oct 2026 17:29:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BCF.mail.protection.outlook.com (10.167.248.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:29:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:36 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 10:28:29 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<mario.limonciello@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v8 2/3] cpufreq: CPPC: Add ospm_nominal_freq attribute
Date: Fri, 30 Oct 2026 22:57:44 +0530
Message-ID: <20261030172745.2045743-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030172745.2045743-1-sumitg@nvidia.com>
References: <20261030172745.2045743-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCF:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 89195616-a9b2-4122-7c15-08df36ab49aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|7416014|376014|921020|261028144727099003|261022075727099003|261026140227099003|11063799006|56012099006|261022113327099003|261022105027099003|261021123027099003|10067099003|261021121427099003|261009223027099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	koipPYrAyk/iHtQxJQIhroiB4TYxi7NPfnqpS+JyX0oXrOsEfQyL+ddimSsACJmE/+XXZUWSWvkkuyM53w2afgt7O2rMg19fJUl8CSGroj1Be+ROGaBZ5hUUW9qPLUa1RzKgnsyOI+rADK0a40wcgKX2hCumnQ24dvihmUWfGPtdykxVpIBJ3DfBzkaH6namhb7q2qgycUGYRTFVqSq1I/hLlDy5r6sevTqJi05Kz1HC1UWRXIqHYcYVOsI1btQST2OKLOprleq7PuRiTu2A3nfxCzdgqzcY8mNv52L6RO6HGicrlOvd3NRbvWKwR8OrhrR8AZbtmPXXYbIMKTVNrWYavnZBZ881PREu+4y5Xd+aPHSVeSTZq8Z4Ezw8BJ4MRMrpem6BGpGTa8/+drZlVJ2XBT/bEli+T0DCFP1XnkYyOXS+lQ2BFiMfkDllZzOVp24f0z8Fu+GaKSk2ts4deGpj826+V4VoEPFYkvY0QLbYdCxIT9Jy4QMkcY1yxmaTcxX1u+aZix7l8JlES2Do2Agoe+QX2zo5YjaKWxdd/1lwtqOlPUhv7cQ10+emPKuXci78ZzhPA33ZCUoWA0u0FEkRB+4hL/Okju4Rbj8Rmm2GmcaPazWE8zdUDQxtwXw+nv8Eols5Vo/m8dpP/F9ZAV+jJb0mNtKchSUDlBM1Gs3LHjfVApfCQyTFBVrE43OOnBhzXtKPFlh1IipREmAohercq2BAUgMr1srmZkj8s0H3OeVOItImjT5IVcMS/hho
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(7416014)(376014)(921020)(261028144727099003)(261022075727099003)(261026140227099003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XfrdYq0Fo0FyvveENKedsDvkzH2NTs+oK+3ZrKw+aHxAZ2meB8gBLuYiG1NcVn45GXy9Pw6EpfIVgodjh6A/IZtZwbO/U0o/9O+MwFLUqrR59v2kjWF6UX1PShnTKCBYF2w0a3gc6N2BMp8M89GHXfGBqwGFRdNsBWD7pEuN4lmHXlMlJmmsH4Ir0UrgmGWIVsOcLOI+RwciXvmVtMVpVosBEeupCIp2VObcPxb7jukpgDoE8Mx4qIsD56BnaOWc3WRZM1oAE1mPhNTMU63khvNoKiK2Cs5Ureg0STmOQ3Nk6Q6cW9ihvsR2JCCfSPcQYSYS+BbHG5BC6krLd2quWyn/7iRMi9QB0EjEGz+r6swf9sslQC4hXyMGKio7lFzhcewigCsfygh7jCPblhRywaa5r0tC+zLdu4JivjYY4lUVhWZ33r0SK6N9KTPYHjC1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:29:01.1357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89195616-a9b2-4122-7c15-08df36ab49aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

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

