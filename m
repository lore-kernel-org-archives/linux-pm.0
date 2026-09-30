Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457214C0424;
	Wed, 30 Sep 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799368; cv=fail; b=Cbh4VQXr5BEi1w7F7c9AzX2jXp+dEgNHH5B9fsRyokKUFxyJcpOCexR7dmXyFS0Av6CYCM+SQEG9hUf04417lZYQTRI68xiXjLzdmpAZE9TCpS/cGhwzokw+8dUeN/ou0l8U+3BVvpGeY3kJwyT0pVZBBXLw9Tdc+QjeEx/Gp4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799368; c=relaxed/simple;
	bh=FEzpRbnSTCvhJLr1DSfF3O9VKjWrRe0WWiul8pluS6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W3bPrfA86WBZeGzGtziisyZzmk3Ih17aK8F2L51e4RceEVqgyC19FNT03Gtx1PjWYe1e3P934yirEINVdL7LX9/j+ZmJwM83zAsbU0u5KOY6N+pZQe6oyaI/z9a8QScAKwlAyWcuuilaaaMqxGUAMteK4Ky77S3bITqUZkCH15E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XeK3nG/A; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XeK3nG/A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiC8n1H5GMXoJZlr02+6nNOPJeaMs8zkhmQM7Ki1JTz4klH2BHA8Zz/gLNZBhFJv2+P5YQ2GnX2kRaE5G/otYzrbFCgmLne8bLU+vVdyxyB6KRYa50k4mU0pOXk3uYy5Rsm6NQ8hB0cn/e8FiOW9P60nXn7sHyM1wxD23QHZ+9ZQRoEznWV5K6XGb9nQD6Bx+bOrZCmGTqgUZNP5uvt0peQTbndLbunkFbXgPwH6dUwH3wZ8fTfNA5VitkbSa3MrQztQZLNq0WgyIDjR4cWUlTmKkdlpAwmn66JYAGKr2Su3K9tC1ZG+N9h8wzMUCu8zQTSoysr22PyAOXpO1q2Ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5PaiNh3EyNZsj0pxCQpPqHKxifj7rHe0obR3cqwHnY=;
 b=Np3cre3strrIY0pXoEfpK9iNnX0J7n0AJanZUv3sQYGziIztFAmUmTK/vL1G+mltUxRvZEoVhz88rGLkGK/RJbFHOTpLhFc2YM+/SfWy5EkXEYMnjkxE3c5JikB/JVqcAQ313xrv89WkREyKMkSHFrFg9dF6lAHoLLraIy132NVH9ivgv3FHA61kk4RnKjEBWlG7STnWv8zjR9ECQKe/WSLnwTue4YJO1ovfveeO283nFhmi4qqYf/mSWSKleBjPnM+qISbOEXGLLKoE93A51wZkZiB9fQ2W590cZ8jmAEOU+U576eDZ9M7qbvYWsPBACsKEBCCjhHq2ETUw2LiBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5PaiNh3EyNZsj0pxCQpPqHKxifj7rHe0obR3cqwHnY=;
 b=XeK3nG/AZZNht+IxGpMnNA+nbPwUWX+P6fgXEasEdgLqA1N/p3T/PE7rPb+zOWLeyVQM5kk93wtOTnRB1z7kByQUfGyQx8R0ww4H6yaekkdAxG6vWIjN/U1cfg8EwztTO7kHk8gs3bwSPXn22ng+P+7VA6QIuuFFk6lrt6YPe0PanTlQaY4RfIhJYWf3MUyBunTuWMULrvbiQxa2V+C/JbJOtlywVf2mIC+PjP5H6lfuFavNhJ6sRC+ySq67ZtRmOhNp7Wf35y9FT01b2FEr5YhObV8iU7AzhpB2BfOH5wYL4kbL51mOf0YG2b2GWimoJzuLquLuwubv03r+5iz33g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MRWPR04MB12096.eurprd04.prod.outlook.com (2603:10a6:501:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Wed, 30 Sep
 2026 20:16:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 20:16:01 +0000
Date: Wed, 30 Sep 2026 16:15:51 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 15/18] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
Message-ID: <ar1t923YOnflDFXc@lizhi-Precision-Tower-5810>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-15-9352be6b86b1@kernel.org>
 <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
