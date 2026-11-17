Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794886669;
	b=rnfEQ6XhO30SZbwxt7RERNeM31rnm1MlJtupTcwWnhm7qiXoCjmFcqA3g6y4ludIbh9c
	 YgqeUAZk8NBoYdliSoepydFDmACDIsbAxwig0YLu6JWS/4X3eQBqBUV5QQGhufhdD+/42
	 ky/E+tod0P/F2Z7ggWg3AfU71ug6Ql9vz59HxuZ05RMtDQjctMl1Md+9x30RPEg5iq0xb
	 fRwlT5oMOPsznPAi1floS6BO8X9Te8YPhHvI8wQ01cCDTXoFEGfVv16ZK+IaXWxnjLLM4
	 HhKDEdg3F9of7lFp9fHApN9wd48WP/1RYux06+iSD2a7RnPYsaCxCOsaNge7bARe+jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886669;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EkmmOXTxQs8ELc2Lrpl5fdxhAQ4Eo8M1W36jFjdspX0=;
	b=sTOiyjduvBD2Be0My5INPM7feddmp5Ypj0Mf4afeMMjFTmMX4SZav/LVWHI8xE4D+VzS
	 JAPoqWdF3VKhd1VshnUkY4jxytnTMu+g02naIJGO65rB0jAcQFkS0b61/VLnROYlICQPm
	 WJrOEG55YSHbKFDRepisToOicCKtysfvh9baYt0TSlXPTQtRxlibugWG7nSYPnUmApFef
	 lf3hbzYvcw2OJR0I2AT+5Lc1nTdHRCiasdG7aUAyV5kxwXQWunS6ojEmZqlgRjOC/Y3Da
	 hVKue5iE9uMiRolz2Cha9aQb0e1OJPgBGK2YioBloPMHK96hkrrs2xgp5vuXNPJDZ+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OMRxfSWq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.3
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2216606A32A
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2216606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OMRxfSWq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH8jSaubrImi9AYc7/w6qGnXUTGV5H2yusboNqA6/2YK2Y0BdxkXsAYhYgakgyLFINDIw9oqwoHJj86kD7iXEu/rOMofCE4Z3G+JZvlHO8Kk0H6BUQnjKVQJWvD07OsadGjfNfval1fHJ3CmEfLjZssXYpSs/kNv+MliW1M6L+x7GA6wwluokWBtH4szKFZp+FXjsjVCKMoEL54noAQjzq8kiBd6UkAKI70VdIlnRsxBxxkxNQXv4ROLN2wP3BNhgoBqs3xkW2PHoG/iyLFarMyINZfMu7FwqicS9vPi+OgxOynjF1Q/reuzbMCNGDhZBTAXP2T4hRMU8Wrvrvr7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkmmOXTxQs8ELc2Lrpl5fdxhAQ4Eo8M1W36jFjdspX0=;
 b=td19WOvkTfLBnMygeeJNUBC2XrJZU04h4C6mfc+51fkiCXPjALEyxqHM4hnv0/vSXRW8ocrbs+YP2O1aHtIBHKnDDiAuwYjIuld1C1QiaogBHfG+z7F3yy6swYuVXWUOiOpvAuRlPLcioOoXEASLABhLKrfNGdVG8q5Hv9QItEHLSG88e2mAhHo6gEj42Ugrfdj0qERdat4bQoa8/o3Qf80UIJfY5cdY+mrd9U5Vk2UmG1DB/0vyUUJLAKj6tF7r1KRz9gA7r82ADq8SDVnuuMy9xLpFLhhZiNOS7wWgxpHraYQEp6LMYD91FRygF1ZebHaZWd67057dhk1PkfQo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkmmOXTxQs8ELc2Lrpl5fdxhAQ4Eo8M1W36jFjdspX0=;
 b=OMRxfSWq97zlx33BP9wNT5ghezr/qE2/AvHsSlvTC1QFSjbjDtGwOxHfsiBP5mkADfulqwlxfvw4b4FghaTeuvCVixP0WxE4ZyKqpWH6qWVjWKoFyEj0rGuPtRz9NGV8MyO+oh/dDEav4lDe9Wv3ihU1FEIlJx/p6MkC8fWGmfU=
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by AT6PR12MB837810.namprd12.prod.outlook.com (2603:10b6:170:115::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 03:37:46 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::4c) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 03:37:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 03:37:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 21:37:45 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 16 Nov 2026 21:37:38 -0600
Subject: [PATCH 5/6] cpufreq/amd-pstate-ut: Restore EPP state at end of
 amd_pstate_ut_epp()
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-5-682aefd4fed6@amd.com>
References: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-0-682aefd4fed6@amd.com>
In-Reply-To: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-0-682aefd4fed6@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
	Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|AT6PR12MB837810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee659d9-f8c7-4cf2-c0a7-08df445c2528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|261009221227099003|261009223027099003|56012099006|5023799004|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	L98dvbOm+pAc2TfJ/gJ3V9L8uLi9r3uvGD7zgx2VkGBapJq3n6gZHd2bGTSmYpiUzbHnA+fb3XOTiWm5RikksK1un2oe3vTmVmmzPJI/V+HmbdkWutwzOorOH4z0LwoocOzCx3cAjuD1M26+gQmYG3kJZP8ON+YwPq3wxuNZnSNTGGYrD2UngJkHMjtqBmqo0IMyH/V8LqB6L0EhRcsJE4gDZqI9bbcB/O82EyI2HQSq4UDDR4b6QPOvgzJ+UmqpkYgA9nRdJsbfqogjNw+bAg1Ip6OHMGdlVAwYVPGl0kLD4aP/meLVCDVwd0d8zF520SvG/eGJ9jAd2p/w8HDWo13mkQ8WsyMlEHnnkB3RnybtBVZwFbYyTpf813leoZ7hlfZBLOkX1aKbZUZnyJDG44mS65Tk+2te+EH0TGX/4Tla68SpEFepeQo5d160PvrcwllCRYVAWzRT8WKnfH7oAu2+cyQv4tpnJ2MgI7f2KxFrXDl8vQJez9hcRERrYuZsLfwlW0cHVPaeXwAddsPbIz6KwJvK+hST+427iJuyThvgc2mScN36UfhDg1uETr7FQ6ltuab5wngQxyu1UpZpOrqP8zvs4PhpA+2FeH3JvAKQqpLAewHK2W5LhRi3cetgpJO7wTv3aRWwp4NmqHxajQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(56012099006)(5023799004)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YHtRwBQenKeqo+UzYFI7QF06nYBs2ilFKfDQLGxX6qQRd4WrrcN9Rm4V7yJbzuIXL7sLa7stHygnJnPQnkpIjciLC6fehtJMiSNMHTV7w4tDt6RmyOEPUJjiMBC9PqPNyNAQn3F3iIQb7bSdGjHJGRHvh5N1Cl+wl3IhFvkNUdBPVhQ+HJaKYhCh0B6nCwhmvciOQrfWR2m1YMsX9XryFAJ2I7eXHQ6yOxBoQSwj4ahLbmZoqm91s3EzbDRdaxmQwFI1eFORdqZ24l0lXZ0VyfPsfhRxRDMmU/SKtzo9ACy4MqvcTEZd8ID5RO/HQeAtlDb2UrZC3lP4q/uTY8zXtR+TLP5s6btzpe1ekaF6HbRvq8c7Tll3ZGQ/4kiPpNsuyRlnK0XNRY22/Q8zIK+L5VLFZRlquztG0pxwNRKNO/P06Q44PFjptIhGdAFwIzMH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:37:46.0194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee659d9-f8c7-4cf2-c0a7-08df445c2528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB837810

