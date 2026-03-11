Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759743C0607;
	Wed, 11 Mar 2026 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237731; cv=fail; b=Xkl8QI1J2HMCK52wpjTUNe6cvIE7L2j8euABJCjBPBe3VNqsfaSTGejwyWG85xEJs671974rj3l5YNRxQGc+3S6xv5ZJb+5neL0hXDSJZhq8bOKapc1V9/RpZBTodAnMyjXLfFej/eVy/mvuaFKtV5R/ZyjTsTBtQ3I9uKEDbJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237731; c=relaxed/simple;
	bh=eXJTKR8Nb9eX4QEH9d0mCZ0lAH2TIwNGOJ/dtCvfWM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxN7tFI5kh1NwCjMNwuNT5uzCLbJQGnTOhTcF/H9LGqGLySUPFr45Lh6QMqLj/rt5F5evfvvTYj20lRegHywIR74OJGwEMDJhWre709a4VFv5ns3xlND0ZZuweJq5s+oMLrE5pwKMrKjWbMyYvTzKFNXfIH0qYJdDK/kTpA01Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g2d9sNdk; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g2d9sNdk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgHivEA2+QVTqgCxFlIulxKPoeD0eytLCcfXlMHWg7Yxtx9gu9H7NDhOmPnKCkgPBy0FIxkoVV9CgWTxksJa+XOP1HtH/oR5ig+4z/1IBLTOsmeQ/RxSEIG+jmVBFz6ID9kH6CgShcUOQDYkNxXm8g5iibfCkP9LzIse8MKyJiJLtwKw5yOeOn6uC4mv/l2xWC9xv4EdVplPOxiWmB/jWDLrLOPRhsf+y/W7/qTzQkO3HC2CaBdvGbN7NImEDyQz6OhAJ4NTmSAdhGaF5VHG64Sz13rHGi3x3nhksflN2dL3yEqAkXZusyyH2vz5jKopwl2edup+u5llt/B63QzoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HJ1P1oBWTPl19WwPkFDpeACpQAoxlqO8fpx6Awg3vg=;
 b=OEwS47dymeYzvDtziAi3sWLRTPDQXUXsrPMBYTTX92I8r5fsug1W39yphk+wIt/r4uemvh5B1utWQDLBiphsbLk1EXzLfH7HUSrU0D1CzWvK71mr01IhKYBlITqshCxdsRZRDaweQOmkTsCA6xWsVcfu+DTP4xNRqDDf/w7MQh1pAqlQhp1YL/HvZ2H7BRETXDDD+DQyMwgrhOtY+sDi31F6R1Mx/RvuOOl+5KK08F5cdJHHY77JRHSHatEamgAy9HlhKYPP8qqV9Q+nwkAV6+klgXBKi8npv3LTmj22Vq6C+o/XuQXIIOX4A6keS3wpqyoazevr9CGIC6MkjO+YMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HJ1P1oBWTPl19WwPkFDpeACpQAoxlqO8fpx6Awg3vg=;
 b=g2d9sNdkUwlmppCHG4LGSk5/APZGFhHPaOgKNAgNkkjkYf8cAHCfDQ5R3KGKwXZG9oWwzQ+tJogKeLGdcjvSykomMrP/b57Pv1ZW10NIBgxx4qv+pL/LC6FeO/EblUjG9NI60s0JrJKxe0VlYjxliuRR30fqYkS9/UYA1njxMHM=
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Wed, 11 Mar
 2026 14:02:04 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::dc) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Wed,
 11 Mar 2026 14:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:02:04 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:02:01 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>
Subject: [PATCH v2 9/9] Documentation/amd-pstate: Add documentation for amd_pstate_floor_{freq,count}
Date: Wed, 11 Mar 2026 19:31:16 +0530
Message-ID: <20260311140116.19604-10-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311140116.19604-1-gautham.shenoy@amd.com>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 89696c91-96c9-4dcc-4852-08de7f76c6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OLFccsU2MjYjhSfyN2ADgN7HqLzia76FqCI4/23PxDURHWwYu+rqgxoDbTg5qmFeOyhPA8OO2/aZxYRwdYyC/vlsgy8jsCSc1kXkgrhONnjPJNTNj6Qf5aWCYuN/3G4EtQcfsEk0KVpNh3gUf90MfBKWOz4DpD0LN5TCaaLv/xuuKPw4Dev4bUPvi+9rOnTJ3gyic5ri8+zwijvHYyKpBYex3UIZ2ejRHAldoXqkfxyksNfoSrqr6LKLB/u3qLKdyRtaSmqg9//Uk4+7EyX1A4zW5SjcgAZVcy3ji9j1TgrUV0BjVMlcq4y5wgu0UyKvrrWGa9qsR9zn6WsM0ie/6eA+OuxZB3dJJWOa0Sj9iUsl2K08aNRJo4qLE/TaGSgzMrppXK/dcl9RwXV/9HovxHrYo/ss2vxi8H7er3T+YZxegM5aIlOE9MlSZ5PHno8x4nK0+nEKWXc+sw8za6s7UhqTrdReRhlkrv9iVnDSmTlCPD7+rCCb4my0NvBb/qY+YmVl81xN0pzV8VfGRtTbtzyJEA62hqHOQ/1PDmwh+2CXmHcV7mkUZJy0pK50vR4MNkCh2EjZ0rBhlJQycMz/vecE+jRqRIRxDWzclYOKkVQCv5BzMA0ln0XMJQFCJGJBgQ6U3sEVDIKg9z72UEC/tVPHuyNaJCZ+cZpsHZjXcmW7Z/K78Nf/GHBRqKfSwVfob/hBGdmmP0LJYrGHRZU8q07mY0CA7Y3TWpWnvyJWEvcLQkNjGJzYfVyMxO1bVFOYqqwarEETso8fH+IcQG/bXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sw6MpI+7GQ8Vp5k1harhSY3vBlMNrw37ONynNn7015VXlduKWLD9NDxxhrdWtnWdPUpt66gUxsW18aocanjXgcX+4/RGUmaVLmGlnIqwD78NZa2QLWfp8l1jOXZ+J1fxHR8iC1OjWYsBTbm/nPQFqLwYNw2VqR0RL3y6Dbnd0h9vC04YKfYgqewWM0vvPDATle58fg9tJ44rkJFDbl81WoZA0vZYGTmFnO+YT6jieT/GFaP6wuTSay8a4crLz5id8m9I7cirjMqjdMlORrMmdpUyEQXux9OFud1WCBCG73mnnEVSY51Jq/pyVa92dwhm5pjlGExHl8T9Vr9oLYNc0ybVyEtWN4RSTVsn9S76Qe+HhLKqhGE2ruzoJnKD0h6ZB4kUt5Ri531h/3vclVXrTZXundVQvz+qpo3QoHgMg0efurUZyGbUSsnlqhwgHtJr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:02:04.7175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89696c91-96c9-4dcc-4852-08de7f76c6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

Add documentation for the sysfs files
/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_freq
and
/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_count.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index f566fea6613e6..5fd2a36f8a4b8 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -242,6 +242,8 @@ control its functionality at the system level. They are located in the
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_floor_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_floor_count
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
 
 
@@ -278,6 +280,36 @@ can change at runtime based on platform conditions. This attribute is
 read-only.  This file is only visible on platforms which support the
 preferred core feature.
 
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

