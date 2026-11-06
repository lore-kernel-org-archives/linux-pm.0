Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993708;
	b=rWAOzLgtQBI7TlG+SKGTmrI/A3pTEY+SXHUTZPT0DoSrimEH6MoxUJpw8t9IUSdTCeCv
	 +Q2w7mORCek+qYouLXBWAkfvxhP/kiR/EozwYDMVHpPeQVYgfbVHjPpiN+8ebNbrqiPnX
	 CqJ9lACPwN0Q9MuPskPkkHV/hT8ATXnOpdsc5vSJys4yk9uL0uVopcMtXjmNd9u+PI18C
	 Kwg79JhXjfCsjDLtDZaT+m3YTNMSy/W8j8b6FGK4ALQz8dQ5PDUBenVCmujqvJeODH9ed
	 BNvEOQJwK21wJ22X4novPbqlU60gFDNOjeLIH0qgb7DUUXLb6Z61N9L8izglCpTwqxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993708;
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
	b=cqO+ys6XwfFELdrBDL6wIf4MbUhOAwDiv+P+eVuf8lFpRLUtfFCwvtD2Xs1XxB2niL5m
	 wnATHtlF0kg3qXKNH8U8AqDLWjRvMRPq91Qn5ctAag3Ru/LJ7b7U7wFZakkWW/FF92VzY
	 wca9Enjbs12T2mU0JZLpUSEcDOvO1pBHcibEG6APKtzb14wKoztZa8bV8cnuSsEcVr3v4
	 8H+Ow5VmqUDeASU/Xsy7i6xA24yhFW3LNh0I5pEyU0+Rv03wj1sMWRSDqx2AMJ9MTyLPg
	 PydM3g+Y2PGwK33DYT1Jgj9KtP7dWHNOUICAgXhaqWJiRtG0GDI/0GcyRXJd1Frpc2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JFCFL+Fs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.23
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B8606A329;
	Fri,  6 Nov 2026 19:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB7B8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JFCFL+Fs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDf5puAF5t4QGyfMtivWI9w+FFPUJriPWt/m3UxJKGm/jGn8fhKMzEDZoovzujEkxhX/bbRzRxDmohMPGpeOMKP194nq8X6VYy3Z5ImaUHykfocdwEtKF/Lcf39dKjZ0ObCHTLiAIlhDAS+gnjibvVyY7GkZK4/7Y8hNK3SqL20VHsZmdG4sdo1zhgtBtfBUTJuei9zFN2ar21oVAMEyofTF+eFyaormtS5lgXy2Cy4pp5n3Yq+ykkjBlmBw41nCMRnGVdooDAAsZjX7crPrlfWfSEmew/tz3oqwQitq0Ywb62PMACq903z/J76YaGlBlxgw0fD0P2EKk4h35DsPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyMZNdmPZhdwkZBt/Dd6TfanVnb5onb6PQe9/Fd8+wg=;
 b=hx3sKElTkl7sHzm6U8TCUoevaJFqOPd9ndUd82SLjNlt5p72LQ2y7dAwR1MYR6sB4NatOlwSiyuVesk8xEMiGMsMA/d9/1gTls3u0Qslp0DiUXQyiry2t+D3XXQTQ/E6nc2oFNeOGHTwx7D5mei8xi2dKy5q6fMwucywkD+hqIIff1wXZbOc4JViODggwzNHhiOzr4c+0ZxJom0DJAfNA8KrUkFMpAiNOM3boaga/u5oTwp+fkqTLV4sljHaenyY8FitNEZ5QhI1gaw2CU304QJNto7VLsmIfbyQRPX6CFyMoI/uW1aKOryG8aLi6SZJBsJZ3yt7LdVQzU6Y4LDtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyMZNdmPZhdwkZBt/Dd6TfanVnb5onb6PQe9/Fd8+wg=;
 b=JFCFL+FseiJgewE/4RL83PfScX4RTUefX/nAvVc5jUHUA0YQ1USi5Kl2FldFSPMG8Dv4KLE5AOcdgqf7bbEWETwOLONxe0u3EMtCtvKgs0PsYyIbEM3HTQQqgtVT2qCUaT43NLFQOpSbdTLrYums5fjg2rslA0RxaFdVGw3iHfv132h7D8MBUXn4lGqAyTROe7g9+DKTcqUs+zYswnz6W8DKDhiS2c4kBlb9KcfLTKiEScsxEFC5gatlQW17A/1khoRQLmBhF4en97aYqN4S8S4rfFNJa+fGikS2wNRgPWWNy5Em7BWdvSj5l8vvI35izoZFayscDOlGp6lqkiSutw==
