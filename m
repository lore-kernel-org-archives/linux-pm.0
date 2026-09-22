Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493B4119E0;
	Tue, 22 Sep 2026 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059888; cv=fail; b=Jwdeb/e06kJLVRjL7SqBzyzC75FK0KEEcru8wny+EZM19h6QstdsC4Mfo8p0eRh+Haiwl7hQkNONe7vRBZvhHnxWBOST5/8OKk/VV0VfLTU1Ddm591ht7RsCKeMn4G8KcIp+QDUPISEelQ8Wzpd5m2fcwjsJShSRh1pzGsPK4ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059888; c=relaxed/simple;
	bh=bsSYQUKTIvjnE28IT+xixpo4hBnsMvG+pC5ZLEWgBWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lcU4roTkUha8LlByJDdInfM9u97fgeHbmKR/0iAgNMg8l+PdBEbs5ur5lDauKhWJGICq0K72S5sUatjOmTJjTNJVPV7OtImA0y3Sv7lZXxUfo0HWDkSb/N7VxkED6DNS+Ym1gqpGfejw7r13CvryKeolns3DsdgQncAJS/eUQpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OHAfS2vI; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OHAfS2vI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkvJR3IYxDQkW/C9nwUlQFHCRVGWWuT9Fkb6Cnxaw4tdyJxebTz26/a44JUM4yD+ZcaP0uIk8n6Z9JOAmfm0OLIc6+1LBsIdqWnWVm8NsII5F8YytrkovlVJPOwr1sizykTCA1d7DVN4HhnerIFuaaR2FStRLdfRIhIvHFcmDv8bise4ZSQ3SVeI3xVgzsjzNGQIl/HYIJ5msphd1cQU1DWuTmuPzyoQRMp6t4/lqIfXnTM5lgrgpwHcCNPnOt354rwZGh2O68t/I206WXPhQsFCtCm2gPC1aJXLN20qbWvP9mZKBMb7XVReXVDTJ3025PdMqwm0d2H5JjPSLVpC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liw6i66DZH5UwWxLKbuYDE2fFTT2yzStWRfGiED287I=;
 b=IxrcTJqud0hwBnT9DQ1/7hPnAQiDSgHESI8zmPtbLvo0+1AIsDuq/u1uKCVVVMzxn92poY8JEn7ylaCgXjubETIVbWpRr9YoFM8dw4txCrS2f8b2kuccth9GrJFdYHnaK4WfKUeAONzOO/XRyWvBlA5PAXenpsFG6KxNHNGJRqDy5zMue64Xm/RnFmIeO2FQzcDIrQZbLPShTGBK6oDRhng+GTmSgOXZx1es+TjY3NsUmVP5VVeveuyfql+yGc86HM/WsArLvhjH8ELJtNPazUKuw+bM+rQaNwYqlYHyhztllhKE5/Wh16oPbdn8tbCHtpTJRnSnh7GHGxCZVXqw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liw6i66DZH5UwWxLKbuYDE2fFTT2yzStWRfGiED287I=;
 b=OHAfS2vIKDwtEsv+a3W0/+0rMmVk2NPsIU96Y1L7ocqmcDtF5CljuO590UHN+URi/80fwTXSj0Cpfzl9p5hRnq+tmzB/JHqj4vP9w//hTGTeicanPxn7N1gZloxpwUpKgs7nTouEa+Da1+Kfd/tvuTnxNRfoGRykKcz34EcPDSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by DU0PR02MB10423.eurprd02.prod.outlook.com
 (2603:10a6:10:476::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 06:51:23 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::7e4e:c249:e481:d43]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::7e4e:c249:e481:d43%2]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 06:51:23 +0000
Date: Tue, 22 Sep 2026 08:51:21 +0200
From: Henrik Grimler <henrik.grimler@axis.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: battery: allow longer
 ocv-capacity tables
Message-ID: <20260922065121.GA70591@lap5cd525d1j1.sto.se.axis.com>
References: <20260918-rbrue-suez-upstreaming-battery-ocv-table-128-v1-1-f477ef39ef0d@gmail.com>
 <20260918082921.GA1515928@pc67698-2615.sto.se.axis.com>
 <fff86d6b-e4e6-4d90-8373-3ee32432807a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff86d6b-e4e6-4d90-8373-3ee32432807a@gmail.com>
