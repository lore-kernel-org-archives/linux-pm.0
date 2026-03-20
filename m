Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78733C455F;
	Fri, 20 Mar 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017875; cv=fail; b=sNqMWtGGvp2Q6PKly3yKzdJjrf4i2IV1zkwmj8B/jHE22Pqf2UWEFP2MEYuOxKGOjLVLwG9TLQ/6OU2No3adZS564xY8ksmAAE8+lCs/1TDvw2m/b4OGjy4tdCZFYDKhObbngbC4TabW/LdKk4ZTgySrdsmmqQiRq7AELCjYJxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017875; c=relaxed/simple;
	bh=dwI/K5e9LeW61XTbgR9nu9Uu3U9zpV8G32RbaHaCK10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCmwdliLZiPf21fmcIWGtNFu6ciaJvpdGGM1+f76x5KC8ZUIrdOzB22Xn5lG3+XjkDedCP2xPGUf4RKMC0m2t8L0hiy44Zv+hcK6pfMqc+kzu32R/zEefDXV/BRMIx9bEXadzmmISB87ScXz23mTCKbvmA/5QPmLjr3Pq94nd2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yyqUcB0v; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yyqUcB0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBM8Nguhsy11M/N0hPQbHPIY5Qjc+PysfYvFntvZ6W0SZ+h3j5AWJVcL8YQfHAmBtPrmYD5JC1nJIpjKg0kJGf2DRq0p/Hc1fxX5jW/4+0yzvvjuPXK5qOjZgQjAfwZrON3Sqeiy5jLQiOgsC/z+0pkbTseK6d+p3U4GET+j+LEsonblQzIxxVzGc18Apxo57jnQRkKNIqF8HqOkyABDnik4GVXKPtcbQi/QTte+YOESNi/xMC13MV6yFiQcL4CtE8Oj4lVnTdP5+7MepCCB1qAtzetY26BxDtaJ3Tyilc8Gav8ebuEZFoemB2hO0c4nD6cdCv3f615L/QWh4IUTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfVsKTQ/iQzgJZtOjfx3BdLk84HIiWtilfg8oOC18vM=;
 b=HP5Wsjtpod7EU8lK4rNxoxTg0HH2rTWvUPOU9w7otIUPJ3MkWYW3HKw+KAuBb3qDNHhyrxeIXngjTaokM3Ml/fyEnYtYAftArO1Il232qDPVE68vRzUYW/q44Bjvgyuq2rVMTVZn9rIUxfOVIv9askFp60LoFKx5VgEA+XEA8U5GEnAZ1AricJTb5l70xjt5GskA45Yu24rGrPc5K1KTa1q+SB69f4kmlWQv6HY9Ox1c8DwslQrVfig7lv1HnYY9pkhegvvK1zAA33g/5YzklAKWRGzr8mXsXfESa8ZMCmzWYBZeL9wLPK73ZR/v9teRkUqcI/+lDP7wQO2qPsYiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfVsKTQ/iQzgJZtOjfx3BdLk84HIiWtilfg8oOC18vM=;
 b=yyqUcB0vcKrAdE2+G4ssm4IRppqxHi2l8JzUFSlJ0tNEunUsK7v0TRIKLgbWu7naOsP/P0mG1Jic/DT8ZCRvZMg4f7VwjcXKTl6VlsZH5LTv6Jj1I9adZsK4wIuMMUdG8Lq33U2tRW/EwzuIQuCDt/Ro7oT+i8C73HjImrjGW9Y=
Received: from BL1P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::10)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:44:27 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::7e) by BL1P221CA0031.outlook.office365.com
 (2603:10b6:208:5b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:27 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:24 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 12/12] Documentation/amd-pstate: Add documentation for amd_pstate_floor_{freq,count}
