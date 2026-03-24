Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD37366DA4;
	Tue, 24 Mar 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346270; cv=fail; b=LkNVRpOC/0LOXxry+1TXIviRSsWY+J4hHEYsnvlyR4Vjxy63l7B3UIeAl3WZt12u37nmtHOtZSj9VKTQGFbHQlESMK1TtdbxeBaMK4eRH8Bs1Cxh8EBwJsfLvKBxg3gGD9buXqYTLhOKuhD6v3bf8XAF4sZ3yB12FDYlNT58NVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346270; c=relaxed/simple;
	bh=pMthKowm7Ar9kyVkTCj1X3giSLQvuO1hU6x80UhZuGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GuGOu7eC+HiPVHMfoqZkk9pVKQNte4HfQxDIusw9a2zxjMdpSTj3It3V9eXVJb3K4kBKCPdHd3BFgVLS8JNR1av1o+3PV32Ep/o19bzQAc1W4Xn0bquI4s4pZmTALRP4lWbOcjnTwBAFZJe+M5KhhNRoc2o1eJSZXwRKjvt9y+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jFV8jhK6; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jFV8jhK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYzvspiRWjzVw2uEiBkovYkbwOQj/z6HE6DSczjEEMDJjbu0r26WHn0qOPpqyNlK7/hFdlFBsvOdU6TG3fEH1r7jtcYJ4m7UnJCSA76zy7rnmTEQX14RVF3Yl98I2vU/gPZwG9VVURP50MMMBskijkz1o0KC3AaYiP0fz/dS2D+2vFasltt3gDjkHcNBQuGYTnQq565b2P8FyCjNgFdPrilRWTIZdDzt7ytumS6IlNWEzATxXr2KaC3MVs7EYUr2bDCcehxQdh3SKnxkjuYlBTFglMMkmxFqGLsddl8UWSNzbvJzfKqUQxk0e5o2UB80AxsiA4mslfWImN86PXXtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3iRgfEVpz/BmUop3OMSk9fpPNTeJ21WDeTmFp9KOHg=;
 b=n3P+Zm3iNI68OL1jzX9212l2gkD2EjrF4mKiJakeY8BIh+xaO7XRdk6R4CuPs4X+Ps5b/KEEPwOj8pumcNgFBsH0ZcHrTwYDpFWhkZbb/A4eYoEWSq7iWWDEHUyalmfT5fv2mZkjiiVJEo0gptNpXaXVIsHVZsPmrd2VSYXfxmTCG3JHHJBNmIloYq7PwiWwQxVixgfTpJ+GLeQzvwuuDcxThvIkgBj21PdoJFp4Jod4hCxsn0XTwAuViSpn6InCXW/DxuupZdr6mSMs9fbgFNpAPpmGu7++NLZY4yeSRH4oZ/APxNaQjtkbJBqwSiLlKiQz0cIiLRSFA39PzNQtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3iRgfEVpz/BmUop3OMSk9fpPNTeJ21WDeTmFp9KOHg=;
 b=jFV8jhK692EappJ5m+e2kDINk+dT7CEnljR7TQLdA2Xun/pFU6asEDk91r+RP321I/G6E/JVzHg6IwLE3P8tXof0wlPNkj1aejzqITDlRtPM7aEqKp1cpObufa4Bv/zVyFR6AAxATdEgMJkVNnI/LSYGsFjMFGKxU+NYpQVdyT5P/lgye3lcRBmGOXspNczRAGkMz8gRFrZY4oBup7CO0fEektZtK13oRjnrFAvmON2nJDOyzDHC6UPf1q0kzX58d8GwuWmRkdM7jXRADK8tzm3otrymTQ71CalQW1IjdYIoflPpVgdtef/6Jo17KXklC5YRBI7k//J/fVLhdVB8Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 09:57:32 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 09:57:35 +0000
