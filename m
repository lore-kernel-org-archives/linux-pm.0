Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D944C645;
	Tue, 21 Jul 2026 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628582; cv=fail; b=M08vXYPDF07lic+0wmdL0kXuooavFUSIosx0l0FKOYJRJDp+zVAXLeZ5jgH2V34buVnOzhAdaqVoowZCALBd0WWMzY6WN4AREbeTUrRYS2Xss9HluwZBrRwe+da8aCy4Oe/iCz1eRUNGDoQuVF3fqGgKDvHyrEMuRpiaH/P+ESk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628582; c=relaxed/simple;
	bh=rQlh20/0ve3ZaZ+GFo8ShOzz7pRjRA29gfIR3KvlQMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=th5nFYm09m8IlNdyWxEq9e5Wbl/ZToVKz5tARX7P73jV4u4+2wr9ZWLzvtCms9PcmyPPKHpsp0W3jd3TMmsDHiH1ZOxtN8pXcWkKL9QVFKzm3o8IyrdGTUIsgaMIeSj6UmFSR11jPH0OYIgZbEVf3Ce8pWg92MA01xaLuMN0atM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=flQd0nxV; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="flQd0nxV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1ClXMPme8vY9X6dip1En8tDYZPX3BwJxD0Gk2g/pXnH1rz3UW5d1raXbo5z0tVnOl0j+UxNuLvawbz/eVntLCrtNQAExomUDDgDOil/kQV7D4eBPPfK/QJH5lauTy8Lcr9UGnhrdPgeSUgQi351KWk6y8LdfStsqzhloInuKKYGZ1Rdvo/UqredEMSQbFbSmWcMVETE9XZeaNBctRef4nydb7Uy7t7dmOKTGmVj72yE8S765kTdM015Sx2FFtfFu/HAKFWmdxpIC+SVqhcg7mx8qpm45+UDosZUrSLUKusdVvbMIxfKOFUI5Sz3k5+KT/5GZfpTUV5BMNGav97ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/rmX5SaleVT22SXUaqzcso9b/SnJrXyC+pjCMv+/l0=;
 b=Sj541lUIm5xglY+hUY8LAqjKSBR8xk/7PRx05Gi0x3fl9o9Rg/TaOhRagC8Zail+MY+PTlW37pHUYyRKX+G+1dmf82b6LGyGWQph6lVXRdG95r1VHBs9hlWBvIp34JNQKekDHDaxG9tnq5fr94QUgLdB+qbKCHdkArJkhDXC5b9zk8msQ4zlhffKDILFyVR+KmxciB2ToAWGkpBTnivmv52NNliFcB5UJrzNDqSi2YJeRbdMttFHPM5E4ChupPMsLBcxvQ7hYo8aH5UpVlSljXcWO4xALOmoRZ4vkqAyGi2jaafENNPAo2lb2a1V2MMvlSWYOBfIai5SykCEiMVQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/rmX5SaleVT22SXUaqzcso9b/SnJrXyC+pjCMv+/l0=;
 b=flQd0nxVl1gmIzbzLnHsJ2If3oI14CsRtA7XQJFWGilwmz02fNG6ID/dFlczf8oJwItW38k/MSqPx6RJ5trCXW7mxXOFHxOVcb+GmZBbiFlcW1IpjGhjlQU5u5eHjxa2Khen8gpM4ny5SGhQ1/UXewuHSdpKC49PjeJiiJ1YUvWqrMyCrRLknnClzRyzYtvceeP6GvR0QcdFpI/sBgToA3lqUKcROQA2S3lxOyEK8qXLMpBvu22Yr+X+YMfoTvaNZb5b19knh3IwKOTkg/si4mM0lDK6RmjXE36EXw8EgbVRN4wt0Az6CO3zA3CTzNVXMe1z2k237bPYGbjyf+FGaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by VE1PR04MB7278.eurprd04.prod.outlook.com (2603:10a6:800:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:09:38 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0223.015; Tue, 21 Jul 2026
 10:09:37 +0000
From: Zhipeng.wang_1@oss.nxp.com
To: robh@kernel.org,
	saravanak@kernel.org,
	ulfh@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	jindong.yue@nxp.com,
	xuegang.liu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] of: export of_stdout symbol
