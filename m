Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C631352A;
	Tue, 30 Jun 2026 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846210; cv=fail; b=UHn3BTuGzavF27rvXWC66Qj58QOG7AIRrB0ttIyEE5rlKStR+AltHFojOXo6o8H3MQSIUclJ5n7aUTsuf2OHCpgotyb7UbC/sAU2p72Vc4xHDnoPtSnhA4tsq0rBGAi/3DdXuA95s7yVRW3LJlQTIp1WCPI96EDtbGc0Ndk3GwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846210; c=relaxed/simple;
	bh=2JGdMvrNAVI4eJ+LCBexfUHd5bUiG2HA2TgtBNyTGgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzJKLraJftqMVCPEU0UIPSGEgLjAjXaTYjznsVX01e/b3ML1h8doa8aJ0tGn41hnAJpQ5uuG1QxYqqLE1FeglnD4ZwbugFKZyfFWJii3jkbA4nryW0qzYQJFsViKniRhZT+c3GHTqpq5au4YQWUrEWBXc/JV/cE1DbgCOPttuJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iGRYMG0U; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iGRYMG0U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFTFM12sEnTydwrtcz/3tbhOjNcs5DMN0GEj3UAdq2z6OzQFJz5UsgeDsyUnGzUm2gQUmk7XWClG4Og1Nidq5MXIjnJvEC2RCWEr+916v1YUYk4wJHbDXmrGK4fdPDWErmMLOwOSoGx274XznQutaEVDylhSJHyDt8NyHcWjGjI3cC1D53p1AJsovbq3tnjZjkMnKQ/SM/Cl+4TciT14VsEVaLpdnJjuerVHGBSCWmGzOUbOSHxfQ0vbottX7RHUUS4fMnyYJGzEOYAT9u7pCRubhqiDEc3gdzFvoUSDFSWrgFfKuHVJD1ZGRhRn00FsyhLrINgihw71G8Sxo5TcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcOx4/0H8XjpaRI2A1rf6LaKUjmrySUPDevqH+Wm/F0=;
 b=U8Gvz07ogDFpLLZhl1gn1ohuOo7m3cf5XQrQrpOSUiDVSEzYIw5e7Se8G2XHGcXZZP3sqJ+PcZTRAHAf7F4ZCQPbm+5yMoAZxSuXyExLL6Cj80JFnzYCdJWqGg9zM+ZOBBrMSJLfyMKEPdT2EQu3dVSNyxo70M86roAT67qaHh8YHbPcoG2/rYbhQETY0Mhj56+yDeJTVWdgO62EH6CB6XXWlYWDZ1EKhO/rp+sXAqqZN5L5mNVsoyAAkY2UTXj0AG7gB/RNbUiciVV3C2Je8UViaLB8ZeMAmC/a3xT/Ksp8e4VhpHysMhHnsJXDP7CNDcAtdiXgc/AuZYiy21v++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcOx4/0H8XjpaRI2A1rf6LaKUjmrySUPDevqH+Wm/F0=;
 b=iGRYMG0UnejZlrL7PYCoEWEL7Vod8+qcoPYhXgDtJCy//0HIY+Ztl2MZNNt0wm917vCS4T6UJJLEzlb9dnwdAcIpy3nTShW2ECWF1sPvYKwuW3hMzn3vpknMNNAsyHn1uohHstoIHDjd02CsTYpoGpLVGmpsiY8dQpeeO8LldZ8=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Tue, 30 Jun
 2026 19:03:18 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::9a) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 19:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 19:03:18 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 14:00:54 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/6] Documentation/amd-pstate: Update dynamic_epp documentation with new behavior
Date: Tue, 30 Jun 2026 18:59:02 +0000
Message-ID: <20260630185904.5602-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 47478640-8551-4073-b4da-08ded6da3f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|11063799006|22082099003|6133799003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	1dNCF7ckJswGs0nIh7fFLRz6ptiil9CB05P3I5K1/3WKh8prlfmEeRxOxmZIB4n6HHm6LOqhf4AZXyYlwejG0xK0kcN2t7z/GdJe8ZPRbEvMGJzpMT+y4vACarzTAzQ80PX6lXBmKqer3fT5/E4QSHhuPUpIqLflp4GmVrHe5EDW42kfWSzEdNcog9dFUYkWLxIQ8r9tsCanm5VAWq561WC4nfDYYAxeTC6Tv3PbnWdKWOg5N6u7aF33R3ZTh9JsNd8eofh2ht4G+TsY5hQ/Z+s4gqw75d7wSapW4hTVm+x4/42uRxEfn0GsDr4bO/Ll6CIVodlVYPSP77XPvnnWtb4B9X/3MQ4CJGdTZChXTypQ6PvxS94XGChnkB0718T4AozCWKeQiL9hkm/HixaNRj1jKrdAUeQ1zgpCI0hqEs513PhQyaNKXxrXC0vVipJR2+7vFqmwvOIecUNWEjXNWClg3YFOuKarFXpeudDT9qdC1XKXTY2ghU1+vUsgodhKpTh2ZFNF+F0NyA9TnuhUs22Oy5pBWZsvEUV39z67GrGqC7FuaJdmIHSWBf9Wq1m/XFIdDSbT7Yc6fvZPu03YowXtINel1bvV6nzwOaSBP6wy04LxjH3ZiI8fi+Z7+v/eVaWey6eQumnZywsgSyBayEl6rMJHu5Y977t8Qw7s+4qRu4tQu5/p1Nw6QMye129qQZc+56I+0LUKgMzHxC58RQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(11063799006)(22082099003)(6133799003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JfKo+uWRFokkGycKtr6xJRX7CNHBRji/jwQ6oRmh0dU7agcDjqUASXoMWsVmblClEdYBAmgjlyd28qRsR9080i5MuAIepuZmZKN7dupEvRFs3Q9Y9QyZULbzgHJjEJ4jNDWfCJyjGwH5vEYiGBmvzt+fI9Izi2+B4dKLWA25o6IZbmaQ8t+o+71MkS7nnIb9EVglrOzfSvCYjpf3GyePPYd8lGPhcaZPi7uOWgp6437k2F6UQZDXY9vhuFubdvGT7U7s8QvDVwniwtwyyK/f2WSzdUfG1P2+667jvN0rvQOAy29bTC1SWPzMiSbpQWaEV2wGsT5r5eCZECTBUNGydnRrAsgdsSaiYzc5f/6sHD9qgsBtqi31VrnoZr6mwVHFX4FP4NK37W7d+lsIaNGvq3maT1G+n/7CSMRNm6Pzlv/6yJwnGyOqGFVWxrQQZyBR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:03:18.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47478640-8551-4073-b4da-08ded6da3f19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

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