amd_pstate_ut_epp() records whether dynamic EPP was originally enabled,
but nothing about the original static EPP, and only restores state when
dynamic EPP was originally on.

If the system started with dynamic EPP disabled, the test's "dynamic"
write allocates a platform profile device and enables dynamic EPP. The
exit path then skips restoration entirely, leaking the platform profile
device and leaving the CPU in whichever mode was written last (dynamic
on early failure, or the last tested static preference).

Also record the original EPP value and raw_epp flag. On exit, when the
driver was originally in active mode, restore dynamic EPP if it was
enabled, otherwise write back the original EPP value, which tears down
any dynamic EPP state, and restore raw_epp.

Fixes: d61c1ad39026 ("cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-e7023df1-8e55-46ee-a161-01320e6a4082
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 506d7bb2e6609..a861216534b55 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -315,6 +315,8 @@ static int amd_pstate_ut_epp(u32 index)
 	struct cpufreq_policy *policy = NULL;
 	unsigned long orig_dynamic_epp = 0;
 	enum amd_pstate_mode orig_mode;
+	bool orig_raw_epp = false;
+	u8 orig_epp = 0;
 	struct amd_cpudata *cpudata;
 	unsigned long orig_policy;
 	int ret, cpu = 0;
@@ -329,6 +331,8 @@ static int amd_pstate_ut_epp(u32 index)
 	if (policy->driver_data) {
 		cpudata = policy->driver_data;
 		orig_dynamic_epp = cpudata->dynamic_epp;
+		orig_raw_epp = cpudata->raw_epp;
+		orig_epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 	}
 
 	/* Drop reference before potential driver change. */
@@ -425,16 +429,27 @@ static int amd_pstate_ut_epp(u32 index)
 	if (policy) {
 		cpudata->policy = orig_policy;
 		/*
-		 * If the driver had enabled dynamic_epp to begin with,
-		 * restore it here before dropping policy reference.
+		 * Restore the original EPP state before dropping the policy
+		 * reference. If dynamic_epp was enabled to begin with, enable it
+		 * again. Otherwise the test may have left dynamic_epp enabled
+		 * (leaking the platform profile device) or changed the static
+		 * EPP, so write back the original value, which also tears down
+		 * dynamic_epp.
 		 */
-		if (orig_dynamic_epp) {
-			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
+		if (orig_mode == AMD_PSTATE_ACTIVE) {
+			char restore[8];
 			int ret2;
 
-			ret2 = store_energy_performance_preference(policy,
-								  dynamic_string,
-								  strlen(dynamic_string));
+			if (orig_dynamic_epp)
+				strscpy(restore, energy_perf_strings[epp_modes[0]],
+					sizeof(restore));
+			else
+				snprintf(restore, sizeof(restore), "%u", orig_epp);
+
+			ret2 = store_energy_performance_preference(policy, restore,
+								  strlen(restore));
+			if (!orig_dynamic_epp && ret2 >= 0)
+				cpudata->raw_epp = orig_raw_epp;
 			if (!ret && (ret2 < 0))
 				ret = ret2;
 		}

-- 
2.43.0

