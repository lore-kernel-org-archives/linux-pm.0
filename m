Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393E368D45;
	Tue, 11 Aug 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448890; cv=fail; b=V14ADnsLWX1g1TCY/Bjm1HkrOYAFC6Nqd/flQYRpUS0RiQ42A9dvvMK1HeMq7wSydBcqubEhc5hd4NW3UgoGk3AE63D05q+9N+O+iQVA8SdMLwn/e4+sv42GWgmmdJuK9xUnPC/pmd5PfaKsyoV9118gVuyM/SUutEnu5jLy4ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448890; c=relaxed/simple;
	bh=p/2tyu5c2aM8dFPVg+81qE9rpoBkzoDA7y5Q+GnsOPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NTyiCMhkHOaZG+tliInSw/q6fbGexvmqx+YUvhu6GhPdYQDxk9niZ2FkaLAkcM5wk3DsmH9iNqtHaoma3MnhdqYXTkzZjZ2iqGTpD3/4XkcN9EbcKajPcZ74WP57Lni5H34Xuj56terVRxHdHCpoo6EXDCbpWGsgUolTPiER0VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=R1e7WL8P; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="R1e7WL8P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rb1ThXW4mcgD6TurDqbtXWx6JAzIF/EOxp3L3y2PdKfsq0k9i5FsEZWhxJGqAGIdAGSjmWtjrPNl0uBlhpyL22RGMvRHFMvDUOM5PRjqCuww/o5NK0MCpudq8eIlanb9MNQaUuEVDPoXDBWFm+vD3uz3AyxpOPMqIc/dZC0E+5uZ+Ylez/vHfNMDcgVdsh0tF0aazemYvnmrQfnNYB2h+2l2iPE5rlx6jLTQ8LebYDWG/hP0ErWSuLQM6e+XJdw+TMNAi2jR4DbQUNYAMLrasy8ZYg46wowTk/LuuZ4hT2P2fh49X+bzecQegQ3uLyzb08Ek84oO1nYchj+Cda7SLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGyW9yLQfCWuH/hzqYFbhpxX+t4ky8Jkvcgumwr6EVs=;
 b=F501YGUTAXi1fTbdqKf3tKVYh86nr/jao1IX3oyaEZ2HPfayFAIcsgh/bor1KQCkjnFNRU/H1FiU51k5iDheHwhhdUWc4DCBlgQll/JDRvTGuT7TvLz2lyhfNaefF+yb5mCWboKQZ1RkZXVqsrZuUit5X9JioEzPG8O4UcOaGBMplBeETXHMWEP3bG+xadp6cLWrZ98umn+aBtXk95/SGSmBVHCkfjdNKb3EzEun2lFLctd6736D54S99tcVlK57KhR0dnXiQKnAD98mgXSCX2hm5xR8Gp/ECCaND9RrtrIgnRBQbtsYUPoDMzHeguqu1ye9rjKmAA8MD3mIrTdsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGyW9yLQfCWuH/hzqYFbhpxX+t4ky8Jkvcgumwr6EVs=;
 b=R1e7WL8P7ZQJk93YzoXO6aJTc+m7NDHSHcQ+zPKCix6aysg8YtLZYi+DL8raf81FYteaEn74rZW0WRZE2WPwbvklPqjeRMmn11BQ7G4dmwIpRg2b0HW7+bZ5kt0YVHyHfYYio6sgzdmrBEbklfitudyqFjrnWaCVF6lHL9yfr14=
