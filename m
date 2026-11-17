Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794909128;
	b=d9uUDhvJEFXXax+5RPsNvfHWcZzKNGtqjsQ3o+pNpzU8calvYOJ9gzaXR+2sMNdWEdI+
	 qXZl4zBwnCFg+HsycL+PjsHA+7pnQE0pTv0tnipM5uFgUUCVG6QAxNUQ3BvAQ6CHnWa4g
	 FFoUdJNm5/1Med4gAJxxLVxMLhPDu4CpT58/8g0LVdxWzGHpih7OZRB7f6+I2rVCltuam
	 8nETMxQ5O+RvAXmUengMoUKtpDRlcffAriZh9f/gMLddeUavk6ZAj3xKnqtnZIzRr5JBb
	 c44L0CXKJE4VWKXoDlJHyJYby0HoCJMqnJO2j74TMy5dxIDsDl6nctdPZH9JkX6c7cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909128;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=1sBSmmCoLSGkQXjTG3B3v1LIX/FN9klYzV3UzhCeZVk=;
	b=AChUyOuPbnC4SZ6yMQhzMm3//okYPAOi3hDDHPEf1VA5xgWYIVr6y6h48NGUS5vUQ3i0
	 hggM3aQDFUQ1U0UzPC4fcM7AATgZZ49jHeO0cnv4SC4nha3gdnWQMLn/m+NtkEfQujVZy
	 cnLdaOWv3dnNFprptP3mb12KExiCAfCng2eUjvH6h3mKBulkyRAFxRNNxSAYfbAH2JGph
	 1HjZ2vcd0IziycxtWVJ6w/GQRB9YWbaDAkc1QCUiq2tuk2Yv2mBiW2C5xnbXpK5Ff5TDc
	 pNNPQ6BjX4/u6vsdYlGtraz+bwWWKSdeYx1Yn4Tkx2BAjpnIv4x+cm0ooVCN5DGemNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F01MeOJr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.38
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FFF606A323;
	Tue, 17 Nov 2026 09:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74FFF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F01MeOJr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utYpoSLMSmU12/g/4i2YgSw44ym99qs2t+/9+aLQtiWbgf8WxeHz/iW6EqtiVB5H0bMPZsOS/2ImFEfA7M9UJg9S7KHi5Z/sd2fQTSpgskldr7VTeq/egE6qQDMsykzj7lgvdERcg4zT6I4mWte/ENu0xpH2xh4MrpcU/B6qyAIpMkt1ZhBtfC79Wz37w4mkmdYXGFX/kIBxAyCZA6sJiOKN3sS76klS44TTcBnbs1jUAGEWXTpxJ1g1qixYKEz/8HUfU3KkRkyt3/icdprNo6zhplTC/Qtp/ZO+L/K3qJtVACJkmj/DSMXrX8ZbSoDj6nq2hYeze5bVLB1C3wR1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sBSmmCoLSGkQXjTG3B3v1LIX/FN9klYzV3UzhCeZVk=;
 b=Bhg5+kLZ4MjnebrHVgLGKxALdW3SwhAy/BVHtVEvrOTgRJJ9oAAjA+DiM1dB441pikkEeKW0M18QvKjyyhU4+wJuxiwA9melu6IRUl4izfev1YWs/pX4yEOXFvOzW9KSCCafoU043zFUvAeBs3P87MPqCiLVdndqqXqY6SK5E16wJp4pR+DdpEKCBmI726TzCriYKcLxmHCqrpBxHKeFk17W+nsTo5AWLL3a4EtgqyE9UVVLwvTjqgGClWM+y1oSntb8XFdHP0FuZmSfRPoF8XApd2SQ+vemw3WrFTGOjOrRVXrXl+3h8z/tGYl86sMDadcgvfHMa8AR73FD//mxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sBSmmCoLSGkQXjTG3B3v1LIX/FN9klYzV3UzhCeZVk=;
 b=F01MeOJrGTZCOKXk73ag9OmSQJ5f3ialNVj8n8+fD4kkTo5DD2cMvG6XRQqN8pl7Wu+Kv6u+/njDCIqOuxQE1kJsrVD7si/dKtraZnxSB9Vn92EmC7aI9vuV9wDass09vmpSrL5wVSa8WL08WHcHKr9nTYPhyK9yZqOb4juWui2exDxvxRBoI8DDjzbUjX1GvHHMn1WWDgDmIptGlLyDW+cgnE/MklxiAI+vj43M1wvbttHusa0Ju8pTXBj2X2OtA+HMOd7d2jiZLYY9sr5dX4aZEpJNplSJ7NETwHYgmldJtKb/3l3yKlZBVvwz0Hz9xwFFDkawfuu25nDWHYTBuQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 09:52:01 +0000
