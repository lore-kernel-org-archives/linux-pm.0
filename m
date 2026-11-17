Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794886671;
	b=H94lebG6uBEWVIfyrrQC13xCWQzPM9yVUeVoSp0q3UennTyqSB/R8yuCee3tCdQLerWl
	 QztJ76SU6x9VlguM05KDan/8WYeG5MA96/JEj9Z2cbR3lxqRVCv9OXCfF0TatiyrEAiWB
	 K0guSedxBpg4HIIkTQXqOpJQbfNnkhWQlW19sK6XRPd/3b24nZf74bHIaqhWS8YjFVJAe
	 17fq5zlD0o+ATsKBEdC5h1RUwSi1fP+Owbo9zdLXrExOGdpLlO5POS0HvMwPsNdHnXtXe
	 5Ky2jwjiKroHfOO9FaNP0ZXKRt5foCoBHsfRr2kmwQU5/uf623vWB+Qd/EFiqsMbqSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886671;
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
	bh=dF8YMlwhLPaFIK9JglBI9dyk4YWYq/cnOBByc6Fr0dY=;
	b=idprvBr4h3JHOx5NwLpRkO4fRWordnrYrVNqrNRQov6wNI0dQ19fLEOqxfPF42eIBULY
	 1mQtvMDxis6hxgVfKrMdS2IZ17mTGUOcahgEOAvMC6jTSrm2eO5tPBDYCmCYb7lAFhMzH
	 tf/3ERgCIWIULU3V0a+emP32ut/EIFZAESyicLycyAW2p2OETB7W0N0KVR+p9zPHDNjYy
	 rpLHZUJT49ousLXnckrrMWWPNZ+E55yxdJz+1lQJVGNAz9Pgon+YNc01sfwdGt0cvtKfY
	 iX7+yQ9Tw/0bvPV6T+rGkxdwhoy7D6nsH9/X3dLd51fjt5/q58Bsl7+2onR+ZyZiS+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="CvhXGS/L";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.0
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBB606A32F
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7EBB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CvhXGS/L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjQk8C85tq3U7iI8YGa2hC/lcifCuglPwKqstaBIB1odalu1QMihKhiws5rtlokrTSEUjwyrqiRhcTT/sSR7oHYIYfcaVTkvvFyI4IawfERwa5llhOgElqcwkTPSX4aQLuKMGnPefgt9YmY9D+J1qGf/H3MzWbHPGa0t0Akv8AsHzork78jOgFwl1vVasUd9MXZEvIBG8XgrhIj3r2DM3D2+mXTJ84rhyUTTB75mi/hhdJ9eN3hb0bhQAzfjBiKG97acFMrshGe/rU92juXoozboJ8ak00wN1khot3tu72j3Kbrg8VeGIcyseDKoUAvzGdV4U+9AKc7ZbSyqCli4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF8YMlwhLPaFIK9JglBI9dyk4YWYq/cnOBByc6Fr0dY=;
 b=kMXBzELZf3uSUWaw6FF8pFL72nOlQM0gEmebV7YmYkhOgmydVLCSFPKpIqgxhNQ6dOMDe9k6CWFsepSAFiQMblPKvTG9KVCG0WLbLzxjR4z+g0KeqoSVEkE/B958pCGD2K7MEHjYIsL8+EltSsZDbDRdETtBJ3v6XOvENOie022oEr5JSzKVJ8C2iCzGNOAdE92yBLtTSdWL3rk/Q+tAjb7WZo2iTaC/wBrp8q453y1t45/jhvvFC43vW4yqCE8LXkEs8u+Adr5XX1QRSMwxucEoqL3FZ76uRSzEGm11Hmwx5iUyX/YAU+NAGXg5X9mBCFGZp50yVBTh2uGeOk0o4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF8YMlwhLPaFIK9JglBI9dyk4YWYq/cnOBByc6Fr0dY=;
 b=CvhXGS/L/vDi3vaJXf/t68dfUB/+Yqii6QgFqArbeq85oaKx7tDVznuliCRdYUfbL+p+55/0fcUk9hIaP0OuKci2Z89gCRlzICC4pORajlLHvIh8Pd7UuIdZ7qGIrPQQQ11liGY3crW5ePM51iura6xk4KWuafsoTnLnkYXPQGA=
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 03:37:45 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 03:37:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 03:37:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 21:37:44 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 16 Nov 2026 21:37:37 -0600
Subject: [PATCH 4/6] cpufreq: amd-pstate: Require exact mode string match
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
Message-ID: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-4-682aefd4fed6@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: e283c1f3-be79-4160-a77b-08df445c24dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|261009221227099003|261009223027099003|13003099007|11063799006|56012099006|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261026140227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	JBkccZpMFOxjSGM07UEreS5JcZHWFVvnRnKZJaAlQSTve9WwLuzQ3QmE6wlSc+ATSBQx1PXcY5JoWQSLMMOHTByrVuZ7g4PAldudACaI3pEqxhBLPdhx90SFvXKEYRJy880j+9QzSn94ASAeCfvkYlCL6rZJ/+Nu1/MkUJg65xy5EH4MGFP8gAx3OqgdS1hOCv3xLZTh2daQ0+HzEZqPqZRSWmy5BRJ+hhf6AQ+cmfMDKzuywz8fChZaLMRf0tcrT9/k5YZJfs9LAFKIEsTWVcuvrHlQPAKVx8qP9j0P2IAOlFGBretw0blAr1H46rO7kF3R/67wPtCrolpV+/rd9kAUZl+EMxhmqUDMDEyWRP3kKJqg5Skn3l60x1Ehu58Zow2CV6uok+YBGhWTONuYaVeR4xNbbYDvlc1GnQ3smMLOzYXUJLlzXDsA2ku6qWcw4Z7Kx3IAytzCRxLJXVxi1ZyQXuGASl9PL+Wcp7Sn56n0mEOUO3joXP58JeJY7d4XYVbgUnznMzIFtCW2WoqlnY/0W3h+PsvEM2Of7BydY7aXh3J+GVc9RSXPfv2Z1xRjXy4jpJ1i8s1lAT2BMwO0IJWz5CQ9B4viSzvUy3kmFdDSNf+k6rAiirtviiNsgbvpSyy2milhFI/YeOCrFgQ2ow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5wO+B1W8F79APpjtNd+oamdwqforVbgDryoU9mqiiuWQ3DDyqYQ6iz+cB2+2v+psOoMN61z5ue7hfkjFd9MlH+NOsh1JQqOzSLhOy7k8NbkCaLo9svjd0+BgEj+iZo9Z85L7loFgo3UBHDZ8MHkmDXNf9uVtg+dQcmNBc4mGwfjvlIM35XI0pEejmb3UCDHaMLlf6ao4J5CCXHo9GT5vj/bZhbz6bs9OXa4azCfru9y6LKFESe4LpEeTkm+F1EcM8K2Cr8yjn1wjr08fcnqXPiEtvDbhvtgpA5vLAvKdkyYkr3iiopjYIpGVm734u1sQ+hVYW86NhPF9cYQL3Afo1tgwZ6HkPOH/HUeI2NVffrcZzQBeE4vClk2jCSvp6oxmBp5Op7Shg+SpH1VNM1xmxxPBYod4caZLTeftDiH2dMlsrDexGV53vphdRvcDkOg/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:37:45.5276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e283c1f3-be79-4160-a77b-08df445c24dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

get_mode_idx_from_str() compares with strncmp() bounded by the caller's
input length, so any prefix of a mode name matches. Writing a 6 or 7
byte prefix such as "undefi", "passiv" or "disabl" to the status sysfs
file passes the size check in amd_pstate_update_status() and resolves to
a valid mode index. For "undefi" that is AMD_PSTATE_UNDEFINED, which has
no entry in mode_state_machine, so the store is silently accepted with
no state change instead of failing with -EINVAL.

Require the input length to equal the mode string length as well as
matching its contents.

Fixes: abd61c08ef34 ("cpufreq: amd-pstate: add driver working mode switch support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-f75b8476-e226-4056-92fc-96a7b92126f5
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e73f30b6fb30f..574dfffc18f05 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -238,7 +238,8 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 	int i;
 
 	for (i = 0; i < AMD_PSTATE_MAX; i++) {
-		if (!strncmp(str, amd_pstate_mode_string[i], size))
+		if (size == strlen(amd_pstate_mode_string[i]) &&
+		    !strncmp(str, amd_pstate_mode_string[i], size))
 			return i;
 	}
 	return -EINVAL;

-- 
2.43.0

