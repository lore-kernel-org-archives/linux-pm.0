Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D72750E6;
	Fri,  8 May 2026 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217526; cv=fail; b=a8o4QT9izNri3WegZZJP1YEskte7SYTAL6hSq+fUBZBCxyINY3RXXVgUEK3guuga3zKdT95d48cfhNCX03AgvmOCc7yBc2PlFTXJOKlZUVpJjE7Ge/wj5KUYAWAp+04toOo3QLSUoqMZn7Zzgjwhj4To7mbhYs8lKmuPJSydh/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217526; c=relaxed/simple;
	bh=ypoI1an7l7zqWvdnA/EKlnGWJUNvc+om8GX6CEDxfVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBuajfHITBatTPCJIDgFMpLkIfjl3elCzvHI6NQuBTtCvuFHVKzP8SJ4oMAaOtE1IknujGWC8tdOSpUug5aU1UN1N0S8xlkjEi+onJjH+r9QpSztGJPGYKlUNJ4WelFo9es/I3QjIndd2BUvkHVkIYUyIPXs3yJpgV+Ao/Jbss8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JM9jGnD0; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JM9jGnD0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wk98911TpfOPg4ukzeuyfqzOSpNUrA9vYSWGlMjMiNVTf4A/UVB9paKZm9JS9rCTMP/zWvobJFAnSoMk6jmlf3etnaLjRcsprWPegJpE50VbLeJTvHR6cFmwIakYQnUI9FhpOVgWYi5H/4MAfUz6w6VtVzinBNxKhJrZBQ06UTJAaNLurieSWi08bsMvQWNvEZSW6TLfTLOR/ab1/oXOqTnmWwrC2Z4i9Zb7Zvq8ejsLlRWh0FxS+v3KMsCvuZiC0p3Eo6/rkOMDEZ0JtNYEjDYqP0BCd2fhrvkaTto1Sidmf3QQgo95kBZXfEQi29Bygazd9ruHIxMExLiWBr4XBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS30NqUeJkgpMIq2Tfz9buWechDzrqa7doXl7DjUd7U=;
 b=QLG0zJ7vB16oHLfsNeBrONe7cAxp4BNJdQinTAsTxsHwq4vEzAxZPBoOm/8lYWunFvCiTNLiJee8hzIAqSLqAGwmpB33rtqwXJ8YYocdxvIz22IDKx71Bw6wwkCRdGL3vYcYBM4EmoVMdBdqGaDwGoIatssR/8gFmrpOilQ6puINCsRzuZsC/9ScSxOnV3r+/zJfJf85JK3jrFAZXePKmTP0KNVUVRmRTuhS0M1n7pnyzco4AsVxoMLhLbsKm2OJ3eDRYXGLisJe/WdPaCnGZiDlZkfaG19F6jWaWyByCJlxjp/lqCA/u6EfaXIi7n+V450Joz8vAPJnusdjOEzDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS30NqUeJkgpMIq2Tfz9buWechDzrqa7doXl7DjUd7U=;
 b=JM9jGnD0RsEXrR3Vhu8y3GRvKQOw12UzyI9+bBEiW6+EBwjSGxzi0vupUcgkkM8WNrVnJfJWsbOHqZ5wHmnUcm02wJYQOfMrTTitHW9ydSiJWVd2XD5+HQEoOF4NSzmj4xxcdqVb/+a7dxzER5+NeFPcNM3neK67MDr0z3lJZ4E=
Received: from CY5PR14CA0003.namprd14.prod.outlook.com (2603:10b6:930:2::19)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 05:18:40 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:930:2:cafe::7c) by CY5PR14CA0003.outlook.office365.com
 (2603:10b6:930:2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Fri,
 8 May 2026 05:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 05:18:39 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:18:36 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 2/6] cpufreq/amd-pstate: Return -ENOMEM on failure to allocate profile_name