X-ClientProxiedBy: CY5PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:930:5::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MRWPR04MB12096:EE_
X-MS-Office365-Filtering-Correlation-Id: 253a9240-77da-46e1-0e78-08df1f2fa55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|19092799006|1800799024|376014|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XgLFCFocmmfYG9DUGLCMd/s8ICbRxHnHSF0f2sBSLJqCX+KILYkFle4vHBxgkgR7yCszSvAhFKFivuae9U/52jwUoTh2UJwzTwZx4Xvp4VbZrRzrs3FVM1BvnDHtYabRCT4EixicXZfjMsHZLAcMUltMhhDD9nYGFYffTa0PGKMlT02TE9EmAAWowcE+jp7opFL3w+Nf2Qmf+uiMV2/ObFlOimQvtW46NlFgvRyCLW1g3ptT+XJaiyldFGwZ4qWcK3K+teI67qND+NuqnAus3dNYbQEE/VH6VubOnzVD3y+El9YP58SqY+zFEuRHZaEIBOFJb62lIdiRhWnMUrU1kYVYB6uCLijZCi/UawTdZugTFQnvyJSOb2o4XabV3RwnQwS6CLWdMB3aOFdbnbqbJxw7CzSGq2v35V3YM7JRWidXo4ZNdn8XDDG/yautZfMqHQenAagkxy8LW0LLlTWDtjsLwuLTuqsj9zAj3gWMhxbjVsdkWYESmCCKAqJo7Qff3joUOaRdT7EB8hMIrujm0mmZYqFYl8lpJVQnWOxJsdo4RPrVRb6QRt6/aipINEYGy38lcmspRBf6cQKryoWjDxBwJOW+Gky4krVSc35wPDg5EPYy4WCbSamfkF4LncCj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1ZnWG4zT0F3b05XdyswNDdBQWpnZnNDaUJLSUlsaDhyeXc1dkI5TklPOFhs?=
 =?utf-8?B?OUVBTG1mRXRuWGdwRVYyTTJwT2xEQ2xTT1dCS09YZE5ZRXlYUFVPQU5KRzZO?=
 =?utf-8?B?ak16WGFPR3BMdjYvWGh5cCt6NlVSWmRrWTFvdVloSG9CdWlHTXQvcmVUYzAx?=
 =?utf-8?B?S0VQeXNvSVp0UjlqOTdLbnJ0blo2aHlLTkJ6MW9ONC9XVkVBbGNWdXpyRXRa?=
 =?utf-8?B?cGdlMVQyRXIwTHdyOFhGazFrUVUwY0tMQTRHM2hxYTVCVlcwdEQ3OTdwUThs?=
 =?utf-8?B?MU1NbkFqM0tlUWtHQ3BUTUk4UzdpT01sbVRoZ3dBc1lZZUQvN3RvZWh4R0ow?=
 =?utf-8?B?SjlBNmYvOWtVSHlqeEJncUZJNk1BVDB1RXlqYVB0clBXUnJSUCt4blVKRXhy?=
 =?utf-8?B?clJnd2NEb1dQUENReTdXbDZUTjRMSXkxdUN0ZDV4M0tDRkdVd1hrNGZHbklR?=
 =?utf-8?B?dGlmT3FQcmwwWUJ0ZTh5eGpOcENwM2RWREZHYzdjRHZWZW9MK2J4UmVHWDNj?=
 =?utf-8?B?Rys3ajlFZDQ0YWFFcnNaN0R2dDlvcERTM2FDYnEycVREandWYXNCYWtTUysr?=
 =?utf-8?B?QzJGaGJTWVRvL0U2YUJ3eWtiSTl4eWpWSEhQYW5EOHZRWkJydXhaNld6TWNl?=
 =?utf-8?B?eDhiRmp4bC9OSzQ0Mk1MZW5xWVJDc3BEVVovZTY3cldVZk9zbDBLcFFtbEZQ?=
 =?utf-8?B?RkdvZFdHNVlPQXFIQzArV3JxeXl5L2pmb09pS1I1dkNVTXRsKzAzSWsyVHhK?=
 =?utf-8?B?Z3dlRENtSVVzT0UyNFB0QVZFRjd4US9YUnROa3lhOEhXaDhVWDRNeWM3WmVW?=
 =?utf-8?B?djdBSlBEZTFrMU80QldSVU9haEJYdWhVQW16MHV6dTNrV3Q5b3c2RlJsc2M2?=
 =?utf-8?B?TjRoU0ptaTBoamorc0N5dDVoSk1zb0lYc3pCRXd0MzBWQTBmemx0NzNzT21o?=
 =?utf-8?B?bjVyNWxaYjlrb08rSFRKNTIya21BNEVoWXFKeERzQ3VnckRrUWF6WllsNlI5?=
 =?utf-8?B?bEFxRnVHYTFqeGs3TmFJWW4ybGxZVkIvKy9VOWpCeHhKY0JocUdmd0h4SSs4?=
 =?utf-8?B?bGFDWmsrRWNTZEZTYVhXNnBlYzNVRUsxWklZTFNTbG0yRWViQ3ByVngrT3FF?=
 =?utf-8?B?SXUrOTRkRFNxcXU2RFRHRGFZcXZhM0FFWmRISEIrZXVnSG9OZTVjN0g4ejV4?=
 =?utf-8?B?bEJSczk0UXhEbEc3Yzdnbk13czlMQXNkaGR1Mm41QmRhMDBEZjFXMnE2bHJH?=
 =?utf-8?B?UXRSVzMzRndHUFlndTh1WnFwSWttVGRldUtkWTJjRTlqSHdaTHZyM0ZMS3gw?=
 =?utf-8?B?VDN6L2liQ0hrMmpvLzVoWXpMcWxBT0NFZEpORllkcVViNWsyN0szTExmQk0r?=
 =?utf-8?B?cjVXVlRDQ2gyT1A5U3hSb1NSdm1JTjZLSllyOHo2TU1qbEkvdGIzOUJtMjNh?=
 =?utf-8?B?MDVEaGlMdkFBak1VRkFibDRLUkxpY29tSHZWdm12bXkwSVRlTTFPaTlOMFor?=
 =?utf-8?B?OTZrU0pXYkZHSUVobkZFdVg3ay9XaCtLNnozbzhnRHB2SmdiRWJBK011NmFN?=
 =?utf-8?B?VVBCR0d3TUV4MGd1UWV1TGdDeG5OZFNrWUo2WE45Ylo0dk96dEdmYk9tRmJ5?=
 =?utf-8?B?U1Z1UUFiSnVHZDlhd0V1UCtINnpPYUFQSjJzVWdtRitYWUxKYmxBc0hWallj?=
 =?utf-8?B?dTRyZHJqaTBDblBwNlpSbDRlNHptc2NZL1A2L051U00vcWpvQ0ZJUC9DL0tn?=
 =?utf-8?B?a0l1NVIrQnp6cDF0V3BKNUYvZlI2MGJGd0dEL0E2K0EzbDRDVnE3ejRjcjlv?=
 =?utf-8?B?bm8wb3FCMit2V1ByaXZiaGd1aGdHQW0rdWwxSXBvSkY0OTllZ0Zjb3pUaTBw?=
 =?utf-8?B?Tm9sT1NSbnRVUEZmQ3JuQm1kWFdEcnV3NkpQbHlLbk1oWmVWalgxamNHaUJ3?=
 =?utf-8?B?SEdOZ2lsYUZtM2xOMTVqR2VjR2I5V2Uvb3RIL01vd2loMkNDSkJ2Mkd2ZTA1?=
 =?utf-8?B?RkpsRitSU0lOSFJXVmErVDZBUmZ6TjJKMkZVS240dXNIWFp5UGVmK0MyeG1X?=
 =?utf-8?B?Rm0xcE5TbVBQSnRKaGhYMTJHUldBQzhmenhYN05TbFE0LzhsNmpBK3VnSlpG?=
 =?utf-8?B?ZkowT1huS09xd0Y4czZkVUFvK0tXeXZrZkQxSlVZbCtqclVpOVpQaFIvQkFU?=
 =?utf-8?B?M3ZWMFVlTm10Q25RUEZxZWd2cHpiSDdLTzhTSy9GYlhudkZXaHMvczJ6Skx3?=
 =?utf-8?B?eU9xcW9FV1N1aldmZDg0VXZPbXovekl6RnpFRTRPQWZtb0YzWTNKeFNEZzkz?=
 =?utf-8?B?U3RtM0s4djVoYTBUV2RwQ242R3RUQUVVK28vZ051VEdURFFSSXMrcWZHUTFR?=
 =?utf-8?Q?okQf9ikAX6oZrPlssSTuZ9qdCBkj4Pc8zwVvx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253a9240-77da-46e1-0e78-08df1f2fa55b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:16:01.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLLCGhfIxeiNfUNaeegt4EF8NV68SLx3EU9UytSPs7K3zgnmnJWHiVdQXiMhw9wBiAVDQsSXNW80KqLcBPG0B3tRDkjlBTEKQ0JhUZ+JJqLIHc4HA0RY7NnnMOuYeUfD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12096

