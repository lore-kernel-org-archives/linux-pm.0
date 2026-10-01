Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82552FE59;
	Thu,  1 Oct 2026 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869062; cv=fail; b=CYAESG8KsdBOkTskdY6aaLSA+c+EeJ1fXYVY7qcf+qiHYFT0KjAvItGY6r1+ZXMdRX9vpE1TAyN0Qx0JFgcMTWIsZq7EhY4sZszJomDP6VNZolNvAMMY7C6WZEDYQ0pfyhbTLrk74onV0C7f5ONS+ZYFOl3/onz4LjeOJwFkuII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869062; c=relaxed/simple;
	bh=IXF2VENX/tJBaOwDfttY7lruGPLzXMj9AIubrQ8p/n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tq+LtKvWsfv2rs8gBF22w4kLpdTHrUvHVjZPhk713MYb+x0oJsPD3c9tOGHnEAGe0JNJc3rASNsh+l6i67nlO3/b/Fj/Tx0KQL7g+bYt84aL2VHCesvPUQ86FGACPhLpWB63dvEHtq4pFvXHR85j0XP4jLJh9rlagpd8RYaTl4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bytYFQ55; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bytYFQ55"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caaFdtfup0uD8d0vxWtSMwQF1uvOinOdRjaYjqEIbE4sxZmj+Es2d+uujJecUtgdcATAXRWyxQ/EHZbSay82XLRE69ktaWtvpxEV2UIP6p8FnhwAxMrokdLvp5VzsIYrBqjm5IVl25Vy3mAJFX60mpDGZcTicFWMrKdeW0WDC2ELyMwXRwbh1svZlufuviI0g4yjgmQ3jNR26jC9ny/o+L82m3yfYSEkVIS8yHczVcEAscrPhORau2jnuDR2Q+8a9VR6Mjz/jV1FkfT9J5FMplAkmfuiX8QvDMadto7my5IoNP7e9ilLVO7IhoHiGAaQLz7DSJbtwh41XFyHVcAPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKMzYPZjlDqdzFAWotasuU1qV5cjX1O/7DSi1M38HQM=;
 b=kep2K5zt2kPE7YCe10XTM61tQJqZLpONh9Rr5WPAhu+agCvmdh7ogp4KcQbau4EnRtYkMmKpRp4UGef3vsXo8SWI4V6WCaTwKoW35j/rYfMIqaqvV3GaNomyOvd7JV90L2B9l8KgNCEV+IE3BloLi6GE20+n8sZOLfq2PTU8TP8Ck+rxGfMOpZ4qLktJ1NIv5PPfV7TVDU5opKgKX7ACX8eb7aE2uOZpezv1U8orORHaAsS32T9oCWfC0YKwXBj450cwUmNF79/hrbRqVvpAtP23VifaTx9mfL8o8WWsrnJHsdL5gnZ+ol+nmRXBDDXJl3Baz6ovn9dFP7nyhhtnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKMzYPZjlDqdzFAWotasuU1qV5cjX1O/7DSi1M38HQM=;
 b=bytYFQ55WTOGdUUhurhL7aCetpLf5I10AlJ4/tM+vypyIaZeCsxXzDpcxzpDrYC1qcp+tfYSn20b+qUdVHsEZqwldXQCiXkVxzSy0MTLA+Hq8jBTfN3kdfS1luPdrPdmKl3sqR16n3oZteGSrPEl7MV5ETIDDuhNYtuzaPw14LI=
