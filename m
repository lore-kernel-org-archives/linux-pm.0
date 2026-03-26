Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CD3F7A82;
	Thu, 26 Mar 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525738; cv=fail; b=Gzp9P0PpYaPL29T9pQmsVcPYTPc7dswJohsp9H3N1kGGOihWnd/kgYD/gXljdjg5LKuvT72pINndbb7Zc/nYkaSgZqNNaocXnf75bDguWwWMuRmAeiLQf9KXRT3GLXRJdqXol9OgB7MaqSyQ5mnj6CBxbRuKxV3Yfk6g/oPE/fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525738; c=relaxed/simple;
	bh=pRO6Hef/W5q8wXO+XxzdA+8oGANSZIvjexg4kas9inM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeaChM8U7NAYKlTGaDc3bDofkI6SeyA8q7myWVbxBu1ui+Z8/50Xa4ok9sPiimKtOqWliXArr84SGigTkvmxoqZQhvB7dwn3x0/yynd4+7AOA1LYfBFu/nIuqKBGmd0UmniGEudKsg55w5M2vuUqPHjzggPffXBXklmWR4mDMDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PwvnZZZ/; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PwvnZZZ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOnxHBJsC5LQ+Bk3Tk0hMFSaUYbei9R7tcGHxfND+ZioyxLllvbjRisFCP01C58Yi9vWv/35QhnHZ7q5E7Y4+LD0uqpcq9Op07BVSJ6Hzvr9uxnO+ClGuIlxdkml1zJfnghkxDoBt+MZJ3SO+/UIsEYnDeDHBRUwZA2PdghipHH2EJVUlHEFSvMlvr8cdI3FkI/9H5naUie+70qxJVDnSDJPWL/LJXoqpSa3rKPvwBHutSkJP2g4adQqhfhFX5W/5RH9/SIeCqr8w/1hIyTQQn+uEkXVldrV6WqJPhqzDZDkRhec0xcoGndU35xJiZwIOjWVLsNYhQrj7WU7IWstfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQq/T0LPXQnNi6OrDFu4kYQ3IolW7ZrdtsnnH5h6rwA=;
 b=YAgXUvX4qyUl1d8xYT/Rrp2LmERlgtehxdo0EfUuwXg9Z5QhF/CchprPmlVtGqYT4LNigfS5lPFc/fWMz7MSPIMyOjb2pOfMnMR6XngTfWvfIAdrK7Md40PHqzcYn2/LFF7vrFfsTYewCzW/JFjKnD4bnB8A3E8cEzL5QKmcLG+UwVmcHd3IKDVSR+d5XoiYYWWIfze1PljMu1jBUZVvJfPM+uNrJfxK7hrTolC2PDuRa0GFwLmUOGT/I5iONg2v+MUSospKD+v42w7hFSZRdT4OjK2Xgq8f5ANmTQ8y7OkgbdEuULl+lAU65aLBeklPm6D2Ol0PE7RtUEpbLEigdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQq/T0LPXQnNi6OrDFu4kYQ3IolW7ZrdtsnnH5h6rwA=;
 b=PwvnZZZ/AlfcveB1NXrHPbecSF95xrGJwx3+MH/vfjihgNlRG1s2d0z200yFoVG68LaZEVeqpJ917qDjjHCk+MnxoQ4h6t3C8gj+CBxGG/hy7DVcShN2qUJxfMOH1i16jJNlhmAri6Rt6z06iJamEsTtrIDKnEzyintzfwkE6SY=
Received: from DS7PR03CA0327.namprd03.prod.outlook.com (2603:10b6:8:2b::35) by
 DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.6; Thu, 26 Mar 2026 11:48:48 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::56) by DS7PR03CA0327.outlook.office365.com
 (2603:10b6:8:2b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:48 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:44 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 11/12] Documentation/amd-pstate: List amd_pstate_prefcore_ranking sysfs file
