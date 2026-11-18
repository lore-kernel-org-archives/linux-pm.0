Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794972483;
	b=zhH4UTXhFp1p+tCE2WwrTfGr0+Fc7tTiDnkqxbLs7C9BKIm7w3/u2JhhsSCQByjb4ycG
	 j3+Hr7aceKKfi4G2eupg8SL5rLD5Riz4im0luxcI9SVi+fTzO62tZwUgM6YPL18eqMHnd
	 10VuLaRR9vhqx137xCY8dDQVbC8HOacpyDvyoCqQuj6sLw7sfmyy+8hMzZbzgFRgoeApm
	 OvVI6dbjZ/m6RLzkK74i9Ym1XBUUOwEUesJLAYJB/+6s+HneSM70QVcuXJ0Rcm3nBcDog
	 ZAR8uQJqcTluhZspbDiYwBa4kUErOTLLcsVj72lQD0f5cU3jjjInOCfcvHLc82b3MAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972483;
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
	b=I8TwpZXht3fufRbNkIQPndIhs6uCV4x7E8pyyhiBMa0FkOadwsVNkdm3N/CoW6E1HQLg
	 ya4IddTjWam+dkxIU/930Y3qNk+XRVSn4g22uexj0KFk5hcN4vkkzbo0hszDU3QEt6nVT
	 zLXDikNt9f5pkHcXnyHv5idQ6fCX8BZrhAO3Kj1lHTJGmKG07UAjA0Igo30on9rm9H5az
	 aNbGxV9W4xUvXG9V03TyNC1GAaAf7q4wSYhMrJh9Fb7M9Y/Nd5kmd6Ad5Ab+r0392lXph
	 pfyO+gqtIv61XTwRxmJl4XQsYzS4zPpatiGGUq6Bjmk+KHQk4W8AECN6AZaU8IU/uWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pHE1Rael;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.71
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A55606A32F
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A55606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pHE1Rael
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf82xdLUCII3zA+fHpBLeaLGO5s5lPmjxkl5DYjsME3QzBINIEEp1GdPx9EL9TV2Dx3oly033ZZlJSpO5uxNtGmX/P3vDqQOyUzJSJKWqF9kgnqZUBaX5YPCyh/tC9AJptq2+/sj1QuUwQAYj0NGr3/vFgBRkYXHBPJKYhxRVSq1RlUYuzQHpe4heGxHF8Gps+XkQ5Hrrc8YTqUCcP8G8Zlfo1OaEjMAabyHMTMys6+dTJQfIppb2af60YI+LSDj6bxeI5pSypIS0rLbnORaVzLFoWjqZc+2FO8KHl0xdNEHxwfH1zXFj/kjbUFJioWrCoU6QEq230fPe1efgNXPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWSffiMZYAVn/ord3RrXhFHT0SAmMp0IWZRrrbTmzmU=;
 b=wt+DBzK2+/E+OJMFLUFO3MNpE1yNQutcbrG8P63OHpin2FGTtWxrLY1AJknoLe7qoJyrM15DGngnYWLl0W2V0MUQRO6/MBR1DKOz4T1+LDfq2d/ZI4XouODgOf09ucnR/INNNoIskHrIk8n63dsfFCDVT04cIl1gLZWdj9KdTrkRoOzsds8Kp+OqHr7Tv4VYza7urHU2LjdsX7oPQiirUzWoBV54sxUbiDsaIRcpMuLyLLgXjKPPwbHtIM2m2XHlyFbQEyOUir6sp4yGZgIwKdj8WNKd8as3qA9Aj28iCXPLe7XtAWoEbj5dsNJ0Etun0/Zn22+IXQUrOV1saM7LiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWSffiMZYAVn/ord3RrXhFHT0SAmMp0IWZRrrbTmzmU=;
 b=pHE1RaelUZxtjmh+LEFJyLx18ygGYR12waHc6KKV+tXwhbTe2CljU/fpQqt/xxPC+SkT8cmiKA/5AuU909AYInfVsjcLsFqXC0fBivwZthFf+SC6RBvW+NBBnI2Vcig0PsNJSpXeGRlUi/PRw9WV8jFMQfRzGjAik9tMAYDJXpc=
Received: from CH5PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:1ed::6)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:27:57 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::67) by CH5PR02CA0024.outlook.office365.com
 (2603:10b6:610:1ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 03:27:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 03:27:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 21:27:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 17 Nov 2026 21:27:47 -0600
Subject: [PATCH v2 1/7] cpufreq: amd-pstate: Fix NULL dereference in
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
Message-ID: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-1-2a0048f563c7@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4a79a9-c242-4b51-1a14-08df4523f048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|261009221227099003|261009223027099003|13003099007|56012099006|11063799006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261021135927099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	xFR3i7aeanV1ZWCddQhSJpQoafNDp+SOedx5U8YJvWriP178BUnky3vM2d79XZioNpw/Pyaa8lqUUBGzXGPJzs33F9bqa74ndWtbJITumNUxz3oYQSbkjRPcssVDtI6yQOxyYJVz/2V0HSN1Yju2Uov2j//NfCaermKRfT2qOFiyGqsbZxy/+LXAyiNBoY/C0/R1u2/r3XsMRTotiHwQg5oY4Ty4O4jqmCsVFX0s8g/QMm98748QgqD3Pt9FcDvsjE+F+nlDHzgWc7B69gOFX/yM5XbjsqXlglU1GPJ0sLlPKplm2VCc4hbUtb8hyM+07+pgq5y1VqWg15QnG1ZduqTngEbONLPyFjWAZKKVNSGIctazgbuZa9uFVO4xb6pi9H+nXNdUpfLv5i9OR/zetiBpMF7BfxFaSrVJ/sFyZUz1PwvkhY0if8sWf8vL772EQtiDGpMvF4aUb05kVncic3that52E2YTT9FlTTMhkkVOmnpZUCNFgJ+LJlL2jpgpdyk2JPrIlqeg1MK+YHMQAyXeCOl0/J5SGgRXMjxJLTQhJylbYkow+1JRHXUHUv+DU2bG7sx7GnJVxLPMETv+TmQp5el74ZkKA3b1ywwNYTs+uK8HjZA5c7PB46RSbUM23gtEYfcXARD8wXFEUBxEAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(13003099007)(56012099006)(11063799006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F7+Gin3Z2IrddBlqL4pEW69ZIosOgb1gYAUzbu2j3j2jqgrr2Ru3i9atY858ezZYrR86VA/n9MpOPyyyX15ZX/joESF6jPULrgaYEPWFiwxsZTm9I73Oo9oL3+xRXnvbMHkdPbcX9GUr2e1ntptZfNOu3+HudFmJKpe+nUqTzVk7jEe/JQf/u+xuewg8unj05NRmMZ+iH0yhQhZ2Spe6jmdedg+ukjCiiCtzrUEDq7oS3FI73HS+YHFJ6+BrVCYIX5qh5DKtuORBqhYmccRucx3PXEqiCTFLfAoNJDhhh7o6WGDRKknzgUIgfHQtErEPJ+O5dY7HpavWWHRXq03lma5OqxYhprOx2TG3th3xPKH0ebfNC30RODchLsp4ViDUdSGm+dsAORHGSYDqJrFFIOLph6c4Y1RvX+EWueuCXzzj7p3jlfvhhTizrE1oiNtE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 03:27:56.6904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4a79a9-c242-4b51-1a14-08df4523f048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

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

