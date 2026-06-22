Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCB365A1D;
	Mon, 22 Jun 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120523; cv=fail; b=qfxBEgQXqtPYmu0bhmpYqzTb/deqmSggIgMrog91kndon8EVtFEVHB8VG7k0lfnGp0uF3AzOGj+7wiN8HfV3K5gMjtbspgzySe9SwrmTaXX+Dwk6bAdCRzECufBNRECYULjCXkOrTGKYSuepkCcCwfq7P/oAg78C0cSl5Ke9lts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120523; c=relaxed/simple;
	bh=gJ2jvEbsYmWtIfBlkm76sPZL2CrO8SswZYQOAFlQexQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BncDVU8of6qEvJ+W7uxX+40uofbyc1RB38pZQswkVLI0N7T31Ma/dKWC0ns64+8OzLuD04bnE9UWFBUOhPH//DaAMSBjo3p1+xbF5NAqkOmmZAY2s7JFY98iGGdC7ylHyNN6d+naFIL1e6SBOIFVr/fjsWvecG1W1l++uPB1R/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qtK+Jm/E; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qtK+Jm/E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5w1TEMTa+Omwo8CGBuJnFcwQfCPdWPulmQ3eEGpLKSYsxh+iF3i+Wb562xOJKDNxTyI/PUc3QYjZ4BaETRWJ6OJWORTVPcUoRw/wLANq7zQImucIzmmYpXgJR8eC+SROI5wLWbw8hiOuOJzLahpMaJL8xg4pzFq+RJtc95AIIJZMYpZyS75ChA0XWm6cgxae9fREvOmnvHyRo2SXnshf/iB6GWQKt8VlZETBCyIzpWAmEz5EX3ZxxDZQ+dLoBR1kHZHPVQwRimfoDfKrHtDeB+fsFfWBPDqIr6f3MupGve2ZcD3xc9CAFDshwM/jYZhuu0jA6IZdNzjLKMmN57k8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJ2jvEbsYmWtIfBlkm76sPZL2CrO8SswZYQOAFlQexQ=;
 b=oxEddPysciZIK0+NSfrvD40AMO/j9wVrFRvS5H7vj2r7fKHdxMrgn4mFrD0EKrfTHeydEqw8curctd6KN8Zbx6Xdw+PxwgmDM48d/c+QGSdausMHlzy/mEFMDkST/BRT2goj7eG7wOByG2HrOrajabxRLBOmDnO8f4a/FmWJvrR5ZQCSYmdBEdSUGvS4y1qvJPf2R3TzZY04WbTLxfA2FBTHjjg1Lc5H9Nk/lc2eABLnpETGTk8uFmdcT8z5HGdtstFg0Y0ZtQXEUgs2t8NI9SoeloM7KwSEwNeNvJ4Gvdy8rV26HnVpbfrg8P916WHDK7cZlra22gm30sgallbhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ2jvEbsYmWtIfBlkm76sPZL2CrO8SswZYQOAFlQexQ=;
 b=qtK+Jm/EpTH6mR4gmey0nG1Ad9b4bkZb0OurRyVpSTnrtOfv+qbjWNGmMiziWBl7uDOeQu5MMI25jiL+/mtdQFgLoJQ0GRaqpqDFkb7BOLlML7FY6XGYsh2BPED6Yu4AayzkxeIi00WiiwlunPAZG2Em+MKg3y4Ug0DVJbCAiubYFot3Eo9wjpG9QZqov7EHIz0aJcUf8oCwQzYiS2yJkQ/drxbFxNl4g2LH7LgbZEgL5gjyHkyjZzzsD0R0H/QQPjNNz4Ymb4IBcFAEicmrY80rpq5r6zuuhFN9FpuHXyDA2OXgwQGcXebbD5HiZwvorpVuvAGzOSLd2RQsRhMGdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 09:28:29 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 09:28:28 +0000
