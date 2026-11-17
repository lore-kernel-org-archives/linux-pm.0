Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794886669;
	b=wGYDtedsnQzM9uFeo7JTFSCU3V5FsgGS7L3miHvvjvyzPcyg/UurrkBedHq+hJbekvK2
	 +LHACOSjuo6QNAgTb/AxuVUzi8ONQ5JJhgRG6IvGGgTjzD4EzGlNk0MwbwVlJip3g4nNS
	 aX2+Oy9tVV0Kn4FplEy1v2OQlOhVhcnWLiLX7lY204XuYzGg1Y9NQ7R/4UT993zLhU1vP
	 XLPavpPUf5BL8WGUsCx1t25hw04ID7ZpqClFVxkuoiA2OuStul26tuuSOvOz3sx8B+KSh
	 pqsqFqmIYsi1+wngfsF4A2T8BeBmI/4His/3b4rP2GgRH6acxdbyyffJnpxNlREh2KA==
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
	bh=GWSffiMZYAVn/ord3RrXhFHT0SAmMp0IWZRrrbTmzmU=;
	b=I5LzJ0rf3GBHUv5O3BBTrobmrhqqS7sV6Wdu9CD+HBLHa4uQGQseda/YtnNxG5pQcY9S
	 haxtUC1OrpT9BTL/CuFGfTI39jAIXz18S6Bq+BB1goZbYwA66j6/9eif9T5ggQmw+J7CR
	 qHYtf+xpATdldQCE2/JuENxcNMg1k5QqkN6lLSJ7RijmFxWXDqt0FA4a96M1rutg6EcLS
	 wDWeErMC6fdCIdV0ORkStR0RUStESjxvqQm/NCt2TPoGaIIf+TLGv4bgWb0CGXetOA6TW
	 a1u3a2Ogo6P5LSXfcQ/E1LyvMh5zqMm3Z5IMy0nDlsDW75vDaW4l8HPLzR2GeLfhXrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JhZAmyXw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.3
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01634606A32F
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01634606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JhZAmyXw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg/izmlKdq0LwBIPtWH+0otyPxfYrzY+G7KmzDG6aEdHBd3etBgrUBJ7316x2WfvoemUS8vDBtVRh0EQvieyzVhK011rJzKXBQF4lAtyXvJi3nHG+swKSzMPmnGQtUt1uzFJLCpbkxiHPbrEbFF4DP0+xeIuhV2sIIealnOewFPhK23TOKJa6AnTksHJlbepxmTjRfvyw29T6fT8vpOw74dXM9pCos6yViHk6wCNZ8pc2IiXF22hlqtZ8/vVH712NwFlunu5RApz2Whxuou+VzI5GZsk+fOmRBQxea9IJcFLxEs1yh7g5W/nj8gI+XUeKWBDwfjQtG1xxCayp1Aekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWSffiMZYAVn/ord3RrXhFHT0SAmMp0IWZRrrbTmzmU=;
 b=cpeVkb+bYjlW3wEAJD8/Y49l5hG5RmG4SuVDTPLd2U3DQy6qHRgUz/OGVZukQOD8vERd3btJmRcax/6Ijfr/zwqnVyrckwmfUsorO8nf1voCpzBSCrHtWmqNPcyzMSzyHzUJ/pk3IcoGdWFIuOuIVLkMb6RZUoavlAxUI9bw9Hv6CKUcmDVMgl/vO3WzWs3U+LXCTEAV0C3k5lCQGgCjSOEex2VDuBoXA9C5OXRqwo73vepQwnITjswA3NgVacG2YlnrvoGBf1kLwbTXenZG1xFCKov1Ha0bCwo2lMYBo0DaMcnViU3CUVDG0Jk/Uu5bSBmyK20V4xls4XC9GZF3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWSffiMZYAVn/ord3RrXhFHT0SAmMp0IWZRrrbTmzmU=;
 b=JhZAmyXwnsTGEit1KSqQb9rJvI2v+awSjRsdApwjBCPshVIA5a5IFyfowMMaCo2MHGNDAvbNwNW5COKyZFDdXoaWzYEroTZ8YzAF+P+jv31X6x2UgiYWDPBUR+KU3kP2OrT1kjm+RhG43Z2faVXKSNJG8/boECPSPrBT0+ODBu0=
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by DS3PR12MB153673.namprd12.prod.outlook.com (2603:10b6:8:611::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 03:37:44 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::53) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 03:37:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 03:37:43 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 21:37:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 16 Nov 2026 21:37:34 -0600
Subject: [PATCH 1/6] cpufreq: amd-pstate: Fix NULL dereference in
 amd_prefcore_param()
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
Message-ID: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-1-682aefd4fed6@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|DS3PR12MB153673:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1871ca-a065-4a8a-9258-08df445c23e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|261009221227099003|261009223027099003|13003099007|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	xBU6eaOm10bFjp+PXvTL1pjaKHGEOKiOWorokTqHJlNHid1ysxYg93tTWr2HYuO0S4OZ86cLQdcQbF/4K2WQFkaUPv+XVwPEew1Hkz4vAYE3uJ58FACR/761o/VZuBzw6rhsb9VC1tDepSL5jZ3jeq35fLU73RJZDGdvxpRNMVx1uQ0sPcl0RiYYOE26NstpjUqPeNFpE10Cd3gwbz1ChovfdHKN62D77Rtvj/BDawjv4OHRZEoIJ2qo9Zq7qidyLfdP85iUu4BvqnEyTicDDQOD6BGJdB1so800171AQWggczTRknRu9WJhX3qxNT/ZfZN0p6W5qajpOX4IjBsfW4TAEX1AE+z/uPBsDwV4/aGBIS1cai5swPhKBkhlxgn1wZM5hR+ZyIixGo8PRhP6IZAFNGiLpYPCLIe/z7Vn/WxEd9Pfkv7B5VJbGXGJTmUOzIrRw9AQuaH3PzDtZtvH+5S4RmSTe7EX7K1RCH5PTLifwtYIHgZgDq4C704Y27XfnI0sxQmyhUvjOZQisSgOMRkaK3LPYTA5JpnGw1ztd28TdPxm36ZoWb8VM9kiypEb8z5ZBoJflyZaGQyaxlL9XT4bPRVmu4HFszhiao6Msr0CavTSh5nE+fPZMoF7kIVJQhpm40Kv+1hHHpL62PjDAA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1PFCb7GoWDVf2q5nlxvZq/qrIFlFp0g0pfBN9gbkwpJF9hMrrhv9uCnbv9Rwv7jogo+PX4VdyFaXcj+AiOh5ICPsHj3SlkF8mnbgDauAvTwGHP202nn1jrZhqKX1xhNzyt4fWh8qbvWLH8fIBMD5VYzzLK/zlgdw7CQgWSUsow2goUWLl0CYuSJRzOa/lREJZkvYPIc7t1sJ2K9H6+Ar9XamwfPmtvfPf+wSqXpPNy6GaGD2Pq5+nn8GVTuwgpV+zxcTspj0EeQqPkhEwwbXBcNo8JYZE7KJ38KFA1gmAVblwK+V8fhoX1/X3A+VPOz3YajU6JlZiwdJ9ZVI5JfAl4J9iQE0grz7dK4lSZ6sYUNckkEJdg2Xr9hsm2sG/ix+CCTHcB+KUV27i7hd993i6bvgBFx7iTySQE7ScjvhshG1xxuW0Js4hNhrp54iLURA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:37:43.9206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1871ca-a065-4a8a-9258-08df445c23e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB153673

amd_prefcore_param() is registered with early_param() and passes its
argument straight to strcmp(). When "amd_prefcore" is given on the kernel
command line without a value, do_early_param() calls the handler with a
NULL string, causing a NULL pointer dereference and a panic during early
boot.

Return -EINVAL for a NULL argument, as amd_pstate_param() already does.

Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4bedfbfc18b66..eedc5fcd9c542 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2478,6 +2478,9 @@ static int __init amd_pstate_param(char *str)
 
 static int __init amd_prefcore_param(char *str)
 {
+	if (!str)
+		return -EINVAL;
+
 	if (!strcmp(str, "disable"))
 		amd_pstate_prefcore = false;
 

-- 
2.43.0

