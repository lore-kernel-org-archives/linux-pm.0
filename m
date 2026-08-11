Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182EA3603F8;
	Tue, 11 Aug 2026 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448890; cv=fail; b=ObaYZRQioW7yJdktJ8yD9xI5sebCd12gW0L84DoZRTjZXJr6j2b1jSaU/FjhcAN2dzxe9tmVyp0oKkxCZw0PQnYNjISAZPgpxbKmje9cGQnhCFu1Mzce10PzNspo+HwyxyR1j8E1JqJ9hNOriR04tn1v5/gktD2A7Kg35sNGm/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448890; c=relaxed/simple;
	bh=VLaAC64aj6w1vAqHyuh3V5Krn26jiYRWKVpm/GWDAeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EjLSZPr1W+Z60nhQO7ZoW0uTZO4/Idva+HUnltoaxstG0LVm/IgUnrrl9Y81K2wLg6qkKObVZHICRQKksaU57vah1ZCzvdRr/Ofokwd8xzo59TkDRJFPtNE4ovonhT+q6izf00EIJJRu0STQfocN7rmYj9nFY8CrWx7QFeBYZRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=COUzk8Am; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="COUzk8Am"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3PXGlp3Gq2Wf+BZ35ZMA6pqxFJL32raZFvpqGAuJHSOZQ6XN+PpPvuDNS8ngiUNwlyJPVW2krbVs+ws43D/ZSydIUKvEmGZakYvK73nEGIf6hmiRT1u5hVqkZEnxdjHlvjB0qXwORx3aIWHRi+I1j7ifXwtOVf1gp7srQd/eon2p7cIUoSdzI+Dwpa5FSuiqFDWxdb7vv+i/RUFqzEhes7I37sxZenVlQdfeXSjc0RQZdE/GfMWqbJ89+hvfF3fT0ohS9QHu3Db1/cwZQZIf7p8F5BLML4MEPi7Dz/kstxZ3XWkmfqapoqL3Zi1+qZQiecgj+fF8nACegw6e/8w5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=794lcFXHVqF4CHY0K2iETKL68oK3mJX1JhcmQi0qPQc=;
 b=r8jmb5RdFNXgxbDFQxsOT2PyhsDHMKrtwQKxAqCwmP4cRVWswJkqjSW4qpYf3EvXQnx61CE6ttTrllNAJCEBGVkxFwF5lj9iedNL3VSjofEDCsHa0HW/ctnrNdg/yn5X4LRpC7MGXCDNNVDeVQ7mvwjMDQhuviVg3nP9QAujpPrtUH/9aohNWt0qwiCI/YUUl6pC9DqHjQ1Hc1y41z6s5mrh5kpJAlBg6poCgTbu7VkEZaIs6khl3JtJeqGO2vOhmh3dx5ieV+s8tcCO8jm0O1Wk/3Q1+wrnsQ3GqJ4C0GY141F8FVzHRvX9Ip8FHHRoG80aEbLNdbfg3se7CyIRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=794lcFXHVqF4CHY0K2iETKL68oK3mJX1JhcmQi0qPQc=;
 b=COUzk8AmNWmcALJgvu1BuhL28eWN4oyU4ebJHwxEdlF5pPMpfcF+fBJhDKZAixU0fQxDlLsJ0CbYOULx+k4xbOwnMk2/1gR5Y6nPj4Cn+aswHTCdeHZuZDXQRhsV/TwasRuYp8PNxXIxRxVbur5bWSFOoZBykolfx5pqL60JmLI=
