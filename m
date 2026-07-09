Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119F3939B1;
	Thu,  9 Jul 2026 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568123; cv=fail; b=TLgOpz7S5FtYL+e1BrQDoLBr91q+KpygwSoo/Y/wBn1ljsgrZDGs7GvY0l5a/RIsHph0AcUzXgoyMNXcd2J+A39NgLU3prWd86GH18k3/RDsNZIV7MoiQ58BkPE83rB0Q4NFUD9rLvpkJShwyzw/82EPppXKD+mEu5y9OkzAehc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568123; c=relaxed/simple;
	bh=ZLI30Ur6LMnn48m7xzTTfGzIF+YWtVQ8jHT3NnifZ48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TBdPTXIAu7q4cLvxlkidJTFRl35BVXqgyCTYw3XHw+2INoSLF6fd4fb/VpXlciuLu8DvWtV9iV0DChQPGPi7lU5lSHlkS9XwXEfkjwFSsBPlzK+W2yX5uOyeW+0kwCV8rkk3BxcZ3LW5sCUoNscgxYWFieON5emR3eGHjucC3+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YY73k/Y3; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YY73k/Y3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxCXuCrS4WtJ/y7MsWhk+ElL58lI6rXhESxcYVcdBcRzujnXFsCTr7AFkUO8y4FWq2/L4lKRADM3CUl/xAudzUYNKbQvvUlroh8BKdXSse5AgAu+gALeIhFkawSP1LUtGWHge0PpCRquxYGneqJ0Ha+9/9hVkda+tWPm2Ci33zFPztiB5uczLDscZD/jVYugC8acBmva3Jq/emckYRbPZtb8wIYaRAAN/WNGkzc8Wh9dncKaXJWkWTS9SolIi4Kxvnhv3FeAwOoqWCX38JgRkBgcR2w9cD14fnq5vuKPKxABkP3QYAj1Mz3HmvP3LHvsRI3k2/xMnXiKa3uTj0Ci+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z29m8BoediWl7yZz0jFahf/N/btt0YEsgVbepvlBgMQ=;
 b=jP0BfoKjCtsfGJ6qHBH9D5mgsuQwNwDeI5f7I+04nR9VFpV7hLYkPQzQrcAsvB4H9nCnr9SeJ5WyAaz1gvmv601OeEruvNgMbQ90/EFpD0kvU7rUGqmZytNMVG9P4ey7/Pb1Zthl58UW5eew6eH3IPuzsY5Yijc9eL611+qR2Z4bzQDB5fvzUK6+mBvQRhfRuTuDBFSs9bQ0auy7DDNVRQ9hqhL5z1mVk3cKwJjKiCpsMo42uhD0I1PUCGCpyl6KQYY3ytHj9FuXjXsCjGuH4ARZDBORBCB6US+oxv1q2LBLF51sa7FfFBW2DJjyKO60yov+bqTW3nCCXMh7F0Zw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z29m8BoediWl7yZz0jFahf/N/btt0YEsgVbepvlBgMQ=;
 b=YY73k/Y36poiQMcFxjOIj1Le0vF9xUvB5xrgmjTSvaFcq6+Qt7fQQqfn/d9wJp3DRdc4xc8Zvtf89ARnyQPA1vUcdXVQLBQ0u45DpiZOoR62yH2ZJY4JeSfjsv4OrHRUn3xs0lqRqVFnrXMLDq3uQv0ReeGUaJPj0gb+FkAEgSmBdzmdKmu2Hy/nMK2+HxA1cfc2rwPhojh0TvHhsm9slWBEYMI5ZU8DZJ+a65ElPkFSMaxw7vPec5c+xxHJM8Qzi0IIQX2j3cBKFIbyvhHPyxKKYUttivY5VoVeVxwyJDRN/B08b+GQt4afMFijqbi8o/YZ/PBigzugvLHmR/Vwqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6360.apcprd06.prod.outlook.com (2603:1096:101:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:35:09 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:09 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 15/43] power: supply: bq256xx_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:54 +0800
