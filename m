Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B13DC4CE;
	Mon, 27 Jul 2026 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136991; cv=fail; b=WYaGh0yJ0lCB+AOnmNCBJZV+PuTGmY2EuMYOgndORYR+QLOs/unAu8sEfWVwTkwkAwdhfrDwyMxeHCV3iz5e52LODWc6hbuaoZ4A8mkriwnRHedTwgZgWndtBK9qQ6KAybST46M5JC0o41K6/kNPyFe5a5xjm3rJBFidPb1vRSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136991; c=relaxed/simple;
	bh=4CFClmXSw0u5nv44AY12sdd2nU/tEurIPo/WsjDjrn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZ3IrjAgBizqTHE9tjr7qfSwH4VuckV5N5jJODh4mjFpv40FJctPxIJ3TJUpS0GX/vrLrcgKDf65lsQdYFx+bIOj3ZODOpMlJyRCsACvo6q3Cz+1M9weBNvB/W7Lb7UTq3AQeS8TUHZrVcUrlxhX6IQJnMvyHEcW2jWhsLygUNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j0WAKDry; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j0WAKDry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDjRIhrIGWOX3LO52rHgHgEexzr7as3gp21N73s4S5g9jwXsvq6bZ6P5POsEQU7/jSsGHsRqP8mKtPTJsg85K+Xh+KgftRoEWPn3Zwgv7Z48ZeRlGFaf7+I4Sg1medBqCqaUJkigoGYhEZNxf/EXiz3r5EwiG8b42hJA9KJejENeLMB5oLSuw9tkHNXtK2mr7w9fyTrRubURXnKaLA8m5HA1BHzCd/R1P+nbIFUl52sCObpaSLjzyRy2FOpQKKmERq3uQwr4kBPYhScFlbi1p5a/eKS2Z5PBcB6NvuYohtGWpdQ3BHsatP+eIo0bwH/so96yT71ShCjgr/+SCG0sBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5ed4hs9jucRPj890PkepblrEM0zsvuO34OcfAdfowE=;
 b=eOFyLNyXPQ8q2IslxUYGIuX5Z58bq3OErrvXsGXMDm7pNDsS5195wDeuIdbyP0yV60HSXAKtaA5bmfFVCU7JCea4T5Nbs8sOSf/IzDD5uegqCtMv6XhXEq9VjpWfkYpwHeZ2qoc/f/RFADVBQ1S9p80aNIx3gRjWoL7Rvr/Wy9OzaqPm5TbghBg0we+jaH5V75XDr4FY9Ub/HwH+/dJ9ZX+a/46VpYxRYaDXDwGFmzbvp1lHytn2OhtuYcXq4VVqR6TMf+pLpmvHzYzmK2lY1m2JVjWk068TJbsCla0GW0VAVH4WJtNWNcvmZcXcWhRMsO4fR6xpTM5C/xuiG1jzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5ed4hs9jucRPj890PkepblrEM0zsvuO34OcfAdfowE=;
 b=j0WAKDryndlVeYQU2PiTXTzE7m9NmaT6/zou4YKz58BHOkUi3D0e/cIbzVcOQoUquy0Md57RlhsCj70eaeno0O6ULZ3ka4SrOfMzgn4XbihNVqJqdoy3i1RNzjTV7D+T1XWxzX1BPCuOJ/QyVEvsPkXxxyVrYXTxqRxLazG4IKY=
Received: from MN2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:208:1a0::21)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:23:05 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::91) by MN2PR07CA0011.outlook.office365.com
 (2603:10b6:208:1a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:23:05 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:23:00 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/9] Documentation/amd-pstate: Update dynamic_epp documentation with new behavior
