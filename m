Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D96357739;
	Wed,  9 Sep 2026 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925017; cv=fail; b=VxJdoLLEXde/9SBba7/F9FsoydWojFr+JncMZrMK6J2LghpJJQ+Gm9nc/8AzzUXs7wABTZ9MMLS1LG3sJxS0/twUOqmeWX/nsPSGbqiUbtr8AiMGiVNzrTvGGbUvw9n5nhqBPc9L6wPc9fElMRX2naBqEhE7g7WtBRoLC+tyC/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925017; c=relaxed/simple;
	bh=HHxpgqOfgooGERiyhgJagmU8LGa66JgwSy06VG4NOio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncfSBQ75pAnV4o7Aju4RDtJGhEpEmWtOe5Yq1I0yO7ayF9MBn9Ds9eDw9GXWPcyhCETMi+VFz3ZGAKePvwOfHzWWL3N/ZEddhKdKb85yUH9kcOZ7tGfGHyWfpXwynELAo79nLDdGdmWAzCCGx4A8zKhRXp/8CfrcWREQzdVh2Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rCCOhfTb; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rCCOhfTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrbH01tmpeG7YwWJADRcl/P5jXDbOprdx2Y74EDyaqWd7Xb8tgdEs15iKmKnzIRBDA4W7BYhwYVDM0xH/gkQJdCoqIgK7ofirDWZhAbkx3vUJYBxuiLgoNVnSRMbcanf00q12s3L57N1J15e2Q9LGmqZnMt5Il5RAuzZFEiylIXgaUucfI9FrB0eH2fFNJrNqnXE89YwXA3j+O2ze7XRoMhaVAQFKpxc3FbIyVf+ltMcUEqSkhHRn+xDwzkg+6w/YnY9DkkSSdxRmOaL3vASzmmX6xGUjqnxylN6ah6wlUdpqgD59x0bDoKrI8eKm3+wSwyVT8V35Zqp42bHKFQvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh0ej7NHDGnjw/IdTstIvYmTIXJa/0HbEcdmsVfSUtQ=;
 b=Dd4Lt2PJH6VyMDPRdVVNrRRnoRKErngedSX73ey/Y0nHPXz7S24x8tIiuaAIq1PQqiJMO3xO/t+2DFrJJkS40NiNPlTfmxa5mGHNMqs+C4Nve1miteR1VjTNCu2I/mtFqZFw3XHasgdH3ur5pjYYUKoV/sWuuEt42V8M+3J0aXWF0PWs7UhK1OTbfSU/0gz3Yu/3fRmPzRvEREYa8hPSuzyr9kQtygRzJka95dv0zJ+OcDKmQsV9pMB3SMhCJrK6nQE8dKB4/onkBjzGZuU9QIE1FIVEUI7ICDd/vOKHGeqfd4QPcy5b1Ln2wf7vlgnAHm0NdM+bK8zo2P+BNuqQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lh0ej7NHDGnjw/IdTstIvYmTIXJa/0HbEcdmsVfSUtQ=;
 b=rCCOhfTbNOHNeD++NbIs0K1TfFyECE3V2rd/lfAVu81RJiAd0gag1kWJL0cfx0WfKbONsTzj7+f2giX/vK3kTr3q7yswz1B7qT2s/XeT1ELdTfZGlirCIWl/Ikygedw/VauaVW/dkCi/vYObtZGm3wc/pm8V6zeSMt7h4uwryCk=
