Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794972487;
	b=ikpWMU6F2OUYbXjlQY+OoaTtOLN+GfEotyz8rCieDP++YlL/MUG0yX+0bTn7ZgulBOXv
	 ZdG7RyKrPuXehO3c1SET/Efw3EY6YXJju4L4nboaDAFHxSWwqE1DPGYy2UjXNPK1ava4L
	 6cfPqQMj2FgnUSvxXZe2sg4E54ENgGJLylGLH+uSiAyRl9KJ8IGFGpdX0jQ3O7PeoWuaY
	 u7lcjr3QB6QYcWi34FdOgHeub0+d0tNk6voIFqvv6pYRb33cXPe4B0ePzCeYNcHs5yFpZ
	 HRGeJ+aY42c9bAfakr8pk3YdgJnTvsB9OkfQY323Bjipoo6SL+/NDNGDyXv9DbkdbYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972487;
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
	bh=/4zdBLMhX3sfKsiFWNNXboL7GsIYO7sm/YHiIFrasX4=;
	b=FQQBdTbj+ih1Fm1QI103q+CmiPgobwQGYqB9uC3hlY7BZr/Ci2I3FajReEg6pseox9NI
	 BGbZt/F92kKh6OQLu1ugJvmaMMk472nkSWItHMzxHkoGWQpaDIKVD2092CNT3yGnIoWyZ
	 bhj/2209m0cYmkk8BoPL3jaIeeMtFL3wT3k3wLSX5pT5hDtPxUXhx68QmJmCzkvY2grIK
	 nQOOQfgrAJ/Wr4XAbsoHTfSfgtTCRXnxQ2Ocvg9Nxiim/xz+GhJ8MtiaXxTjevrlgFsVJ
	 u1RSyWv0pS/Iojm+7HCjHCxT+ubEZAdWVOb3mqee8+FBK2/dd9YxJOqGvIcDJpxQnAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oe01gths;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.31
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F9606A32A
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C07F9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oe01gths
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjvuV91kthkh8tRGJus7gXWfRbM/sELfcw3sKOjORTZkZSKH9xLgH+LM82hY9Y0FeFP9KIAiXHdo+hqFB9cgGeCq/45VDBrhPddc0+adhwwrN5Xyo4QkUyKjVdxiIaQwbZHhSLEGwfQgZG+jPuNlHWVyQz2Hjwu6PvkfZW2ZlVPVhIAs9JuDAqjwnjZa0zNLol2dX++4d1cLpRX/AmwBftvPFu63fI1nQU8aRKySAaqrrH8uvoTbVyP2dFX/O6LicGk7e11fDy9y4bopwwAWYH8tnVfGJJdOCLPXAfB5EiAY9MyS792kAqta6W9o+2fPjpdhBdS1jtNWPBXJ3fkvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4zdBLMhX3sfKsiFWNNXboL7GsIYO7sm/YHiIFrasX4=;
 b=YoU1+ONFiFHkGcnj8dslJbXXT56fgL3QCmlrkGELJY9W2+NJhsu7ZoL49x5PaL4tLVhYI+blhQk0OPEDwZ6xkakJVC4uiF6o6f6k6rs0VD20nFsLL6o154w7NPZ5Rg5qxa6eUSMdX2UsqO5peniLYId4tk72S0+Hod7D7bhZW+cTjdgj742HpRyPHWORUwLR0bKDOGcNCCA0DWem+C9iqwHGdgIhTP936AXS6+ZZKIg1gLCboG7ufEcetgV2x8o6wMaGV86XBl5LA8ZkNkyqPbybTRXzEgPqyweDUjBbgKnMq/BdDZikgteMznWiU45Kkc/BSb9vPXv3RLKDIo5MfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4zdBLMhX3sfKsiFWNNXboL7GsIYO7sm/YHiIFrasX4=;
 b=oe01gths4t9n+yNCqIakRCbfaeFNB8QAigeEz20zsKlsGHEUh6bPRn4yDZYU0ne/+fzWPabEqJbsH7uXUqRiy91Thu8FLitZIoNCmqDz1+vLR3aJ6lEeYVRe/2OoD1qumusOXy4XTtWYqqrUIcMCxgiw45uAwcxr9LsLatIKN7o=
