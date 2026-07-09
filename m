Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012015.outbound.protection.outlook.com [40.107.75.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6133BBC6;
	Thu,  9 Jul 2026 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564329; cv=fail; b=l917uviUgNHxNz/f4U7wfkEhvneNuKtd2n+3ZGG/cnUJpqG9ZG2Az188dwwjZ8u4JKlJKbokcLGEpr3xL6mIRixi3i7vS2jhn404kQlmR4lwMfImuNVDdUidpC9IHHUfbY8jQJG1Zi4+++PXKEpi0bprMa9dugh0SS7lHSKNuHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564329; c=relaxed/simple;
	bh=2KDQM6LHoAAXOquyvPcaK4ix7pDPsW1nMdcdBACYMJI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RmMVXd0aFcWasLZRaLkgH1BGtJT03RPOIaUTOgS4+vgi6jwx2oLc+/C4lvaGutKTH9ajHp6DVxbEpFk38nlXFANQhxqCq1+/iwjaG71jMHA1p/LbnR77WHCzLXX0Wx8tcBK2DUq3MpR6/UaAj/Y+5SacxU62bZsVr+Axhi8X5nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=N1OdfH7D; arc=fail smtp.client-ip=40.107.75.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="N1OdfH7D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTI06gkw0VI0URzVUK85i3DQLPtxw091gsguLb0LhLiJXBd3BQSaucJm4a1pNy9RoYlT/tnYrJv3xAo5MCA0G+Uv7KhHZlmgAZbktA4Unnls3KaFw98k2YCRQuTpPWNjujNspufxrmVcevUyGgB3gwb8m9K928XqsgAe2QcvYcEu+C9Lx/2m5clR1k4diWMu/6OyBdggXEuJbLhpW0oFiS65WjqglxcIS9F5TDScFm99PLMM0p05LteUvhG2KgBzITMQ/svoJr7QEgNMdTtcqIXEfHqkpVvA8RQUdWJQhTr0tUq0w1QqOEHk/X3RQ6S+Z1SnN+6WIrJ30WmERRnSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clxH9xTvrY6wo4xFmHT0RNPS7a/YzIXQ2aszVQEzq6k=;
 b=yWCSD+0lNrXNyl62gWETcN3tT0w4Qk+vwNDWrajlKciTEOwwKDc5Kyrie984/AHdY7Fie+AOJCTHc+7GmsP8kN7SRnjDS5U62cGSefY681NzbmD/62ePGlRodwT2BixHYRossl1z9n/AUJSq47Ev8aMybF0tjbKGJfGEpReh4WHFH2yePKgNIic8oX/2jfCIFg2vQvbFnFhBus3WzQv6WJwssuGd5Z6YDiaSZqIqQbGbhJQESv3IZOFqmf2j4TjTcbWStOFhAghqgWrCzQmyiN02dcXDBGd4bs4SGKY1SIU2FcBhPNJJ0kCdq15Uti+andF6Imx1iYvmAPZCf539nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clxH9xTvrY6wo4xFmHT0RNPS7a/YzIXQ2aszVQEzq6k=;
 b=N1OdfH7D3C2/XF4eqD+jMZvdZ8jYhBDoFfB4jXX+8NJD/BW5t9J1jnPc04qwN2jVEm+p6oDgttTJsh0Tvdko6aRYNlfraTcVR9FnQRYl62YatPotkClXXF1X/LNDYdOCFBA6powBwn1xu4AkI5ipNmPzMaKt+p903aNz88F0BZEwFmfQLK3B3ymQGzaVouD3uE3PPEfI/q38L/fqUwPDaNK9Ffbmq4e2nzs6el3HNz9BW5ZymRnGiku+7PM0486mj8JpKTSZ/21aY0sFq5PjQm9IGhU3BdSYZch3XwoaY+gApU4o1OTkevGE65pofnCog5VilV8Rk18itcRu6ewiSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:32:04 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:32:04 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 11/18] thermal/drivers/intel/bxt_pmic: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:14 +0800