Received: from AS4P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::10)
 by PA6PR02MB10524.eurprd02.prod.outlook.com (2603:10a6:102:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:48:04 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::86) by AS4P192CA0015.outlook.office365.com
 (2603:10a6:20b:5da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 11:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 11:48:04 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 11 Aug
 2026 13:48:03 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 11 Aug 2026 13:48:03 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7B5062341;
	Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 4E374838AEB7; Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Tue, 11 Aug 2026 13:47:47 +0200
Subject: [PATCH 5/5] power: supply: bq27xxx: bq27z561: fix invalid
 AverageEnergy address
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260811-bq27z746-v1-5-3a4fa38205cc@axis.com>
References: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
In-Reply-To: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Andrew F. Davis"
	<afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Dan Murphy <dmurphy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, <kernel@axis.com>, Henrik Grimler
	<henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=VLaAC64aj6w1vAqHyuh3V5Krn26jiYRWKVpm/GWDAeo=;
 b=owGbwMvMwMW4gT3Pk7swMZvxtFoSQ1Y19wePYLHznrcnXjnVvr/prt3zoKgw/8pF+9w99n2Y/
 Kfm/lTTTkZjFgZGLgZZMUUWnXrNddM75VMkVz46CzOIlQlkCgMXpwBM5KoE+3+3b7q8ijETSg5u
 TYz1Zy7muXhBwMGORUBU6HKD+PJ/Wpq+eezq5/mfd2S2K5ZOee92IaNYs+jetVPzXSXXF3f3+PS
 alhlr73oaYMFpIBunYCPQ5OGUqjN1zbaZP6MnbT+ivveHxMcdZZ81qmvU/ues0Y2L1Ji5yG2zjt
 3ynwIuQfWmOZukfaWPu8Zxu0zdkRGmtWn137O/VHVDbmRVJ33+fPWzwA3mnQ9nHWX8OyHFtyP8q
 OuRGf5HM1e3syeJyzaIfy3WLmZP6DhiY5P85sSK/ymnIpIf1GxfGbnvX39vn8fJW3EBV9nfml9N
 5YyzT4pzdm18bHp7Od8Os7IiRrWvnztstE6s4l+qusQSAA==
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|PA6PR02MB10524:EE_
X-MS-Office365-Filtering-Correlation-Id: 25be8dce-23cb-413c-fbf6-08def79e6746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FGdRqfUUxZtT/o2dLlQAB/8qlpbBoSKVDXGFM6Oucpsprfxfzef6sQESulFMwEHi1xwqKakWopEB2TBcAFhejFr53/1OQlCqLVFXPyuk0PfZyEDQQ1Sbw1g3YdXlP1r7HOVUTY86DitHyPYtoM9QAj1ojRluEzezzT+MAFMIss2U+L0DFL7ytgA2GOQDr+MZmK7MUUPpZ4grrCQ+np9PywqkTEVuAqXgwrLqHJOEEM2qmGPuHj+ZQ9+kau4P/SDB6XjSIk15elypPR3OzmEXcs4CvQ/UhrPVVgimfBsN+hExlL7muWPdx2GUTH7lto61xoeZ09Eord1bJvGuOB0TMw45YyNWGprHf/fFmxxKBdq9QnNhNHYg2ko8zj0GPzb9/Om0fJCF5OoKG5kcmO8AgfqNgQ1pA3POGf6Jz4+3W46UKzgvrnqiXRobNTNTD9YA1pCQFE4BPb485MtNVNigvMFzD9geO2AaI4O4/wueGN0T8sMSCdAp+WI9d7/bPH1/D+bNOyziNS11+FEO6Uy1f9fRV3+L4Xyc45PKRn53ICYDpR0cQS7gF2myv8XcAvlg3bX83HzIGPblGutiSRWbHJ/m4zb9LZz9U9wmhuHQMTdtnc0nwlsvvITRMJG0gJCclnc2qhhy5mtdoZgr5c0jypUqHc9/zybnjAjlI3B4ZV6MJgP/xaorMLA1UA20LqRNT72AOBIVU7pnySVBEOBK3Q==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x5NTdivhfMX89r+fXnuD8bOZvTyRha5iHjyFVq0mCh9ACL1mFx5xLGK+QAwJUDvaiFT41yXOlYqQ/2EEgDnfb/0rwa0zRAM8iF9yCE70rKx437W+f42/eBvqyQmEcVVITgNHmWg72olnBp4zZUG9lSeWjvpEYRnfFqtI/U8/fE7B1WzGflDodC7yKrXhozE7bPPzU6ZtMrg4CE6KpgRiXFZgr6HzPzzUwznvgNA/mLVSeNkd9J3K/wiDtA0zgmpxqphRAMaosT0g0HVUu6GH+SB1AeIAwYT3s/i5tciBYU2cMrVSqACcfGDI6tPixrr6ok5qOmR3A7ZKddFVV2cH1e4OK4EazzEnPXmUxI9Csn6T8eZcd9k8WNRcGHn5ie6UXM8ET/X93l3uFyGHMYUQSGqzzklV11KdvZjAjIn1H/q3SdG1WsK7OLc2xftDDR/t
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:48:04.2386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25be8dce-23cb-413c-fbf6-08def79e6746
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10524

bq27z561 currently uses the AveragePower reg, 0x22, for reading both
AveragePower and AvailableEnergy. The technical reference manual does
not mention AvailableEnergy, and it does not make sense to read a
cumulative, always positive, property like AvailableEnergy from a rate
property like AveragePower. Set REG_AE as invalid to fix it.

Fixes: 6f24ff97e323 ("power: supply: bq27xxx_battery: Add the BQ27Z561 Battery monitor")
Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 4985eb54090e..5aed8b24119b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -496,7 +496,7 @@ static u8
 		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
-		[BQ27XXX_REG_AE] = 0x22,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x22,

-- 
2.43.0