Date: Fri, 20 Mar 2026 20:13:21 +0530
Message-ID: <20260320144321.18543-13-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d5d1d3-4d8f-4e05-04e8-08de868f3000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PszIhgmoumIe19jRIyZ8QoTrTiuKmp45v4GPUb/08OAKKe0QWbaJ2BB8M41qlMNZ6owBRyYK4LMyu9aV6xGQuxd1em31mGXfAnHCVXlhD9KVrHD7Sw9pHmHjyQ8RTXE2h138wgavYV1huCo1vuews4+vN9hXbpYNaudZE6HK0izRk7JPJ5Kn14PP1DAPB5sNA71SYDmTCfHfUdDpbo1+L5qpfooF/O1/yNhgxoqJIgjS1InICkCxI4TYoiLi9MjmdOPgSk3DnBRyng8SaTGQ5K6IcUgoDYeGw4hb+1LkR10Y4XdI5KPGvOCwPdpMx7vriSOsGbHm44qoUpLj3xxxnGoLjX+aKseKwW0c/tWdyJjiiz1bB9pSDyJTbcStFPKAA1Jlqt/VcjCkXpD25tOENGBg8R4J3xRZ37bdg1CdORDqHG3crLSz1GHqh05uAN8QYSQn7tI7HhW11nPC9SFKU5mibJ0gtpE1q3jh3WzTAxycVyNH8JDpPA1+unJpY9kRE1CWER9kW1lW/5ii8iTr0kbFoR+ELSfTYqk27Bsb1h3hoW8n61Z8WIJ887tLQOYNvl9tdutyaSYlKXy2jcscV9+E8Q1gmiyxr2oeqez8qdHOg3dQhyoMS4w/eLtFwiztThb2cRzkOqdCK2jWdgr/baOq449ZtVQpPltnsvou3aKbY7snAfcHWfGTlgsbRIM33Pnakhpcra3DEtrz4ERJ2tUTSCZIHUdaiuhzU3fOPqNg65ZLW8XK2GCi+ygfG4O6lRsI6cWcTzrr1jKWDw9rhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0yF7L7Q1cOAtBRLizDhheAvzn2alJgaKwwYATLfOovxRd80gTi6nILQsOD0tLsUFDkp1Bz3Nb44CEWbhbtUhwA6YylJUFjsGPNPRcKxV4DKZN9mZQiibm3g311tw5tijHI1brDbfFcfafa2kQTrEBbixuWs4BOmepjZFZXQ8l+hgb8aGR82Y0RnTIw+gW8CT87G0cnmSGM+e+b0wIPP26Vf4yjnvhrHoMYwwA2L/AJj4DH9P2IAk3C7mB/1TMPkT+iWFQfxbKe7r5i4igDnWBupFcguCIaUfE4Df++ESJrT8xiuyOwKy0iIkajavlDRINVFbBYN3hc+JOeUqvHy8BZnhIqAY94JL5eesM6OC4bMqBjPFlk4AzCijICdB9SPDnm9mCIXd45sI8JllWOFhrVE46wMoD9lNFZ5NPXQgcTuoLbxdXGcy439XBcKwZFai
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:27.6511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d5d1d3-4d8f-4e05-04e8-08de868f3000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

Add documentation for the sysfs files
/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_freq
and
/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_count.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index b31a478c28ba..d6c2f233ab23 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -242,6 +242,8 @@ control its functionality at the system level. They are located in the
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_floor_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_floor_count
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
 
 
@@ -277,6 +279,36 @@ larger numbers are preferred at the time of reading. This can change at
 runtime based on platform conditions. This attribute is read-only. This file
 is only visible on platforms which support the preferred core feature.
 
+``amd_pstate_floor_freq``
+
+The floor frequency associated with each CPU. Userspace can write any
+value between ``cpuinfo_min_freq`` and ``scaling_max_freq`` into this
+file. When the system is under power or thermal constraints, the
+platform firmware will attempt to throttle the CPU frequency to the
+value specified in ``amd_pstate_floor_freq`` before throttling it
+further. This allows userspace to specify different floor frequencies
+to different CPUs. For optimal results, threads of the same core
+should have the same floor frequency value. This file is only visible
+on platforms that support the CPPC Performance Priority feature.
+
+
+``amd_pstate_floor_count``
+
+The number of distinct Floor Performance levels supported by the
+platform. For example, if this value is 2, then the number of unique
+values obtained from the command ``cat
+/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_freq |
+sort -n | uniq`` should be at most this number for the behavior
+described in ``amd_pstate_floor_freq`` to take effect. A zero value
+implies that the platform supports unlimited floor performance levels.
+This file is only visible on platforms that support the CPPC
+Performance Priority feature.
+
+**Note**: When ``amd_pstate_floor_count`` is non-zero, the frequency to
+which the CPU is throttled under power or thermal constraints is
+undefined when the number of unique values of ``amd_pstate_floor_freq``
+across all CPUs in the system exceeds ``amd_pstate_floor_count``.
+
 ``energy_performance_available_preferences``
 
 A list of all the supported EPP preferences that could be used for
-- 
2.34.1

