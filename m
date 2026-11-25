Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795606315;
	b=PXuL9u5RQVPworcabMXj0fw4Ku0dDE6vLXWs9LypcTQa5Sbsh1wqc42FQdHK84TrrIPv
	 4wi0Fpi2816XEyHyeeMcU7SJ5gWgUN8r0UXzF8OyRdixmrxayyaBhPu7nWYYdUgBRjQMA
	 aqk1Zq0opsLJkP2cqjT+7aPspCsOATMCtof0WWhIIVFHibrAOu1/SJG+rb6BaQLoOQB5E
	 U5uzrIjICHuwtGvQ8pCho1kBXxHDdsnyTloMuBEmWrFASAmab0dI6ytbfGZpbpesuW7BC
	 fNamPRe/1+9b5I9h5+j5+7C169PC/ruNfi4A+i0kbcbDnf7nP4AQVYEJHX7CfS7FbNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606315;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Y0fnyL7wffLAVv1OHutGX6Ghlq9bs0rDM48l7sf9SQo=;
	b=OjB4e8s//RqrWc5B9suI34pPMC5Nbiec+ff3135pQqw6RyU63DEZ5g8SC0La2i19S2IK
	 vA3+KPzEH9vI0pCSxr21dgj8bvvF2fvKcd/7hFXYFqhwriu1rb2sdJww+OKwplDa+mYxT
	 qoGIykRy/RcDLP0cHfRcJElHo2hCWt83azZaTHCif8enXKE9NIpfyHCiDhKWz4DTg8Xiu
	 hSw3oOlzAWqwGewWcm73LhOeQC7omswojkLB02byvm7Kiygya5RE6gcg3EiHkWFwSIwoE
	 PjiTR6qoIYp0yB8E9e0AHuTIRU2W5hLRhrs+mBncSgAxX0GBsxoVNvQjw0ooErg/FEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VPGO6wta;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.71
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCE606A33B
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52DCE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VPGO6wta
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcxa3l6bbDSriSAxc0Tc0eQVTQzeHVvZIL7kpuTxKgM3r8/DRFaUa9IhpG6lIH0apPfGOyZ07aKrhA0ie/gHFvQ1ZivObQhuBd7K7ucSnP4sGYMsGBWqjp3wxO+Yf0q7yN9p2ED2cd9mrqB720vzPa9u0QmzHdvzGruV/KmxQagHlMbaXcxKSanZiSv7Bgpv8V+lSKIQaFD2cRlIMHRnNAskNRVdd5raM/q02Qkt9jt4WbYnqKaeQysb5Wv4jYGohl6X9+FHVWkUer6sCvE8wOepNYYmz1jTA66CL4H9c1QDya06FpEPBwpgQRVneWMMHoqZFv1j902otXv5r1QWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0fnyL7wffLAVv1OHutGX6Ghlq9bs0rDM48l7sf9SQo=;
 b=dc6mDRbEITWOpqaaqkcbm44llTo7uToyyAb6T8SVS6qHn2Kc0aaFH0y0/mjFQb6WD0xtCxCa4Ny3Xco78AkRUZSL9OrTzCCeZifopBHrp7axqgrRfqgmdRFd2TLhyRVLVquFYy7MEnJL2nZpIbSyqhqnocQ/onUS0wjStGnzUoZuzjyTsSo8Wzu4LnALGZ9g1JYePbaQl/AU9J3fy2iwiNDqTAm3p4KJDpu32gSEJ4iNX66zBlZGZ1TbwVCmNTUx/OLfFxYohrVJH8cbQKp0T5PiWdaILF44JZjinHzAwWcmLNGGp0LWkng1GFHY3o5Aduln5lumUdPK8m86sLDpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0fnyL7wffLAVv1OHutGX6Ghlq9bs0rDM48l7sf9SQo=;
 b=VPGO6wtaUj8oA4yil+N61u25ecIwvtMouZo8R4Xeas2TH+7Gdsv8JwWedNitXQT3c5TpBpzXXATNKB/5YHdek01S3QphQ9BHjn0jWQcJFzkSfMjWMG8RDljEx//QyOI8198rYCZr93VOzg6/M/50170nFfQ3hkHWnCJoyJ+Lr6x1K78G5/eWMBPFll2u+Qrv9lLuIOV4l53ONEhCEOG6DQ5kdj8vea39UFNc6zbOm77bZvlCRv8Z5DHDYlbRE0wyl9sXmoTmFGRgbMYE8jdYnGbyB4VhujNGOrubQDPOl2RbhjXngGC75HX8Vs7lceq/tFNlChSUYcRwEGYgpST+Ow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 11:31:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 11:31:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] pmdomain: imx8m-blk-ctrl: Remove the power notifier on probe failure