Received: from PH8P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::29)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Wed, 9 Sep
 2026 03:36:52 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::97) by PH8P223CA0004.outlook.office365.com
 (2603:10b6:510:2db::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 03:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 03:36:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 22:36:45 -0500
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 22:36:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>, Christian Ludloff <ludloff@gmail.com>
Subject: [PATCH v3 3/3] cpufreq/amd-pstate: Show a warning if missing EPP tunings
Date: Tue, 8 Sep 2026 22:36:23 -0500
Message-ID: <20260909033623.454449-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909033623.454449-1-mario.limonciello@amd.com>
References: <20260909033623.454449-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2b0759-dc4d-456d-03e5-08df0e239458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G8bWKMQj/dggn9yse28yA5YlxaPVLay3zqudlGH1ulvUKMfAuHJa5cOQtcvDF7YvhiZEzqhCiek7yDq7vBaexWulz534dtkIxDR3Ev004Vi1sfmalytpbPGEVsNrjdXNfqLh9g8xBT1S0r2NxpDu7XuesXmfU32cqSG1X+bWuuMjkLktlI5HpGat9ubJOUQy4HM+OcuPOgoRQAl/0RIhljZ0oooKQZDO42XMQRK+V4xSLWOYRaN27/Nc5RgDt/kE3NH6f89CIS6Mexc30iPJyXlHrod0t9TZzoaF4TlM3WrN8M8ultUkkYETU9v92zSJI4ZRQKidluYd3JgwAuY2JurDcbKIHRk/P18HF6kASajoYOKYKUUwNFr3AE/O+Mxke9EdGi8yNK3JHq/72uY3AIYtGebg1oKsqjgeSb/n+dc2QSOhlimdDR2VxFbBEjm5jHRiRTPdHEzmhJbpyzOlA79qdyy2Xib/zktG20YC535HywYULt4jnUB5edoYAT5iM6ydtZNeV63kdNGB6TBASjPqGGEvDr3qaGKQ4YVe48XQzA1mwUBwcarLxtPVevpxTGZKGyeWO0YtDKlE/HbXPtgJ+KihzQWv93l9IYdV2C1xvHeJGyOXRhG8FxCfghGhaDc9ERP6TjLBukcBJaXz5MvfiCBZNewtuyntjTe2hiBhkkwgY+jmps7TnMYmnd012OgQHvfUTyfinWCBOnlFwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QpgnWZw7p2gMzR+5hLwotbzBEaoYSl0PBitFVnQfoweoYUg3Cdu9bJXQNWj9F0yLvbqaBj8sFDsNlv4xOJF7IXikGsSUtU/rxTvi4WUaGN5xcUsKcYTEM+mJqfp+ttCs6fxWpKWySEwHzs/eRS9aBY/VdvRarJK1bJKrQXXIIQEKzObqJNJ9TaE2qcen1TgHof0OAqfgd2HWLPJAeBnrO6J/2RV1zg7xtjTxGkpIAZt6SUOhsAhggXskQ9yCj4x35EQGw0SO86OgYyTqxjBaQBRUeqtlP+1SgH+vgVWRsng2XEJ72zNLxNQhaFtZXk0qWjY8Fjes8hgIlKv1V6uECrJJC4RrkHbkThScCEalIrnx0K3XON2l4vAWAvd+PBOogxGCvRb3hmeRD+S+aSAI89LupjUxVrGmZ2VjZiv/9QIRMPNoLmUUBQFsEQ+X3FpJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 03:36:48.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2b0759-dc4d-456d-03e5-08df0e239458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

EPP tunings are going to be more important going forward.  Show a warning
if on a heterogeneous platform without them.

Suggested-by: Christian Ludloff <ludloff@gmail.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 380294bb56cd7..ae6caef389bd7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2376,8 +2376,12 @@ static void __init amd_pstate_init_epp_values(void)
 	const struct x86_cpu_id *id = x86_match_cpu(amd_pstate_epp_soc_ids);
 	const struct amd_pstate_epp_soc *soc;
 
-	if (!id || !id->driver_data)
+	if (!id || !id->driver_data) {
+		if (cpu_feature_enabled(X86_FEATURE_ZEN6) &&
+		    cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
+			pr_warn_once("No EPP tunings found for platform\n");
 		return;
+	}
 
 	soc = (const struct amd_pstate_epp_soc *)id->driver_data;
 
-- 
2.43.0

