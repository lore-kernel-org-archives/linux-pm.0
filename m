Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBD364E84;
	Thu,  9 Jul 2026 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564320; cv=fail; b=hRjjAy8uHGBxQHvhRChH5HdLJ99v4f+N1KSoZwf/O189Yw1r+apR5nq8J+hCQ/WRBAJYT2GZGRuScxV6XKUyokpEdrQ7JIGoojW4t7g34uAgfatY91/zlJUGdNSiTqxRxaozULUbrb+ZIfROxQaldfIz9uCAU2meLn1+Ce9cv4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564320; c=relaxed/simple;
	bh=KHc+PMLVWedoVGDSS8n4UN2vRb4sCK/rytBhKXakNJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hfc1UCNKaoC59C7HWCVCsZUs/AfLMv5qpwW1hg8Pfl0M7ML45SPJtuKlZWcSLQ4ocApspx1oJpVdJ+Rz8Dec013AHEiPi9szSzq6oHFHA4WX1xhj1UU/83rsjte1CLzzXmr7iVQj2Yl4NO3WCnXuqKzrzhVf3FNMakLW+Da5VBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=j+6leIPl; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="j+6leIPl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXoDh+alPjZDWHCl6HO412RBTedKzAKCnYgUfBFKtLgChYmwUgf8kqyJxeBpYyOR1xOc/t1mkR3WHGppkwFrvFxHjDllauJpjLYmGKkv2iQkTloLo5DiebjjeNX6Ga139MGXeqco9tC0iPfDunr7g2sZ0YCbc2NAPyXGR/KFoTZyKKgiLu17xiYEOfsq13i0n/vvac3U0zUzMa/bOwdkCoaEMiIw7UGTnlj1ZeTyS6QhZXl9vgz8XeZ3oKAT4x+QCdOCIBnPGOe6tK55kO+G6ij3JzqhrEyb3LuFvi3BULMQZ2Xg2ivyfS7Sb126tym9wgPtxZs0w95t4OadUlNKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zTfbpWQpf7c4mvcWyoEqT6FCo6V1fAHakTN839tUP8=;
 b=c3nD6eyMQ8eSbuFVZ2l3rFKrP0gyNOc18AhCE9DSrob6bKmwNybxoJ44Vq6BHpYlRQafM2UOX7YjXS7qdNpW4DhSgoouMKEP5zXWXlKVrX+fPqynLjhIQ8y+UFslEQFSXdOssZqd1hvPYz87HBxLyA3MaEQJmPN04jjxeYGyxKxeTG43zoDbzQp4GoWYb6JE+51cBGWE4+otaz9T5cd3XV8xfHTriGJaxEpO//USgaaP2nd3cSJLf4uaTQ/UFN4GjeFqCxxa8F8a0dpKdIYqATa707Z8+sKYCUK4ym/YxLaKwxHneY8psPK3iCkBmydnFsyNbW2X31FKcgjqfRU6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zTfbpWQpf7c4mvcWyoEqT6FCo6V1fAHakTN839tUP8=;
 b=j+6leIPlYkTGeUhSBz0W36tbcC2BF89X4C7KNAaqolApDUXikOIH3Af7CLsnzwd3aqwP2gdCJ6NZAhWki5m8f81T41ETXLPabpSP6v0WVSNccWQXOJAcB9IUcd4hAuHXqvXzk8zLkrMgwgj1LIOj4ra/Jb184/fB5N8ZMQ7cEZjJ27/4Eae/Y+Y/zU5p0yACYhKeu5rw0SlN1i7lrua6KkL2RlzfCEwhps7UXXf73YTJ1G1WSKDA0Y4qcxp9heEaK605YXhANn+2gdR4ZMukKsCAQYIZgcULGhWOuekp3Qjg8se5VU+yyqztMWURb9Dy13JyLbj8gV7JgyUIz97tMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:54 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:53 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 09/18] thermal/drivers/brcmstb_thermal: Remove redundant dev_err_probe()