Received: from BN9PR03CA0193.namprd03.prod.outlook.com (2603:10b6:408:f9::18)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 19:34:56 +0000
Received: from BN5PEPF0004698D.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::8e) by BN9PR03CA0193.outlook.office365.com
 (2603:10b6:408:f9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 19:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN5PEPF0004698D.mail.protection.outlook.com (10.167.245.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 19:34:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 11:34:40 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:34:40 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 11:34:34 -0800
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
Subject: [PATCH v9 7/8] cpufreq: CPPC: Add ospm_nominal_freq attribute
Date: Sat, 7 Nov 2026 01:03:03 +0530
Message-ID: <20261106193304.3347374-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698D:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 945dad83-d8fe-49b8-040c-08df3c3d09f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|18002099003|22082099003|6133799003|10067099003|921020|11063799006|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022113327099003|261022075727099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	8qs+PXwXTE7BQE6z92ZcOul5AxV8GCf3wDEWd2/5GK7JbBhAEgr1NdixtLjSDOuvyLva/MP+Pry+LqI1y92VaVUowMC+G6kwa4jlinM3lY4lU1QJw0yiiRdvt4yAYJIJ2cRk3qzEqHGK3oafpKEiSBeTFjTv+RMKRUX60CQnD/Zq6gQq5Qfzixc4qGbwoRoHRzVr4pdAqEeFPw6Pnz7gyCshr7nBUvoZPylFzArB08X/RtFTbl5q4SW35UyLyd0lqEwiGvYX0kEyBapIWxVMegsqya1l02wBNp2CxaZwJZrxo7+5CbRqz2QGuTRphi35hqO+hkXlsGOwQGywy15FiWlxBm4uG34eww9B6HJCbybG//ZzOe5QM++3QA+pd3xcH7wtpJXBca2yXESsHqaJZ54aBV0mNfy81h4wR+DC+kgPmbBiLZQhfHx1N7wFbB2Re2PzF+AAnIKPdtSA7Ei33QlFBbb1mJmpc2X10wqKFJdcfQjtu7t23r8flvRU2ybRgjkB689hPO59lyQuwerdHfEIzEYsSeIAyAUQCkC3EYFe8aF3kN1ed+A/hAKcpJqljekI1oTZFVxn5PHzMqgSY+bOhacXnc3mkYsj9iCNnBXH/G9ucxhS/QVChfbpYqgwrlyNH2OMON1BH/TWa7gXm5WxuS8PqYS0PluYzHXax1uHydQxw9IDfXnGBOC0JCOJp6xBA8KHKXf9RYXSDqNsHa/OJyv/FtAqUCiqy/htI5nIwrghNsdqACchuaPWbf5c
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(921020)(11063799006)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cequpm4Pse0qjV+73xck/xW3S6SikDvBi2ONB/1TFPqRHhaI7OgMjyH4upwvoJp1xw+K4IH/slbxaHE7llu1jEmbNCrtRZL/hy+tyXm4SQpHgv6+4eRTAp36thtb70XBkE+7veqqSYghG1J/k1/umnKDJvChZKW3ouq1AAa/6eQZWl8GbfMVzjf0xJ7FOZwbKg6D3DaVrgqkkeLdkhlQnZGzr57m6k4ujMurhDJzDGmijXFfBu+oT+xWda+NYMz5SwfFXKYDyFkUpRR7JtOsmLuLz7Jz8VT+KF/S0ItUDEYyYkxV/tdX3bTCkx0guXFWIC1n6UqvPj+i1HJeVYRibcS0HIE+l0NNYccpZCybj5rnhNylRIkYSyAFPfgYbWrCyz8eXmHCuJpL1FxbbvRHNiOHk2f2k+ii2iFm+PzK1w1xxsWaNNWoohMqqst7Ounu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:34:56.5928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945dad83-d8fe-49b8-040c-08df3c3d09f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

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

