Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795057064;
	b=ggQGHoB8PaBzyaVPhQjxp0JzUElWcNu4mZRlP9z4Sd7IeOH05dAHWja4Z7hYPozn2XCr
	 /jgjDhGXJ7HZ9xjNwb4OFjMcf0PwKWgitcaZ0YeF+hueySGUCJI8tBtI3GoZ0IzoLyhxn
	 zWgvpbXzURjswRsm3z5LTgchMcFy2GqjnTOhrGt9zc21OT90X8zUpfJRpCzLWUGR8NUQE
	 QBcIfo/PFGpePAtts8hBaAK/Md83Eg9lCQi4EV6vcXTpLjq0rdfRyy1fCPpxwjiLeSQv/
	 8fLkmav9tkrfzQsmWZYJ4MXUXdoQCH4aen87Ig5c/JVXpMe64etkMcnM9QFAcxNo8MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057064;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=VTw/13oYuLOJUeL3tzDZYQixvUsZprFaay6RceG7kmM=;
	b=jhBZ7V8/0L2zLqRa+p+Sj+3aRSTr83kEugXVG/WgH0ABvSX5wBYtzNGlq4ScaLeJTnl4
	 UCNVwX8SX77OLXFSlXhOHd1NwGd7GhUrw2CAWsqwWFe+TnnqGLszfvzcpP1lrTOl3KvjN
	 hl9UvVA7TeheiYK+FZ8jszYwja69gJRlaKhdNT/uM+MADTXcRh37Xly53bnPr/vCI/4Nw
	 7tMa5VKYHXeAg+tWdbWaYfC+M1l2Tx0Nfc/SNMV2IE61IOGhNpAZnD2DEpupz/B7AwkoW
	 JDgKbQyEUFsVld6qTOQJtDCRTRaw0v+Do1qGK/Bsyem4l7/qiPqNBZdVE97SRhbLOeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=b7n4f33V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.25
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE660A2604;
	Thu, 19 Nov 2026 02:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03FE660A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=b7n4f33V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+PeOuckT4U5qYtLFxpCpy+UuFmQSfY3Oiiy7rSaT428dzS0hhZLchhZ5kUdU9FJYpTBwDosgzejjQs6J9W5R6JIdfgvPXTBulCyMAzCU3RZ6Yq739QNy/HtSJypn35rA4OO+WNfykJZBUgzKJktRHnh84KKMacMzkyA4ETNfsYuUh1OmTo1g5AgJXtqQewSO14VUN8IMSNxH7rZgfq2UNFS9BUK+nVjCSIHWAR+Jpwd+TOIioL1XnD25cY5XguMaHaXK9x8/v9bbK6Ax9jXyXqarlepcZ9HQYdOxdXM3jMYWIvniPsvz4MWCaygSIPja/go6Y6enjxxEm4olWY3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTw/13oYuLOJUeL3tzDZYQixvUsZprFaay6RceG7kmM=;
 b=szlP4cV6thxiCD4ATqcw0IbMTa6r4CZP/Zh64OrrJsPcgvpqb2Wbj66hPNuJ5Wy0/bFqCEP1YoKc3Qxlgd20TnCtkkJJ/zzB5wSWtkZPp28Jc/Diej3ZGCFS7b1+j15juKthK0YE0mo++GIo4rDMeBKy9bEaH1oDaQb928uZ63ZYEXRrRGR4ytEF7zZinHSvSE1ClTZcCNnbNbsBZbkzZM10bubzf+wa5YLhcr2efAtgPq4fbBHlsqw79EwZLiXvFHwgOlqEEDKMa39ee5QbCi4DKNftyI+K+vhPYDRVpkFqsdCpshSy4D/h9BdXQH8HdkxtMqs4+m1Qzo1bR35Ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTw/13oYuLOJUeL3tzDZYQixvUsZprFaay6RceG7kmM=;
 b=b7n4f33VaN9uLLTj+ATJhHmcDP8s/4ALDqF1vnQUHFRqGU5DlzXaZXyEl0SPMjdfAf1+e2u9uNsXCgXKuVX3Lqby5N99EeXSwM8p85ppSeebxl3x1sbvQv3177AuyFa/zQU4xmdlqvPvoFvoT6HUGMCJb9+JOtakRHhN5bmRgYhpeuz2l7ALSAIw446o4g4V8l3EnfA9F1dBCqZCf8aMDyrWdaCuKFowBXQgDBSh9GE7zm5yH/6XsizVWXHGRh4Ru4kGTFVGMSYXe57XqmyGrHq1T9qJquC1drZfIeKlu638tE/Hear7J4vlzUlsstZ56aQSvEBOUC/1N5pHfmuEMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 02:57:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 02:57:41 +0000