Message-ID: <cd3400ce-295e-450f-b650-6715142ccbde@nxp.com>
Date: Tue, 24 Mar 2026 12:00:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: st: spear: fix dtbs warning on spear
 thermal sensor
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 vireshk@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
References: <20260323133814.14152-1-krishnagopi487@gmail.com>
 <20260323133814.14152-3-krishnagopi487@gmail.com>
 <20260324-smoky-radical-hyrax-1274a9@quoll>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20260324-smoky-radical-hyrax-1274a9@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: a416b40c-91b0-4d5e-9cb5-08de898bc617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	10XH6E/eo2o2iRafIfklVe4JLaJdVeZT3CDC9c4vvPnqecdgH4vJJ1k3TbD5ciUYtaZmsW0h5e07Q23mcnzd+XggwtbmO3Jrnvwu10sVc3kitMQFdKqtcs7LZiXHKSpuS1CoQkvBoIuYyZJ4TGmAW8AzJBEKaTGWl5u7+fLWTavuXppNz3O/IuVpdAjD7IFfRD/OngNCXlcQw+7GgZDCmRTRr7scDL2LutuijHNcWzEpFKV9XmARorykU+70SzQwMtJNEbr05BGm3RQ3EE8f+ZWuXnUHp1+RY0UWF/+C4/ASAN678/xaDn9CdL4LxznXRwX+h1oBO+s6hEUV4W+CNprT5aS9zJCh/cHPiCmqqFNyMbWk4jlCu4aMw4K3LyI9XcSLBOt7mSwjUVC0IIR06XQ1gw6axKaQVS3E6fHp4X5JECQG8hvrt98QnJIBX+IjGQFZIoBNDto7YxA+yPiqM2nL+lP9AM+QjB3HzIjR7faadvx0yyMbAmcBGNfVa6LEeKaJNKGmyFRlfPdljbU35M7023IisEzTVJQVnosxdb8oybU83MBxyPeIFn/hv1QsqeUs0NlpKY0giO6wKfZ8+QpJs3VfAIiaRdzWOvoyH8E3YnZcPRK8nwfoc4rL8Xw7JcAiT0qbeGmCbYPdHCmFeqlSdymnMgKdj93O3qtEjhsM9pVqILVse4jbaEnOouHtB7DAHbHlkDsofa/95zQbh6l4zYdiVJ35kpJOx4DVkLxLNU5NgZbJSp9NjGudqfvt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGRFWTJJUnErUVdxbjlZSVhQc2lhdUE1VmwrQUptNitFTkFmV0pjU2x1WEFU?=
 =?utf-8?B?QW04cFo1ZkV5ak1XcEhEYXY5dVJncG94NERGczY0M0dVdWlXMDNHMk8rR01U?=
 =?utf-8?B?QVIyMml4YVdFSWdjYUp4dzFyUXZnZ1VlbDV5N3d5Q3Vkc1VZT2djMVVoUzhh?=
 =?utf-8?B?VjBBUER1WHROQ1ZYQzZyYndoSWtvemdjRlV3RFg4N2VUVmNtWG4yMldtTTNZ?=
 =?utf-8?B?T2VaRHFpbzUxclVuVzhTK3BPYjdFY1NVY2E3VVArVUsycVZoUEV0OWtXcFpi?=
 =?utf-8?B?THN2Q3Jwdk5mMDltcU5CcEd4MFNHT0FmM0ZjbmU3NWxKYkx3OW81eE5OWjFT?=
 =?utf-8?B?UXFUN29WQ0g0b1VxR0FSbEdYNE1nQlF1UkE0YlBrQms3WE8vRkk2bUFidFdk?=
 =?utf-8?B?YkFQYU13ZEQ3b1R6ZndQZEg0Sk13YmJXVUpIODdlcHdtQmlZRS92bm5kTVBH?=
 =?utf-8?B?cWRMcTBrVjhFU3Z5V0lsR2ZPSzNrRm5UNEY5V3BGclRpejB3MDV5THhLcjNC?=
 =?utf-8?B?L0pvY2NjWDBncExvZHA5OU5yRnVOUHQzMkU1VGlXUTJwaGpIeUcwbTJsNnNk?=
 =?utf-8?B?N0N6VXdOVkYyMjZhWDlaR2E2c0FHOVpDQXBnT3E3WVBvZ3JGZk9GV25jc25R?=
 =?utf-8?B?NWZNcko4dTNyZS9zUklWVmJXOXI3T1FXTDJjVGxrUVFBYXRVb2VoZ1hTUDlV?=
 =?utf-8?B?RkZFQzlOczYzUGNQanJ1dHZCc2w5VXpra0FxTjhpWnFuMUJJSG5FU0d5dldI?=
 =?utf-8?B?YzFHOGZ0OU1Id2FzSENzWDloVm05TUZBb2hNR1UwcWZQRmtZM25FdnVGWnQz?=
 =?utf-8?B?eU03d0pzT1RxemVCTytwN0RRSjJvNFpsdHJrU3NmcWRYaXIwZysvdjVGdkNl?=
 =?utf-8?B?RFhhMHk4VnpqemJZb2dSZVQvSjNrT2pJSGJnNm9HQ3krTTZvMktsR0JrbVd5?=
 =?utf-8?B?Y2RnOFZINTZ3TFFEMnVJYnMxMzBIK05FL2J5b000MVRXVnJYZk1adks5UnBV?=
 =?utf-8?B?RUp4V29mK3J2eFRYUVZOaDB2cmo0MHMxY2VGNDhUUFBZdnVYNkVnL0IvRG9Q?=
 =?utf-8?B?ODlqQ25sTHM4Qlk1Y043MFJ1a2loYzdNdko1cWpoelVzbGZtUjZtTDFZWmoz?=
 =?utf-8?B?N3dXVjZmWTFSQ093VUtUYkdKVTFYMlh1MzhTMkpEM2pSUkxNVGc4YU44bWZj?=
 =?utf-8?B?TlB4SDhFTGpsWEZuTGt0d1gxd3JLdHo0ZEtrMEN0S0tCaHVnUjlJTnJSUmRJ?=
 =?utf-8?B?aEdYNEJmWDROdlBORThvKy91YWdCNHZFYXo2UWFoa2JmWGxUUFBBSHB4WjVS?=
 =?utf-8?B?L3FncVhsbG1WM2tnbE9XYzF4S3NwV0pQQ0hyUDZVcGRYMHNXSU94d3VMaXN5?=
 =?utf-8?B?QjAyMi9PNEpBYWMxL292dnZnR0N5Q2M2OERvbnhsTTVFSkpUL1RVN1RaeDV5?=
 =?utf-8?B?M2tzYlE0ZjNJM25jUmlJRTlXd0o2dC9mNkNiM3M0dWVsejJhQklETmVyWjF2?=
 =?utf-8?B?cXlmSTNvY0pPSVlRQlZNbjNjcUhUeXBWbWUrMkIyUkJueTVNZlJnYUZDbHRj?=
 =?utf-8?B?djlkcG1SQzFQK1VvdEZUcDd0ZWp0S1hLS3lNTy9pSkNOVCs5TEVxc1RDd2pP?=
 =?utf-8?B?WU02OCtraC9UbUhqNC9pd2RjY0FYUW9LUkhUYWs4S3FsNDhKQmw5WSt5Q1dh?=
 =?utf-8?B?TWUydmVyTHlzNi9HT2FPMWoxREx4MDdhZ3ExMDUrSzFhREJlWHU5ZGV4em56?=
 =?utf-8?B?UDVBd1d5REVyeVlVSlQ5eGUwUHh0cFRCRGp2cWZRRWljbkI5d0d2aUtFWEFK?=
 =?utf-8?B?UGNKWnpMa1V6bEk3Q0w0RXBZZGhESlBFc2x2blVQd3FPczk1amUvNjJxK1do?=
 =?utf-8?B?YXBwSFdBVWRyTjRrYjdKMGtCZkJnQzNOTmZzZkhxaGRqclRtOW8waFZiTC9T?=
 =?utf-8?B?UmlNbmFPSmo1QWNhWXFySjAvQzdGd2hKUlJLSm1ObUJuR29uLzZuSXI3WFhE?=
 =?utf-8?B?NEoyTzUxbXdJVDlKclp6ZWJ5Y3puSysrUHhTZFJiQlhLNEIvNUtmcmx6NWkx?=
 =?utf-8?B?UHg3aWR2TWlGZW9UMHU4b0xZNVMzL2w5WEdmcWhNRFdFOFk2V3Z3RnhiWEdH?=
 =?utf-8?B?T3dvU1pPalhwRnVWeE9EYTRKMUo1UGlHR1p1YkNZSUF1ZGhyWWVSMGdKWGtR?=
 =?utf-8?B?SGR2NFJ1SkZGMkx5WWtkc213RXJidHVaL1dIYy9URnVqbkJjUTFEenRzWm5B?=
 =?utf-8?B?QlRpRHcwSm5jTG9ST08rU0F6a1lHaFVWVjJwRDhCYmU5UndXVTNVWWplRjNL?=
 =?utf-8?B?T09RZTJVam91WHhaRFQrbGVSYlYyYTNDcGJjTGZlTHBYUlRMclJMQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a416b40c-91b0-4d5e-9cb5-08de898bc617
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:57:35.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBgdj72qM1sTgldrgJdLJlzIu46K842nmxqg6/dWJBnc6XvON7WyVHnho8nsdxn7joZRDfk6ILpotNf/DEtWyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