Received: from CH5PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:1ed::17)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:27:59 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::3b) by CH5PR02CA0001.outlook.office365.com
 (2603:10b6:610:1ed::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 03:27:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 03:27:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 21:27:57 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 17 Nov 2026 21:27:51 -0600
Subject: [PATCH v2 5/7] cpufreq/amd-pstate-ut: Restore EPP state at end of
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
Message-ID: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-5-2a0048f563c7@amd.com>
References: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-0-2a0048f563c7@amd.com>
In-Reply-To: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-0-2a0048f563c7@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
	Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: a00b301f-b230-42d0-baa0-08df4523f213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|261009221227099003|261009223027099003|56012099006|261026140227099003|11063799006|5023799004|261102123227099003|261028144727099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	z4733ZzG/DJZftuGdcObcHt4xF6mPW8CioWLo5tlOdHcL2XnZopCXJr/YXQEh4eSk4ASXVmqsCTOxEKdrTI54b8es+MCWYh+8/SVzdAlcc3QjOJllJcLD/mk3WuoFBaY3Hrr8draONZITd6utrN5wkVri455Vj3IwnT5CN51WpodFxi+D8Db4uc7hj8e2eBMJEenDRQCNGutuCg5kGACtnjCwdynPJJ4pdtz8L7vtg/D7wn/77vgCWpfMIBjFxZP15j8InE9CXcVNdQ7rhdU8OUW6biF1A8ux/48r55Qa21XeCZmVmmhxYp2/VTQKxXy5Pp/CRRLcZZx6yWcoNVrWZk9gIUJuU+BjYOsQpf/0nLti1uVVJ2HSrvfmrGBHK2trH+15xpcZGJ8aFRXt9PveQ1X3ufry3uyTzOftmmctHZu1ae5Gb4tGv+jC13guMd1m6cpWEka3g7MhHkxKuY+4K0ova58/m+20fl4OgIlGbX2CVBjGsDyGtryUlX2OaMM8wXV8s4y7iZKSIUpCY9YoJ6srDThRuKsWpWeMOT11eH8o8wRjsnoR5gaBEKRNetTUfDzBOh4AaAswVPqnsJmySaRus+9WZ5YJThMPU8OfN6O/DQ1s6XYWK79B9XE/J9XoomzI8G8krYRbvHEdU1f+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(56012099006)(261026140227099003)(11063799006)(5023799004)(261102123227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PzLMO/ZCGV3T8QAccS0FSLax+qWbWBC4Of1hFaj8BA1AzRGeIGqloNYf3WmK4tWolcP81U1QljORXUQf56S0Q+oTCsPqN7lk/LYUQrbsnbi4FeAOUBPRr/EpkYz2i10Rmubgh4EHRhkZCAve9TwFLfgWC5VP1ABJ1Tp8bQGkScj980phJGhpbgrQ6j2OwAzw9GB64ye2cE/jA44sy3WbGUIYTaAvTurEUaoTS1CGcJ81RLKYP5mBfq3a+AvGPsoPsCVpDU71RsmkwftPOzWjVrSTug8aOCk1DSws6XKw+ovTmvym38jawHQhcMaLymgOjGWdHpArhbs7RFY0Io9fgy0n4Tqc+Wdyi54ZrTdL3yDqBtCt04K6svI1REAjeXqni0oS/Ks0IANIHTXiSQ8F76yykkDaL9enyhemOrMr9hn08B8zuGP51NEu20CdNeO6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 03:27:59.7029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00b301f-b230-42d0-baa0-08df4523f213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737

amd_pstate_ut_epp() records whether dynamic EPP was originally enabled,
but nothing about the original static EPP, and only restores state when
dynamic EPP was originally on.

If the system started with dynamic EPP disabled, the test's "dynamic"
write allocates a platform profile device and enables dynamic EPP. The
exit path then skips restoration entirely, leaking the platform profile
device and leaving the CPU in whichever mode was written last (dynamic
on early failure, or the last tested static preference).

Capture the original EPP preference string via
show_energy_performance_preference() while holding the policy rwsem for
read, so it can't change underneath. If dynamic EPP was enabled, trim the
"(profile:...)" suffix so that "dynamic" is written back. On exit, when
the driver was originally in active mode, write the saved string back
with store_energy_performance_preference(). This restores dynamic EPP,
or a static value (tearing down any dynamic EPP state) and raw_epp.

Fixes: d61c1ad39026 ("cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-e7023df1-8e55-46ee-a161-01320e6a4082
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 506d7bb2e6609..bc696f452749d 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -311,13 +311,13 @@ static int amd_pstate_ut_epp(u32 index)
 		EPP_INDEX_BALANCE_PERFORMANCE,
 		EPP_INDEX_PERFORMANCE,
 	};
+	char *orig_epp __free(cleanup_page) = NULL;
 	char *buf __free(cleanup_page) = NULL;
 	struct cpufreq_policy *policy = NULL;
-	unsigned long orig_dynamic_epp = 0;
 	enum amd_pstate_mode orig_mode;
 	struct amd_cpudata *cpudata;
 	unsigned long orig_policy;
-	int ret, cpu = 0;
+	int ret = 0, cpu = 0;
 	u16 epp;
 	int i;
 
@@ -325,14 +325,36 @@ static int amd_pstate_ut_epp(u32 index)
 	if (!policy)
 		return -ENODEV;
 
+	/* Prevent any changes. */
+	down_read(&policy->rwsem);
+
 	orig_mode = amd_pstate_get_status();
 	if (policy->driver_data) {
 		cpudata = policy->driver_data;
-		orig_dynamic_epp = cpudata->dynamic_epp;
-	}
 
+		if (orig_mode == AMD_PSTATE_ACTIVE) {
+			orig_epp = (char *)__get_free_page(GFP_KERNEL);
+			if (!orig_epp) {
+				ret = -ENOMEM;
+				goto early_fail;
+			}
+
+			ret = show_energy_performance_preference(policy, orig_epp);
+			if (ret < 0)
+				goto early_fail;
+
+			if (cpudata->dynamic_epp)
+				strreplace(orig_epp, '(', '\0');
+		}
+	}
+early_fail:
 	/* Drop reference before potential driver change. */
+	up_read(&policy->rwsem);
 	cpufreq_cpu_put(policy);
+
+	if (ret < 0)
+		return ret;
+
 	policy = NULL;
 
 	buf = (char *)__get_free_page(GFP_KERNEL);
@@ -424,17 +446,11 @@ static int amd_pstate_ut_epp(u32 index)
 out:
 	if (policy) {
 		cpudata->policy = orig_policy;
-		/*
-		 * If the driver had enabled dynamic_epp to begin with,
-		 * restore it here before dropping policy reference.
-		 */
-		if (orig_dynamic_epp) {
-			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
-			int ret2;
-
-			ret2 = store_energy_performance_preference(policy,
-								  dynamic_string,
-								  strlen(dynamic_string));
+		/* Restore the original EPP */
+		if (orig_epp) {
+			int ret2 = store_energy_performance_preference(policy,
+								       orig_epp,
+								       strlen(orig_epp));
 			if (!ret && (ret2 < 0))
 				ret = ret2;
 		}

-- 
2.43.0

