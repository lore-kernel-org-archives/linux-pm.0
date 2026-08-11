Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C544213B;
	Tue, 11 Aug 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448895; cv=fail; b=smoc6PXMNJ6sovBFGaqyI+tpyXIDgnuw9OHZBQzaaFGPemkysiw04y6ArkYlgyCiR6xx5ugkiyHLKYmtKKBIx36Oz+qfUGEJDmrxvDmh4dlrZtXPhYZqKKJudES60dPWnzZ+0JDmmbudo1T4vKtQ1MC3G8EaFif0aqbdsKA3R+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448895; c=relaxed/simple;
	bh=f1scD2E1UwdscS0nRRf7EH5SpKOccGAxAzBv3SCcJkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q7TTCXEfTA41WK33PXkDBUmBjG+csON6potShR13jLBLYDKUxbVKdY/Fuk6KahoWUffc3HKsLkSwzsgS53MgV3+/KNUFM54Qq/U3v7w/8kHaQ4reQ/SVksW3zlOJrMo2MZThU+WtodcA4SWkAvnyNdDq3JWEgZWzTXUo+khgDuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=X2bA2+fm; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="X2bA2+fm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=er/NWcEXet7xWAnR2t25Kzo54fSX1/eZzWKS8GNaTQSwD57LJCfZBFA9Taw+ZK87mJ6dVlNSfWJk0pXQ5G2TQkn72UYTup+LcqV2QgIKvwHobfvyk+HZDdlHgeVe/nzzVv7r165F2pCYkzz+PG1un9MrfEYpp1SipdEdRYXCkGokDKWmYf4HFJwMKIAnkz0LqFMCo15aHI+QbU2Dae4B/puIviETWCWW4nJhdzlnlF3Gr3YJUqDMkCTSNif0zQg6FXoLLzNlNs/fg5BxtuiakmkBYjrT82SYRA2J9Rb8ON9mHzsxyKrTe54Pl4BC2XHkRFOGDayLc6BueXzZttFcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFcpMsUEHSHSxh/yjJHYHw/dxAa48OP5tBmNzABLnLo=;
 b=GuPe2hczx5QmRmPkfl6SoGexR4+QPlC8+rNtYWJGR7z+6sZgXB6aPVzDEnXz4cmRkUYZ8Bi2i+e4lcQGYKNEqCI9FDPLiSCvAb5oXaBtQU3d9Dmo/aApo7sFeDcYzJTS49vOIrFbUrYFQLhQBigsh+YeCdH/seBkTLSt8YXeODi15T4SWIXK9YIvIzUd+4m6XguQ/w3aFVZn4ikPUiM1q8mQLrjYXFAMbjPOLs2FpzdwR7XlbxCL37M+yrAYY8zDClyINToIBLTnd3pD8+uCn8LK/eLa9hdAdsZCmbxi9mIcmSDeOcfjyPe1V27gqsPaFDouxWkCQR3H35WOcMbucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFcpMsUEHSHSxh/yjJHYHw/dxAa48OP5tBmNzABLnLo=;
 b=X2bA2+fmg2SFi4HVxEJRjeX1kngc0n1xJ8kiaW7A9wdboW/mUJGUl0A4S566o/6o8RTSfLJwsji0rqaRi7geCwWxPtWTFfty/ZDzNVrZ169Rbvk+faZj3DbshyAUynGJRat+pn9UVkmsM0GGIO34Y/AIq68/Wma8I/yGYCjG+3k=
