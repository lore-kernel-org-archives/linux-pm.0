Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C0366836;
	Tue, 30 Jun 2026 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846208; cv=fail; b=I/BlZEj7IX86v3U1asE+xwMAmDF/8+m1fd3AY+7rvAaxdHwIzhBsjVbtx5SifFTQ+K8I3h9JijC80pbTFVwRwGwnhFCzPmbk+QmjXHA0/6odOZajwJVL37EfiTOW6l19Iop+AgbDTDZLbhWs0hjOQjOLKiLwVRuanQHwGJ+xM3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846208; c=relaxed/simple;
	bh=2JGdMvrNAVI4eJ+LCBexfUHd5bUiG2HA2TgtBNyTGgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qot0Ct2owwbeTLDf0vmkKz7Y5l7N8mbPhwBJ50vNGdqrl8ncycvzvmis7+vcWA26Fokc/QZGGgwSumDea1LI7KtC0y/z4XrCViXpN33+usu+bgfuE9xZiuJ8rleRNl3Z2hqcPeG9muqxBUQySfvDB69zpS01H1tvCZdbBXLOKy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0aAzE9nm; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0aAzE9nm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuMS3fYKLfmMPDluCUZmD0MDxCOFVMkhfpVxWOSGWdwecZfXB4fvp3uvn3MPHEDxHM6USJpt7/lB4yyWHaoS5iV9LG4N2HOrX1hdxx4Ch+QX7sgOB2eezPfB0D6pC1KBywiYyTBJpN9zuL6BBgSpu4kMX4Q6pwf5V4KoA0U3M/WLkBJsP0L+Z/oXp+mIJrXth2U/43w4ypk+MxOqZW3IHWJyvd1viR6QyXcjWxZEPayYiVCo0nARs0/7ooeeX054NXVy9OszKBH2QP1cs58S8wIEUmxWx2SKwbFFp4l6Bz10hvqDMWGgrxyDSqhkdsJ1CktIBtXHykvsRs3OlYAkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcOx4/0H8XjpaRI2A1rf6LaKUjmrySUPDevqH+Wm/F0=;
 b=iX+/lIn0GbyAfr27E18hCtydsMvlg8u8DXX8PcphQ+tqvISIBBfmHu36UIXTS+jo54PCpCMqUxVOIDH1caxRIRSCI+CDa8WtJhLb4baBNUzQ7gh8Xw9NPm2/1xUlK4OuoFUu7mFuBDOJwEiI9vmQZiGXPbcPbsOz3wQz7dslRE8VQERTIbWpR5amViOiZlB1XFDBFgi4Xz4VgkCpoEpJVB7Ga9XmEEdeRX4put7iRHKDMRsNlDm1qj60mabYOjgx/bd898Ltm/3gqnHxMvWzZxAiwLUBBZW19Wd0lobJX3TdF9m7wD1zrfE8NCIvwuCsqaY5SByq/4y7GSDo42kAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcOx4/0H8XjpaRI2A1rf6LaKUjmrySUPDevqH+Wm/F0=;
 b=0aAzE9nmCsINYgUHlkd8Okor4619N1y+H+5Yk4EypltuaQgi9MBXgwsq6ftFuIVla8oVbhH7RYFYfJPFuVDMY7rLtQLXW9LlCc2wLmZEBv7X29wj0m6nHyg4GKkjIZyR3+mx6KMh8US+IQNhkhzhgEU2cZ4Vwv2mH9UZz77+yJY=
Received: from BLAPR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:32b::22)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 19:03:20 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::7) by BLAPR03CA0017.outlook.office365.com
 (2603:10b6:208:32b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 19:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 19:03:20 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 14:03:13 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/6] Documentation/amd-pstate: Update dynamic_epp documentation with new behavior
Date: Tue, 30 Jun 2026 19:03:02 +0000
Message-ID: <20260630190304.5671-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630185904.5602-1-kprateek.nayak@amd.com>
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3fdb41-4104-48cb-2dda-08ded6da4060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|3023799007|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	i8yA31x9wk9P5gIEJdC0kgqfsO1f4mwRO9gVNRh1u+0uI02pArCDEYR5rgmKoSxfboDYs1F0g/V6OhXSehvSXHZlSX7MTFD9IZBTM2CwHhbg17VKaLpbGmJ2kbOZJH1Eed/e7BSoyTBoBBBY0j5Z6LBD+dBQ55PGUVKHCxjLMtstMsLnZtJmBQuDKTr2h8RnAG0ciO1KB3tG229mHrK9qhQj9kJ9b+Pxu/vdWjIIdXI0//RnfVC1X2CoHjdGf5OKU6IyEZxOVexoPj0MXsMz8F/VvJnaxDcsti32N1zeHeG3fWds/EFIvtHfQ+G+2YQ/cJ5HMfJaut1RK/xImZISyseessV4dyh8sKw1fjM1zs2vrQjPN3PD5ImqBKmAjEh11PWbUqwGqXnCP7mdSKW+0TXXH88NNMZQ08swQ+yl3wTT7MO1vymkwC7lIFPSmbRxete8Jzk5Cu3OHAwoyHvMMN9AVPcL06DPDgeI/Ywmlw9nN/JtXbsbcr8nDxxbOxZxdC7DGPm2pM4s5b9Ja+ehN6za5OTlc+JVNxeWULovZh1JjkV55Nc3MahYswu7h2PwlPrm3xtGBBPF0wJurLVmwAf0vnu+2M+2ypOe1dJUHObaqAo6pSu5SUSHw64b1S5u0++z32rjnt30/6TbEXinA1XZTtTvmRgUA6vT8GG081fYFhbeoXUt6GjM2Sl/PcoWF4mBKFQCy4KcDqvnjjhxyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(3023799007)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6nB6Y6WytOUukj9I8inp8UixNinQHmj9tBZs6Sueeo0pKJ8fzPMtJjFtWOnpzNDBU65vmSaLGjTCCNDsHNMrc5OAVxB2mckcSDO4+AdBjrGoqI2SmOw8MTa9A3GSXq4Q/ajMPnmyIj7OxCZlTBLqIIw39eBPHoP5/Qwvfd+H01cGkmM3Xo4JM5HeH36hjeEyyNkBpbxQ3ftczm4L8Efuo1YnqVF5jfQX0dxXJc2As8Junk9JncLqJ27j7+N42X+4hbFvuomfda6UdarxLrbgzaeFhyBFRYgBSOpXnOADO/RogDpKS/OSlgdb09Mu9RGlI4Ipeqla4d8F5+c2JHi/vu1smKyPoTPaNUXbz03FsFIwpIF+wqPYO3lnA8kjummnAGUj3FOUVd5hj7QLtfc2iTOoTL3IpxSnk14jzJ8ZwdTCWYlGzYkkrPBKXmtnFKsT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:03:20.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3fdb41-4104-48cb-2dda-08ded6da4060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708

