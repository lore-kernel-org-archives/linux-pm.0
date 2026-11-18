Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794972484;
	b=Ijx85vkSgT72z2peH4t1lB1Z27Z+IghrPymjngvlPTYPmur5yl4rP7TOCECkK9BHh2ZO
	 hDtA+x0xkOROfoZqYOnef3vNJIrVqErj7KpUwYi4NQ9S5lG98rU7cpq+ClyORKNMhFSjz
	 TdNs5ZsjSWX85M/QX5lXlqtBSNk+25UxafDtTfdRovOTZVGzPtqaihPMLmWWDpny0rbbq
	 FnGn4F52v8uCQLStesueA0Dl2elgvC9yh7Sy/DwC8yfsbzKTbLT5gMitQPZ7KcG2PgMum
	 NDCq1z8EfWotub7mjV5lgDHaxbNBkQquaufUVgm0HNmgnYVLkC4NbqNnRhvrwDKqCKA==
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
	bh=QPuMb/TxoDoq/S41JSzC0YSippmho6jDslMBTEVsupw=;
	b=UpevaaQsCnHRv8h7sLU8XR5S6dBRKPYPu49VvidaSRYx/k3RmE+TSlMCmha0lY4DRmIh
	 uPigKE5vBaHmDbBR4dgl4bUDT+mIHhg0dH0je1JNwa5Wm6CvPLdqMKAvvS3BhM/a1SQ2q
	 qw87ZTjS+V0QCC3MC1+UDDkfVvPj0d3lO21b4QSAS2vyVKokJavbJwBGiIdxy9QZ3/j/Q
	 kbkL1e5IQUrQGH8q63H69N8DHn+WtWgOV4d2NUUVWuBwvTz0HD2tr8WHUo1gjvZPNXG1M
	 BZWcQE4mTsS3/na6qjE2pVlqyIYjG6JgmsuV0ikfWxLb0psXRq70qZnUldujrHemyTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="LH+/Y8rb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.15
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D80606A32F
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D80606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LH+/Y8rb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1Hs2X/o/H5qqFszbjSRaph4d53Vmd5H3f0H8AiTDCL+cLqFHOidZzMvn91bnUjuUuKotHIErXedonku+x83JIJcgk8D7/BhV1Eji3AewEU4TrRut/D3lheVfvSNIr3O2WpAKA7QYX1nqZeHRxGoOtU0ha0wHGqfP1Qs5avkXrctaDmuV4vWBCYtTXumQJkWHHPtUc4pTHpvn5hT+aJ2HT195c/qMtLvNZTa6HjKo6I2EsNjr2Vks96q6nUsGQiNMuweR5ovGFELuNf5CzvrSwgtMvOijksepKHQx0DWa+wLQKiS0v99hbuYSKasxbyirzrzcADJp0Yqx/5kB+arTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPuMb/TxoDoq/S41JSzC0YSippmho6jDslMBTEVsupw=;
 b=N9vBC6iHeteLuH88++rXsgmCoj5ajqpLnCyLbokZhjSH/g79qBHLfEeLn9tN2c2eq0P68lR0lG1CPuGUucX7Mdk+Nh3Xd6aYouRIIXLvdQX8iLL/r1qkfsGdtVkMHUzkSllkl7CySsOFNK8HXMDJTPr87fNnZI8hFT6whGQl9nhTB/5kN5OcdvUde76sGGAPcWbw0ykBImjKQIgtl/+nYxETPDKcxBAPfk+HHiDwgsvrWj2CeeqHMot/JoxNtOOsDX/yxhhsF1PHGPRGX9R4mEQ++SjBZUjcTKTOkpaRtcZK8jQzLyn2imkxiSzk6kLv5xVMGvJyzyA+ZLq0O7z7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPuMb/TxoDoq/S41JSzC0YSippmho6jDslMBTEVsupw=;
 b=LH+/Y8rbs+dOOtZStyTJnU/9k3GzxHGDdB9eEnra3C2a5wS7KcUN5qfmTP3rFMdlxCzEtFPD05/bwSxw8CH/5v8bvet7ARoNNtwAhuZ7ZmH/pCKZvG+1y6FeA/s126hFy5L+4shRq6jTUO5JdD3bY++bEZQfviFToe2KwM8urfA=