Date: Mon, 27 Jul 2026 07:20:53 +0000
Message-ID: <20260727072056.1248-7-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727072056.1248-1-kprateek.nayak@amd.com>
References: <20260727072056.1248-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e41a79-caa6-43b3-8b0c-08deebafe686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jm0/wUi45KyaX7fp4LugRcxF6ly0sZrx1eIV85lnSJ94H82ibaXm2zRJwnePHrRerCuKB8Pnlal7JHsQF4ksgJ6hn4fIUByfqHCY6ORxSexPzqmpR+fZfoswhlqxj90XjQKqiCxRLNz9SjTh9/ztdshdyTE4hBz5FU7VKRftvUqLHBmT8IBGkXsHm9mb+GLxRwxbD6RVDeu/eFOT3rPueQRs7mXYIAmd7CAfg3OHaOQTdSnGDsiWFi0aynL3kjRhcBO95Wojesqf9U/MQy0jI+3JONzFAnBndQzB3CEkRdoFj77KfPC4FutcSp95KdbNoqw7J7IzqugvP0TW60Dh0u4+F/Ex7WBFlTSMMjDmX21nyT6oJ7mFP0AM7t70vcwnEHKjnDGgPy7hkhQtpw0lwG1ZkyW04uouNyxKMOCLsY+FsHYKGu5u/rYd75ahrb9KcKl77CdPKpbG9KczyGDVEUPFNuAJXStvwZcSCh6m+9D+nwAQZ2DihOSmn5oDyWASvpqu+Wi7JUQCj1ZisLbWNXrC+gmbUAhLjSHkiQ6BjOnijt457wLHYKG7Sqd2+9si4jv5lnnERxxj9PeWfk5qXfcDoVxYZsr82YmHWslRkdhlvMxi9bWce7ol/OTkE9wIQk5WVcfjDiVMujOt+7u9tnqOXemZsueusuyG4SE2OK2DFLgtgBrehB4t4wy/lQs2ROQmB4hqnJJYERaGdDktyQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D9YcfAF482FvYrrMngKyB5b9Cze8TFb1dnFz8lDpp0pIj4obmn3WvtqLs+n21mLwQCdDpfF12AISfxuo4v9PfWRoBiWL+0PHFGk4YknTjiKZC/lIla9dPqt5DJFXmPN6l0eCnEq2xjrJ29ivE7oqICtNFFkdcqJtUfAPVQqmcEJ/iOBRF3BcEJW42e1btxpYPnYcajzUB+qB0B7Zd1ZVBhkv9gi4H8gOvuGay4Rbtg8ncqVu5Du2HwJxYAcY+Z6PUXef6D9WAbXhWf67+OmYmLR9hm5Zpa4HGzuVCxqKEDvMOQ/+bZpsifIvPOFRm1+N7wQjhGUXmhTqNdwsi+i23tS/TEFrDOCi+HClkZ6Z4laISbMUgPSlqtaaJbwxQp+Ador6zSiZzPJ+OgnBdQbdV17D1m1MnmcO1rkOOwkqEBmKxoz8moH0dWmE6o8SnIZI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:23:05.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e41a79-caa6-43b3-8b0c-08deebafe686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

Update the admin-guide for dynamic_epp describing the latest integration
into energy_performance_preference selections.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o Reworded documentation based on Mario's suggestion.
---
 Documentation/admin-guide/pm/amd-pstate.rst | 45 ++++++++++-----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index a95e2ebce005..c7bf7cc2db87 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -317,7 +317,9 @@ These profiles represent different hints that are provided
 to the low-level firmware about the user's desired energy vs efficiency
 tradeoff.  ``default`` represents the epp value is set by platform
 firmware. ``custom`` designates that integer values 0-255 may be written
-as well.  This attribute is read-only.
+as well. ``dynamic`` designates that the EPP is modified dynamically
+on kernel events. See ``Dynamic energy performance profile`` section below to
+know more about the ``dynamic`` mode. This attribute is read-only.
 
 ``energy_performance_preference``
 
@@ -326,13 +328,11 @@ and user can change current preference according to energy or performance needs
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
@@ -356,21 +356,20 @@ Other performance and frequency values can be read back from
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
+profile based on the system profile and the current power source in active mode.
+
+The ``dynamic`` mode is listed in
+``/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_available_preferences``
+when available while running under the ``powersave`` governor. The ``dynamic``
+mode can be toggled on by writing the same to the sysfs file
+``/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference`` when
+available.
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