Message-ID: <f269fbc4-8b8f-4829-97bc-cf4cc9246aec@nvidia.com>
Date: Mon, 22 Jun 2026 14:58:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Pierre Gondois <pierre.gondois@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, mario.limonciello@amd.com, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260527202550.206828-1-sumitg@nvidia.com>
 <eacc76aa-318c-4b41-b507-e91e322561de@nvidia.com>
 <oxw5k2wad4vorehgmrduoxblequy3ynqufwy4sruclnh5d5wrb@awzmfafoucnn>
 <35458c15-73b3-45f1-91fe-aa81d85a3efd@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <35458c15-73b3-45f1-91fe-aa81d85a3efd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ff68fe-2782-4bfd-a105-08ded0409e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|7416014|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	H4095Znneuxd1B4cNqsAu0RV7wtjpQRmrXChGRDHXSmeTszjYtUOD0RBt3ywfN5PzMPPw/gT2oP4PyYafS9wm762K7rtBrGlLzAjlz4rT5VxsgQsr9zKlHgRfNlHs3TXx60azz/JKN4pFF7GzNe/b8kpgJT0B7/ltu2zIbkYIYWMW2TQLTRIISB4IeTudwUY3BFn2frSYp8GBQ1e5vDSjkUOCpxs9sGCriVbOaoMCbrGcSBBqvuKFw909yfdZBspacFOv1AXAUwWx97qbRLr1r4s65pe4foVmyXOhzDNTAeHladwWqvUJwdyWHKMSX6BXzBLE8DA/0NzcpYzswFXkiQytinegivuL7hp55cnMbLt+snNEo12pg0U84qNymb55b/oo7mNjeUlpAvK6DbkOXwnYPOoqHWp1gWHZsgrNHMZlFCjqo7oYBWQKF9CwVoMvXUYERXNKdQCSXAfR29FHU56euN75fHPFBFoBBghLz0c51zTOmovBFzqIf6rQ5xpbYHhX55J4/tIwVCNjqgnhti+K0BBeybXh8FfQBtpeT6TuBGwG1tHQtnurJPg3v5FASBMfu4B3wWybIDP70+Kht7rgp6u9HbOmtxWUfewpNTM/nnwp7qmrEjzlHMO9GKMDqmjHtyUirX8Wakhb2qzxZqtsK7FZZ3sTtIw6TugXTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(7416014)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVBra2xqR1Bud2xmRnkyS0RFOTFiZndaTHVhUWFVSGJLdGRMa2FlSWdSdjVF?=
 =?utf-8?B?TE8xdHdzOW1xYVM1ckJoRUJhVmJFNncyVjNCdkVzWjNCSkh3MUJjei9pYTc3?=
 =?utf-8?B?YzBFVkZQNzVtS2xxVk56OUZqYXFxTE1sdVRjd0lPZzV3ZjJ1R3IrZ3hkeGhJ?=
 =?utf-8?B?dm1lL0JIbi9tVythY0M2aXRVTi9zTzlLWTlsZFRBQ3lpUjVXVS9zak5HRlNB?=
 =?utf-8?B?MjRZcFFHZ1ZFak9iaGJUSWNVcTVpcUg4TUlEOTNVdjVpRm4rRXBpU1FlZjJP?=
 =?utf-8?B?UlVLVHNWSXFmeUMySzRGU2ZSRDBDQUlHdUhDRVNmZ09Mc3FpN1lnV3pSRVRD?=
 =?utf-8?B?WW5sQ25NdTVEZG8yMmlzazlITUM1QUsxQk5pTVpXQ2xNa2R5Z2ltZTYycEFF?=
 =?utf-8?B?NzdsTmNlTFdsUVo3QUNraWdRVklXYjBiRWVXQTlGYjFyTG5oNGRYM0F6eVRK?=
 =?utf-8?B?U3VsQ0VrVGdwRGFvR0RsVFpRWWpCcWdJY01IcFVueGx0NXA2aDBFbFFRK3Bs?=
 =?utf-8?B?MDZqMEpEalBwOEU3bXVQV09Ock5vRkVCblI1VHQ2dW1tUjJRZFZLZXZBWFpW?=
 =?utf-8?B?aWs5L2FIdnE2VlFkRjU0eFMvTDRoWi9VWmxCSmRZL0NiMmM4UkFFTHJMQnBX?=
 =?utf-8?B?dUdGeXI1eVo0SDVDaVIwQmhSUjh6UXJlQy9HbkhCQ21WSTZTMGU5UDV6ck1t?=
 =?utf-8?B?aG9tYk1MWjNNUEFQd2VzNHRlZnNMdGhMZ1huYzNPY1d6UVYwUE95cGNnUERx?=
 =?utf-8?B?NnFDVXdMZ2JhS0hMRjV2WGI1cnlzdXNrc1VoUmlPRm5oeTZXRFRjaGV3Rm9X?=
 =?utf-8?B?OS8weDNYWC8yVlNIVEthaVltYmRRYnBhdHRkZlhCd1ZnZEZxdSttV0FRM2Vi?=
 =?utf-8?B?aEt5bEJUOVpYSnF2OFZ4Z2pjWTFDRlNDRmo3S2NKOEp5OVJpMmYzOEtQOHBG?=
 =?utf-8?B?bC9JT042bWtDUVFDdDE0WXpXUXl0VFlBUWU1TzYrQ3hqYmQ3VElhOUpLVGp1?=
 =?utf-8?B?MVpvQ1BKR3ZHQUYwSW5rNmFPdFowd2FJK0ROc1U1NWl3ZDdQaTc4TlhaSU9y?=
 =?utf-8?B?YnVsQ1dyeXJNNytwMjB6V011UUFJZ05iTXRMZ1VzTHFVNnp2YmFscUhtblZK?=
 =?utf-8?B?QU1NL29FRkxKaUxITlVYVlBXQTVYNi9iaXVZS1VUdzFrZzdDR3hVZHE2SllW?=
 =?utf-8?B?ZG9pZnk5ZkdMRmlHaE10aStIakdmekh2anJodkJJN1l1TVNtS1hZbWpzV1lz?=
 =?utf-8?B?aFhJbFM5VFVPbTc0bmtQSjNyTEcrRThsRnpZd3RSRkFXZGhpTzNwN21BZjBP?=
 =?utf-8?B?WmxKV2JBdzljeFFDU1F1RndWZFRYcVBrdzhDUXRXNHRiei9EckZraS9IQjNH?=
 =?utf-8?B?Z1hxa3J3S1FCbXZLVTJPTVZodk9vN3h6WUwxNjVjREJTY3hZWjZRODRwQlgz?=
 =?utf-8?B?cGxybGZwRmlvblgxQmxKZ3J5Qys0T2RWY0NOUjRDeDJabUxrdloyZGgzbE1C?=
 =?utf-8?B?d3NlOW5IN0lnWFc4TDkxM0JCTmY5V1Y1eWloNk1IdDZMR1hNd05OemhDaG1h?=
 =?utf-8?B?cHV1bDEraXRhOFQzek1tdDlRQXFuRlJpNXVsRnAxeW1PM1hmOWxWMThmS2Fo?=
 =?utf-8?B?eVR0bUtrK1dFeDBseUtkREtvZkNXUHlaYkM5NDdUa2lGNEZEb1o4Z0Q2YjFs?=
 =?utf-8?B?dFNPL09iTTRiOGdOQXRYNVNQaVl0S0FRVDhsZEgzSUdGTityS2gybjAwTlI0?=
 =?utf-8?B?aXAvU29ZdW1DNGg3YlNMUERqVS9GSFVqL3ZKdWY4SXBkNXNjWXMzcjJCR1o1?=
 =?utf-8?B?SC9SY0xSWEVJYnFJbk9lUG1yUzBMRGt1S25oelMwWm9GbjBIcmxMa3lhYXR3?=
 =?utf-8?B?MksyQlVkSk1ZdHBoa05uekVPV05qSzlJV3EzeWlOejZkZFY3eGxHdEtMNlVh?=
 =?utf-8?B?b0RFbjJzTDRiNVpzQ1QvenNqbEZRUmtHeUtKYU5LeGJqNWZDbFcwK0JkZ004?=
 =?utf-8?B?VWpZYVdxZ05hQUpMZnhXcDFFREpIdThGeW5KczB4RFF6TGZ1S3ZPbm5KWEFy?=
 =?utf-8?B?dVBmYUdURElBeWZGMFB1SW44bzMxNm9WUlNiZHRaeDkwRDhseVpQSmNGL2o0?=
 =?utf-8?B?T1o0V0hoTlFNMnVwMEtDLzhQcWpQckpNSjVIZ3BkNWk1eXNvY1VCWWp6emFw?=
 =?utf-8?B?dDg0elhpK09QaitXM1VUZWdFSmtEWDJiM1RlWVhPRDhDcEZubEJLaVlSM2hm?=
 =?utf-8?B?YThZYXlsMDE1ZXdFdzZudkRiQVJrMEZLS2lkMTdoYVgxM0FNcEpIQTVBQ04w?=
 =?utf-8?Q?11yxtfz75TlFkZ26cF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ff68fe-2782-4bfd-a105-08ded0409e38
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:28:28.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2oHeAM2PTtLDZc79fKFcrFuenopiJIlV0Y7ANUfwruP1/QEX2Hk/cV3BzlZIq28F+am5Zd6i6px+OrFm65iaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559