Date: Wed, 25 Nov 2026 19:28:50 +0800
Message-ID: <20261125112851.29323-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261122205136.138173-2-dario.binacchi@amarulasolutions.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7ed137-ad88-4bd3-f2e6-08df4ae7b23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|23010399003|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	NqnYhgt389fgLKoVserWg+nxs2XejNvJZdZm0qVJoZjU48VRWFahZl2NTa0L5hbN7OayK7Yj3GKkRC7rUvz+L6JXK88hI5f8dOGuPRGQjP0OCuiif4g7xvgrQrExH5G52k/wGgyj098Nf2pe/DLgWKhLjT7/mlkyvl2qA0m1g+medjGOR9hguPpDLMl45nV2Dj9Dq645uO91i4gLhKboFnLb/mJ0GhUCjtH1Bq1PObJove4iTrdKYghFK6PpaF2WNRtiJkljVCyrO/kxZ4kG8t/HFgUYHwbyzMR7zcx7cyIBalLrKhlQ4EYmXmT/HCqoIpR08/KKR/EDta841jJGFqX/2VaFwa8H9giUAmTZiWTTx0+ibD+I0fvLWDXH9t6yJqUQDwFbpys5qaHYimaTxHRlg8lltYXSbWXMy+pCq7IEk0jJMBLVLqmUkIJjDXgyLiMyK4mxVede6N22l3oFqe+tIeg97gw1oZnQjnH/duJjcz5sOlEWFj0poRTX4j0g38QbbGyF8AuxMlyYG5CP8IfZwxj8YOAvffMe1C+8swwudwQywuMhEWqeylNp06xRwQYZKcPr7kXD6dt9OmkuEdJjAQ49vZBCsCN+slh41upuyhvHOQswmaJppsjt6+XK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(23010399003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ocZ9n6dGX7T7BOyldh53qrsOFHTe4FrlZDBGWjha3XG0jVogr44ldj1/2VfC?=
 =?us-ascii?Q?Bu5DXcDCfq8P8Tb09T+9iphw9C3nIEiAFZU4DL70c9h2aKeVGtHLK/XfSX1j?=
 =?us-ascii?Q?AdlEbk2bqRUnZu8OSUIaYTKvqIeFJ8b6V8NhzyFytcgDrTWpzcB9zTKzVtPd?=
 =?us-ascii?Q?nfb7N2nz6L9x+h4D3/lI63UEs0DuIAHzb/UkxssDFG9dicayYfGtPR8GcsCJ?=
 =?us-ascii?Q?u6pQWeDVVXEU/ZD++Txv0dVLWCo/lgnSDRsvFl0nK053BhSEJ9P3DEEDgPLb?=
 =?us-ascii?Q?sF6ITqY9SmyMJV2nYSMBfX5kRpGyiZjNqJuVo9qlH2NsnPQcauVt0NHQeLEC?=
 =?us-ascii?Q?pteUG3ybBrV7GnQCbKpuZRG6FKpCnrhmO2j/WjFU8ptO6BinmfyOyVm2Z9lO?=
 =?us-ascii?Q?wsJX4CIPQuPL3zgrlgGLarswhnRAN6a+8Q27AQcVF4EtzcEebIRxAg5CutOv?=
 =?us-ascii?Q?loZym2D65cWw2N8aLPhan2hKmK8he1fxVErmAzW6MZLxR0ZNuhmoVxrQ83fM?=
 =?us-ascii?Q?Qk4mSBQpu0uwJnhQn2STK6Mz7Xprt2s66daXagB9cjilrm/UdDKSMsGkqqkt?=
 =?us-ascii?Q?JktTgc9ry8tf3O+cMAt3fgvvK6rWYxuAf3gXD791MgVrNW3LS6+XAugMSWab?=
 =?us-ascii?Q?AW2O+cqL7YswRQ5YSeHFje5ccMxu5gzS+cmNyXj4e0wZPAt0BFj0mUe5IKAt?=
 =?us-ascii?Q?JpMZ6z/5T7bLTG+iaYlnqKUKYYvybWnKhh+ICnUVNxo4VKUD/R9ADfZkJQ4U?=
 =?us-ascii?Q?lYfcSP0jTqZJ9j4Z+YbfCiG3ZkLaq0hRTXZM3nSP62nrnC+rcrqRXJc5TjyJ?=
 =?us-ascii?Q?9i6GA31OwZM/KX9ec4yiwCl+OvjLZ6XI/psuxZrjvTP90ObwoZuk0jXp6bP2?=
 =?us-ascii?Q?nWVFe7hiZdpeUuP5j2+gUvPq4LVpKKxsz0s5iJ6R2yLyN5Ol+cQY6LYKByV/?=
 =?us-ascii?Q?376YhJd6ImEsiFI7YjY6Y6r62TSQv6D2fF6FXjb5xpGbm1I+XbG0KkiIZ3ws?=
 =?us-ascii?Q?nFuopgoTZ2KeE/1eegFN4FBw72GG/CilJeLR8r5/pqjbGqy8XJ4P90GytBmi?=
 =?us-ascii?Q?ZvH80tV5b4l6Qjag24Qtl+xBBN24vDF6wbZdiEvJxbhRb5AsJ3kZSQXdv53S?=
 =?us-ascii?Q?YNJgIe0g3y5dT32mPfuK5llcOtqD+1KnfpwJpAwfSO2L3EmGvJQxTrGu5aAR?=
 =?us-ascii?Q?b0b83uVsa2XQoEiRr/Zf/RF723JlbLsemqY1xpbj2f6aCtK/kAluAZ/t0caX?=
 =?us-ascii?Q?vNVBE4+6kN0hvWQn04XTWaBxkfP/eBpOezg54o6rSi7EP7A2bNyVaph5d5uj?=
 =?us-ascii?Q?qwKLp1HNic5NibTeV7M7FSmj598A+uQZsxU3h3DX1cPB+n5fb4Q8Y8VBNpf+?=
 =?us-ascii?Q?zLCZ3oV2WqbtghPoGryVfo6gG1Vu3jHsHFiWFK3bbIm8p7oCWfGgWzA6YRpL?=
 =?us-ascii?Q?p92tBfePnfyScSbMh0px7gT8i/QkSD/TFufkPuMI8LDcwUU6sIUOKa1OWMPA?=
 =?us-ascii?Q?02ys+S2u0gjJ3sZQgitftcmg+Q+hNLiwpLVZmVzajKacr5f0dGmPATVr/Khq?=
 =?us-ascii?Q?UVreWCC1ctFTNdi29vM/1FpwySIx3mXonEXA1nGVJyGCi3Y7/0T2euCR6ISW?=
 =?us-ascii?Q?AZ24Be47n+kb9qg1k2rAPM9doswZp8fn5N+vCIS9Zcbj2sOCdYpQb5S9MiDY?=
 =?us-ascii?Q?QAwOC1W99EHL4C2jBEScnUd0oWylXnpLFB/mKOWUxFM0pEIHuXofEQX9B9uD?=
 =?us-ascii?Q?NhPYiAYCBweEkiQuCqfM6wmbb/h98cMpHzYkFE8VAH4hl/p0ycca?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7ed137-ad88-4bd3-f2e6-08df4ae7b23a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:31:50.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhG9GzUUFXf4/AHz1Is1ymtygqhA3QoGtI1TlPjLkQQR2hndVu81ytD4NNGs5oBF/q55mpoK42bRcGdMppq8doOrHLBCsKeSyoJCQuEkAIXAbSWeM3Vvn+Yg+FSbXXCA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

On Sun, 22 Nov 2026 21:51:10 +0100 Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> If devm_of_platform_populate() fails, the probe returns leaving the
> power notifier registered on the bus power domain, while the memory
> holding it is released. Remove it.
> 
> Fixes: 9cb6d1b39a8f ("soc: imx: imx8m-blk-ctrl: Scan subnodes and bind drivers to them")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-227073@kernel.org
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 

Reviewed-by: Peng Fan <peng.fan@nxp.com>