Received: from AS4P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::9)
 by AS8PR02MB7111.eurprd02.prod.outlook.com (2603:10a6:20b:2b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:48:04 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::78) by AS4P192CA0002.outlook.office365.com
 (2603:10a6:20b:5da::9) with Microsoft SMTP Server (version=TLS1_3,
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
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 11 Aug
 2026 13:48:03 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 11 Aug
 2026 13:48:03 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 11 Aug 2026 13:48:03 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 687DF17C8;
	Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 4D661834C4E9; Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Tue, 11 Aug 2026 13:47:46 +0200
Subject: [PATCH 4/5] power: supply: bq27xxx: bq28z610: fix invalid
 AverageEnergy address
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260811-bq27z746-v1-4-3a4fa38205cc@axis.com>
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
 bh=p/2tyu5c2aM8dFPVg+81qE9rpoBkzoDA7y5Q+GnsOPU=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqewvsxTZuVouoUVE5FelQgQyVNjprjxoBvpPH0
 jFrfO4zH1qJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCansL7AAKCRCwB25JC3Fh
 a7+LB/sHjVuNu4pzIyfqM5Ijni9vO4GRdlb+GZW5KlsppXRltTi3XBxctoAH3K2wmu9bKEG86VU
 NJjydfDCWx7+0PAfsaiOTgRzuYA/O2lcw/6PQ8vYIXW+qo4u548Z8VUN/jV5CMB6nHqjN91PQQ8
 VJxG2LU4GrSZ5vyHjCZxaxAnx3I4NXsVAgNiHWyAO0NKq+d019DkKKN/M+0pmRK87t78MvK6QS3
 LHiJFXQUH3/RK0R2TWHzoa+HdXzxirBqaDpBdmTVpnBQbH3svaiA14queb6hNGZbTbwZ9AjxvHS
 u9FIXz3UZB17uBzAsmWgRWk0IaGv9nMG/TSKQ5w5NPAP+1Cw
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|AS8PR02MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf1940e-6547-49eb-272c-08def79e67a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Zp8MsYSPvt4fWj8MT0toypcF61v6t1AV2jbtbNUEMQV2AhKFSuYMAzKkyxmsuRunMUwoS9vPcv9S70//Q4jFcoeIwfeLE24Ig0Q+lpNofF3iZlc9mlecH5poNpAfgF5iaM5A00qlXJgCNDSyYRXi7NVDphNKa+JhQeOTnD6FlXVb/x1a9Dzi2QRaTbV8IHzHF/pCkZfe/b3SIprwqU6evqAbCgToOi8EQ7jRdB5WD/L59m76qruYp1KttushS1QMnxh67CUG6XB4BRFZVJqxQi6gFVPEr29e9l0H3piQ9G4XONg5pQJPyZt9nQtw1bQH39wSF3g2wiPmbPqaAlaHo0x22U7Vk3PwLyjPSC/noD2N6PPi4Mma3luYy3y0U+3+r0cueloV0u8HoP5ffC6Q1/uhPVmm26dwzIrdv7IAwlIKqqXXTN9Z2WfE0+NjJFzCUoeUL2cKs5e+wgsCyCcyPGSNnGdPjMU7hgy6l8q8vdS1UPjjaHtOqCHPsPCVeo7Mdx5vMhwTWzeB3xts9VExC3WZJ6VN3VFYwOe+B+wpYc+UM06X+h6rQ7WLNrzTNfVAsnDncN7/JXd+XTir4KHtSOUaEkbwvkB0xS0/exIARGv8pcpJW/SUYOrPicOCWNoQZNTl27AY6voG78FpLVWliZU9vkRIx8bTwfszpQGh0Noz7FuxphD2WqJK9+/Fe1TTm5TbPKIHuysTE9LLbeB3Vg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yU5vkYS9vySiR7nwKSx5nvCXEltvhFxm3GNkksVgUUBwE3HrwnZZiYfpusVFN7Imvmrq+C9qMSuRdAl/Z62jl5ymUVYEbu73iiULMR2Go4KGxLQBiUBdp2gYDVPt9NS9N+0/fqgd3DCXtG1yktyBB4CD7ktj47We5UpniX9QNryyXhF/hHSi1WGeKWA+ZWZB0QFIxDGFCSChTEATboEbMBCw2PxiFXvlO93madgTy/5XZlKMLtEdTIJbSrOrVxILOBo0AkiRTP/g/fuwhxDuQ4TQjzTe/6mfcpCTxVwNECv41FQrrS4pTzWBlXZmgsEKSLUEronE3PuHaEKc21iTnB4rC8GFbLKyr52OYZfZU5cg1IFvJjwcFuuvNRjUYXoj0ZeKLXhunw0jJHwswqX7cS/WCLmn9y2eGhbDR8+wMHFJ+e+MuSL8TJAm69blNpzX
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:48:04.8558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf1940e-6547-49eb-272c-08def79e67a5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7111

bq28z610 currently uses the AveragePower reg, 0x22, for reading both
AveragePower and AvailableEnergy. The technical reference manual does
not mention AvailableEnergy, and it does not make sense to read a
cumulative, always positive, property like AvailableEnergy from a rate
property like AveragePower. Set REG_AE as invalid to fix it.

Fixes: 707d678a5c7c ("power: supply: bq27xxx_battery: Add the BQ28z610 Battery monitor")
Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index e28eca53c7ee..4985eb54090e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -518,7 +518,7 @@ static u8
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

