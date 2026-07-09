Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50B390CBF;
	Thu,  9 Jul 2026 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568131; cv=fail; b=iQGx9yHHgFDtdA3A/qy9gFmcQNKqaOL/Akda+enkZHdq4a5g4qS93a56rU16Vh+4r1qekf3kYSRVPK5tHJ5mNDDXbgg9mu5gIG+2rwwS/Bp4DJozC+AMW8dUct/G+VAoHP/AYn6NgE4dNrGv6E0xnC9vE+jTLN2yBT25gZqvn+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568131; c=relaxed/simple;
	bh=HLzeqCOQCadHYRFn4ezN+BHKpmogQPaQwu20M9r6KtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlVCJuhP/ClXu3b+v3tw48EC4oKKP4P/RMLFxyKpfqTpnTea6rY6F1JhiHmhpzi3VZqRDp2r8GRfXh8KW9J7BTbTV7SNnIl8w4zh25IhLBBEkd4j2cXuttAeikrTpRUaHyBKE7DgvQfB8wxmaBGh6ER/oWZi1khc+iRuhMTILpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=k5CVoECt; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="k5CVoECt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gw8v3fAi6laxk/+AiGGQLGiu/3VCGwiR5IcL804BCaVqQcobn6+c5VkwaWyjSvo1qhcC8jlWO6wVhcoSMCD7xRBGGJNlGEtSk4V0gp/6cAGyTi9Iw8/3OM78II11sHBIly1y9H+8hi202/wCPEQKYVG+ZPGsqT9kxKbXRWe2KTC8jxp6PQPcYj8ZM33qCvJ/nxpQKaHxG/oVHvO0RkOg8l2ITK32jMv1EIf1KLZyyBZnwkHYVnCA05Yq2oK7UBU9FeSO+Q0ye4+92jwDktBi+MKMoVvFNPV0PQLHiM5QoxfktGKA8ili4O+AKaK0snDenveug23WEOq1mHk3YebT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYSgjYWs0o+Ce+GFzcsUEew9AOWxzXW5+wjLJ1BC56Q=;
 b=VMZp5dzKO5/4E2Qd6w8arVGWNyDseveJCkf28iMw0SSrUpEwOTTBge7/hxZzvKPj7x0Is790GNGs8vOy20Vc8LoDEm+ggSUscpvY+GHmqUjtH82YckQ7tl8vWue8YsDJKMCfI/eQQyfEvR0KSoOzvxu/U/TWxF2G7gsMrLkWonIdzBr9jZ5PtPjob3/y8Tek/suG+9C3+EIHVWWs8kc/vGqXA+jQjuqI3HMwXDWKp5Ban9JhvD5D/S+YQJGtAXTlI8EXBFvtF0noNnvEKU/8X75q6xRhCJi1zICtTQYbXY0pwImJWmnsc+cDYL+19dcJUMOKLj1MsOTb93AX8BMwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYSgjYWs0o+Ce+GFzcsUEew9AOWxzXW5+wjLJ1BC56Q=;
 b=k5CVoECtPXxVp49n9tdFmSyLlYmZ1XclK+u/HhuJ94r7UgFJ1pjixkmjNBbftyH3XyKyqImTauW2O4T4XyeUMIUmtqSANrjSj4kRr3PFlvhjxCVApvdcrfVNK8mn/cfBga2ge/VyvnWsn+XNg5YukU9rBat38rHUrYYp8LkOhEJ0HpzdUGVug8FSSsb5eUVIblyS/+0Yxy2gbAmsdEuD7ig7OYmUwJ8uZ4bkOaNVVl+XYOm4LSuyyofY2QWpcinE9+QK0GdYxnxqHJhyf1rfwO0pbLpzcOnVK/rCik/sncfvnBWfljvAHNfffopqlHgKdUUtqJG/FqDY7lI7etCetw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:16 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:16 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 20/43] power: supply: generic-adc-battery: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:59 +0800