Date: Tue, 21 Jul 2026 19:09:16 +0900
Message-Id: <20260721100917.230923-2-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721100917.230923-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260721100917.230923-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|VE1PR04MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f1094f-da8c-4b0f-5dd1-08dee7102b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nNxxLLaPvjU2ijOtOx0ucdAMGKsTbS33bBwIl9jN1u3zKCuhtOjyQ6cHcZ39hqsz7x5MHxn1yqMiNC2roI/RIT9KGGtLl3sBP3wa4va28J5TBKx+e125IqCm8qMHSmO7ZOF16eGCOjZIsJC56oxTSUiJVL7HcAH6e4kNJpx7Q1hWgo1EKrPpnGUfxXROB3Ka5KyAwGp5+g0PLIIb1PPwU56Vl0fDzvMN+cRGbEal7sxjAb70XhMzbvVFAo39MyfWEtqOgoSQ5uk5SmpM2ivDgsGIzv1U52Hz5PjgMTxiui+8jrqahoQWqEUkuiApVyJRuAnYxuwNrVuO3foEuGexg35+xwu6Gpbz9Iu5CKn3TQ2wSZIJzjUD/yIkfAg4CJyJaxVv2jxXK8vnlFE8Ej1a4R1ZfzahwoVc0GsHbfLyxI07TZtfKUfpYp7f1aYuNgZNPNKlQFCAzsKWrSPgI8E8iiwQh4Guk2504VjX1fMv4fftkmihO+keMN3vhtyykipJ2fEZ92mEMtD24g7Hw2cLEZhNkPciYP5MR87yZBNqGGHjWOX48BlmIJ2/KnX3aP5dhwOixYxjQ9Q7kkgxVLps7v1+k9+w9iA2KPloLmM6mOmpodYaO3IpY6Hg5mw3Hcb62AtwRx6TtXecVRCI3sW97mUBf5iOGDSwXOo7OOR0wc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9GmXabeZjCgoNvxRfTRpQK6CtFoXUC/4LfyyrM/Xjn09KLu7zyltqRQEQMwz?=
 =?us-ascii?Q?228VxlQ2zmiQ7hF1/WCMH6sxvzZhNq64QqluuszU1OZNFp6EwKei81juT3as?=
 =?us-ascii?Q?+HSTSvaqkgC7z4ApdfTLNALEoO5Kg2vVop0TuCshfEXdJF8JiahFseV/Kq/0?=
 =?us-ascii?Q?WInusFkOjL70acxKT7MJD5XrQ5N9HaNfOKcCTDce7XO3YipJSgbjSny1YGsh?=
 =?us-ascii?Q?Pgj5DF+D9xXo8m1q4bQiZcK3Oxdt6K+eBXuAkrdTG0gP6YHyTfj6XMh6ul5U?=
 =?us-ascii?Q?T2+lLvBA1V8k9GlZAbaps+BSyb5LJLNzmpNe4KwXspOK4XXL9nHg4/P7+ehC?=
 =?us-ascii?Q?TP15MU/5zCfSFXKoBQwNn9pU7IChGPyt0kIRKFtFOYGcZeKMZG5b0ZkgrnL7?=
 =?us-ascii?Q?X2UfoponscNRkOzMl1pwVF9sLUnYTwWle/JzknyTdqNl0rsU0AtmSAZBd/CE?=
 =?us-ascii?Q?yJ4nVF0nxu2K3X2ihCl8j82IhHtjI7WOBtKtFBW9et7xAB9Qt9rMfTksSU/P?=
 =?us-ascii?Q?aXhHq137yiszH6kvExNsuJeznh2Yg43DXTzyBoEYzsDZDJmRNeg+xd2syBm9?=
 =?us-ascii?Q?7wAFSJTdUXP6fyNOlIYSpSWW4XzpwBGkuaKZqD0CCsCbpolYG6M39pIEIAul?=
 =?us-ascii?Q?SeDqnpg+FUQ4LjRlXE8rYQrOLJkOO8TJeblWz5ctsgzSGYvk5dXDSRJ/d+pQ?=
 =?us-ascii?Q?aKH4uDwXMr45YUZWckFTLQF7wdQ7Nl2hF2srZvzVKZXfBlWKYOzIivGXGJsB?=
 =?us-ascii?Q?ouT46rJdCwDyiyeCLZPMev27B0e/58yudPAXvCpdC0H0B7mY5ihhx7JtDmHZ?=
 =?us-ascii?Q?zWTSJHo8oofH6v4gAUTBSs5iJ2curIFIfYb4a1reGLb9K/YQvrS6rcgDp6rA?=
 =?us-ascii?Q?dh/I0j3Bw8sgzcYYbIJfTo+e2DFYIBffLUaLszDssFa2Kg81aWME2biofY9N?=
 =?us-ascii?Q?rUOJ2rOqwGFjf0sRWcCQyRXlHg+bhnUrObFUmMDp5UkkZxl2lKgIGgzSgi1a?=
 =?us-ascii?Q?Aq3jrnrups+tiT6RBbwV0ukRe7IEc2l59rCTOm/Ss9X7UjbMMNcE14dgVAAb?=
 =?us-ascii?Q?5NpNTrRA+yKqRI4V/dLs10sfSg/RLLDlCT3tJUmmCLLhDkc29WPR0Pzl52QP?=
 =?us-ascii?Q?LtdLFEc0Ku0CrmVuQxtptTVLUSDbDwrPWSCOmKNwp2FQoD58p9sahRRY1YEq?=
 =?us-ascii?Q?elb7ZkvUimuo6OvvNt0lySBOnoOy1BRKLoWdToh+GVMNYGSHaYIGWyC/hUer?=
 =?us-ascii?Q?7MzfsTo/OiplokuBv9v/CrLGzJSWsXGKUMygstFc5tJVpzh8eM48kRpWu7j8?=
 =?us-ascii?Q?VCujnXQMASjUlJFFmvI9MMaM7VjWcYLk2GMSsSmqfc8enEUrBYaUm9WHLFTp?=
 =?us-ascii?Q?8f9PLFHC03NWapb2IAMQYip6N1I9pXzmBOHgJpy9vT23wXz2UpJPTEvqZ4bc?=
 =?us-ascii?Q?3AGzeJ5ZM8Ygab94cl0c2vB+zloD2bRhR68+mFfQRZTSAFvOiJlrJGQsD2H1?=
 =?us-ascii?Q?kzbQP3o2p3Q2OaFWPpM11TB8BG62AJlbwc8te5yyU2zb5MIT4BY3krAP3RVi?=
 =?us-ascii?Q?IJ1jCbLA2Pd4GidQsb6PmbueILKtnzPa2xVXa9K2r7SutZyXTzV53ikzGf7y?=
 =?us-ascii?Q?ZFtgTq9fc48r8AWQ050cX4k8ISwDRGoqQOsjgToyWHvqxi3Aq5nFuODm+qNq?=
 =?us-ascii?Q?hC3+Yiic2V0Jtlo8xaxieWECZ/8jsfRJTiPrNhqyMl2x/bjLWJTFzM0cWz32?=
 =?us-ascii?Q?0YW7q/C6sTK+Qh/4OQifxnCxxq6ieRGYXCp/YEILl0dUgJYeD+Ad?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f1094f-da8c-4b0f-5dd1-08dee7102b71
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:09:37.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzG2g4lIN/+QYEIx/8fMcin2G2TZw5zgH8tpx3HQywbe+h5HAjOtKWq2rfTsRFlbR/QCXHh6PlP7wLPxFCeRfAUpytauoGGtPt837qVyNoxEMRI9dnwgKIylW2klaEFY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7278

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

of_stdout is declared extern in include/linux/of.h alongside of_root
and of_chosen, but unlike those two it is not exported, preventing
modules from referencing it.

Export it with EXPORT_SYMBOL_GPL() so drivers that need the stdout
device node can be built as modules.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6e7a42dedad3..a25c95800719 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -39,6 +39,7 @@ struct device_node *of_chosen;
 EXPORT_SYMBOL(of_chosen);
 struct device_node *of_aliases;
 struct device_node *of_stdout;
+EXPORT_SYMBOL_GPL(of_stdout);
 static const char *of_stdout_options;
 
 struct kset *of_kset;
-- 
2.34.1