Date: Thu, 26 Mar 2026 17:17:55 +0530
Message-ID: <20260326114756.20374-12-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e14715-45fd-4f3a-f39e-08de8b2da45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fzpNcOZ4/UNudKftlwl/GKX93kGqr5MHjsXVFHXXz6KoPSD2RGiuMwxF1Z0tYP/Wk2s2/IFOJmSQh+JCQ4qGtvFV2QsILAVVMLJ6I/fHzXv2GCSJ7M3XcE7NT7zpQBHdPF47Yq4WZKj2HfdUvwZ4TdoBteBYgpoHh51F05FrN9siQbmTiRsrGdOozBQA2xHUYy1DECdHbSfM5rtntb9Z47N5rJejyMFJJFqULU/5ngAK05S9ZHglNMJRTJg5yeLxg5rcoO0nCOYqRjqW0IV9uGvs0xGHqfgODX+f4jQAwvLyUnkLq7Lund6PtDmU9HM9yweu+JcgCzaQE2ejJSFkEGIJLJbAjAL8Fet6H6UJO3C8r3CWXhjcA5AVSrMGCqrMbIK8kHrp6hCCY1AmZZqnXfvn+Gcbbb0l0KJ8JtYZgdgCgekVM8tQVje8ZYB/U3JjKAtAtcV07dJE+OTMK6caeIBYUNTZTmBB3vQjOuD7iqR3TqiWG+vKwvt5hV2DaGZ2T+hqTZnVxyTVCdXcf5Iq+xNGZKQ3LXAPXkaEp74k7Gzn8d/C/NWVU+jIYh4HbogDYGEL12uYUz3hMrHfWzcI3R8h9nEyotdpLrhFfKHzOAYx6VPcAxjVRmvVXHS6PaSowG8mNcQrdTsZAitTL5ESG47hi9FAPaMcqZyNeGlkyNYkc9L7tG/XrfH2kdkOrJr4Pri4vAMP18ZQfAl6iJ1l+WLaSOHAGT4I/ew5tEBH9AhR/nc/nHoC4/K9652cldDzycMBSdq0mw3nLq58wtZovw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UDJ3/rOyoHOLJ24NolZsvm30H41jviELnugARyZ+C7wgLxZe16cIGzV2VqcZkwEhwSRHHx1KJ3nmL9882AiYuWCdvkDymlwir6nNj7D2hD8bKIlvllmhQiKJsd3v+pMTB9VkTNAYgdjSEKsNN9JfMt+UrTZHgaTvMiozgXexH1euKukyP7jxmPZtMgcqFYfSwFsYcXnxGPZlqDvjAyh3tHMrj1Dm2WwKem6CuxBaUM6I7Y6v08Lc8WFmIpIujVVpfYAjzjZEqVhyj5RNLhMdriFdFpcmdms7OWWZG+pKyamyu0GSumX5EMjtrWBdxwhPK1QTlNrXeETVF9WCH+qxCFRy408qCinQOenvissZ1a0SsKKJqrBZ5BtUCQldPpG5/dizqN1M4FVTG1zpRQu9BfhBYiNg/PYolYHvhINh1emTnc07PKFFdSwzcEPmgnOt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:48.0218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e14715-45fd-4f3a-f39e-08de8b2da45f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751

Add the missing amd_pstate_prefcore_ranking filenames in the sysfs
listing example leading to the descriptions of these
parameters. Clarify when will the file be visible.

Fixes: 15a2b764ea7c ("amd-pstate: Add missing documentation for `amd_pstate_prefcore_ranking`")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index b8c846cbf301..b31a478c28ba 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -242,6 +242,7 @@ control its functionality at the system level. They are located in the
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
 
 
 ``amd_pstate_highest_perf / amd_pstate_max_freq``
@@ -273,7 +274,8 @@ on platforms which support the preferred core feature.
 
 The performance ranking of the core. This number doesn't have any unit, but
 larger numbers are preferred at the time of reading. This can change at
-runtime based on platform conditions. This attribute is read-only.
+runtime based on platform conditions. This attribute is read-only. This file
+is only visible on platforms which support the preferred core feature.
 
 ``energy_performance_available_preferences``
 
-- 
2.34.1

