Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F93E8C65;
	Thu, 23 Jul 2026 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837700; cv=fail; b=f6dqPQKDECFq6T46pZ0HmPZ/qdPpO9aifYXVCMI9V6R+Xmcq6jBNIwnGtwmxmi+CfnHNpAybVyo7dO4iJfT27x8fsatTnnA9PHZR5BAvS1f7iNbuEfhkjOonPuILwKDv8We04/r9fXsuh8eq0SZzG6JczIgKugORyipjHDA0VuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837700; c=relaxed/simple;
	bh=Qyg1ubsAZxYymj7FF9YU9c2MA209NM66vH+HE6BIZ4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzt+Bz5os+qCgQet0dsSJVYqMeBgB8hiMi4BD8lgGhlZtE35oetmjGVKYTYEpzw25xIO+HqUF0xeS5pYOP8oKVgcsylqT58eP/NVixcpdPcq8fJcMV4brNqWdFx36kR4/QUv4HhMXeKOuhCacil/IVcAPmGLn6zw7u5IWXQE9aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SnUED31I; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SnUED31I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCC7OBDqJNmbL1PseygyHGUT3BGlR4029b8DxaeaIIKbU8FwNv5k1p23zM9gkPCF9uI7RSqFykJYidOaDlLmpdWjGB7n5egbaI6xLwwGD/9WWKk4IWh/mZ0aqkfSEvrHnNYdkKl2XmZz14zqF55EN/p8Xl7G2v4NcKKR9ruDokD5FZHJPrkuYliaZO30v2ZUqx9HUFaGWX9m57rzG9qWI5vjqsJPdlKv9W9qa9e3m/UzfySPdabNlwoTCbw2T2tpBolJZMunquimPnVXlGrn3DCVmyGtJsicPom3QqalneDXKAlhfMusp9qA174D0o3FvHBacAtmD+FrKBUP2C4lVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt8Ez/7gpexwiuqiLOKW/199Wyn79gRdlgXQR5Y+xow=;
 b=P06wgi5B/FY+0MVl7tRoN0NB1YkMizviR+yXbn+UWjEEVAyNV9c+MZsWkYzCgB9xOvqgiJrQP02KZ81nRqvivEe8w5QWN4WX9LOCs5VpvvuwcaPg6r/Ct7/C89J3bIFxxoWlb1f0WAQygW+SZQDAdnIauiQvaXYPJiMUPWQLPzUWid90I9xq6fuj39pq9gMhIHK4SV7+OpkBWGTpdWvHg99bBdXVl/9L5xo4LvYBtL3cSz4SB2R8uMzPDJ+z0dOWkPaFnMjE+7+abj5Is0Ix6y+WHbR3JgvWishSCfwrfgGlrAAYxXMJKMd7kqbVF3VQEN/Fy4lSrvEfLIVNt7OBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt8Ez/7gpexwiuqiLOKW/199Wyn79gRdlgXQR5Y+xow=;
 b=SnUED31I+t/BGBmcRUQ4edOvkojg1Bmf34HQsb9SZTBlPoWmuRfiGTSjSoqRqm823ZN5hNSLsjEf1HOrLBK1zsdScvb99Fz+wKI6U89NubJZzR+2aXCWYBBS/xgLtTBRNBG8dYSkR+UVqQ0UmVhvTUIK0tZccs3DtM9BGiqyNII=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:14:40 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::49) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.4 via Frontend Transport; Thu, 23
 Jul 2026 20:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:14:40 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:14:35 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/9] Documentation/amd-pstate: Update dynamic_epp documentation with new behavior
Date: Thu, 23 Jul 2026 20:12:25 +0000
Message-ID: <20260723201228.22584-7-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723201228.22584-1-kprateek.nayak@amd.com>
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 457c7fd6-7542-48f8-6ca4-08dee8f70712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|3023799007|18002099003|22082099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	51APuUVwYs4Hc7Bl/Kf4FQw4PGrRaScF5F+lQAvrP73EQhRC+9bBtCtXUEtW+GwvF/eFGjHbVlBMLydnE68PXGiiq3N7LI3W3bbovvJ8cS71OYwdHyLk5Vv3AF1xzmPYyN7CuiU7Zf33c/kEsY/PLhyrN6bqQv+PeGk/96vmuDzZ0Op0qS/cFowlgoVF5it4esY1R5QNbVQ4Gx2Wz2NTx9EVLwavo4c3ggmepdAObrhxb5+ftaGJDPX3K2QRw7F2XnYHJIE8aZSL5CtMfl+kOxRe16V/y67PEDXb63RoP83G2Vk7aKVLII9Ck7jsTAkWS3RI37JDKmp3THE2C1Tg4mMJKOp+SHo2O/tszZN2NqQCjxS5pkk9D9gjEKEa8ZFl43c08vO1pP8J7/hVOHAS/6GYaUK5ISb1n52GGyTYdkSNqrvC8brMulYPpZ3wh9sBOHJhAQ5YS8xGPv/kmpA1GR2JS2Nsth019qg9Go1UI+EvJR9JUO77M9UTgIReKBSSaP1JfL+nMjNW/oPHuUkOGxyJnokjOY20A67Si8YrSO+jH8MzQFDIUGCAg0iTJFmTWM6qSgULkl3/6yU7qFM/T8pcLhP0Tb8E/F1JjjM+JTrWL+7fx3oOVGncKtw4Ge4VcyMFESpPzwsdsLPBHiP4w6LEYEgxz8DGFmnLd+iWOOQhjw/kmQ55feSdPZMMRe+I/tqS8m1w2sdD/ZhOdKymCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XAquBNAVMRCI0aVWou4kGBlM6QPpaxKIMwcyNZH/xioDqxnClDlWtPBfd4Oq5tsYqoTo2tbFmr+5R95CmkotfkYWQBrQeOcQS+/HJrWp5Ku6u7IaZ0gWI609eNcqb1ByrN2BhUsu5LiV7U39OOVUhJtaZUQ/6LSdy9eyMUH5nOU3K7YCNjrwlh3TO9T4+cy5ykyMO8iZ/BJKr04mXydr7YT4qSJYQg1haWdedq4LLpYTIsOXLqDhUScQD/1BEsCwfD7N8ljpW6RFlovrr0Up937A2E3MhM3hX633a3mzbtA8mGeAlJNWlEXYYHKtFPgDTw12aSnzel7rez/QizVEbSrx6Lxcg89DH4gyIQhxeDbJH2YGZXF1ed9QAzLIKkC6gHykd25lZ2oWz6uF9lXIPYO9IYNy4n19W+7YhMsehw3TxupAvI0Y2cqUTnVQq0jD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:14:40.5133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457c7fd6-7542-48f8-6ca4-08dee8f70712
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126

Update the admin-guide for dynamic_epp describing the latest integration
into energy_performance_preference selections.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v1..v2:

o Updated documentation based on current state of rework.
---
 Documentation/admin-guide/pm/amd-pstate.rst | 46 ++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index a95e2ebce005..b0f1626bd783 100644
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
@@ -356,21 +357,20 @@ Other performance and frequency values can be read back from
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