On Thu, Sep 24, 2026 at 03:26:47PM +0200, Ulf Hansson wrote:
> On Mon, Sep 21, 2026 at 12:49 AM Linus Walleij <linusw@kernel.org> wrote:
> >
> > Replace the LCLA ESRAM regulator with runtime PM.
> >
> > Use the SRAM device that owns the ESRAM34 power domain.
> >
> > Hold that domain while DMA transfers are active. The DMA controller is
> > runtime PM IRQ-safe, so keep taking explicit LCLA runtime PM references
> > from the descriptor preparation path instead of relying on a runtime PM
> > device link from the atomic transfer path.
>
> A bit of an orthogonal problem, but related to the above. The irqsafe
> thing have been discussed in the past for DMA controller drivers.
>
> Would it possible to get rid of the irqsafe configuration for the dma
> controller device, altogether?
>
> I don't recall exactly, but not the entire consumer DMA API is allowed
> to be called in atomic context, but perhaps that is not sufficient to
> allow us to drop the irqsafe configuration for the DMA controller
> device?
>
> If not, I wonder if the consumer of the DMA (like an mmc controller)
> should be assigned as a consumer device (using device links and
> DL_FLAG_PM_RUNTIME) of the DMA controller device. In this way, the
> consumer (mmc) would be able to control the supplier (DMA) through the
> device link directly using runtime PM.