Update the admin-guide for dynamic_epp describing the latest integration
into energy_performance_preference selections.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 61 +++++++++++++--------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index a95e2ebce005..1afc2f8b3f0e 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -317,7 +317,10 @@ These profiles represent different hints that are provided
 to the low-level firmware about the user's desired energy vs efficiency
 tradeoff.  ``default`` represents the epp value is set by platform
 firmware. ``custom`` designates that integer values 0-255 may be written
-as well.  This attribute is read-only.
+as well. ``dynamic`` designates that the EPP is modified dynamically
+by the platform profile and the power supply status. See ``Dynamic energy
+performance profile`` section below to know more about the ``dynamic``
+mode. This attribute is read-only.
 
 ``energy_performance_preference``
 
@@ -326,13 +329,11 @@ and user can change current preference according to energy or performance needs
 Coarse named profiles are available in the attribute
 ``energy_performance_available_preferences``.
 Users can also write individual integer values between 0 to 255.
-When dynamic EPP is enabled, writes to energy_performance_preference are blocked
-even when EPP feature is enabled by platform firmware. Lower epp values shift the bias
-towards improved performance while a higher epp value shifts the bias towards
-power-savings. The exact impact can change from one platform to the other.
-If a valid integer was last written, then a number will be returned on future reads.
-If a valid string was last written then a string will be returned on future reads.
-This attribute is read-write.
+Lower epp values shift the bias towards improved performance while a higher epp
+value shifts the bias towards power-savings. The exact impact can change from
+one platform to the other. If a valid integer was last written, then a number
+will be returned on future reads. If a valid string was last written then a
+string will be returned on future reads. This attribute is read-write.
 
 ``boost``
 The `boost` sysfs attribute provides control over the CPU core
@@ -356,21 +357,35 @@ Other performance and frequency values can be read back from
 Dynamic energy performance profile
 ==================================
 The amd-pstate driver supports dynamically selecting the energy performance
-profile based on whether the machine is running on AC or DC power.
-
-Whether this behavior is enabled by default depends on the kernel command line option
-``amd_dynamic_epp`` is set. This behavior can also be overridden
-at runtime by the sysfs file ``/sys/devices/system/cpu/amd_pstate/dynamic_epp``.
-
-When set to enabled, the driver will select a different energy performance
-profile when the machine is running on battery or AC power. The driver will
-also register with the platform profile handler to receive notifications of
-user desired power state and react to those.
-When set to disabled, the driver will not change the energy performance profile
-based on the power source and will not react to user desired power state.
-
-Attempting to manually write to the ``energy_performance_preference`` sysfs
-file will fail when ``dynamic_epp`` is enabled.
+profile based on whether the machine is running on AC or DC power in active
+mode.
+
+The ``dynamic`` mode is listed in
+``/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_available_preferences``
+when available while running under the ``powersave`` governor. The ``dynamic``
+mode can be toggled on by writing the same to the sysfs file
+``/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference`` when
+available.
+
+When ``amd_dynamic_epp=disable`` is added to the kernel command line,
+``dynamic`` option is not available in
+``energy_performance_available_preferences`` and the feature cannot be toggled
+at runtime.
+
+When ``amd_dynamic_epp=enable`` is added to the kernel command line, ``dynamic``
+option is selected by default as ``energy_performance_preference`` when
+amd-pstate-epp driver is loaded.
+
+The availability of ``dynamic`` option as an ``energy_performance_preference``
+can be found by inspecting the sysfs files
+``/sys/devices/system/cpu/amd_pstate/dynamic_epp`` and
+``/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_available_preferences``
+
+When ``energy_performance_preference`` is set to ``dynamic``, the driver will
+select a different energy performance profile when the machine is running on
+battery or AC power. The driver will also register with the platform profile
+handler to receive notifications of user desired power state and react to
+those.
 
 ``amd-pstate`` vs ``acpi-cpufreq``
 ======================================
-- 
2.34.1