Date: Wed, 18 Nov 2026 20:57:32 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ste_dma40: Use power domain for LCLA SRAM
Message-ID: <av5kXd5Kp0e24FER@SMW015318>
References: <20261115-ux500-dma40-powerdomain-v1-1-da8b6e1a0376@kernel.org>
 <av4CJkri6LQO9FxG@SMW015318>
 <CAD++jL=ZFJFTV6zY=SA+aHMQyjw4MQ8zFgWmUUBEoH6vKDLTsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=ZFJFTV6zY=SA+aHMQyjw4MQ8zFgWmUUBEoH6vKDLTsA@mail.gmail.com>
X-ClientProxiedBy: PH7P221CA0054.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::34) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: c4051709-c773-4609-2650-08df45e8e059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|366016|376014|10067099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261021135927099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y/iUblPex/4gDcfpjwDRiogSOWAHkNrNcZUPuA9P8hdtKUIM2Qcf17RpwzkXR6gD2u4LDOSobkysy9BpVeS0yk5/KT2s7ONv+8HDyM2yj4bCVFdFMLBfe3rp5r6egA1i0NTXryeiPWFAP2+NuiLrz790uLeQd8K5LU5CHzrrODvAOLI5wQpE0Fca/zNaH98bBlYrskhVKcFCECVkl51rW2exrANqEaXv3Pe0R5fDpTxhKkpX3CDFqFdPMUyeCjRDdgs3+E0H5jZ1wZxEjxTXma0xbO/4PDlrK4tZDn5kzTEzWQfn5Zbqp2EDk91LwLKMQBby5Oonmbb3ADkzaQJAbO7sEVcgW6DF+GtZ4tuHSX7xB1dhdnJEpypzwJEDXCQexOu8Wcti4to1LSjwOWvxeizz/pQUjYgkgbrQYHw7EQdI4B8Dz8k21MfR72js8O12hWj1N7Ega10Y3jQQAj/Ecx73erbXTB1NtYgC63kMV7QA0Bj4RfcCGuwTPAHzqggzaaJnT1mt0DnRK2T7+bu+PW/viLzwaq4ySIF2vA5lR5UW0/4hfpN1MLWNxcgXHT7bGJXC7AFCJoUHggoyQXkablL8dmKewmvfvrf4Pza1QC4G3Qw4g9YGkeENIBIICUAdyUh2S/ihXSZj6o+mU/O2AKQHxsR+f5wgXMdK4vFhmYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(376014)(10067099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261021135927099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emZFNlpIWWhQeGNyRGlqR2EyakdNeThUcGIwN2l2Y1FnT2lBQk44SGoraG9p?=
 =?utf-8?B?NiswQkt2SzUyaXNleEU4TGx4aXBNSTBabkVpNDlCc3BVVTZHS1pySFp4cTQ0?=
 =?utf-8?B?OWJCdXh0SHRlSWFzV0tlbUpRYmd4cS9kenhJMWpjTWlMUUJLNDZxcVhqUUxo?=
 =?utf-8?B?M1diTUlJTDBVK0NDUmF6SU5HOE94RENvbVJwWjdIbGZXMjZnU0h3MjhTcmxF?=
 =?utf-8?B?cHUzRUUrVkRnUDYrNzJVSURvTjd1d2xncU1Hb1FqWlVWa1NocmZWYmNSdks5?=
 =?utf-8?B?SFhudHdZeFdMMlpmRU5JODV1NHI2dURaYnczOE1uMEE1WXV3cVowOTRlVG1L?=
 =?utf-8?B?ZkRGU1paemZ3TkxVdmNvTWZMTmYvOGU0aCtCQnhyMllzZ3gvZ2E5TGlmaFhU?=
 =?utf-8?B?RnZWTnJVSS8yNFI0MDhYM2ViNlBRZ2tqZ2E5enhaUTdxK1F3U254MDZEOWpI?=
 =?utf-8?B?bEI4bm0zNkVYb2JmWjhSb1d3c3U3WmJiUnVMaHpOWW03d3F5Ui9aQ2dGcjRL?=
 =?utf-8?B?cmlvdmxIdldCWkxYR1BWWDlqOElPTC8yektBWnJOaUhHa2xuZEliYU1NNmV1?=
 =?utf-8?B?bmtDZkZZNjB6VncvRlVXUVQxY21CWWo2SGtGbVFHa05sVWNMYXZlMGxkUUJB?=
 =?utf-8?B?ajNmQTJKd3FIenJBL016d1JSN0NiNkJrZEtPT2prRnVGRTZSeHV1VHdpOXhX?=
 =?utf-8?B?bVMvZ3o4V0Y4S0VQaVFmZFNzREIwZnJ2dDVtbndvNUdyQmtnQ05mSjlnbmNu?=
 =?utf-8?B?WXkwcGZ4M1Z4U1RXV3pVZTJiMEhEamJhRDA4V1lDeUFqWUdEWVJFNFVMZXRJ?=
 =?utf-8?B?aXhXdUZBbWE5WG5vQnFZeUNieTlaUytIVXZHOFEraTZSek0yRm5UcEVCU1ZL?=
 =?utf-8?B?Q1FaWWo1MC9EWnRhdTg3TGpqRTBqYUhMV2Vic2lCamZPS3ZpNWdranYzNmpr?=
 =?utf-8?B?dUhEWXU1ajdOMEdsUktGWlpLNDliUGhaUTlGdHh1OGE1aUFhS0xCU3dYdXN4?=
 =?utf-8?B?YytMcWxOUk82a2wwdUZtNFQvaHpLd1pyNVBEaVBrVlB3d0FRSmxxNmt4TVIv?=
 =?utf-8?B?bFoyV1owbWROQm5ZanIzVEtMY2c4WG5Da1NkMmlubmZSdGNCbUdhRWlmUkpu?=
 =?utf-8?B?b2dwSWtTMjM4UVNIL2xkc0RCaUtPQm9wUUhnV3hEYmJ4WlVPUndLYlhWODZF?=
 =?utf-8?B?enloNEFMYVZuVGFBOFNWWFQrVWV2N2R2ODFOQ2U1K2hUckl0eDlIOXJ2V3RR?=
 =?utf-8?B?aVIwUkZQZ1VUUlpWS3V1QmdZN1YzQmUyTFNjbndPWlRkZzRIclhVSjB6OEZG?=
 =?utf-8?B?UlNkSk1sYkpGNTI3SkVNRFliRDZXdWR6M0ZkTkJhbndWNFB2dGlwemlCUFNj?=
 =?utf-8?B?TDZMc0kyLzdwemhWUlo2eWQwY0dsVE1TSVl6c3NSdnNEYUVqbEdlWU9PM3Fa?=
 =?utf-8?B?c1RNaE1Gam0ydEMrNGxMd1hMNGxIbkhDTEpRZkIwY0gwRFhNNWhkNWhMSG5h?=
 =?utf-8?B?cHNnL0RBMFVZV28veDdQT3N4NXNlYjM3Zmp6Y0ZMUktONFVrdmQ1VkN6Umk0?=
 =?utf-8?B?WG1jaFp3Tm51SGdZVVROZHNVYUd1ZWV3L3ZHYTJtNStCUm1RNFBleDF1UnFK?=
 =?utf-8?B?bnpMdGU3NjR1RXVmSHdwMjVmRzh0OFlodUhnMVZLUy9BNm41K1ZKeVc3U09X?=
 =?utf-8?B?Q1FkNGNuT05VdE1CR3dYZFN5QnVaY2xmMVhFdXE4anhYMFRmTEgraVRnT2Ny?=
 =?utf-8?B?T2I5clZHYXMyNmdWOTdyeFlpcXhwRENCVENqUmpFZG01NFdBbTEwNFFzUWtx?=
 =?utf-8?B?N1NDdlZpMzJpcmdhMlZTMGpJSVdBdWplTlZQYXY5Y25YR2pTRTE0RHhUa0d3?=
 =?utf-8?B?ckV4eDRtSVRNbXYzcks5bTVqRk9BUnZzSmdLQXNxaXlaczRxSXNwaXQrTSth?=
 =?utf-8?B?WkFFTEVnenF2akkrRUc0RVJ6RUpPRDRWbHhiWFZlTHhGeWxLeU9jSWVTeGZr?=
 =?utf-8?B?dndESHMwVGJoZkJTMHZtWGJsazVpM3RvQjFhWWpRNUJMQ2E2aWY1SGczd2Nq?=
 =?utf-8?B?VXVKMVcwVWRsb3plWU5WSk1xTW11ZVJRTzJvTGRXaUE1L3l2VjFCYlB0VlNl?=
 =?utf-8?B?TVB5bTJBMXhTa1pIZGx4dk9McGNUMEIrLzlnOHBQS2JSVGhaZUcvdFJFcDBV?=
 =?utf-8?B?bSsrYUYzSFB1ZDAvOE5IUmJBUjJ0dlVtcHdTZUxFcjYwenRYQ0xXWkdhdHND?=
 =?utf-8?B?M29Wcjd1aEl3UlRDdldtalR4RHh5cExHMWVTSnZJMWtiMzZXaVIrTGxEK1N2?=
 =?utf-8?B?OHdjU3dYRkhVYzBxWmMraVVXU1h4MGR0SHhqd0h2MkdTNkh3YzZQM0FYUDNw?=
 =?utf-8?Q?rybSgr9k1ZtLbL/d1s+VHE5f8wdqK73lvPnha?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4051709-c773-4609-2650-08df45e8e059
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 02:57:41.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMdzasrkAs8Ps2rdsj7uR8gdZMu33oGsdQFuKJT2Gtm7VWhReTfv9Rhhr1/SLvcb1Ke7hcvu3uWwX4GCkINPQESv7lAqPYxyU7PuJnCT2csciIWH3n0M3uCTJvYzdtk5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967

On Wed, Nov 18, 2026 at 09:19:20PM +0100, Linus Walleij wrote:
> On Wed, Nov 18, 2026 at 8:53 PM Frank Li <Frank.li@oss.nxp.com> wrote:
>
> > On Sun, Nov 15, 2026 at 10:26:27PM +0100, Linus Walleij wrote:
>
> > > Replace the LCLA ESRAM regulator with runtime PM of the SRAM device
> > > owning the ESRAM34 power domain.
> (...)
> > > -     /* If lcla has to be located in ESRAM we don't need to allocate */
> > > -     if (base->plat_data->use_esram_lcla) {
> >
> > Does it break old dts's back compatiblity?
>
> It would if they were using LCLA SRAM but there are no
> DTS:es that actually define the LCLA SRAM, so we are fine,

Please add such information at commit message.

Frank

> all existing deployments put the linked lists in common RAM.
> It was an oversight or "fix later", "technical debt" that was
> introduced 15 years ago.
>
> After this is fixed properly with power domains I want to turn it on.
>
> Yours,
> Linus Walleij