On 19/06/26 14:59, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/18/26 07:28, Viresh Kumar wrote:
>> On 16-06-26, 18:22, Sumit Gupta wrote:
>>> The dependency it was waiting on, the "cpufreq: Set policy->min and
>>> max as real QoS constraints" series, is now in linux-pm (linux-next).
>>> I rebased on top and verified autonomous mode works as expected, and
>>> it applies cleanly on the current linux-next.
>>>
>>> The [1] reference in patch 2/2 points to v2 of that series; the merged
>>> version is v3 [2].
>>>
>>> If there are no further comments, please consider acking and queuing
>>> this for the next cycle.
>> I was waiting for CPPC reviewers to provide some feedback.i
>>
>> Jie / Lifeng / Pierre ?
>>
> I think the patchset has the same issue described at:
>
> https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
>
> I don't know if this is important to other persons,
> but IMO it would be preferable to have a solution to this issue
> before adding more functionalities relying on registers that are left
> in an unknown state.
>
> If there are any other opinion ?
>

The concern is valid, but this isn't a new gap. The registers the boot
parameter programs are already writable via existing sysfs:
  - auto_sel via auto_select
  - EPP via energy_performance_preference_val
So userspace can already leave these in a non-default state across
unload / CPU hotplug in mainline. The boot parameter just sets the
same registers at boot via the same paths.

I am already working on the save/restore change we discussed on
the ospm_nominal_perf thread, as a dedicated follow-up grouping
all OSPM-set registers (ospm_nominal_perf, auto_sel, EPP) together.
I think doing it once uniformly is cleaner.

Both features are already under review, so my preference is to take
them first and add the save/restore on top, rather than merging it
first and respinning both features under it. Either order works for me
if you and the maintainers prefer infra-first.

Thanks,
Sumit