X-ClientProxiedBy: MM0P280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::21) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|DU0PR02MB10423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b17fe5a-4318-4fa0-0cc0-08df1875ea04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	F2S0IDTGAmYLo0VAuek1Mh3Ye+SOFUBNXvZzd5kYP/N0l07pY1TZHyfghkoIdStiQBYtXBEvE1oAvmjSXvLkLfzpHwENoEa0TVxdF8Ab9lippiQIkQ7pMcugkreL23iKfbbV7GiWyYOoX7AHoepClgm5mDuMcJghWOcZfKpdSq5buliQoF9i6oQ1pMM6LLmsVw21+3+qKeDrNmQnMCG1r46eGk3BV9fys/duTI9rNUeBPos1atrHvuQuMyP+Ls/LSP3DY2nNNbsfyMgGL0J3fp953z7diaPiWa6ijFyj7PvEsqHS+AFavSO99Em9BilU8w7Tdg6Qz4DKgtv3OrKFl8sMifc5+nA7UZ9x0Wc9IMA2I1UyFoaI1q5fJGmPUkt1W4AITFBhvzL3tD7UYjowMyIvwoaTy0GdbD2yNCg0H71ix262qBKFgvCsdIl11a81ottzw755tN4ZsQBYz6LQlbReXMuniVzPAxwoIuTXxZNEab9INBTckFsU9NsuXGNGxF4HxcMmbcYS/hRad/9CIE9EH3TfEH4ZaxZmEAOrAiL2F2QemcMYPQhTBUwI8QBo8phwPIgIAL3+K+ZFfBNeNHhcTr0ui3f5BwLQFWi9P5Rd5lIE7epSMD/NdMmXB1l3CIw6K8sGdPJ8h5vNNIWeCat4uLqmVoynzu7Hf0QDols=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5mY+5okzxSBnSQN+HTaGKRTGEk2zl8EoAvoLqCb7ZP2FwPmMlQV/vHw6LcN8?=
 =?us-ascii?Q?fjeC2fZrLbQymnuv+Apwl8BEn7KJpyy0vH3nb2xjWf2HbGVraxp2TLtQx4Zw?=
 =?us-ascii?Q?O+vfZ7XbKEluK2nhBLZ9l03OHSjn9ZhDkv48EJVsTDzkAQiZrHSSdmczkNRW?=
 =?us-ascii?Q?EyyWZ0eHLqVYVq37/dWTfzUPMUIE0vdzr0ObM+z6SFAJNNedPDYZbQuVZY95?=
 =?us-ascii?Q?IrQZn4BdHU2nq7bTKQVzVkMscyA9UKzauohs4qVBiSPDn0fmcId8RZU5sUug?=
 =?us-ascii?Q?cMpptPDHi+jOqz8EY4oUUFlHOBgmM20SYXDXqhG2IorHH5ri8bCKHW98ZsiO?=
 =?us-ascii?Q?dXn7LqUgC0eFg2kJ1U00mhRw4i9p0QwyqWq52sJMpjcKdqI0EJcjhsih9OqY?=
 =?us-ascii?Q?YRyyDdM/xnfDzx4/3O7U2OOJLMhtGdeuIYz2suoI2xO3sMTiuns5QAD/yamq?=
 =?us-ascii?Q?+Pqi7XTWOjacoZAifDYOpKxCPlS6SpPf5V+JhzqdbouT5cdqoKVFB114gNag?=
 =?us-ascii?Q?JAXflmAGkyos6ObftaZbcJ9ZwNkkr+jhOaKAj2cli57j1fBGaz1E/E4HxxwX?=
 =?us-ascii?Q?FIeIrXn941c+m/EQl8X0rtgo8uvXmt/GiaAxY/oD6Eq/7iCB8t7iaFBfyKJf?=
 =?us-ascii?Q?lv0aiIOB6W0IftorE0gYeriRXsTOHG3zEDd6jGKytHku2CY+zBHgk/LeevnO?=
 =?us-ascii?Q?AnD2Wj4ffIE3HrC3ZUfLdjlyG0TfIKNcRePnW1LIjKpF/5P9O7aHFGmUHFIy?=
 =?us-ascii?Q?UuIgCOJw2vPfWetKz75nIncocPsjgqWWYrU6KkbUxP3Quk/wGdrD946cdP3r?=
 =?us-ascii?Q?pSZb4VpRW0f+QJ79pUXzik2ErU5CZG7C1Ht/NtH8y3sg8fjjkcZeOqKX/1YI?=
 =?us-ascii?Q?BQAWG1sJFtfse5CQTxmM8hdSPG4dNgTGbZ7SEs6Bm6mH8NLUW8ueNY5XzDGS?=
 =?us-ascii?Q?49tByYp2rou+2T/KJ9rjCBUyRF99LDRCb5SGf2ApKGA17q/UVnE/aJ5mERBQ?=
 =?us-ascii?Q?nVpBQjW3rXtDKFDmiXxDdM7Nsh95j1oO9EUmANkAYtO9QCBBgZwMF64BAAbJ?=
 =?us-ascii?Q?x2aQ4COxO3FO0agjzPo/Q0YgBHdgXipUgosNdaTR71mWJye1AuHEqhHfhsak?=
 =?us-ascii?Q?yJ5qjFfmadCxg2i4IOTjhPYt+eb5PxjfI7faktXT1U29Q5RwIyJjtmgjDFsS?=
 =?us-ascii?Q?YGyMdhnTcXsxE0I5ssy5hOLbpCkuhYRy8cBJH4d/UCImnLhpMOoqqa/qli/U?=
 =?us-ascii?Q?lIS0CVie1ToqzDpwF8wD7PYFPV1H5gc4rq8vePALm02gTB2LbOIRjzttLbuS?=
 =?us-ascii?Q?879HmCRsmSRN11O1y1xVwXFjZJNJ4oberbBy9DGpAJcI/NVj1S1ViHC0JYLp?=
 =?us-ascii?Q?mUuA4ELKucgpdwhJcI7FIg6eHybFg6EuCq8VlPR5OmajreJ1xw8eX845vTX2?=
 =?us-ascii?Q?xTgmUpKujUWwDwdIk1l7G2X+1RuJotPiFUua4VPiebke067ANn3mI7KE8PYo?=
 =?us-ascii?Q?/eI+marea6MZ4meLqFj2TaaIPSrfcvIUR0/wPbhqDzwxjrDcS7dETNAYAa9b?=
 =?us-ascii?Q?uZnxvgDmO3WTWXQq7mY+MWaUhlqU4odn6+yHNWYSowGEdjgAKL1ywOjJvNTR?=
 =?us-ascii?Q?xXMoyDEX0BaZVPZCTggatHOYqHMD5FIn9ODdrHsPJtjPqoRqnkYs+HVp0xJd?=
 =?us-ascii?Q?9AMuhE4unHHVIXewX57gBQTNFy8B9Uuhod3wBkJ44PKKwctu?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b17fe5a-4318-4fa0-0cc0-08df1875ea04
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 06:51:22.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhBOndodUun5X6FNUNgxGBchBsINwU/uxs/59ySuxg8/uvqtAykqIk2fwY3QD0MMG3Hp2iGc9+ODu9VLbK7Avw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10423