On 3/24/26 11:26, Krzysztof Kozlowski wrote:
> On Mon, Mar 23, 2026 at 07:08:09PM +0530, Gopi Krishna Menon wrote:
>> Running DTBS checks on st/spear1340-evb.dtb results in the following
>> warning:
>>
>> thermal@e07008c4 (st,thermal-spear1340): Unevaluated properties are not allowed ('thermal_flags' was unexpected)
>>   from schema $id: http://devicetree.org/schemas/thermal/st,thermal-spear1340.yaml
> How is it possible if there is no such file?
>
> Did you just add new warning in patch #1 and then claim in patch #2 that
> you fix it?
>
> You completely miss the point why this change is needed: how could the
> DTS work before? It could not. And that should be your justification for
> the patch, with explanation why it could not work.

Correct me if I'm wrong but I think there was a hidden bug here 

drivers/thermal/spear_thermal.c:spear_thermal_probe:

      if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {
»       »       dev_err(&pdev->dev, "Failed: DT Pdata not passed\n");                                                                                                                         
»       »       return -EINVAL;
»       }

So, the driver was checking for the correct property as pointed by 

bindings/thermal/spear-thermal.txt but the dts was using the wrong

property name: arch/arm/boot/dts/st/spear13xx.dtsi » » » thermal@e07008c4 { » » » » compatible = "st,thermal-spear1340"; » » » » reg = <0xe07008c4 0x4>; » » » » thermal_flags = <0x7000>; » » » }; And because this check is wrong:

      if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {

people really didn't notice it.

The check should be:

      if (!np || of_property_read_u32(np, "st,thermal-flags", &val)) {
»       »       dev_err(&pdev->dev, "Failed: DT Pdata not passed\n");                                                                                                                         
»       »       return -EINVAL;
»       }

So, this actual patch has uncovered a bug! 


