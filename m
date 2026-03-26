Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1233F8E0D;
	Thu, 26 Mar 2026 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525743; cv=fail; b=kQNwhtQcWxL3EJIglCpeMVIIsCQPndYXeHrrT84j+lgtHExyKAyOXhSqSBG1IFRPfq6hJyg2hYT1CCyQu70/j7j5EFkZrWEMDHEiez4GjSz94+EkRo0AnbkZRmES5+/HiZQaul+aHiDHLFuqbzhenGM5nEehqmjCO0jhGdNLE54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525743; c=relaxed/simple;
	bh=dwI/K5e9LeW61XTbgR9nu9Uu3U9zpV8G32RbaHaCK10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hs5K5Aq9HizrzIkys7r4exyGagPBCDg4P/osrAkj2jTYuYGzcUAgwZ9cWEuQ+1FN/WKGpQalZd0cDDSq25gK7DtgBrG6Vgvkufiq/PGff8NuOs+RjGbDZYPKCpZCf2cZ42XIsiYjx54y7VWJ0z4kmk/D2XvhfBdAiFVl5/dWAy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mgzqwURW; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mgzqwURW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV+iTozEckGBIX4sn3X8JxplFpbKY4nnyl68Lmi5SqUgQ7Zn9Trsb0GziyoZo/gw8FgmbagXxT1Mp2hvJhirmLQy80pNDgo0a5QmgLXbohfhcgUrxgqIBjKzRXqE76PTAi4T9KMtmgU98Er3IjtwDFYHVMK4z6rSmwPmldGEfgssfH/R/W5cZKq7scPHmmreBKoGHKHViCFZiOD6zndnusXSgirMm2wYPbAHntWdXDna5XFWQaoS+P0Y9DMOCUF4IT7V9aL6CmK7jd3QIY4v9oBm8Rq5v4luLBxPFCbhjFb+tyoOli04hJib/ch1ZYZyZmbfniqNu9Snh+5uAAmsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfVsKTQ/iQzgJZtOjfx3BdLk84HIiWtilfg8oOC18vM=;
 b=Yh6HY+S/OFOsY2iuMkzUYvE64OkjyvN1XGDuNS/5oDYokh1ZSuwO1b+bjgzpmc/kFdVSFSX5sdUM6apgn7x8oi5kLlXz3u64bjkodoCr9aWHnraJIwqIizmrlZGjaFWQfO4ltAlGmt3R14LkukatnvDaAWYNsrtc7lYU8C2+PKmLUhjw7FPbTzgRsgFGSIR5MntEVtXCNdwK8M2e487eW90ru5q1EHA8npIsgjJGuawNsKmFScOkBVmgKjI42zeK+AjlIN/Liq6lGxmBCXOT35p12bAgilGSLc+JSA7fJdp5slTNamnbi5x/ZpxC9+801lSeApNAcYsE8kxSg4mCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfVsKTQ/iQzgJZtOjfx3BdLk84HIiWtilfg8oOC18vM=;
 b=mgzqwURWyKht29gNeEHrZULOkbl6H42dd86FNGh1GW7x+b+Pef4Hpk+yO6TsM+oSk5Xq0eqzFXh+DiudCNc7WsScy5vfgGnpmj+xXbr7b6mXVCYds/dUdb9wTlwrDwJUhhJo64PkPPt97dXjhaJUOOXeld6JrhDjLAQNrR7S01U=
Received: from DS7PR03CA0324.namprd03.prod.outlook.com (2603:10b6:8:2b::24) by
 CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 11:48:51 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::3b) by DS7PR03CA0324.outlook.office365.com
 (2603:10b6:8:2b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:51 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:47 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 12/12] Documentation/amd-pstate: Add documentation for amd_pstate_floor_{freq,count}
Date: Thu, 26 Mar 2026 17:17:56 +0530
Message-ID: <20260326114756.20374-13-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326114756.20374-1-gautham.shenoy@amd.com>
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: dd55e161-9543-43b9-af57-08de8b2da63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IgzTaW2kw+CFEyg7gg9QSIT1MU4nTGx7Ez5BfUw5KdW9TSvMBNqlA9d+CY8YhD3uQCkwC8/vcyIek2IcUSvKVoRQeOfgTIVj6OTRCRUbB0Ey6tlxNld+aqL6za1/lb4ZGLPyzhnzahKoVJxVIpE0EtuJId+JHAX0KGAZnQNJtzNFEG3WtYov8K6Ser6QaQ3zNI1KtpAjAetslTNbiFkHgGfIBnniCEWSTcUkzJjmexkcVap92gJqqg86ybAjEPLDcCcesGuPZJLB7oFZVhYcIJQdNj+g/6dU4NV/VGFjMgHXCucPS4FR/7C9ah1Z/JhxWW9MtjQq2btW69OR73EJgA1KGM2IXQOHVsbOoq8LHdoZ+HMRb249Smrtcofz0KEGMXeFjQAULgbGWOXBg74pYuwCZVG1vRs6Fnyi8lKZ12h8jPv8lTekhP/q/YNq2BXKA2wh2p1eBpF9lUiGyGcNIPV/yINedMiTysXONrgO7ucOyajxUD5QVG+iGas0qumB4bFiocyzpP7HTMAwoQYDIMkYG+IsfvfWd0Zdvuhsxq4zle6goQ9EU65ZG14TY3ATJWJH9SQZIsVEmXwd0EivoyWAbcG4unds4Fo33TAKidPCyGTDABjDroZh0faMpq0FUUAjGJAoWN3E8mIN0MzBCy7JXlfF8181AxRPIITVYN4Jm7DXOUYRw5rTlA8MaY6+vY3F8Uok7iH63Mkq8dMppwaWux/hu2J2C7/uskag3ffD4PFnFS+NoqL/vn5y2gHPHNKeblWadZ5BFIOsIwmKFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5IBhJOBH6queeBYjAm6X7lMT5NXresPPvDPIY8v/VutWVV288Hz4P5wJXMWFU6bqf4Do6yW/qy2Pjx6a5c4zgivfSpyILhSkGweNRpjfl+4J+OENhiGZKMvsXle76V8H5FwMyjE/teANpcKd0VLttP0NOZHMR/J8/ngENgtg2cWrb2Ma0znw+DML3oyWMhdvMPfe0UrpnqBLTqr6rSob2a6+rDahu+f4Fyv767xr5ahnoXwZeuH0v5RXH4TWGwnpeQlliaciTlhp0TgCRCBIdYSPNJ5+z2rJcUB/I8V/Y44oTcUuvcXh8tce3RIziW3zpaHR32mBpkGii/+rDnY1TBmIMga6jBcX4Ax2MK/zHLeIXdVI8yJclvdDMmu20VKk0hvEOz/pFxoCcBFExR1RULDVk93mcSS27YeYNG1woDHme9ciyDW6zSIpOTWI3C/R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:51.1173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd55e161-9543-43b9-af57-08de8b2da63c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675

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