Received: from CH5PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:1ed::13)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:27:58 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::b) by CH5PR02CA0016.outlook.office365.com
 (2603:10b6:610:1ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 03:27:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 03:27:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 21:27:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 17 Nov 2026 21:27:49 -0600
Subject: [PATCH v2 3/7] cpufreq/amd-pstate: Fix unit mismatch in
 amd_pstate_init_freq()
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
Message-ID: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-3-2a0048f563c7@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: a9909af9-1bec-4cfe-74fa-08df4523f16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|261009221227099003|11063799006|56012099006|261102123227099003|261021123027099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	UBmhkFYBQRbywITfCDL2zjIeRZikODWGSoUD0clAVUm2IjFrqGOR9IeiMw1VpAAFiV/xAdmeNV/17XNslzwJCUgamSMXurLPk6t5Wr6Ln7BORonMfgazDDz/EZ162zyxZnYuhPspgsxW8IL72D+Sg2LRx8nHzTXAqyQBx80UGFIgRcT+je+OOaX3q1I/nJd4bgsJLoOLAmF3swIgau+RZ3F2B9kPc4LJX/vcsTmqW0hf8KcNOyQVum84j+qNHG0etGJvaoz6KK2iOyJb7/H1xs6+iKtahjdbK5kdv6A4mnCE+ZYlRpbyl5fWFfTaK8v+6A4xtNkn1wGmuPlrErIVpAe1sGoSOnoLRiWxsEK7ONIXB+RCPVnz3qnUYFIoyYm6idMm7UATsPdNEx65gK532ulCQebnPnCmlBQXUSRVyzlHxDAvhn2oAGQjtU7OxbTwpSujC5CQDiLZSfnuIlStYf9uDsR837hs5DbJh2RPmwge3+pperzfcg1wah5tjL4zEb4BMgwqGTqfVv6KNkH2J3pMnDHm/HbjqggGYyksGZvGLZmBj0orDQmq8PEeWYVXfdgUGNP8UmmbbLzFNz2nu3v+7qC0uI3kwR6DPmlaCJ+W51/Dr3Vb8nqRgnk2Ip07SzPUKXAXxKom/BriaNTVMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(261009221227099003)(11063799006)(56012099006)(261102123227099003)(261021123027099003)(261026121527099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PnWwv5YWLdYZ3I+8CI/Dp5gy8D2wHwYm3FmDnkoaNf73nj4jDsyWBMsQVkOqtpya+XFI/Lj3Xdopx9sAPklQ3g3ntQorDCu25y8UXy/4bekC1axMvgVVycvJoBfeuNzW1Gy/f3wHaG7zfOuEsrowY+Sv3hJR835LG+a//Pe2WpCgKGiggxE/06Rn9HVRa7H4lt31LwhDAIM1QXQNCjZKP9zefWXXwaXZyqRycFYUz6JTKozof4ziQk/ytLtniwLpA86hcKzrivQ5+1IOq/5L2KhT+hBtTW7XUXD7PCPlNzXW7jOyZRhh4PeMgYy0DUDeBQMxpUN2ddTBJTxSKFoA9ftGgeYeCd2mmJcAV0Pmd7CyfCZ9xMooKe6oid6QNFwjJl3FfyU9lXjxgWhTt6jMDj0PkeHmmXKdpmU8TYDi/qYES/ktyCGayig7uK6cye3G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 03:27:58.5969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9909af9-1bec-4cfe-74fa-08df4523f16c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377

When cpufreq quirks are present, amd_pstate_init_freq() loads
quirks->lowest_freq in MHz and passes it to freq_to_perf() together with
nominal_freq, which has already been converted to kHz. The conversion of
min_freq to kHz only happens after the call.

freq_to_perf() divides the requested frequency by nominal_freq, so the
off-by-1000 mismatch yields a near-zero value that gets clamped up to 1
and overwrites perf.lowest_perf. This defeats the purpose of the lowest
frequency quirk and exposes an invalid minimum to the cpufreq core.

Convert min_freq to kHz before calling freq_to_perf() in the quirk path,
and do the same for the non-quirk path so both end up in kHz.

Fixes: 009d1c29a451 ("cpufreq/amd-pstate: Move perf values into a union")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/bug/linux-515ed05d-eed1-45b5-82cd-41b86ca2ee88
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6136437562545..e73f30b6fb30f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1057,13 +1057,11 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	nominal_freq *= 1000;
 
 	if (quirks && quirks->lowest_freq) {
-		min_freq = quirks->lowest_freq;
+		min_freq = quirks->lowest_freq * 1000;
 		perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
 		WRITE_ONCE(cpudata->perf, perf);
 	} else
-		min_freq = cppc_perf.lowest_freq;
-
-	min_freq *= 1000;
+		min_freq = cppc_perf.lowest_freq * 1000;
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 

-- 
2.43.0