Yes, I support this method.

there are someworks. welcome to join discussion to make it move forward.

https://lore.kernel.org/dmaengine/aNVufDmHjLRauKYo@lizhi-Precision-Tower-5810/
https://lore.kernel.org/dmaengine/20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de/

Frank

> This could potentially avoid
> the requirement of having to use irqsafe for the DMA controller
> device. Maybe someone already tried this?
>
> If the irqsafe configuration can be dropped, in some way or the other,
> this patch could become less intrusive, as all that would be needed is
> to create a device link to sram device using DL_FLAG_PM_RUNTIME.
>
> Kind regards
> Uffe
>
> >
> > Add a stateless device link so system PM keeps the DMA controller ordered
> > after the LCLA SRAM supplier.
> >
> > Suggested-by: Frank Li <Frank.li@oss.nxp.com>
> > Assisted-by: LLM
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > ---
> >  drivers/dma/ste_dma40.c | 130 ++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 88 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> > index eda3f91741ed..2841af5b160b 100644
> > --- a/drivers/dma/ste_dma40.c
> > +++ b/drivers/dma/ste_dma40.c
> > @@ -21,8 +21,8 @@
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_dma.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/amba/bus.h>
> > -#include <linux/regulator/consumer.h>
> >
> >  #include "dmaengine.h"
> >  #include "ste_dma40.h"
> > @@ -383,6 +383,7 @@ struct d40_lli_pool {
> >   * @node: List entry.
> >   * @is_in_client_list: true if the client owns this descriptor.
> >   * @cyclic: true if this is a cyclic job
> > + * @lcla_pm_active: LCLA SRAM power domain is held for this descriptor.
> >   *
> >   * This descriptor is used for both logical and physical transfers.
> >   */
> > @@ -402,6 +403,7 @@ struct d40_desc {
> >
> >         bool                             is_in_client_list;
> >         bool                             cyclic;
> > +       bool                             lcla_pm_active;
> >  };
> >
> >  /**
> > @@ -571,7 +573,8 @@ struct d40_gen_dmac {
> >   * to phy_chans entries.
> >   * @plat_data: Pointer to provided platform_data which is the driver
> >   * configuration.
> > - * @lcpa_regulator: Pointer to hold the regulator for the esram bank for lcla.
> > + * @lcla_dev: SRAM device for the ESRAM bank used by LCLA.
> > + * @lcla_link: Device link to keep system PM ordered against LCLA.
> >   * @phy_res: Vector containing all physical channels.
> >   * @lcla_pool: lcla pool settings and data.
> >   * @lcpa_base: The virtual mapped address of LCPA.
> > @@ -606,7 +609,8 @@ struct d40_base {
> >         struct d40_chan                 **lookup_log_chans;
> >         struct d40_chan                 **lookup_phy_chans;
> >         struct stedma40_platform_data    *plat_data;
> > -       struct regulator                 *lcpa_regulator;
> > +       struct device                    *lcla_dev;
> > +       struct device_link               *lcla_link;
> >         /* Physical half channels */
> >         struct d40_phy_res               *phy_res;
> >         struct d40_lcla_pool              lcla_pool;
> > @@ -628,6 +632,36 @@ static struct device *chan2dev(struct d40_chan *d40c)
> >         return &d40c->chan.dev->device;
> >  }
> >
> > +static void d40_transfer_runtime_get(struct d40_base *base)
> > +{
> > +       pm_runtime_get_sync(base->dev);
> > +}
> > +
> > +static int d40_lcla_runtime_get(struct d40_base *base)
> > +{
> > +       if (!base->lcla_dev)
> > +               return 0;
> > +
> > +       return pm_runtime_resume_and_get(base->lcla_dev);
> > +}
> > +
> > +static void d40_desc_lcla_runtime_put(struct d40_chan *d40c,
> > +                                     struct d40_desc *d40d)
> > +{
> > +       struct d40_base *base = d40c->base;
> > +
> > +       if (!d40d->lcla_pm_active)
> > +               return;
> > +
> > +       d40d->lcla_pm_active = false;
> > +       pm_runtime_put(base->lcla_dev);
> > +}
> > +
> > +static void d40_transfer_runtime_put(struct d40_base *base)
> > +{
> > +       pm_runtime_put_autosuspend(base->dev);
> > +}
> > +
> >  static bool chan_is_physical(struct d40_chan *chan)
> >  {
> >         return chan->log_num == D40_PHY_CHAN;
> > @@ -818,6 +852,7 @@ static void d40_desc_free(struct d40_chan *d40c, struct d40_desc *d40d)
> >
> >         d40_pool_lli_free(d40c, d40d);
> >         d40_lcla_free_all(d40c, d40d);
> > +       d40_desc_lcla_runtime_put(d40c, d40d);
> >         kmem_cache_free(d40c->base->desc_slab, d40d);
> >  }
> >
> > @@ -1516,7 +1551,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
> >         if (d40d != NULL) {
> >                 if (!d40c->busy) {
> >                         d40c->busy = true;
> > -                       pm_runtime_get_sync(d40c->base->dev);
> > +                       d40_transfer_runtime_get(d40c->base);
> >                 }
> >
> >                 /* Remove from queue */
> > @@ -1535,6 +1570,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
> >                         d40_desc_remove(d40d);
> >                         d40_desc_free(d40c, d40d);
> >                         d40c->busy = false;
> > +                       d40_transfer_runtime_put(d40c->base);
> >                         return ERR_PTR(err);
> >                 }
> >         }
> > @@ -1583,7 +1619,7 @@ static void dma_tc_handle(struct d40_chan *d40c)
> >                 if (d40_queue_start(d40c) == NULL) {
> >                         d40c->busy = false;
> >
> > -                       pm_runtime_put_autosuspend(d40c->base->dev);
> > +                       d40_transfer_runtime_put(d40c->base);
> >                 }
> >
> >                 d40_desc_remove(d40d);
> > @@ -1637,6 +1673,7 @@ static void dma_tasklet(struct tasklet_struct *t)
> >                 } else if (!d40d->is_in_client_list) {
> >                         d40_desc_remove(d40d);
> >                         d40_lcla_free_all(d40c, d40d);
> > +                       d40_desc_lcla_runtime_put(d40c, d40d);
> >                         list_add_tail(&d40d->node, &d40c->client);
> >                         d40d->is_in_client_list = true;
> >                 }
> > @@ -2067,7 +2104,7 @@ static int d40_free_dma(struct d40_chan *d40c)
> >                 d40c->base->lookup_phy_chans[phy->num] = NULL;
> >
> >         if (d40c->busy)
> > -               pm_runtime_put_autosuspend(d40c->base->dev);
> > +               d40_transfer_runtime_put(d40c->base);
> >
> >         d40c->busy = false;
> >         d40c->phy_chan = NULL;
> > @@ -2246,6 +2283,7 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
> >         dma_addr_t dst_dev_addr;
> >         struct d40_desc *desc;
> >         unsigned long flags;
> > +       bool got_lcla_pm = false;
> >         int ret;
> >
> >         if (!chan->phy_chan) {
> > @@ -2255,11 +2293,20 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
> >
> >         d40_set_runtime_config_write(dchan, &chan->slave_config, direction);
> >
> > +       ret = d40_lcla_runtime_get(chan->base);
> > +       if (ret) {
> > +               chan_err(chan, "Failed to enable LCLA power domain\n");
> > +               return NULL;
> > +       }
> > +       got_lcla_pm = !!chan->base->lcla_dev;
> > +
> >         spin_lock_irqsave(&chan->lock, flags);
> >
> >         desc = d40_prep_desc(chan, sg_src, sg_len, dma_flags);
> >         if (desc == NULL)
> >                 goto unlock;
> > +       desc->lcla_pm_active = got_lcla_pm;
> > +       got_lcla_pm = false;
> >
> >         if (sg_next(&sg_src[sg_len - 1]) == sg_src)
> >                 desc->cyclic = true;
> > @@ -2297,6 +2344,8 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
> >         d40_desc_free(chan, desc);
> >   unlock:
> >         spin_unlock_irqrestore(&chan->lock, flags);
> > +       if (got_lcla_pm)
> > +               pm_runtime_put(chan->base->lcla_dev);
> >         return NULL;
> >  }
> >
> > @@ -2628,7 +2677,7 @@ static int d40_terminate_all(struct dma_chan *chan)
> >         d40_term_all(d40c);
> >         pm_runtime_put_autosuspend(d40c->base->dev);
> >         if (d40c->busy)
> > -               pm_runtime_put_autosuspend(d40c->base->dev);
> > +               d40_transfer_runtime_put(d40c->base);
> >         d40c->busy = false;
> >
> >         spin_unlock_irqrestore(&d40c->lock, flags);
> > @@ -2931,29 +2980,11 @@ static int __init d40_dmaengine_init(struct d40_base *base,
> >  #ifdef CONFIG_PM_SLEEP
> >  static int dma40_suspend(struct device *dev)
> >  {
> > -       struct d40_base *base = dev_get_drvdata(dev);
> > -       int ret;
> > -
> > -       ret = pm_runtime_force_suspend(dev);
> > -       if (ret)
> > -               return ret;
> > -
> > -       if (base->lcpa_regulator)
> > -               ret = regulator_disable(base->lcpa_regulator);
> > -       return ret;
> > +       return pm_runtime_force_suspend(dev);
> >  }
> >
> >  static int dma40_resume(struct device *dev)
> >  {
> > -       struct d40_base *base = dev_get_drvdata(dev);
> > -       int ret = 0;
> > -
> > -       if (base->lcpa_regulator) {
> > -               ret = regulator_enable(base->lcpa_regulator);
> > -               if (ret)
> > -                       return ret;
> > -       }
> > -
> >         return pm_runtime_force_resume(dev);
> >  }
> >  #endif
> > @@ -3509,7 +3540,10 @@ static int __init d40_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct device_node *np = pdev->dev.of_node;
> >         struct device_node *np_lcpa;
> > +       struct device_node *np_lcla;
> > +       struct device_node *np_lcla_parent;
> >         struct d40_base *base;
> > +       struct platform_device *lcla_pdev;
> >         struct resource *res;
> >         struct resource res_lcpa;
> >         int num_reserved_chans;
> > @@ -3610,21 +3644,32 @@ static int __init d40_probe(struct platform_device *pdev)
> >         irq_requested = true;
> >
> >         if (base->plat_data->use_esram_lcla) {
> > +               np_lcla = of_parse_phandle(np, "sram", 1);
> > +               if (!np_lcla) {
> > +                       dev_err(dev, "no LCLA SRAM node\n");
> > +                       ret = -EINVAL;
> > +                       goto destroy_cache;
> > +               }
> >
> > -               base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
> > -               if (IS_ERR(base->lcpa_regulator)) {
> > -                       d40_err(dev, "Failed to get lcpa_regulator\n");
> > -                       ret = PTR_ERR(base->lcpa_regulator);
> > -                       base->lcpa_regulator = NULL;
> > +               np_lcla_parent = of_get_parent(np_lcla);
> > +               of_node_put(np_lcla);
> > +               if (!np_lcla_parent) {
> > +                       dev_err(dev, "no LCLA SRAM parent node\n");
> > +                       ret = -EINVAL;
> >                         goto destroy_cache;
> >                 }
> >
> > -               ret = regulator_enable(base->lcpa_regulator);
> > -               if (ret) {
> > -                       d40_err(dev,
> > -                               "Failed to enable lcpa_regulator\n");
> > -                       regulator_put(base->lcpa_regulator);
> > -                       base->lcpa_regulator = NULL;
> > +               lcla_pdev = of_find_device_by_node(np_lcla_parent);
> > +               of_node_put(np_lcla_parent);
> > +               if (!lcla_pdev) {
> > +                       ret = -EPROBE_DEFER;
> > +                       goto destroy_cache;
> > +               }
> > +               base->lcla_dev = &lcla_pdev->dev;
> > +               base->lcla_link = device_link_add(dev, base->lcla_dev,
> > +                                                 DL_FLAG_STATELESS);
> > +               if (!base->lcla_link) {
> > +                       ret = -ENODEV;
> >                         goto destroy_cache;
> >                 }
> >         }
> > @@ -3663,16 +3708,17 @@ static int __init d40_probe(struct platform_device *pdev)
> >                                  SZ_1K * base->num_phy_chans,
> >                                  DMA_TO_DEVICE);
> >
> > -       if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
> > +       if (!base->lcla_pool.base_unaligned && base->lcla_pool.base &&
> > +           base->lcla_pool.pages)
> >                 free_pages((unsigned long)base->lcla_pool.base,
> >                            base->lcla_pool.pages);
> >
> >         kfree(base->lcla_pool.base_unaligned);
> >
> > -       if (base->lcpa_regulator) {
> > -               regulator_disable(base->lcpa_regulator);
> > -               regulator_put(base->lcpa_regulator);
> > -       }
> > +       if (base->lcla_link)
> > +               device_link_del(base->lcla_link);
> > +       if (base->lcla_dev)
> > +               put_device(base->lcla_dev);
> >         if (irq_requested)
> >                 free_irq(base->irq, base);
> >         if (runtime_pm_enabled)
> >
> > --
> > 2.55.0
> >