Date: Fri, 8 May 2026 05:17:44 +0000
Message-ID: <20260508051748.10484-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508051748.10484-1-kprateek.nayak@amd.com>
References: <20260508051748.10484-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bd3ba0-3981-4770-026e-08deacc14395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5T21xXabEtB0OwNWv2XEAobSasUYzC9nxHYnGmvqv9XiKH1IZWJ29cUzFgOT6YWP76NdqlV5hiwkZUuPt7WDtPbTVZc3erbT1sRIW3LhD2ANAJWWHiwYqe6p8Ez7AfvvtcoHjQJqGYvONVhpAYFtk69HYBOdvxhqLg0PehDgo7Bl0EL9ZxDMo8I0tqYhIoFhnCkXuA1Qjpb7k9fQl1h61BsHikEOtkwSXkYTx0vvA+FIoBSNHzd9vSedtwf5ub0IF/Eqp1yW/wZHrYMNNFbVAp/aW8FOO59gid3RrFklDqsQS5LX7jHJ8WJbUzxUzPSV63B6ONca0RDdAeMUdW7T5mdzT46ProoPjyzP6aD0XQTS2sUtcrnG/XzksDg5xqzFcQLjLEy4x6/qNs+EEW9Hu57CxHPQPzEQ9XqSDKKt37C45bohnQVyVOPtUxZtojy5FODxW2dVIjFzHbec2nfBElcjnpeg/WxK8BgoOkORqhvEkj7zqCuN7RQBvKbZPe6Yig3STP3rT+N42t3CkTtg+W+vJJo9RRTybNsxH9ndyj608mC04o1H+Vky+XSMykgH9r7A/Hc6NC+655taDRc3DZQMy9H8dH+L3uAd0WHPqlS9ORPREgsQJ3NoKW3+ax8aHV1E9aJLznRXO1JIQw8lM6Zn1PKh9/uDfpAEMPf6iPHyUOFRYRomhp5M2LYtMuGUcESCtugdOJ9Bd6WwqEGfnkwHvdx0xH+Q76mDKKB9Lc8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PXq8bzl7cWPpcrqP9eaxkcFG36IdcOqhzYVSezWv5vfm/NjZOnDtoZezVZixbuigQoPbdo2ho6kisY4+MxkhY7v6jSQunvlRoUBGZSaPict1WCzgUGUPfyZeOCe3zSAnYxbKQI5MxqQQYHlakPjmxkBpV8UN/URGEooK9c31JVYNHKynIM8PoK8fAPvS98WC8VtM1qt112v6X6BkmlYrsU/j2sfHPAG+oOKrjcWILuzWum/4cob1VuVvMpx47l7Ji8VKaZbJ33lQCxsJzEY+3pgyaIb72tVnEsS6CfwYt72HBMNaS3CCtCuPX2GAI9UbTIvLQyNIuB013wMuQdhPZOI1BjrXmsS/LDglrNp83apPA5c1yjd2AdndHMZEzWfwyijhhd348mIt1Wmve80PIF21boEcidQBaZ0TpMwqNdkTQ7MWknaR646j9eKoaA2O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:18:39.5398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bd3ba0-3981-4770-026e-08deacc14395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

Failure to allocate profile name will return -EINVAL from
platform_profile_register() while in fact, it is a failure to allocate
memory for the profile_name string.

Return -ENOMEM when kasprintf() fails to allocate profile_name string.

Fixes: e30ca6dd5345 ("cpufreq/amd-pstate: Add dynamic energy performance preference")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5e2d28c73294d..72514be2f30fb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1291,6 +1291,8 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 		return ret;
 
 	cpudata->profile_name = kasprintf(GFP_KERNEL, "amd-pstate-epp-cpu%d", cpudata->cpu);
+	if (!cpudata->profile_name)
+		return -ENOMEM;
 
 	cpudata->ppdev = platform_profile_register(get_cpu_device(policy->cpu),
 						   cpudata->profile_name,
-- 
2.34.1

