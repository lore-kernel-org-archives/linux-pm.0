Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DE3438B5;
	Sat, 23 May 2026 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515737; cv=fail; b=MvfrNFX50naERH8Ca46513aDFdMiqhN77SsWARZBMrcQtn+SGbrPLoE7DLepl03D0yQokzZKoetFyyAltUW9JrQaF7ntRChl41nBMgikwuFzl4L1lsLpqbMHZDTNmQVLNMCn7VBx9OBAimvgsnhhGq8mmvgXiLNWibe9p+4xlR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515737; c=relaxed/simple;
	bh=SE5DeKPMhEPtEwwhODWckkHZEqV9HsMnS8UCa9oiDMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tJVwPDUsVK29vi4t0Jjr/F4eTX8ZuFOnMTlp+2sXEWJNxhA3Z2Sk6EuYlpAKDTM+eLbSQsz9YcK7+pAb1WaNfL9OR09IPJ3UNM/IIGlfAVY3l5kyR0a/oY0hs6OI3bVBxvRcVJOx4jvGVbI8qC2D4oUqsOWlUNhq5flhaT+8bgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eTlIXbks; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eTlIXbks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWt0jbNXS6mZhPVYjGwt+Xx8xnVzLO1oydYYD4vcWFNY9DhGwY9BXO8ABJC0QTZRdLc1vixr8Xyb8/d6lzrTQZ9pEFVIa7H9i9+61wj9kGo7edhgAlbkV+5C9pGJILjOmroy6C+gaWnpza54/PeJk5EuTzs3tneH6CCyS4iMm/Sq1L90V8auroiFNAczU8AaWtUEkc57HDhhPIdm5iBSpn85r05OK4lzLMka0MTExlArTgUG+4K42Xy9xBTRTKjpSuIwnk+9/mOhFkWd+nrfn/UXZMg/vhcJoqe9gliE5xzc6/b7idRQ08pNJ6EkuqAB2G3Ks6DmDXLpzhrcgG9y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1JzN7jMo/Puk0DxQtFVcXnYLTBAf6kfstNPrAcMiPU=;
 b=CPIM0On5tShoAazrty28C9C0tuqSAOokFTQ6WT89M06O3/BEIwCzBkOg4WfGnkn2Df0hpfMCyO+Ym8aaEa9z2QWVyWao5oXsl5vEVKaOXCP0mjn7uNFtfBdvrbQkBvovWaHXJk7kPuLGwKyhVuF79gDSIfmkPBWyqwT/htaXsFMqoqenizPJMISVoanUPOJHpGgdtiXTAGCJYxFP31XrMWEk70j+/EwJhQcsvlBEkAbHGpIgyJlRYGzQJd1FXOZ2YGVHjSv/9VPURTHBRhLVAQM+b/o52ojsBEhs3edLpLwT625cSbRzKUdrmc3KQXbRRUEzpwtG14zjv7nViSkXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1JzN7jMo/Puk0DxQtFVcXnYLTBAf6kfstNPrAcMiPU=;
 b=eTlIXbksZGmHErKc2VoERjr8a0qEBXtRyd3mlUliwc9SH2OtRkDkhJV5Zw31q5UluEVaWfHdaayx8hf94p6YN4pk+VU90i6XhFgumeTtN4nbBslXQ6ck0f1D7Z9zjfnI7OtXNq/2uBeYE1sO8D1tl4/3M/6TZ23CQ8U0N3MUDls=
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Sat, 23 May
 2026 05:55:28 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::70) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.10 via Frontend Transport; Sat, 23
 May 2026 05:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sat, 23 May 2026 05:55:27 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 23 May
 2026 00:55:22 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Kalpana Shetty <kalpana.shetty@amd.com>, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] cpufreq/amd-pstate-ut: Disable dynamic_epp after the mode switch
