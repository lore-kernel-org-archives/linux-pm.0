Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8633D6F8;
	Thu, 16 Apr 2026 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776319256; cv=fail; b=n6tex3z6Wh2K+pJtNHNgBwPLMqOTk7AruhZt2VIRjaDIROGZE3sStVlVOlmBL9xPt93qOOZvTwHK1UYftJhrmDoxPS8zr7Uu96AjqYUKLOhtzo7fn7zJBwbrhmSwPnbGiRvRwEKc7hvZuPehiWiG4zB4lnX2TMbS+fsVNkRWKrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776319256; c=relaxed/simple;
	bh=IwoySTwUAa6XvqKjaapfeEcJFxBbtZM27flJMlk3XyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X1IwGlcf08oz2J+FslD9sBa8geqX7ela7p3Zez0y1u3KqHzQlRoisctJ/hiGgeDFk74AmTgKu5t/HK7aBFwvWRRm0aR01qU0QxuNFZMOg3bwNCSZ1FYyFOEqCnfVc1DtegsC8LzNnV64TTGO0wpLHyukWAhrQw9nNHXZuRJ10IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aJVq8Cja; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aJVq8Cja"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHJbptTydvY8FBPp5tgwDl17MOI4XErWialMDAupRP04N3ZJ2JlXsVqeMhKvdZAYqlU6m+e/fzgc5L7MS8iMvQwb65jBFQpXGRdonNmw05Vt/e15taqIdHaQO1psiSZS+78ZS1HczjT1WGvAVZiRF+4BYhJBbTtFyOV6eOBqvkQ+uA6YsorUdoWrd3PZkoxlpcCLM5AVhpQE4izSoV+Ng7n2NLfUiY70hIt+fCqfMfQ+lrHrLYZslWeQJ/VcMgIyZ8h8M7mmlZDJR4jvwD1T/YqE5Wfs+JTr0JjTudvaAqMqjGMSgQoMfDeycjjmbuKOTTLS16LFvCW95ktkT9MJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGhXB48BuSQmy2H0Hdg1xhGtDPivDgOVO9iq+YeKlGQ=;
 b=mjgq9f2hPu/kLCIlInvRuE3O+WfhB0aVDzRlLLz29iTXTn2vDepyi82GRFs5wg8HG6sdNRsePykSAmc7Jw54o4BTTaMlSOd8Lg7U1eaDvfd5HEWljVhjN0qFid+alTGzzSXe1iw58t0wRYa/l/sOYfRcSWCLKxSlaAwD+EGStptV8pxV2PVFg3hcrCWmANC+UPvO5wvHlRC9+Su/Ls31JoIONaoaMBXQl9W6EMJI9VLKH6j23JckoYZn9KyD/ZRs0kCMWITDMPB4Ea+ej/3N/kC6LFngMVdD+GfKemDmXX4XTeh5q4p1Q1uXsApcNP2t0iOND0HdMOJ1zzUwFjNUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGhXB48BuSQmy2H0Hdg1xhGtDPivDgOVO9iq+YeKlGQ=;
 b=aJVq8CjaO3aXFqa7eTe6QJThtpnHlNmvrOqeCVfgaLt7B6JPXcephhq1lzphxD/4BMxsRRE0mGRwkYt/io6POG8TIXck+WDkNEBKS3YeG906fxeUj7reEa15qGhpObWAVW8pAup+hRjh9hBlf/XIdfxXJitm7FpkijsjkXbc/Qll8GLF1FLpRpXHMUCFYXMBiXrS919XHZs2eHr2ZjHYMYYOH+1I4aNSSHDNeXuozWupL3pL4F/sJaizmH0rF/Iav7x9+vuxCqSDezyDJFAiJaz2pObwzLFwCybgb3NNBWacbMX5nB1IGn5tX6vjwx5jdf6EBwydTl/bZ68hoh+gQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 06:00:49 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 06:00:49 +0000
Message-ID: <d44a60ff-c8a3-4347-9199-def61e855066@oss.nxp.com>
Date: Thu, 16 Apr 2026 09:04:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL
 tristate
To: Zhipeng Wang <zhipeng.wang_1@nxp.com>,
 Marco Felsch <m.felsch@pengutronix.de>
