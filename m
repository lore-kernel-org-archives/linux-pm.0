Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794972484;
	b=cZWMEP/VMJAdzb3pD47cnE+expaVzT+yRliDWMakpDe93uWqzal2y5/GykXMnUkoZvk1
	 +pJW3lnF8vlBPU1qy9ZbIqxhwDpvlJBsXLLUZa4j3P2OI1u7Sz3Fpkk1io4v/FcAXg2Ai
	 7oBWP+DytmjnqBDo5TB/qqUVB3E385YL8KUhpyK2v1jkhFWTg8Jqwkw+YfCWOkCRA8NMy
	 x6XMNbF8TdGurDQSjq/2RLdydjDYZ9Ft2oGItDhEhupITEthoR2naTYXVLL5xrfAYWa6W
	 HvUUR6hUtX9XfyKy50Jbm1JJnLp9505NhFnB85/7H3xMVagIzX1ec50brGtVU24OXBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972484;
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
	b=M+7J/Uh2JwEyqJEHTVyvQDb9O/+Zi4Ienu8yVTpNhnHVEVcZYfVSgmfEgVaWylLeEWLw
	 oCHXsOIa5/41aaObYCNX9RswR/bl7o8crw4/DHcmYTTVjYHb/9dj8EBu991fjDvw1Gn0E
	 bSokKTi96RZQ1vYJXHgyWbXrNV2xe0HTv78DUhMY9jRSHdFEZeMh6hgaijx+60m8zquxG
	 Q4tgVN84qGO9ybQn0UNuStoPTXxoASls3es0RPKiS/hz3Asy7VqCC/Ykfxabe9bdozG56
	 OjYlb3IDcG332x12FSEbNj7diOFnYib6xNl8v/wEVljUKBZ6gkGiJUPWjw6eMDYezeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ILWOp5JE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.49
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983E606A33D
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1983E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ILWOp5JE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFuLOeQJ3p9hVgeaN1gYRKFJwZI5YMUj5xBbXvL4lgAq538buXtY9KTexikwf1yu/4nMTOK9GQ1IQDI6048uRydK0nWL//z+aNS7085oFAvkxITEvLUm1qAwW3kvjqwrcqWGXazLR+UMxbtrIB2R0S787rwLZcHR+ol8XZc0nrzCiss1XbKmSrX7eVQerxs9m8rdVfrfqC47CJbtXMS5pNSFaKrgHuJ3HusypA6gPgWKxUauFd4iIYTc0TZzvEpeYqh0W4mAR+/WlWauFXkwFxg/0mHP3dcZgH7iqUizvCNkROfKyBuzBxVPa69SmXOKbXQlyEV7QQGYD2vcqX1eaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF8YMlwhLPaFIK9JglBI9dyk4YWYq/cnOBByc6Fr0dY=;
 b=YMO2m4dgA5hnuOwO41nn3XAIAJRujW7vJgEMw5EF1VJjrg8bUZ5AayfIDe6GzKc1hsncoBPrEAHxubtWud/JCWiDUp5vQhbeZh5p/oXjU2lJEJ+CvesBTXt79wCX4vFrmEubbD200UW3qyl6rBAfRX6zRWus4cogLnycxqJBGP06f6qvRVHo4S6a96ZXFBzLZt93ofcVIj1wQFAOA1zfo2YwpKHeWDEsVBTxTS7dvS0CJLlIArJYYa9AEOmwgXt5ooStHkzAp1909x7TJCTl6vZEnwapXPrbRqIgQ6pvyCrzZt+zSOHl7/qgZIlSZiOco2uQXQctlOumDga378LNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF8YMlwhLPaFIK9JglBI9dyk4YWYq/cnOBByc6Fr0dY=;
 b=ILWOp5JEiiknl/Kz5Sf8zhyHnltzPlfgAINyGZvc0cPFH4T3Vb9WBCTCIaLBwycQsgLjf+f2Do4u/8Hoc5kZKMWJBIQe2ETfUA2CIqyfqzjORPt8kqP7NXi4Z5utnkCHcISKq+/v4gKDzIp7l9w2+jgoEMhbd8ffY9MKsvGHbqI=
Received: from CH5PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:1ed::11)
 by DS6PR12MB765562.namprd12.prod.outlook.com (2603:10b6:8:4c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:27:59 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7a) by CH5PR02CA0012.outlook.office365.com
 (2603:10b6:610:1ed::11) with Microsoft SMTP Server (version=TLS1_3,
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
Date: Tue, 17 Nov 2026 21:27:50 -0600
Subject: [PATCH v2 4/7] cpufreq: amd-pstate: Require exact mode string
 match
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
Message-ID: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-4-2a0048f563c7@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|DS6PR12MB765562:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6b1af6-224f-478d-21e2-08df4523f1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|261009221227099003|261009223027099003|13003099007|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	DQnAAu0HVhrxEDnfuEoc5iPhx3n6tIIeR0t4FYKdoEINNNtUdUZAB/bSM/9DPiLh5zm5C9809XCIebsy195YHyhn5qYwBHkOVZf7mE/9TG4edUi6e05nPeCx5J9mGLc8/rmuTvEJ7BhRmn3/ObPZzAjvQ/bQ9wKszBWXNE+q96Fo7GXrn6guoFK6lIEio1eVHJ82OowgpQ7y5BeNo0wI66zSYV3bIUdzMDJb7oI2ovbZcMkJ0/HbcJvCqiZ82ofDWeT4eCfT2M03g5GNfioU/Y9rVvgSlCyjDs9Y6/Ir4l3m69R1cR1E+BhdHeFnEIkwH0Ga83wu7BqvlslUFX5ySZaRq5J7IGRaWet/Wr2TzViIhrUKxOG3ebzI1lSwFGyV9JPnmCLmKbZrkUb1D52foexOy0jMPyJDeGESqSiDZrCwTweTrLMRzrcm7lwGeIDCbZ+j7Eg14WBCbUzHAKCE3F0Ku84+D4//dVGNwe25KEFkuqWQ98WhLhrM8Zk99AMxCoWVrkIceNAuAhHrs1mxaI2rygtmJ6DATMyOAl7J3ETSm39eyxvqzcr+dzgqZYfMRCNIq7sodvrLTMewP9O5e4ccbuee1GLxyFBE+jnSrh6yEbhchxOpcUxATqvOgjKyUBmwgWpq0IHhXKmifiCkqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g62pqHJxY7HzD0YxY533m2AhK6uczJjBRjBEpTmSKM9w9J7dUp987D3QC9MbAHTnukNMXmAnk/M8rGeVnOD8dKEQC8ulQb8rSa1WRyssQiTz15cM3d/cK9XXLqWzCm4WBlPKRw7PJoFGoNMPXid1oGkNYDzvAPFK9DWt2m6V1apTGri2yvqISTSrzUd1CY1Dq+Q0BVQhoRjrwJrFyaHCdvdxhPWhiuIwCwshdneCPWCXcayKcECs6HuEUXUZ+V1hMN9pcgfe82px9wb3bY8+gJBGx0NVZqvzpiRmEyNkTysyfA2+SJJ1VOh25H+UdMV2fP5wG+GFQODsLz+0dZgcMES2HtkoPwKAqp/TNnBsgLUvvupYfp79LSp89kla4al3Fg4uevkX+t1tInS69OCzItlz3VXd6dg7hb9W4FwHq1DDdAkZoFqt9zGaYFEBx7cU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 03:27:59.1723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6b1af6-224f-478d-21e2-08df4523f1c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB765562

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