Message-Id: <20260709033428.362970-21-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709033428.362970-1-panchuang@vivo.com>
References: <20260709033428.362970-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: fa12c543-4821-4556-9c56-08dedd6b17ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	W6ISNhpAA2QLsbUQ80lFrm25wUTLB/lJfzlcy08BOcplPgf1s/qm0eppJCgVAI0mifeSMkYfSEIdsqJ92uW+YIHkZ2Pp/ufGnCmued/eZS+XldvHbOu66tD7gdSMZRGF0s/IVcc3qVMc5fMR5HmMh/Z+ECfnUBCPFCt4jBOstK6aPU8zouuv23eL0sXpSlb39LrCNkhLT4f6GzTydSat+C4krfBpLnL+pkylmleKBe6AV9Lli/+zcnNvgF54bxOKkuIVHD4UKpUIz9mX1fPgOOWUMGfFIj18TePqscVMARiXmW4WgvJvANbaSJygqXALIxxnPbLMyO8VNuBkBrR8hrxE405RwFya6jyXkFYi4DMXTP/TP5YrU5FjoV7lwr4Yu7J4P8HrtQEqQOab+9Iu3VjH22vvZ3yNAED4/JTWuewC3tXsX69ZhAU+FUjYrkrh6YcDa/23s88TCTm9N5sVEgpBH3lbswzmFURlsAqSRdZX5E5lf0jjTQMBERSSLm63PqV9kf5biC0FaFqlqTqE+fxxNuc8Y1A1q1x8v8qVQ3OaIzbFpg9EfAYkZLVrwFRRj9FBP7Zx4tG1xhrpXRU2K1eBQs94EVCe6WfZZE2dpKNTWlNbjSCV/c34JTiDKrnYewd/GIbtg5onqVAEcid84lOzECtBrweyL+nVVHIBzuSqrA9s4X1gl5Bu24gJ6gTjJE6Hmpe9Z5+YjgKV4ObpYcOyR7In5qdBSplzRENaX+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lklglM7iVDIzerYmMTr5oKErW6tbhtcxX0NyE4Oxji6v96JLjfxR2cMg5vAz?=
 =?us-ascii?Q?CbxekvSDHHTTkEERgP2gFAFsIS0Qd1djsSKXAk277lfe0F5f0Jkob90cz0IN?=
 =?us-ascii?Q?OiPLQoh3Ks+SJDd/Ut20CR7Y+PFKfpbztvA69rJIGW4wzhmBk/X6DruJLQf1?=
 =?us-ascii?Q?1KHRBBHVJP11VkH+HACnT4R1p3mr7yUnITl7KtZ2LIMB7XKw0j46XMvDApTW?=
 =?us-ascii?Q?j7HVV+JwVKeHc/1z9g5hgjEFqy9OqVF/ivRihiEAxJED3USdx7NmTdsi3l19?=
 =?us-ascii?Q?dVf3Uw11l14X7nrVM5rU+Rte00yAcRbjS4MklemaLX7PWf2xe+Ez19JnqfmH?=
 =?us-ascii?Q?H/Xz14+87i8OoouFpKDEwtweR9h2JHoUNmssRqhcFudcpYvr4DV0ZQP7BJMV?=
 =?us-ascii?Q?No8vskDy+91yEaMhpnDWPabLAtOCNz+5pEfbvRts8Jtm05bIvWccSOsEvV4T?=
 =?us-ascii?Q?+vRqL4SlTbmyCg01zNq3HKXm4icy9bo+IYmqrPPmLgO4NARq3Z2/uvcHUMkX?=
 =?us-ascii?Q?5M4WTYNItahGk9GDDUXRNNGD15VikYl8LT0fKg9ruQ7OxmRvuhApjqz17fVw?=
 =?us-ascii?Q?ugY7NQ5KMNZGwzmycJ0tkWoxLEga0Qjsci5fDXsBQLDYouyc+xUSelkt3f+v?=
 =?us-ascii?Q?/K/GQZOTArCehNC/v0VOQ08bOm3gmp2xhfnt6ytBNR5F7eazX3pQRn8OFmM9?=
 =?us-ascii?Q?zD4Au9dGA0HO4Z0HjArW/GkX3Yr5uTxaUGXfDg63YKlcWF8GDLogymKXvBrw?=
 =?us-ascii?Q?29JesRAqjYUvOfaC41WD7i5lY5jXNMEq5eM+ssWay+/xH/CuHIduI+Hj8ql3?=
 =?us-ascii?Q?zjK9ktO69J3Giku2QGY3+YQ/TM4IRixIbb1bPYD6MfkNqE3j0o3Smo+8fBES?=
 =?us-ascii?Q?mj0lFIW7IYi3Idyq81MkqytdJbx5S8IiHOn6w2FUrLnKWN0LrijnldwNqhN5?=
 =?us-ascii?Q?pF4IHJ89HgxvBWSXp0uPRfYDvm0ICc6wcbzNxytPRlLYq+HvHHg058OgZnDZ?=
 =?us-ascii?Q?PrB3wDIQ1/AB4g2zom4xhVLS42fOMJnxfWWVzSmEtRhqAjLa7tjFsEa/vCIf?=
 =?us-ascii?Q?Y9ApWRFyMKf6ZSLyQ9lqF90EkEbvY6gDsi7O2zU9WmwAmPfcOsHC6w5ALkbA?=
 =?us-ascii?Q?/FY9dRyFwDMfY98ILI98RdIa3aJx5rFaFaydjFoI3LYcSznotq720NGEevi8?=
 =?us-ascii?Q?MvxpGtFD+cWBPeGDrrIHScVmzeBIDYiSWnhVJ2SbjNTt+xIkObqiben3z5Mn?=
 =?us-ascii?Q?B3kzULrq5efVBXVAoRPDyHAj3kFSEPmiR/tY2MzVqzqeAwzDliLJd0WxF5AX?=
 =?us-ascii?Q?6HZTSwLoUwZwVYXBfDWLM8+S55plI/uACP8tlJCI4BBIooR/KUOR4PDyZ7f6?=
 =?us-ascii?Q?G4MkPUEvzmMgQwdVlobZM9RcKFC+TSmM1sRJDTG6SWrXI1s3wfvbe4b2wfwG?=
 =?us-ascii?Q?1yL98UElt7ir7gSjYt3XlYFs/9pDTFj9Qk5LuF75vpPcpTDFD97dAvbAdeMn?=
 =?us-ascii?Q?/K9lY0EHihgP92mT6RvG2vAT5GpW52cKvM8x8TED8TTwCyPFOpUngZRHzo5q?=
 =?us-ascii?Q?Y7DFNaJcKT4psm27GSxtClFz57VzeP3qixR3NfYblf532nSXI/3DiG3W6aeD?=
 =?us-ascii?Q?eUGybX/6WBiE3Mhz+2WtaX/8zZY5vQoRQOVJ32j0vTZh7rpN5HAkUBTHZ7N4?=
 =?us-ascii?Q?+G8fW/oCvArqJvqakitm2LsLbr1+y6/edkQdFvWSustUXHTRZkeLZUQuYrxV?=
 =?us-ascii?Q?1aick2erow=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa12c543-4821-4556-9c56-08dedd6b17ca
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:16.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1aFkU4xaRfgI4gO2RGW3dgUY2Huhs7hO2W0YL4LpGV1SZKrsGicRRLI8/IYlMILvdWU8Ts65WmMWyG5Dsa9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index f5f2566b3a32..6913179ebb84 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -246,7 +246,7 @@ static int gab_probe(struct platform_device *pdev)
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"battery charged", adc_bat);
 		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret, "Failed to register irq\n");
+			return ret;
 	}
 
 	platform_set_drvdata(pdev, adc_bat);
-- 
2.34.1