Message-Id: <20260709023048.599150-12-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709023048.599150-1-panchuang@vivo.com>
References: <20260709023048.599150-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 1837e44f-522b-44bb-fb2a-08dedd624381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	LKcTLWkpzwzPTVlPyU0zbCfelYAFiLX4/QkVRleOs2GjjUoJ0fOR4CtadbZXWn0Uje+V9exfjjK7jVKV3B2wVkfkI9qvnlRy2/n85++zMRUz3IReDHBEoTNnfuCMnPNP/d3EYY2EvWrzLXVo2+OQtIiQ39TYDx5nLdfkShCtFa3h4D2UjUEnle2gmS/CEBRad55Ic2/52soj7KfFG2Rlx6vYrJqVG0o+i8t+aqXgJD7lOeztPmv/Qa0kWX1jY5GMavWVzSeTuG0ilBn1hrmyXKBVQjJstmeyTHCEQjbVYf/tY1j1HdZuYCE7IRStqfPhVGFuSMa5KEua5sAQ+9RmM5ki6yj+TNESaPDxdf6Ay+eprQtT2F09ytV8/9LrlrUnF8CeXgfxOuA4MClGBQdysJIbxUSqWNrDp5TEQQLKvIGKJscYiZyF2A214cguWWOvgtcTTCDGohbK/AMKQV2t1li7H5mM7o1GVBii9iAyVD2kFY4m7Oacn/l9Ub8+GFBSNgQa+YcXBnotZlxt4Mtpu711Hlj8kXu8DgpZscljh/ugko4tCazcJuuONNbINiOnsEHut1Pzlgc8XBR4cfYKJR4w7SsCmwRwgna0gKPgCADtaXEIMPDkisi/+TJkSNhDGI8J+zYetH4X5p70m+oH7mzFuOtThv9Maj2HG1gHOAWDqICdYAyGeHnvyvQA5LDaqueWTAa61EHBlZEFmj4dkCmLbaCoJwqOlixTmC2jriY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qAnc+6UBwdF/0hTyuBGnxv55PmpaOiLGEcYjdpn0wl/+5Tth5FAccUPJpfK/?=
 =?us-ascii?Q?orEqTSE3H4TijyXm3cGHn0C6T86516JGuJnq9/VQGv1qaj6Pl3BvnTSJm9MY?=
 =?us-ascii?Q?ttqHv6liPpqT+3tH3SIioYrexaw+MIpTdN+625VD6am1HaaDB6dLPQ0q3qFL?=
 =?us-ascii?Q?+LcyPYe20QmARgRwQCJKzfEOTYrgpkmrk+JFfn6yf3N5uDOFPW9PBGzAkdLP?=
 =?us-ascii?Q?7tHNLTxiLfxQj6FYGr06fWwF32YSO/BG4wfotKJct55JpIXQbISCSLtpRpDU?=
 =?us-ascii?Q?/Zx4vyKml/JI0PqiPaBCpJCC6jjzNUEMOsQqTq74i2r6WkcaNE0a/UwpkNkr?=
 =?us-ascii?Q?nDxWDRkSDjxPuTeQM8UeefoJOfpnmDBQzsn/SxwXq+d/7OrfnSeQMwSHl3vy?=
 =?us-ascii?Q?xwlrQrIUR8AQsm+Qe6Zu8B5M0JOapXkja5TXsUhUB6RoxDwAeg19jeARHqfr?=
 =?us-ascii?Q?GlA7zdxgL2zKlDiJbrYVkaeNzj7bSNSdL4JpRHCZrYrk2Qzy805+VcJkDK8c?=
 =?us-ascii?Q?8DvbCYUukOj4mDHXzEcsL4vn2FFXRGJIuKdWQqQ81BajWL0bKGWekAceGk0j?=
 =?us-ascii?Q?4D7h8Ghskc7GYwPR+s27hqeM3fTTGNSzLoLGjwoFGX7t97qWn4KfOE0BWDnP?=
 =?us-ascii?Q?5JZc7rRFJilcHvd8Hnccfrziki+E1jLel9PUJL17N2ZqFKsHqIuaodftuFYV?=
 =?us-ascii?Q?i0ttzxEtf7y9tqWfpwuDUQ3UkMroY2LiOhtHpemkR8+ObaEqRIeW/eNkKBk8?=
 =?us-ascii?Q?FJjGasBy8RtE34BlK1sDt/6q7LJobU72TtOEpg0exzFYDzFLgHJci8v7bChn?=
 =?us-ascii?Q?b0WdSuhm/EJrrpVwoa5vCypS217TCHYliWstCNLEybX4oREGoeqotQCuEN1l?=
 =?us-ascii?Q?1PCrPuxlbiJ6gaeopjv/h1Wwma1KYehhXCrTy8xlwZaViCA1AMRz78QaA8Cz?=
 =?us-ascii?Q?Bi4TJl/Boy8m6U3Z4Yii+SuSBtzvtzXJtdPPJ3z9xHlpAghoKkDk2jjtq31s?=
 =?us-ascii?Q?pkba0wjyG9whZNK5gpTKkbv9eaqJbAi4EleUXY0hbUmxKIr5HETwR4gUIGPH?=
 =?us-ascii?Q?ppFVUbgIL433jhleh2ZAs5z6iaJ6dhHJFFde1JbJeQArssSBJtJOwpFfOxf+?=
 =?us-ascii?Q?gFYBTmnsxUWWvs300+O1xgd21Y67/nMQPREZzU59nzSAA11gshiLjjt0Vqaq?=
 =?us-ascii?Q?6g4pkF8tftI3wutbgb4gAiD1ffbzvdgQCPeMoClcE95pJvFEJPDUx20W6NHb?=
 =?us-ascii?Q?KQgAEhQ1KH9FSd1yefIS8jAbrwpf4sDioQF7HaWiqcxspxU7ZZRTsULKx+wF?=
 =?us-ascii?Q?n1XTk8whEMFjX1PwTu+mF0e8zGnf+yv4mZmWRDw06o5WdVUVelHtTObZJKfr?=
 =?us-ascii?Q?JQTBfMe5+URMxL3yZtgg4b9ocp6tEyi7MFVuFlRo+QOvc5Zj7gfSGx3brSsT?=
 =?us-ascii?Q?zNEP55GzPiRILLRvXD/6RJEYZT0ygOo4pK17JRfwsb26u4K73znFpU1XYquG?=
 =?us-ascii?Q?jVMZnQvCGAS9GIh6+0Ijh8z2huyFVHKSuweTd0lDKDtD2qtSNpYCa4ibUG6T?=
 =?us-ascii?Q?vEltpsCycnVk+OAdmX5tu7D0WTuTEquT4rhVjHCUhgfTxwOIT3+DW/vxJCJ6?=
 =?us-ascii?Q?OPXiIeiFLfwboodTcWzWcT78iSqOEaYNYfQixJKmIa19xVMdj9k+80Q03Z6m?=
 =?us-ascii?Q?4OMbZExfhIu3PZECx/3noZZw/v3p4NwqS2FrSO34rUAAlovAKNKQZC1cWl0l?=
 =?us-ascii?Q?qWT4tn+KCw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1837e44f-522b-44bb-fb2a-08dedd624381
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:32:04.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WM8o2QnlG+4QKvBVf1f+oC0VXdJqq8GjHgMc6aoyso2XFJEXS/YYsnhTNnJlajvMUtreiS+pzJ+vA6bUXAy3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/intel/intel_bxt_pmic_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
index 6312c6ba081f..aeaefbbd5d8f 100644
--- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
@@ -245,10 +245,8 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 				NULL, pmic_thermal_irq_handler,
 				IRQF_ONESHOT, "pmic_thermal", pdev);
 
-		if (ret) {
-			dev_err(dev, "request irq(%d) failed: %d\n", virq, ret);
+		if (ret)
 			return ret;
-		}
 		pmic_irq_count++;
 	}
 
-- 
2.34.1