Received: from SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7]) by SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 09:52:01 +0000
Message-ID: <c2f8ef2e-cf8b-4b8e-8b13-819d4c2b68ed@nvidia.com>
Date: Tue, 17 Nov 2026 15:21:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] cpufreq: tegra194: add Tegra264 support
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com
References: <20261104181521.3003578-1-sumitg@nvidia.com>
 <904f7ac1-d488-4700-8839-ae981b04a71b@oss.qualcomm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <904f7ac1-d488-4700-8839-ae981b04a71b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0118.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::7) To SA1PR12MB5637.namprd12.prod.outlook.com
 (2603:10b6:806:228::13)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: a3aa9d42-283a-43c6-7eae-08df44906d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|921020|261102123227099003|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261009221227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rYqRxWy99zRRamxj8wv3+yz19sU7KUG8EBvFSTeVZwN9hqsNj4a1+Ybfjqz7s91+C+dAu7NqTSJXP5cFubAx2UvQeabaW71WCXswIyW4wWFcc5ZdoPWPDsIa9eopk3lnAea5vlK3YBlk9naPKgkf51WGyqfMjJt27fZYXwv4+yheH3rfY3jysbwSiQucilrGY/G6ehFyU7ORi7wcvrMq6tx1U6U3bTNuCXGO6M/YjKXgDc9wRdohhbWbL3LAmS2pOyzyQzgWqh3JHJrFlPeFfAucGk9mh4M6RUEBxLQjdJw3PdJt0+A5Jj1X0omUHm232dtnmjQRyRwP8ojRqsRhhcQ7L/+TXQpvYV57PIxHKg6FG9hu1VLnCC+eXBXEfqaRhxN7O01dNUKNA1l9upXnnZlmwdYlso60bxSJjiuptSkT9GmNkxatilX2fJUshASjVC6Oe2UouP7j03xP3lRdoj2rb2VNBW3msfd7q1ntQzTBqBZ49t3U+YHcpbd6i5uQ78FSAsreWDXyhgD6KlhKrD8OvMhXD+HhdhrFCc80lWVt7XQOA2+sVXXt8hD7i7vfPAQJNyUa+P8X4wfrwcCuEnziQoKn6WRR9IP4Z4+ew4vtoFNBlKHqJYwIehjC144EEvausYFfXOVHsBxfrCLBcYZPDmPOBVCzso5pLU8eRJh2OUADi40U1v0XcFQp2cOuhUdpla7yA57VlcQTm9iurA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(921020)(261102123227099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVdrbUROcitraGdWR29HQ3diUjFQa01ield6eE5xS1ExY21OK3hJYUQ0U0Zv?=
 =?utf-8?B?ZG1JTExSKzVLcFVNemhtcXU2TldSWHFKdzRsNFZ1SHJLSFBrdEhaNHFhY3pJ?=
 =?utf-8?B?eGFDOXFhUDBSMFVHREg2YnMvNjY5enlnVE1Gd3A3TVoxM1FKSmFRVTRmZ0Yr?=
 =?utf-8?B?djI1ckdwaWNzWE04bWJyekJoNmY5OThOcXFnWjBCV0NzME4rSWpBU0lrSGFK?=
 =?utf-8?B?TDRwdGxSZEh5K3h6T2NSbjZxeXI5bFJHMXdSOUpzWCtSRE5xZklPZEZCNDU4?=
 =?utf-8?B?RFczYXUza0h4QWpVZkh6Wko3c0E1NUUweWhyd1BVMDVWYUNlODcvelJlSU1C?=
 =?utf-8?B?MHlZSlhTRmZNSDkyNHNLWDRIbUpmWXYxOG9nNy9CK2x5VVZNQzJkZGZGaXhD?=
 =?utf-8?B?azB2REpGQlBVbVh2NDNZK1BpL2pFcHZ2clQwMysvSzBQUFJkTTdoN0F5NFgv?=
 =?utf-8?B?T0xSMzZZWEVrcWlDZVJIeUMxQ1lVd1Bjd1k1QS9uRC9zaG43VmZkN1Q4VkIz?=
 =?utf-8?B?VHVSTHBpN3dJcDZzQXJBbGRKdVUyTkRiNVRzOVZmQnJSQ21UWkRkU21KQjdL?=
 =?utf-8?B?YU9nRW5SMmhSbWR4Ykc4VWcxYytuVDBkNGw3TTh2RW15U0lrVjZucGFWeTJE?=
 =?utf-8?B?alVyWC9vU0VMck56THlLNmF2alRzQksvOEEvU3FtY3pENXVUK3RZUm9RVExT?=
 =?utf-8?B?UGptcno2RnllcmZlcmkwTWRoeGFEWVhXZFgvVkNJUno4cFpCd2RqSE9UN29S?=
 =?utf-8?B?K1FlU0Flb3crZHFNMW02RHBCblZ3RVBLVjRDRjVkbTlEN2NvSVRJRkVGU1Rp?=
 =?utf-8?B?eDB2d3pRTTJvT3R0MmUyL2JBSm5na2hyS2swOTFOZDVZbEhPaFpkRG80V3pB?=
 =?utf-8?B?R1hoMG91cTVGKzBQNlhFdXJSS0RRdHI5VDB3NVpWU095SnR5OVVLSS9MWlRq?=
 =?utf-8?B?WVd4OFlZdDRpdGRoTXg0cUxmYmIvRGJKNXpWM2EwNjR3MlpCbSsyb1hDOHll?=
 =?utf-8?B?eGwrNXBQZEpqR3FOTEVJU1p4NHFNQ2hUUkt4UDY5ajk3RkJUNU05dHh3WHZi?=
 =?utf-8?B?ZVlHUzJ5LzNwc1FNWWhGd2NoOTVwdXhWS3Nhdy9iT3AwNEJWUTJVaEFSUXRa?=
 =?utf-8?B?NUhmR1A1SWFrRHM1L0MyLzNMejZjdVB1dmZpNER5NCt0MEs3SlJuQnRldHYx?=
 =?utf-8?B?YzVaL2hKL1JETm9ia3VwYjB4U2h5L0VEMzQwZld5OFRwem8xRGZQcGwrN3hR?=
 =?utf-8?B?ekxFWmVxZXZTbk1GYUpPbENYRGQzQ2hOVzM5Qmpab1FXMUs1QkhMbXhQdXo2?=
 =?utf-8?B?RUIyL3dPS2x0MEtCUThNbnBhbnlKdVV5NE53dDB1T0d3MFRacU1hTUU0Rm15?=
 =?utf-8?B?Zy9KSG9obWRmMVpEMW4zT09nTkQ4Zk9Va3N1aWdYamNZaFlhalhacWkrT2Nn?=
 =?utf-8?B?YVVub2dZWjlqaVRKS1FEMm1iTlpTWUc4blJKaTRCaTh4bkE0QXhKQXkxVWlW?=
 =?utf-8?B?N2pIV1VjSzNubUJ2dHRQaVhQaDBUa0RCcDFmbEs1WktENEQ5NzVuNHh4TzlX?=
 =?utf-8?B?R2YwV3FPN25OcFhKUG52bUFKUjQ1bDI3Z0Q3NkJvWjRBczFHeS85QklUM2RG?=
 =?utf-8?B?aVVSaWd2M3BoMFJPeFJMVDhwOGJIWnYwNTJqSzdFZVlBWjdTZ1FTdHV4SHdM?=
 =?utf-8?B?Uk1NamJKUzdLNkZ4YnFiQ0xpM3RpbXppYjB0aS83VGF2STY0RTYrRWUwMFM1?=
 =?utf-8?B?SDNuYWx2L003OUN2NFhZbHA4RmhNZGdaa0V4OXlDbXFrbFB5ZjRET2cyeVZq?=
 =?utf-8?B?Rjg4RHBLbTByNzlmMEJRQVpCb1Q5Rlo4d2MxT0JoTmJKbmdiOW93SkxWNHIv?=
 =?utf-8?B?ZTZyRTd4ZCtZRXFraE55UTVoeHZ2SWRpbWh3bGo5RXN3MThkVUpNUjhuTGVE?=
 =?utf-8?B?QjZtYjdOMUkrdWxhbGhOcDI2enJoaFZZK3B4d21DSnZXSDc3RWIwb0dFTElp?=
 =?utf-8?B?QStuZlRpTERra0pFc3hFRFZNZUg3c2praDdZV3ZtREhGbnU1ckVNNlpKSWp1?=
 =?utf-8?B?SXg5SUhlS3NScnRnYVRTK3d6MlAvbHZwYkYvRGVmWW5JQVdvNW9QZWZNbjlB?=
 =?utf-8?B?UzgrWlplbUNPL2tKZTcxcVlMUjNqR1dmWGNsa3FYcCsycUh1b2kvMTY1Z2hh?=
 =?utf-8?B?MWp6a01YcU9LRzVkaHhDaUozdTd5MVYzYThJZVpXWndZcjVOWEJNUmdwSkdN?=
 =?utf-8?B?UlVoZ2JZdVhIVmZZM3dMdEpOcDRhY0lFdmdtZGp3NVVjZ1RRdmJTVWZYQVZV?=
 =?utf-8?B?K1ZCc2dWem43QXNIN2lvdXlJR1puZjdCZWNOM1Q3NS8zZ3dWNklGUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3aa9d42-283a-43c6-7eae-08df44906d75
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:52:01.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Coy/NLj6bd1Lr/X889EHvWIWWHqTO4WlfMB2eX+FW0cmR4S0FpCcmydbXmqlvZJAaHy3xyM1MrDS0tgQtRswRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

Hi Zhongqiu,

Thank you for the review.


On 13/11/26 11:56, Zhongqiu Han wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Sumit,
> 
> On 11/5/2026 2:15 AM, Sumit Gupta wrote:
>> This series adds cpufreq support for Tegra264, which joins the SoCs
>> already supported by the tegra194-cpufreq driver.
>>
>> Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
>> The driver derives the current frequency from the core clock and
>> reference counters.
>>
>> The main differences are:
>>   - Frequency read: through system registers, as on Tegra194, but from
>>     the 64-bit architected AMU counters. The reference counter ticks at
>>     the system counter rate (CNTFRQ).
>>
>>   - Frequency request: through MMIO, as on Tegra234. The driver writes
>>     NDIV to a core_freq_req register in the CCPLEX register space. Each
>>     register controls a cluster-clock unit shared by two single-CPU
>>     clusters, so both CPUs form one cpufreq policy.
>>
>> The patches fall into four groups:
>>   - Fix (patch 1): read each CPU's MPIDR from a CPU-hotplug callback
>>     instead of at probe. A CPU that is offline at probe then also gets
>>     valid cluster and core IDs.
>>
>>   - Preparation (patches 2 to 5): cleanups, mostly of the counter code,
>>     to make room for a 64-bit counter and for an MMIO mapping without
>>     ACTMON counters.
>>
>>   - Improvement (patches 6 and 7): group CPUs by the generic
>>     "performance-domains" property, which cluster-based grouping cannot
>>     express on Tegra264. Device trees without it keep the existing
>>     grouping.
>>
>>   - Tegra264 support (patches 8 and 9): the driver support, followed by
>>     the device tree changes it relies on.
>>
>> Patch 9 depends on "arm64: tegra: Fix address translation on Tegra264"
>> from Thierry's series [1]. Without it, the ccplex@30000000 node does not
>> translate to the CCPLEX registers.
>>
> 
> I have some inline comments. Please take a look.
> 
> Sashiko also has some feedback that may be worth checking:
> 
> https://sashiko.dev/#/patchset/20261104181521.3003578-1-sumitg%40nvidia.com
> 

I will address the findings on patches 1 and 7 in v2, with checks in
tegra194_get_speed(). The issue in patch 9 comes from applying it
without its dependency.

> 
> P1 and P8 don't apply on v7.4-rc2 / linux-next due to 4dd10fbbeb9c
> (devm_kmalloc_obj conversion). Could you rebase?
> 

Will do in v2.

Thanks,
Sumit

> 
>>
>> Sumit Gupta (9):
>>    cpufreq: tegra194: move MPIDR read to CPU hotplug callback
>>    cpufreq: tegra194: remove duplicate counter sampling loops
>>    cpufreq: tegra194: add tegra_counter_delta helper
>>    cpufreq: tegra194: add per-SoC counter mask
>>    cpufreq: tegra194: split MMIO mapping from ACTMON offset
>>    dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
>>    cpufreq: tegra194: derive frequency domain from device tree
>>    cpufreq: tegra194: Add support for Tegra264
>>    arm64: tegra: Add CCPLEX cluster node for Tegra264
>>
>>   .../tegra/nvidia,tegra-ccplex-cluster.yaml    |  27 +-
>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      |  21 +
>>   drivers/cpufreq/Kconfig.arm                   |   4 +-
>>   drivers/cpufreq/tegra194-cpufreq.c            | 422 +++++++++++++-----
>>   4 files changed, 357 insertions(+), 117 deletions(-)
>>
>> [1] https://lore.kernel.org/linux-tegra/20261030141101.845044-1- 
>> thierry.reding@kernel.org/
>>
> 
> 
> -- 
> Thx and BRs,
> Zhongqiu Han
> 