Cc: "ulfh@kernel.org" <ulfh@kernel.org>, Frank Li <frank.li@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Xuegang Liu <xuegang.liu@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
 <ql2c6m54fjjwifycaan3hcr3p3bp4phva2vdux2qcramt7wrvy@4dsvpyct5tqx>
 <AMBPR04MB123344C1F802528A10CEA7FADEB252@AMBPR04MB12334.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <AMBPR04MB123344C1F802528A10CEA7FADEB252@AMBPR04MB12334.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0033.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::27) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da6c3a0-6930-412e-51f6-08de9b7d8262
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ppc+kHtFcqQ9SuU+Un2rEdlH+dTQu08wjp+zTAHneLwcjdtL7m6Ez17TdgQi4xgN551tZOS93pmp8+1WmkzHVxy+hyNRxzR6p4G0Tr43LWDFOzPimYl/q2oXr3LgnQaypMriSXrnGcU0tEKTXxOEqb5tkVQXRv1Tob+rezx7yWVDUbmnauC47TaN6ujPK55zlBbq9u+hMAsjGLYXK28gjJQI8zU6NRGZxOgKzjU3ILH879p3pTY5UjHrA5hgQds9CIPt+nkATlEbLW/Z8XKwXXJQdwnliMOIjNgRLVTPUzCuGfztjoj/D8Hz8IiWAyiLiDDUwTD40+aGznTXC/pzLiJTbLxmwXFW7Rh9dmIt+zQYefrCGwxcavggOf7nvt+Mv716WeuCEzNGTaZGBQw9yb/HjwSEf1MxULNw7MsN0s9wLdkEifLS+n7EB1UDMrgZ8PaPbsv1o13hG2/uBjuFv4tIDY0VyZyyv+afoLQXul/Rp1tERNataObvC3FRm5h3P5MMxqMnGTqqNQ5uD/OJRFS9SufrSAW8KddeRh2fDMExhSdLqq4tK9C/XDK2pJKbGk7N0yLKNeZ69wGGIp7j3A2N96zVvMc1U1wchOg6/RAbJcLLcLdUUt99EHB3KPKvKV0/eYTF7Z3wtoFxpbKI0zh/GdNQx88JcbwUdqsa5tl8JxwJCw1SJMRb1NkPr8UfGZle0tbQJDScVZlivXGql0FASFQdMRIwWwDU8Qo2m18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmJ0cWxDc3RJUCt4dnBaSVN1dlBrR1JrekZUeUl5ZEhEUTRGL0s1ZzF5S1lU?=
 =?utf-8?B?aTBtY1FWaXBpUTVZa29qRy9WQ1JMUzZodFlNT2ltdGt0bW1IRnFEMjhaa3Yx?=
 =?utf-8?B?TndWWUFPdGZBZER5YlMwTGdVOEk3d2ROeURPVm0wRkYyUkJQM0huaEtNWmhK?=
 =?utf-8?B?TnFTNUREL3Q2MzQ1SUwrUHBRVkpkaEpoclpBSTBlWUFqVkxEVTJmVFY5NFEr?=
 =?utf-8?B?MDloc213eGJoenJqRUljUFdkYk1STU9ieUZlNG1JNjMzamNSTXQveExubEtS?=
 =?utf-8?B?aVh1c0d3VUFUT3NlQ3lScmIvd0R0TXFXOXZSSW1uRW56Y0NqY01oZWdLZS9Q?=
 =?utf-8?B?RFFEeXF5Z0ZVaWxFM2xGY2p3UCtrb2ZqY2tNZmFvakFWM3FBYTFQaUNydWQy?=
 =?utf-8?B?TGkwMjdSb21Ed3FXV3Z3clI4RFd2NTVuMG95cnlhS0U0YXV3eW1tTG1OQnZy?=
 =?utf-8?B?NjRLbDNhc0E5YzZ3OS9mb28yQ1dYeEdPWVV5WXVWeWdndHY0ZzdMMDQ5K0hC?=
 =?utf-8?B?ZTk1VkZDZldMRml2Nll2YTRyejMwV1c4T1JGRVNzMjlZaXlKcXo3aXdBRGND?=
 =?utf-8?B?b2NQMmVXSGVZdmUxZWYyeThVSFcrdzdmWFRRR2RGSEY1RU1yZmFJMzFsQkh4?=
 =?utf-8?B?NmlNdVNJaEpiWFZkdGFTYUhlUWNrbXRPTHU2Z2luZEl5NmJWTituL0czL2pO?=
 =?utf-8?B?YUpIRGhnNzlxeEcyamU0b3YvcmlhbC9jNlJ5ZUF5Y2g0ZER3emJNLzlnRXZ2?=
 =?utf-8?B?dEpiRWM0UThsTGpuQTd6YWZacnhaRUh0aDNlN29jbE5TYWVyWmc1ZEQ1bzZw?=
 =?utf-8?B?TTh0dHhyVFRJL1c2VVdtK3RHdXpUcFM3K1pkM05yNVJuNzFoZEhWKzlUbnBG?=
 =?utf-8?B?WStZeHRPcFkyWW05WFRmcGR2dTJHWkI0WHlBZ0k4alMvOUdGWWlweWVaZHYy?=
 =?utf-8?B?aWtHSGluZGY5bUJMQkx6Ti9MZ2ovZWNLS3RvcEFZRllBMncxSitoNy91anVT?=
 =?utf-8?B?MENCdEc1U2QrM01jV1FYY2tQS21aR0lYcVFGTndkR3hvSHZBZDdmN2ljVFZw?=
 =?utf-8?B?ZldXZm9aUHZrRXpjOXJqZVdVN25MT3VkK3c3ak5Xd0s0N2Vib3BzN0QrV2RU?=
 =?utf-8?B?bXAzWFRKMVp3YkxKZVNQSWM3K09jbjAvUWZBMnlhTTU3cHphUlM4eStGNCtF?=
 =?utf-8?B?cm9BRllSc0FXaVBvS01mUG12WGdUYVRCYytwWnlQOXhzaGZFL2toL2JqdW11?=
 =?utf-8?B?aURRdjZzMlFIOTJpV0dUYnVKejRvQ2N4emJyL2tXaFcyaGVldWZHVi9GTk5H?=
 =?utf-8?B?OGk3Uy9wS0xzcWQ0a0QyM1dvZ1A0RHZ4ZHBmU3owMXJoOEp1Q3BBdDYyOFkz?=
 =?utf-8?B?RTdTRkRGNldWRjJmbWFZQ3laM1Y0dUs1T0tYSUlNbVNVa3VMT3dzTnN5ZGVq?=
 =?utf-8?B?bTVydDRvd1lBc09rbi9JWHJ5Wmt3aDJSbmczR0ROMWZEYkQvb1A4Vmo5dWli?=
 =?utf-8?B?LzlaM0pkOU5UeHA3M09kZGJhZTIyQUN5ZGh6NlpNRTI5NUwwMVlGM0hsRSts?=
 =?utf-8?B?bnMzZkR5Zk81dnFiNk1lTUJYV0pmUWdVMnkxRlFXTWFNeEt2aUNQeVpZLzNQ?=
 =?utf-8?B?MEpITDF6TWcxL3dyQWM0dDk0S2N3UWNKNkxNeTU0WjlwVzhPblowbjlISlda?=
 =?utf-8?B?WThyVTBraXZCMGZKa21HZFdKNGJGTHROd0ZSNGt1UTBhb1UrdDd0dHVpbHhP?=
 =?utf-8?B?NGdpOWloQXcxaDd1ZGtrZWlpTkRJeEpMMVAzSHY5Tko5S28rZlVxRGxJYmd6?=
 =?utf-8?B?NTNpUXVSVndQd0JqSTlxa1VaRW5yVG5NTlhDSnhMQ3JBeGlQRldDTnluQXgx?=
 =?utf-8?B?aXU1ejM2b0xmVG8xMmZSTWRjbkhzQ3FFci9HY1JwTmU0ZUxxMGlPWVJYV1FE?=
 =?utf-8?B?UytRSXphRjEyM0NrTU9LQk9uamYwWG5oNy9SS2gxbUNFLy9PTHp6TFF2c0Fr?=
 =?utf-8?B?Ukt2UHF0cCtEK0hDZHN5TE9JVHJzd05KekpGWnJMd3lqQjFZSTFmenNEQTg0?=
 =?utf-8?B?RzhCUW8rMS9LOFQyQmVHOTF1VVZ6SWpubmhqZWhEcDhsR1VuWEpNdTZpVUMr?=
 =?utf-8?B?U1ozNGZqVFVJaitlbkhpKzV4UjdIVjQzMnBiRXNMblhaMm9lMUwxVi8rVmZD?=
 =?utf-8?B?MElEVVdhZXFka0QyOUVvSFluNHlDRVh0L3BOOWtuczRJT3dBM2E3dXNTY25V?=
 =?utf-8?B?ZVZHalVBczZSK000MDduajBmdURpS2VSY21oU2NRODZ1QmYrRWJuTDJ5Rmps?=
 =?utf-8?B?YmRnTGRXcWp4d3RFTHFsOCsybkZJYW5SRDVDMHY2OWVUSC83RGJBdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da6c3a0-6930-412e-51f6-08de9b7d8262
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 06:00:49.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGAjzHKfAtNqe0CBLylrPt9LMhtTl9S7uhxVItLqUctK8fW6DMpJiy+l82Xv+/rsniO+SDX9DSHiFZFmaEU4dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506