Date: Sat, 23 May 2026 05:55:03 +0000
Message-ID: <20260523055503.7651-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: e38c2465-e348-430f-8bcd-08deb88fe3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|3023799007|11063799006|5023799004|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dPeLr0fLgWZcMe9nCL5weMgCPN7SdB3UNZRx5xjzngg24a7XZ1APv0Yv4euB1oGk3wyWVkhYn7VdqVwUQYlLYLaDUg/g4+ZDq045XefGK9NHIwX8wq5YErvL52sw5EaMi0TDDKXjNy8Sc0yD1fjHf8vSQDRH4aVKjTCj4JOu5h2OVR2gWv6aE6SKiPRqOVQzuJwBH2JsyMiW/9R+E5JqREOTRf1eS2wmyIty1gdyIpxrcMWKlV10g4g+FKL3DpPi66Ms89vr+Grwsy58R4ZnaY23+d4qoKE3FqVegGgKAlNVBK0yz06DIVLVUm+W54OgNiC+rY4Khze97kJ8cFGHzQStfWfo1e5iQlCfADd7mkFsafmqbhPjujPgfwP4COBOl0WshTApzNB5i+jN+uvgo/fspZ2+cFpko02vn2thN/LXvBxyLbnj1r0QgwSuxnM3LrMg027k2RjlXQ0AvQ7c5SJ18aaFNuBG3teMrFUyzjmeSYkZJOEB6NRCMt1UqbwVESwO8D7wokey1YrMevWNABP2SKuNQ3iKAMwzVEWKAweJ1G9OaTPeFgngPLkM71oQK/S/Sx86qq+iXWsSajZFREosCDNzU74QNdT5bUXJN4N6P7xU6dtRaPD8SSsm5zuMwmu0tq0Te6rWjCfKSBcmvN/r4txpQJEIMsxCHG7lUxWHyZgob+smhzLggLp068HO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(3023799007)(11063799006)(5023799004)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cykYzCNoBe5Ctz2jYKN2niKHW0JlrL9/pDWCzP9ZtWB2vAkjvCxnpje+xBUrXBz50fyI8JwlQQYl2vY82rWSVYb1mdJhu3m5f3d980kGBywLS1smRuWA7Q/K4z0AP6EsjIpu5hsM3OXZj3ldjQF5Ua0Uy9QBfWZulLtKXf4FDm7kKND2SM/2ukX+atWKvh3TuaqrFdSOTL2ab8LRcKCnwTdJQ0+Z8PxccIlCYAUCNBSMdgueJgy+81A+EqRy7EgFbSyWua/t3AC0P7/fEEIpRUpWMxwH0M+tdU1wU20U5ltk7A1SVX/D9OYg9kMLCaBOd2MVfw1rgqsefp6SHbYM2HiacC1U91zw02x2WBz6GtVavYVkMtcYYpF4qrpH3qZyBvfn29ZoL4WR7bpgdjXx/OQK3q0uHRaLKmuB9xK2LlYGDyAr0zsL5SxgETFSRpFB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 05:55:27.4433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e38c2465-e348-430f-8bcd-08deb88fe3da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

Dan reported a possible NULL pointer dereference in amd-pstate-ut.c from
static analysis and sure enough, running amd-pstate-ut in active mode
with amd_dynamic_epp=enable results in a crash as a reult of the policy
reference being set to NULL early, before disabling dynamic EPP.

Kalpana also reported seeing amd-pstate-ut error out with -EBUSY for
"amd_pstate_ut_epp" test when starting from the passive mode and
amd_dynamic_epp=enable in the command line. The reason for the failure
is that the command line enables dynamic_epp by default after the mode
switch and the modifications to EPP values are blocked when running in
dynamic EPP mode.

Solution to both problems is to toggle off dynamic_epp *after* the mode
switch when the driver grabs the policy reference again since the unit
test is in full control of the policy after that point.

The final restoration step will reset the dynamic_epp state via mode
switch based on the initial conditions of the system.

Reported-by: Kalpana Shetty <kalpana.shetty@amd.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/linux-pm/ahEq0CvdBX0T7_cO@stanley.mountain/
Fixes: f9f16835d4dc ("cpufreq/amd-pstate-ut: Drop policy reference before driver switch")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes

Sorry for the oversight on f9f16835d4dc. I've tested the fix
exhaustively this time around on a Zen4 system with all combinations of
driver modes and amd_dynamic_epp state and the unit test runs
successfully under all combinations without any errors.
---
 drivers/cpufreq/amd-pstate-ut.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 13a23dac477d..735b29f76438 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -302,12 +302,6 @@ static int amd_pstate_ut_epp(u32 index)
 	cpufreq_cpu_put(policy);
 	policy = NULL;
 
-	/* disable dynamic EPP before running test */
-	if (cpudata->dynamic_epp) {
-		pr_debug("Dynamic EPP is enabled, disabling it\n");
-		amd_pstate_clear_dynamic_epp(policy);
-	}
-
 	buf = (char *)__get_free_page(GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -327,6 +321,16 @@ static int amd_pstate_ut_epp(u32 index)
 	orig_policy = cpudata->policy;
 	cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
 
+	/*
+	 * Disable dynamic EPP before running test. If "orig_dynamic_epp" is
+	 * true, the  driver will do a redundant switch at the end and there
+	 * is no need for enabling it again at the end of the test.
+	 */
+	if (cpudata->dynamic_epp) {
+		pr_debug("Dynamic EPP is enabled, disabling it\n");
+		amd_pstate_clear_dynamic_epp(policy);
+	}
+
 	for (epp = 0; epp <= U8_MAX; epp++) {
 		u8 val;
 

base-commit: e4e9b7b38d5db2cc6a8770bc0596bb8b36b92b1f
-- 
2.34.1