Received: from BY3PR10CA0006.namprd10.prod.outlook.com (2603:10b6:a03:255::11)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 15:37:37 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::68) by BY3PR10CA0006.outlook.office365.com
 (2603:10b6:a03:255::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:37:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:37:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:37:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:37:36 -0500
Received: from [192.168.0.226] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 10:37:34 -0500
Message-ID: <9c65d1b2-4c9e-44a4-82ea-4351ff9aa6b2@amd.com>
Date: Thu, 1 Oct 2026 21:07:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Zen6 client CPPC
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	=?UTF-8?Q?Rafael_J_=2E_Wysocki_=E2=8F=8E?= <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <x86@kernel.org>
References: <20260924160052.2858456-1-superm1@kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260924160052.2858456-1-superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf32d6f-e85e-489a-5ec7-08df1fd1eb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0+n3Iul+B0beqRuQuVFwyttf8Xo1gLaxMXOJWbVK+hkrbNjYrsehyRZZumE6PpNH/d5P3uwCQnMzn/RsV1Jb/Pev5tzIuwnaotHlKfRqKT8IDG9H2/JEaJTtpFg6eNW3vuMbzG7W5kkB/R9E+sSYs2P8xXd+9Sp35Vt+rwbRUmWk8qffdmAkDhqlhesjXneSBSatAkZga6yl/8CuhIIM/8Q9Tvw5Ch8KtXyLnsCAmykSMp5mpfxhQarSI3fay1UyLiNPbD9R2HsJftcgCjZ/Tb9qfg3wLTx3wWD17Zrt0W2WAA8MY9DraGLbAiD4ALZqeWPEBirGF6YWnNuCH60+tJwBhT3rTdrYj4JXMDtv3aPR9D4n4WoRhSI1oBqtdzPk9+LY15z8r/1qeYeB6Ei5CW1jMGyEW0lX9gkNWNVvCUIPYWetnII2DRUYH+Wfu+CFzMrXJ06PwVRanb2OfFF76sgGetKA716LbXTYUmNC2axxHH4rJfDd2IN4eup7CyHXIs+NCa4Pqeq38ZtoOK5x1TXObmd+lyDCqpKAjeDB9CuIuGwg47n4UFIStluPbiUt2op65vab6TAaXzGc8FkYcPpWyhqMQlzxUgvmbdjRRx0KapDuRssT6ccWAFbT7R0xnSB5hVG6FYMcEehkFCJc95XKnY+wRIVbnh2o3g8iNaSaLs8MHxa2yE0e3KH8Z+x/TFmU3vl3MS8QZ4rkxBFSrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yZUZCVnOi5QpoUG8R65ZWPHkU3nnwhAXkpH4lLVJOFV1AU9BHKHrllVEDxmDl2lTpFNrQwSHmmGatVL8SpBKI9kwcgTui86UreI9RrzVmt5zLsanf+omc7+m0TjKq9i9N3VdwuH8SqfMTYeMCNsHnjIsEpKacYCZnnoi6YuGIA4nlttULiiWDaobz8OUrWbH6s/8udQpUBsAdtMXLG02JkRFVJOdBFgO4yYLMU8aCrDb5wGXqfx/naXsOk4KiKawJv0yrhBjPn8HO/36pM173hfo6XOpgEXv8o5klrbsm5y9zrerTu/HvPSe6LOl6TDYAkz9BvILD8vDYIb08qUYPPqznifDFUgYrZdBpaNyz8B+3Mr6Bou0HzbUBNhJyEUOhAzm+J+8a5Es3nW91ZwGXRGMeJfjWWc99ge+gZooRctspJ7bx2A3NXpPc5OSc76f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:37:36.9663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf32d6f-e85e-489a-5ec7-08df1fd1eb8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017

Hello Mario,

On 9/24/2026 9:30 PM, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <superm1@kernel.org>
> 
> Zen6 client platforms use CPPC differently than previous platforms
> and knowing maximum frequency for a core type is needed for capacity
> calculations.
> 
> Newer versions of the ACPI will introduce a proper interface
> for getting this information, but for now hardcode values so that
> these systems perform as intended and to unblock future scheduler
> work while we continue to wait.

For the whole series, feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

FWIW, I've been running bleeding-edge branch for a bunch of
tests today and everything looks fine.

-- 
Thanks and Regards,
Prateek