Message-Id: <20260709033428.362970-16-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7cda20-562d-4011-aac7-08dedd6b13a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|11063799006|56012099006|18002099003|22082099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	mFm+yN1Ukj3KcHtL21cIkU8k6mJo2z+P4F64NVlwPwibDxkfLFCqUzibpj3CEjQ6Tefy3mCG9AcUX8mjYn2zDKtUbP6NzRLFzhMsUp5FhtP5QwgI2Gr2LD5DQ7HSRb7ZjbQ2PevSMpjHBun4yBh9bmA5aRZTvkV5MEe8mPu93mVhZ1vFEI/fgq6sxBaVjHvZkbOPpu5aO18p3d9R1jFFBm0gYCT3h3HlAvQCVtHap+a3X5y9dvcOf5Ph44qNYXA7ltR6hXavug4iAOANHjrauDM4ODqBAWG0gn9GX7ntL1wUyLSCxXL2LsIwRlpZ5R+Z11TvEgfFKpY1rHTDtkEoRezbXRS8Ybgbi5/+4FvgTFHyi8FD94F2Ri6WIdpnVkuKQ+wZU/RMEmO3fNVQfUAcWPfFG1QCaLa2W3Uqe7SSiFu0XZu2+6uOmBruzP6EYvRNj00gmX2+NNQo4gpD4K1TIfNILjQDOCQtvvmPzpoubb2B9ut5EVIsImSmXn9qomR+tzurPIcweecVjkMaqCtBAEUjazrXsknq+UoWPAiN4VSPSiHRyDtmypE7MEDK8sErlVAUudPcIxNcaVkdplQZXmu+t7ec81UcGEvMINSRQc4MafJtUrKggiLizZxhNpnIbCAu7ZoxrwQmjiGcVf/8SuBe/qHy5+sDTREgJVbIn2tqkLVvzFaTUDdxwVsXvdiFvdyrz4FxU4JXhXDHDCKPylYvXKcIasDIDMOPwmOBmF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGJQ9xxBgvFaWmYNLLycH9chCcO7OS3QBX43UwcgbPFPdgUY0VvP2W+6kil/?=
 =?us-ascii?Q?6CnDLINDd5jlWRem5FFLlluAqJKyAAne/eTXtEqUzLRz8zVWp9fI+nwdM6YQ?=
 =?us-ascii?Q?Et0MuiOt8kJ6hijLKToZ+QGRRx2wEXEnugVNvpSJNtCzhP6C9juwXeMU3bJA?=
 =?us-ascii?Q?+O3hs3gg4kzZe0z6TgNOKnYZu52rBkVwL2w5YflbWT90CLcBUA9NHb4z14hQ?=
 =?us-ascii?Q?iKfQk9miMeoJjLVKpUI6+1Bj/Iprbxm5+oxB31nbXRT68pHh24B0hvP40sZu?=
 =?us-ascii?Q?z1dtKMQShMcrrBpinhQ2DO3K1rrGKee74oOapINZLkwI79aVhmqp6qoi3akn?=
 =?us-ascii?Q?Drzf507X2Sx0MIlue+3rlWgzVzWrgszAWIaz9cZ9dzqSSGOOFztGa2e15CdV?=
 =?us-ascii?Q?DVtATyX8pqrXRr2vvGWgsAw2IjyBS5XhkzEO6Hk19zZGRKk3FhqvJPR5i4og?=
 =?us-ascii?Q?buPNr4ecYytZexG7TsCtsyvEMP2XBYPrdCtJhocZjOQZx3YCSpEuaD7f+7aJ?=
 =?us-ascii?Q?sTZfGS+XlWmNNUf5zvAHSC2c+T7Ixkq1z5Pjfa04bWj1Gg3sBha1aCdHodu6?=
 =?us-ascii?Q?YrQFwPSzRzbxHsFhwhPQASIRW77fkEDkEGqv8BvjasEiNzR9FEHrYyWNrqgH?=
 =?us-ascii?Q?aHG7yEDkQx25JqXx/pbD3MLOM4HQBYMIc0MI6URanH/BT5CmhHxeYPZeo/aa?=
 =?us-ascii?Q?XE1eGpcdM+QVgkP63t94SR6VjG0ozCx9ptTFojDu0eVo+2fwpJjIUtLY0eFM?=
 =?us-ascii?Q?4g8ELWsiDkuDf0hh1udwIWtQJ5oA3B+90dxgDZ7WlyDy3faPnOOteV6u3L8O?=
 =?us-ascii?Q?lNz4zHuB7pbRHb0xjDXDeRZv3W9RMlCU1uQuzGs0etxAGEFm4AxxKUWBlUNS?=
 =?us-ascii?Q?OMfsSmSOAIuKpQUWvrtV9GekIOKPRnebBdkK2UsW+tPkzvhfMMjw9+XiQINp?=
 =?us-ascii?Q?CfZgZm/iqZg/wPvpBHBR2/+S5a0OPK+TltZd8OWbkBPqMLmbXIePk0F/sHrV?=
 =?us-ascii?Q?Z+XD3XBd5GLO5jtsEMRVNgeJcEpAS0PRpm/ogwvSvzNMZbgyiZCXkE76LI8K?=
 =?us-ascii?Q?pOIhHlnIo+eGaEP9/YRUwx1W0VKsVijCkK5pVwCcmTstXrPGtLu79J5VYj9A?=
 =?us-ascii?Q?saIkiKxQ7zqAFQjdKuA/P0uAU7ulTwV8Vm0jsIPGOuRW3LJkXTihWZSKUbrF?=
 =?us-ascii?Q?TmOODWXCT31bynQv2cmYp3VMCL0K3uYVviwCVIkYHgAAMz7M8HPzwZAtYA3r?=
 =?us-ascii?Q?i0CSpvr7557YZjIqDF3V7+J49ivZ9y4GUiTzhCMkxeU0W76H8p2Joc8bUwjU?=
 =?us-ascii?Q?JIU+1x2mjkdob/yqf9ZwSua7ifQMVmyX3qtn0E+HVuDN4HbIrPjOWw+FbFJu?=
 =?us-ascii?Q?+rXMOyrchHzfmheKVnnRxucY/wVCloLHgxnt8xy9dBQ1Q/zML0wIgs8ZncsB?=
 =?us-ascii?Q?FXUJtc5LlIGQZzQzFg+E8U3z3EAPsKb1ujtlZKf3ad4cRkuKrqo9fUVeCxlU?=
 =?us-ascii?Q?snu5Bv/RHWpuX+wRADUFEG6C7ye+cSoEs0QiJg4u2ujJlBuEZ53HAlDmG+R1?=
 =?us-ascii?Q?ksnRuuhmlShvhgiN48MU3wVmk44FfFqdINR5+DHpsFigYXcHHkuFAPI6TEXn?=
 =?us-ascii?Q?XHkiDuMDbvqHFSiozDkCiW0icBzpiGkzOT4wf6C0Clucp91hpcMvxTPKUqDS?=
 =?us-ascii?Q?I6ODreSF1eIHv5pKC89iPBpvY0nflacEeDziXcQhJlnDnEzxMSaE+UGo2DaO?=
 =?us-ascii?Q?4fLcW57Y3g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7cda20-562d-4011-aac7-08dedd6b13a5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:09.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OWi3YvNYuLWlwuxCFI7th+XGH11sb1gp2Mpo9vYn9hwsG8tJ7MDNFUR6OB6nd+iypPyI53vkt0uah5S/v/jWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6360

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/bq256xx_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 5a6634fde837..4ea89b7897c8 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1752,10 +1752,8 @@ static int bq256xx_probe(struct i2c_client *client)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						dev_name(&client->dev), bq);
-		if (ret < 0) {
-			dev_err(dev, "get irq fail: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	ret = bq256xx_hw_init(bq);
-- 
2.34.1