Date: Thu,  9 Jul 2026 10:30:12 +0800
Message-Id: <20260709023048.599150-10-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c45bcdc5-31ce-42fc-6db9-08dedd623cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|7416014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	bhxC8gA+ZD58bXTIIjPtOYV1ZMhePvRLJ1gCIFv+zWv8w4b8XVYH94joY+ED/SMNw3XFm8JSB6UfPJtNgu5tYAGp9szfD0gcztXz9PLoEdgSBGKBMJqPoivMMfkwfBGDpgRTwkDcU18lSc30RrbMAMG88QBMCAS7k7DA84v37g672HPyTgfu6YROkwsp3HgWRqLwxryGLyPSPZcWf37rnq9QQoZw+b55aNnF7wplpuj/KJEjyTd1mpjAVw/NyIybNeSMAYaUieBIQjaiMgJsTc+MoK3yXj9ES3Y5uBzhstSfiBzZfPEDSuqfZt0guQnSXmXS+oOg7ukdyB5q15xLYDhNRtUOJkWDu4cJ/tNvpZcuUnh9h4KECN+uElVkYp+LyfpztkYLL7Ge0/PMUqkPHxgh1GPkP+DjcHaGnx85OSHhRtowr2q9nngH9RYMJ+8ZtG53VPXU20ZDlQbzeF3rwaMKCP51wPrLqAs1Zum2Ml3j0tSfQ2swCg6ydFocrvpElB20Jf5idbAB6sOlKTOb1AuhDheo/jPeMdrEgTZgt9DfXSErC7sQHOt7AgApafy9TqouxaAquJjRbc73+ZZEhtH+0AiHnBVMrFdCTGtO4a4HWm+TJZf7BZYQWTZDHw7JkWAGSNY66wXjaWabe3w8IWq770M1vzNDr2Xa8B2KKJY3LCr+SGAwvxRrEe2WzWlgnAHYnDfqnd8cjDFLFmb0WxPs1ctSeZ8lY6yC+C8i5os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+lnwdAJZdc0meRFEg6BVEDS3+nDT1Zpn84SCIRjV9pHRRF7mmO11clAqrtf?=
 =?us-ascii?Q?FAL3pPLSDKdIlKEjzTea7+eQ9cG0lKnFpL6jD5Xy6ldVo56Q6Jhf0ZAyK2aS?=
 =?us-ascii?Q?ZEjCSyO+q3geZWlwlMxfvQZ7JTUpSxmCszbgMGMDxgXb+w7IOem/kR8UBVp5?=
 =?us-ascii?Q?PX3GXRu8eTmtW0HVb92WbyFgl1+ioQoSH+EaihPWFMNobbxcxiqCLwp1OSUI?=
 =?us-ascii?Q?9sP4mwjfbRPBMzuLADC4r4qDMH8M5DAeTzZuGkUmKogTngFOgT6THqozoxNW?=
 =?us-ascii?Q?5+DkxK8Ce2pnq/3edBAVXU4GZ4f3sMWzHJ3JrBWkNLSNrE1248dhXJfiVNDJ?=
 =?us-ascii?Q?I19d98AK3sRVJapQDUvvsBlYd1Tm5qjmUIcCdPNVynvbxPBymGDl0UkDk0iI?=
 =?us-ascii?Q?onre45dLsq/0YiMkGYncdBy9Aixcrp5/4E8qeCWjEOsUT6TN4MHRFYGyHuRi?=
 =?us-ascii?Q?Qf3bhd07TMG1KTnYBCblpLgFXjyzhsQ1agRCTjW7xM1QdbNcv+uRV4+MtUbC?=
 =?us-ascii?Q?u1bO4JphSgmJ5fk3MYrxaEFIzyuPy8n0/PH2UsO7r3xXXJP2ANy0Gk780Vet?=
 =?us-ascii?Q?902VsjtbVwcA0wY2XGq1vT0jQNu5wMxwPsUogUDfGazSz1ie6QOReL8hdGEE?=
 =?us-ascii?Q?JjfX99P4vF1Q3Hh56eB/16oYSnD7LO0//lqa+rxQ1jD2GIUGMLyLImxVm2DB?=
 =?us-ascii?Q?RzZAPjZpZ4axkg+Ne5W/Bq5+47JNvtOycrePbKcrXZLtulIVrVDRG93Qntdb?=
 =?us-ascii?Q?mgSYCiPf0CWL2Oe5NmY2458wfU2ftvpEGv0tYExsP+kAmJvCD6pS1SQ2B6fX?=
 =?us-ascii?Q?OoipfOtGOt1zAJr6bsTecIkfW6oIj18lzChVuUgMk269whaaAxCNQ2fW/hAE?=
 =?us-ascii?Q?F652QRDaMBql+xqi73LYK+JHR/d8uiHuDA46LvqtRr5wcgbq8XT0s7Sv3gm+?=
 =?us-ascii?Q?v2dwaxOR8lNCizTXHkK8mwIm1B62kfSNrzZ7fUdXB/VrmlQpz52vmchAPOLh?=
 =?us-ascii?Q?88iF4il5N67WC+k5gugXneFxfBhiFKsN/UVWMN+/o8KiMrkbdLCUiPaobACV?=
 =?us-ascii?Q?bNOEc3na181Tv6mAjszzeYKxcv7UkrxoqQQYpIHZOecMbrgpTxbfRl8fx7im?=
 =?us-ascii?Q?VAFkSWtsyiLhg8m6Y4vV7A875Ug5FsecVaijcIJP4p87VV352jwgcW0u2gPb?=
 =?us-ascii?Q?FQw5thM/PL6JTSorY/0pcs/QMAy+0clmDxhC8Z39XuWeT5LXlIW8JGY38Xlx?=
 =?us-ascii?Q?4H/CLXHVI1gexNc3Gy+7BPWUG0IQGTcstf4r7goUbesR/KCieaU05bzsIlL5?=
 =?us-ascii?Q?E/wPPpUHoRd0XUaRWDf+21ZgmjL0hlb7zeQJMSTc/9biGUOs54bMjgudQ70s?=
 =?us-ascii?Q?fb4u0yp/QNJbkOMeRr6tkWHRwFYwxxl4QYRefrDpGm0r0FX/iFrF5v8mFPh6?=
 =?us-ascii?Q?P9npbmPhYmFcIfnx91iRQL378gqRoE/XZB3WvZOg4xvcvXUhKJQDbJ2ShJ8T?=
 =?us-ascii?Q?5I9pLuB1bDG73XUZR2db/rqvKON7C/X+m5vt+FBNbxiA02SKG++oa1B60emU?=
 =?us-ascii?Q?gkrTxo4R7lee44WzcsGxUj3HPtg/wK3vzj42d57qf0wqJmpYLEVmSa8TDs1F?=
 =?us-ascii?Q?b+yHmk8Rbr0LLUPj58TnGWeYMteWoL42OHMb5RVxd7Dtcm/OYAjnPUYtqZ2Q?=
 =?us-ascii?Q?Aun62ql7Slq2qisDG4XtAXSmIXzb0MOh+LX/s9yKa2t6Alkjm7kBPeohc0MM?=
 =?us-ascii?Q?c2sTcyWr+A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45bcdc5-31ce-42fc-6db9-08dedd623cae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:52.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cagsRVJbuyJ6KmCbzIXVJu7RRGNt7LvxPpOPxqhohgoQgRciEutUaPDGsMFYXB7oyjqsy55uCdJ7+3wouYLZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index a9ffa596f7c0..5e23f9e00847 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -356,8 +356,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 						IRQF_ONESHOT,
 						DRV_NAME, priv);
 		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-						"could not request IRQ\n");
+			return ret;
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
-- 
2.34.1

