Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479543F99DA;
	Thu, 26 Mar 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525741; cv=fail; b=d/3oERkT5+2clKGIIuzZDjkI89EXbtQZkDVz5p2FLmzwwGCPYZyaBoQhCtaTA8vC0WGzBrBylAGur0RVMgC7oViw2bktpme513+ggJJRA+Ury9Kjs6KPhZaIGMpXgbSzDIaqBoBzRzqGiKKVk9DOWu+JFJu0wVUM37nE9BpLEaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525741; c=relaxed/simple;
	bh=P9KB+2X1mAg0Xug4+ksC3lirYjVwaF7qGUY3j3Ik1K8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDAQg/cGmchuOrdbxY3zttX8251L9tYQs7/Oi9LIrq4NwdZEp1/25qsw9xJgMwMrRMUsq2EM2qJ/pltIdSF/Na4dJ36fy7iyp2DuyCm26sCl6EGYqsjsMB839ZPjda1m5J7xAx7R+4JeFDuO4TFgIP9/IuUv8UbgAoIZkrAiYhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zlhd+iHQ; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zlhd+iHQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAin5CSKYA8JPAcDOqYkukCvD2szm40ZdD68vs6EQEriWdppKKJFq4iJzJ6GiUXJ+L5ZOfwAim8AOO8JOC490qbagCc7vORTNTLNsQAPyt5caoHUq3zKjlxZzukINpKJ31FJkZtH5GHEh0IUws6UoUm9o/ropo6mt6DwsfSdojetCSdb5tzUD0dtnKfsgUZN+7J8Iy7xVwNQ6v0PiCJeBXtB8yYWaFBlx+6S7LWR/2wvxA7BKePH9SumLBbn60ARH2Cstk7IpCVF5cjE3VFvRsdz0BV+t1GwDtDGTI3Xw+1QKMWzKyLCTmX+WeS3EmCPR8OOqBbMoXf2ne8wb0Lczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GITbD6Y49EzXl7KY5/HMNz/7B6r4x4Llh75aKGlS3rY=;
 b=nAXx6+bj7MNqJ5gVSyRmJLgbhVGRcyNzPHAd8k4vHb+OoB1OMPQAF5xNWpi+lfPIcgqTmu4bZAcoXTQgJOZkSKjDLSmtAtQhSk+oBC86fQPZGkSr4M8yWwd7WppuppvtLd9TwmvIwv9BuzQjq1PxY/hHYYDHBZoPnM9ZyHVRDxDp2R4NKgJwFs4vIxQTOABo1JywZ+L4Sphs3g41T5x12CJdorTwF8lKJJwwD79cwAXAEBihYtWQAKNl15O0Zx6UPMW+mV+LsgHGZfStMDbeXcUdfhDdFWGTba5PdPsKDDmXCqvwTRBGYdIfz9uJG/+GocDbFPr/XGwkU6ZOVOqxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GITbD6Y49EzXl7KY5/HMNz/7B6r4x4Llh75aKGlS3rY=;
 b=zlhd+iHQVCX+fVUHd/wvMORHhE2DvJVz552i+VjvpwGNFbFml2F7mj5xkhYPxPJXgpCgLwm8xhDjwHQrLH08g0hanxXtHMWvlKrklO0lDPegf1IW9+OUbsICbPzXNs9KtvBehEyXvMYjmGx7Jgf34hyjvfIEKV6+TpBaunXwPn4=
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 11:48:46 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::5b) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:45 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:41 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 10/12] Documentation/amd-pstate: List amd_pstate_hw_prefcore sysfs file
Date: Thu, 26 Mar 2026 17:17:54 +0530
Message-ID: <20260326114756.20374-11-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: efbcc7db-93a3-434e-117b-08de8b2da30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A3iFibFw17NOEBJsTVWkzU0zf5qTW6x5JKtWgF6W4mJMaFqrBVCU69O43Tu0J4YzKNL3S8rJ/nmgalDmcphI2KemXW5f3Yoga4cH7+YyPSA7hLW65ji2Ih/SIemYnoQptSg5eoVbfkDbMxnPsFyzYU8LnBSwasCuETu4nZs5dB5yHmoQZDrCnXEf71gnnJCOFYm+2BRsB0zPrFHOhpqhEqwMWi5Jnu8fKd0JoLYWFoPuwJCUN2mmlO65I6cz3UuX2aAhAxrTPxInC3PsOZ8aIQHapleeaUpLVFQbN9nyl2Vsy6ujqqvUnYqM7AzBqZdNqkkFlnHGkKa8fHgNu3HdEJAJezLK6r7md60CzudsDgdSS6byN7df7t+Tkn0CKzX5dDcan+GH8PLOnHSM1zGRQHSLTS3oPCym8pWkurPcJTbqaz/PiFWpenF0YBgR6F63T5bCc1bswJsiK2kP0ZzlEt/ssrGW8VrXg54BZ5yWYG043Em3aWpz/4OItkN5bfQj0sVJj0w6bCWgNT8V68h2ilk6j6iMkjHuS9PaEaMcsAk+pGqbVRgwyIrU5S7235acKB64JsOe8G1x4zo/el6Mu6F6l5NxLcKA3W1q0aJ5haA58NMdwVaK8xfCMeqsn2Xyr7AWJwCyWnrb5Tka3rJO9oxJBMR4Jn2kAVhHt2gF73zeCSmYW6X6J3WLPYN1zqZNZYbUWfAScw8C/QVMgTFHYBPhBVmwGymkHNgy+wOSIPVQpeT4bErH1+pezQpbt3inypkHbzGlKnBIkqnYC5kO/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wsAjCPqxE830ICI4QG2GvdoDIpHjDvl1v6vrC5Kq+eVKngizjmWa26lh0wEirbwXjXS6cWcJr2HwQSnvPmVWmWMJ8baisMjyBLAUi3iEkXEmqR5j8JR5uGV4vwamc00nKJhyHCZofXOk1VSBOzrWnhSmooou11foISmLTCYWEsf3ys/91ubXSpBxaCoHW29NoJ0UmsNTVw5/llqHFlxNA6UZXP1MvE901OU7Yt5FqGg1dpzhLMtK52QeE7XVSW3d6QcNNHMhXHPcLVL2Be2+A0enjB8mMXp8J8Qk2IpavGefN+8bZgfuirxBDFJFyWLjF3WUCXRl0yO3uzHFUekXTm3oypkw1X5RuLsodtmUwqQUfVDQxpe/siEdzgEdsl8BNKqTYkwyqKsLKkEBCvCtw6vW3q8Aw3DKfLpU34iacMDw8NHf4H/QXPmk4Wob7z6R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:45.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efbcc7db-93a3-434e-117b-08de8b2da30f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

Add the missing amd_pstate_hw_prefcore filenames in the sysfs listing
example leading to the descriptions of these parameters. Clarify when
will the file be visible.

Fixes: b96b82d1af7f ("cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5..b8c846cbf301 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -239,6 +239,7 @@ control its functionality at the system level. They are located in the
 
  root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*amd*
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
 
@@ -264,8 +265,9 @@ This attribute is read-only.
 
 ``amd_pstate_hw_prefcore``
 
-Whether the platform supports the preferred core feature and it has been
-enabled. This attribute is read-only.
+Whether the platform supports the preferred core feature and it has
+been enabled. This attribute is read-only. This file is only visible
+on platforms which support the preferred core feature.
 
 ``amd_pstate_prefcore_ranking``
 
-- 
2.34.1