Hi Ryan,

On Sun, Sep 20, 2026 at 01:42:02AM -0500, Ryan Brue wrote:
> On 9/18/26 3:29 AM, Henrik Grimler wrote:
> > Hi Ryan,
> > 
> > On Fri, Sep 18, 2026 at 12:36:31AM -0500, Ryan Brue wrote:
> > > ocv-capacity-table-N has been capped at 100 points since battery.txt was
> > > converted to YAML, where the limit arrived without a stated reason.
> > > 
> > > The MT6397 fuel gauge is characterised per temperature by a table the
> > > Amazon Fire HD 10 (2017) vendor device tree carries with 126 points, of
> > > which 122 are expressible here - the remainder are greater than 100%
> > > discharged, so the binding excludes those points. Boards carrying this
> > > PMIC fuel gauge would need more than 100 points to describe the pack with
> > > the generic property. Raise the cap to 128.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> > > ---
> > > No kernel change goes with this. power_supply_get_battery_info() sizes each
> > > ocv-capacity-table-N from the property itself -- it reads the length with
> > > fwnode_property_count_u32() and devm_kcalloc()s that many entries -- so
> > > maxItems in the binding is the only cap on points per table.
> > > POWER_SUPPLY_OCV_TEMP_MAX bounds the number of tables, not their length.
> > > 
> > > The consumer that wants this is an MT6397 PMIC fuel gauge not yet posted;
> > > its pack is characterised at 126 points per temperature in the vendor's
> > > kernel (Amazon Fire OS, based on Linux 3.18), with 122 of those points
> > > being expressible with the generic property (the rest are greater than
> > > 100%).
> > Allowing for points > 100 % could make sense, but why would you need
> > 122 points up to 100 %? If the vendor kernel has several values at for
> > example 20 %, then a better solution is probably to take the average
> > of them.
> > 
> > I think only reason to have multiple values for the same percentage
> > would be if hysterersis (see for example this open-access article [1]
> > for discussion about hysteresis) is taken into account, i.e. having
> > one table for charge direction, and one table for discharge direction,
> > but I don't think any driver uses multiple tables to handle something
> > like that.
> > 
> > [1] https://doi.org/10.1038/s41598-019-51474-5
> > 
> > Best regards,
> > Henrik Grimler
> Hi Henrik,
> Yeah, you're right. To be honest, I didn't think about that, and should
> have.
> 
> On why there's so many points: the vendor's table isn't indexed by
> percentage at all. A row is a fixed 54 mAh step of charge - step_of_qmax,
> which the meter converts to mAh directly - and the percentage column is just
> that rounded, round(i * 54 * 100 / Qmax), which fits every row of all five
> tables exactly. At 0.85% per row about one in six repeats, so the duplicates
> carry nothing. I should also correct the figures I sent: 126/122 is a
> different cell in the same vendor file. This unit's tables are 120 points
> and none of the points are above 100% in this one.

I see, thanks for explaining.

> I don't need to model the vendor one to one. I measured what dropping
> resolution costs, and decimating to 100 points changes the capacity I report
> by at most 1% - so it fits the binding as it stands, and the justification I
> sent doesn't hold.

Interpolating the vendor table to fit 100 points would be the way to
go in my opinion.

> The only thing I can see still being worth raising is 101 rather than 128.
> Capacity percent is capped at 100, and 0..100 inclusive is 101 values, so if
> I'm not mistaken no board can express 1% granularity today if they have
> points at both 0 and 100. I'm not sure that's worth a patch on its own, so
> I'm fine dropping this, or doing a v2 allowing 101 values.

Changing the limit to 101, and adding a comment about why, sound good
to me!

> Best regards,
> Ryan Brue

Best regards,
Henrik Grimler