Received: from AM0P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::29)
 by AMBPR02MB11906.eurprd02.prod.outlook.com (2603:10a6:20b:765::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 11:48:06 +0000
Received: from AMS1EPF00000092.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::a3) by AM0P190CA0019.outlook.office365.com
 (2603:10a6:208:190::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 11:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000092.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 11:48:06 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 11 Aug
 2026 13:48:03 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 11 Aug 2026 13:48:03 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 6CD972555;
	Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 4C7FF81AC012; Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Tue, 11 Aug 2026 13:47:45 +0200
Subject: [PATCH 3/5] power: supply: bq27xxx: bq27520g4: fix REG_TTES
 address
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260811-bq27z746-v1-3-3a4fa38205cc@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=947;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=f1scD2E1UwdscS0nRRf7EH5SpKOccGAxAzBv3SCcJkI=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqewvpHCKCw0+yQ7BALjuwJPi+Ao8jNRb8V2hfh
 a7NS+zPL0CJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCansL6QAKCRCwB25JC3Fh
 aw2iCACTXziHR5jzCxG0FOo/AV4eQvhYs3qQa/IYS/bbSco2A5gX2/+mtk2+122k5r8J6r8Pg3A
 cAPps7ZyZnmEuZXmt9X+sF8EguNDfSPi74qMw8GA5KAarI3G43FRrB/nIhtUb1Bp9z0qCKi6SeW
 jAwG75yaX37ZJC1Ak4yqzJ7bCXOeJej3ELVVzSm4j9IumWbknEuYFF4IvTpqpQ07VZkt3wckXkg
 3fQyu4fZM+LfhKdaOL6T4tiwEFRLGa0e2fJo/5KoJ3PF8G5lL8etIcHSALA39TCNWdz+KU7JZgo
 sYcjrtSyBR8rlVkqjyA02yoEEHl8TqHzIMgn9f0zE6HosknR
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000092:EE_|AMBPR02MB11906:EE_
X-MS-Office365-Filtering-Correlation-Id: 78345392-c2aa-4dcf-9b4f-08def79e687a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6iTcA727G7qBxW7LS6GAcHWDyxsz/fDOoIR31veqzIJcFZkLZ5VinpsRQN+36EKLmQxL2EUuvhXFuqHtRtnal/kjBU/zkqJCti/OXoayIv18qCpvuPsf3jFb8M43xMtJtd8H2dzzSmY1IdmqU/VdyUC/orlbm8LO0u4rLq9qzSJUaKkMD5oSMnxjpQbmdi50QWQJKswMTAueJlFkdcfrw8LzFkDq0worVTjoQYqVe6Sfck7Rf87PgxP/IoVy50gtdZho4fRwLZE3MTd+AUXWhuo8E76fDMQ/O1vMwHYDrnTyT14dQFfShKrfNuZUQRHDagy9Wbm6vzt/dKyAx6yXInjPrN4itUnOd/DEi7CJKJ+mIVXyjX4k95zRFFae5eMt62gGRDXSy/4iArwn1nJqjKUoEXm7vTb3l5wW/5A/uh6h9E4RdVFrWGfoSGdaEQ3fxg4e2ZZ4tRCjFR+0cN/KObHY5qouWCh8Ut3y2jeGdvkJhgIR6hlKPXpd+toafO83+/JEeRXkTelCPkiStq6uyvWA+DLDVNtdwx7NrcxuEXO8KyT6/gNDiQEyd856RkGkbXGFCiMy78XpKperA0jou+HoYtaVoJveuFQha4Jtx38x1uyBzBHlML3M4m8dN4Cd6ZsDHwRA27j2xig9+dIUF3zAuiWEx9Z9g6nDVtkvRpeb6ATQQnx6tcmFGJUWMFDFvj1Elrtu6hNUVFLY9ZFqbg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FOyu+bt1rxiA2B9Fo8u/87+1Pt/OxaH2KrONF9lNkIe2FwWR3wzhf14A+dDvfzD3rBG8/y8a9f3OUvwQKll9rNO2EQul+NUeQz2iOthFazxIumQtOhNrEr7afUin0zFd4abcIgkYPRuhXNpk9Z8xshkUHPx6+WGe9g+YSoqMUpeCMSNbkrx1s/hvkCCGWAXQuIXi7o51YzmPRJxxRKguyoln2uCQ8kDpoBVdXJkeR8h3CpBNjFIqStE3YJOdIJXDqaaKVrmVl+UvbtChOSeHJE2FcvcKNp4k5PCwB9aPbBABXhEgYIdUzLH/Mrr3fnfj8zT1UNpGk6QP/B/wQulfXBIvsVJJKXQOadjLxzTkWIXg480sZ0xdnUysXzQIJ7ED6LqatzCWBjfvzeU5igBdsfccD7ZsNe31Q7iTVM5dbCi+DbtwssLPOxZRVCWdSIv0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:48:06.2574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78345392-c2aa-4dcf-9b4f-08def79e687a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB11906

According to the technical reference manual the StandbyTimeToEmpty
(TTES) register is at 0x1a, not 0x1c. At 0x1c StateOfHealth instead
resides.

Fixes: 8835cae5f2ab ("power: supply: bq27xxx: adds specific support for bq27520-g4 revision.")
Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index be3ca4b76c80..e28eca53c7ee 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -331,7 +331,7 @@ static u8
 		[BQ27XXX_REG_FLAGS] = 0x0a,
 		[BQ27XXX_REG_TTE] = 0x16,
 		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_TTES] = 0x1c,
+		[BQ27XXX_REG_TTES] = 0x1a,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
 		[BQ27XXX_REG_RC] = 0x10,

-- 
2.43.0