On 4/14/26 04:59, Zhipeng Wang wrote:
>  > On 26-04-13, Zhipeng Wang wrote:
>>> Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate to
>>> allow building as loadable modules.
>> Out of curiosity, why do you want to have a PM driver to be buildable as
>> module?
>>
>> Regards,
>>   Marco
>>
> Hi Marco,
>
> Thank you for your question.
>
> The primary motivation is to support Google's GKI (Generic Kernel Image)
> requirement for Android devices.
>
> GKI separates the kernel into two parts:
> 1. A unified kernel image (GKI) that is common across all Android devices
> 2. Vendor-specific drivers that must be built as loadable modules
>
> Under the GKI architecture, SoC-specific drivers like IMX8M/IMX9 BLK_CTRL
> cannot be built into the core kernel image. Instead, they must be loadable
> modules that vendors can ship separately. This allows:
>
> - A single kernel binary to support multiple hardware platforms
> - Vendors to update their drivers independently without rebuilding the entire kernel
> - Better compliance with Android's kernel update and security policies
>
Can you please add the below line in the commit message?
> For i.MX8M/i.MX9 devices running Android with GKI kernels, the BLK_CTRL
> drivers need to be loaded as modules during boot. Without tristate support,
> these devices cannot properly initialize their power domains, making them
> non-functional under GKI.


