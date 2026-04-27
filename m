Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57901F78E6;
	Mon, 27 Apr 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304006; cv=fail; b=i0Q4pVQDExwN3MOxLdyc+3dDxgs5UHxw3NJdouagQ1kgddAdcVKKoECqJONzyJyrsppljYR71NdLYNsifIur7YC65qfZ6GjNwlT0yHBRA25S6ByJ2I+8cDOa3JIsj450FYiDMnWN+iX/BcRzj+sswhb3VOObF1PQSiyLO4x2GC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304006; c=relaxed/simple;
	bh=KqJ0gj0n1FLtFTAG5GSfP0VaQDx9nxa0F/5S0uNmYOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YiPHxLus3p33uWXM46IL3clg0QtO15EFp05y0R1kLoSnWDhwX5KdAWbzn8FszXxhIqe7aqdBzuKfz8FcKi1Je2ICQBgnnRISJvvJGODMSq+/CRqmA2wgi9juWGbZI05fYvj2d+ULO65CY5Mmel6bijd9cOWAsiItmeixyedAxjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZCTTIga4; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZCTTIga4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4UQae/g7N4ubtBAVZV3p1nRxNXxet/Fh7/Wy27Elh2QuI91Nu5npc927KXFT7zoEwLDA7JCaNJ4GAtzKCFfwpzKHuQ7E3e/maHm64AC82ZMhFgNYiD7xB0d4b2YoaMHK8UxHQUPHfC8zhMDgK/e5xytqTcBSBTFSiFNh0h4jYQGbZbsZKgHOArY2PYbdbZvYevAHOO6b6KJpeLIYPpG0tThHjlc9wmykbXKhz7n0Y7AJ2vZqeWUOK7737OgirisNjOvc7LVMnJb5XC8BSaSlWuzX0sA3guDBbXMngczzas+41c9KLw5XwqLnP0iaGKiG0VWtF0LmNsgkm5h9BnMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWq/EqRUV08IvNjzbwJQpa70EUGjOK8cwa+TlLH+K20=;
 b=AhImKjp0ZHupBy3wr5gcNHLamAdeQ0nRvauZaEYY6u/P4oxgnvqVjE8rneI8kxigdXrK+AROZYoIqhT+r3LqlwBZsS66B/N+VQm4qdC4odFQmXRRbSvAIcq/qX7APnZcdYWk762zB2sjZLPSF2TJRSo3Vtgt4V0vwvQHQf2GkXfu4Xd1i12dq2FIEXNop15V16MfqlpTB7Ryu9SSgCkzVEsNzzlTeAOzdBxMiAiFh/tzl+TSCDof8lxAiBl1yNX1bkNyIvTfPanE0CKcSIr6bnY+iEasZ6iHhUwof8//ZaEHfrlUT+sOrEjjU8w19zOyMRZfDhRVufJ3RsDnTFUpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWq/EqRUV08IvNjzbwJQpa70EUGjOK8cwa+TlLH+K20=;
 b=ZCTTIga4XSVtcJGA5DpCsZIo28ziliJW4nbdTrZ7DwDyfmDYNX3OAtS89feNYOp1s9ajTalg3EjWyCvSM2pSILA+FSmIP40jaIfMIvJ1WCxZoiVbMRmXB/7Tjedx1C4uJUXwhjsMKe/gsXUC/pUSe7+kYaEYdIzg7/9IvtYTqpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 15:33:21 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 15:33:21 +0000
Message-ID: <d76e7f9d-f418-457a-b08f-90f929bfe71b@amd.com>
Date: Mon, 27 Apr 2026 10:33:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: CPPC: Add support for CPPC v4
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, "zhenglifeng (A)"
 <zhenglifeng1@huawei.com>, rafael@kernel.org, viresh.kumar@linaro.org,
 lenb@kernel.org, pierre.gondois@arm.com, zhanjie9@hisilicon.com,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260427051823.280419-1-sumitg@nvidia.com>
 <20260427051823.280419-2-sumitg@nvidia.com>
 <bdcc0785-9930-49e4-9918-c1255bd296a4@huawei.com>
 <8badf464-a44b-4636-9202-6fcf00fc50eb@nvidia.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8badf464-a44b-4636-9202-6fcf00fc50eb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:610:60::37) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8815dc-4e1d-4070-7978-08dea472501e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WuFMzyv+DiZDM6GNnTR1WtwhlKZ35a+sk0xRLMx4NNouorGeyPLVMSBa4WEVSNz9rm4HYHkqR8MhPMtdH3lyln5jdOz0eA/jBxC6S/xuP5rfK870sioLg4gx4gdYaeL7O955hAAvNJH5Oe4mMbYEA1Fj+SZlasWW70rsHhS0vmKecP+Kw63VxKuGFCOSrfJffJEXVokmo+iiYxS5SD5xkVlfECd1PhSPQ+yzvvW2OvJ0Y70ttNOX8TuY59fjMLpIhHmR0U81uGSmnjnBgcgZEBGsdWEPNBN0s/9Pb+xYlKQ/tlIXxB3aGBoctV1V7p2nZcrPTjXc4779+GOQsZqwcScoJ4HFcR0jB7P9tuWD0ZEtP3+hv+IWXx3SyLu7J1tA6IKtR8EGFtOrlszpSJdwHoy5AtZ6IcPMcQ3dr9JE5bH7jGVZRIUwDqcMnSkIYmREZWL/MKZzYIRrB9ZwriOL0Ph3+9Qf6ekEXNHtJH/z8GuCxxeQcN/HPRxN0GD2KCHY+h9KkjcKqoLAe9MB27v4hzM6JbTx3wFMZl0I6MxJfDRwDO2CHdCzP3l2XeaUHuEvePmYYM86KJaysdT0Gtcw7QIv9c32QV0Z8HPLCjQEwG3ZzbHteIKgmlzoXsUoapQzFDZQD3qM0PrL4l4kYSM76tUHxMTkIBER5i1BgtBOX0G1G94E2S2P9kOmjuUwC4AkYp7LXwvVIB1Q2R3QJsxDUrJZVNGJX5533f6AZVXmMyTjhcb7XyTw5OzQFHVd1xNmzAydT6eAvNpADw1HSgYRUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGhiTG41cThNSnQyWW5jSFg0RGZDR0lLWHFlbFl5Vldob1FqRkF6TXUvUGVC?=
 =?utf-8?B?dGdKcHRqTEhYUGZCZmsya3puai9wRFp1M1VYMVZUekZBYUVvcWtrVDZiU2p3?=
 =?utf-8?B?NlNNSFRvMGl1VlBvS3JmMXpCcWJTQTZ1aGk5S0lHNEVJei9mLzRVZzI2QmV3?=
 =?utf-8?B?REVLYUFGOG1FdjRDbzdpRlBwdFlVdERoN3pkb3dxdlN1clNVYThydTF5UnUw?=
 =?utf-8?B?ODA1ak5KakY1RisyanA2ektjekl2Ym1ESUVnOG1xRzB3VVcrbzdGU09VVnZR?=
 =?utf-8?B?YUtuY3YweWZ0VC90WkM5bkRGalFhUm9aTHQ3OWRwTHJTbHl6UnIzcEJ5SVly?=
 =?utf-8?B?SHdrb0d0K1dVdEdBS3VhbGI5OG5QQWUvS2p2NmhVT2w5L1l3WkRQTGp3eTNP?=
 =?utf-8?B?UDR4b0RIRjdySzl6Tjh0cFloTUpSQ1pIMjBKcWluMHY0UDZ3ZnZhZnduSFV1?=
 =?utf-8?B?YWxUbzFZUEs5dU4rOUUzTlJ5VFl5bTg5cm5iT25qSjRwV0tNZHhBcFdmNEtt?=
 =?utf-8?B?K3RtUkY5WVlma1p6RUhVbE1XU2tCaUlGYmNGS1hlLzgxTFgzU0Q3RnhqRi9F?=
 =?utf-8?B?MndDYWljL1V3ZEJuejV0YzhqaE9aL2tWRCtDSjJMOHdvMU5HWWQyZmpSMjdP?=
 =?utf-8?B?VEhxa2FMT3FQVzllTHQ1WURLQ1NyeGh0ZDRWWVhTT3Nxa0NaQWxaY2NUdW1r?=
 =?utf-8?B?SjJBc2RXWlB0L1FXa0hFam1Dd21RNWF6eVFvRkFzZy9idnFtNmhlaTJnb2Zr?=
 =?utf-8?B?YlIwUndGc2tTWTlVaGZmUWJiZEhSM0xnS0RvencvRjdZZkQ2MDc2bFRHVTlk?=
 =?utf-8?B?ZXJyWWJRWkc2cnlXY09jYm9IVWkyVDVkWEtuQlkrVFhnRzRKYWMxajkrZFZr?=
 =?utf-8?B?OTNBT3RKejRncVBpaUVVbWg2MDVPa0ZWa2JkdXRNSWxSdzM2cU1pTW9yelZE?=
 =?utf-8?B?bnR4elZPdU9NbjFSZkZEYk1RajdKbCtjRzBUa28wZnZSdWgvSXYxQjJSY1li?=
 =?utf-8?B?eUhzR3QvM2xJMlpJMGF6NXk4bGpocVhQbTFydU84OENBVER3dWwwclgySkxx?=
 =?utf-8?B?RFhOa1NESlRNTW82ZXc0ZStuZnd4dHVBbzJBTFQ4TGdwWWpyS0pPeU96TllB?=
 =?utf-8?B?TStWMmtLK0xMMU1WWHI5TjVsazJ2UVhhU1lKRUkyV2hqbmpUMGxwTnJoL3Ny?=
 =?utf-8?B?SVFQbzFNMExQN1BrdWdsTUp0bmpTTVAxYTk3UUpkeUszczROUHFUeSthTmlG?=
 =?utf-8?B?Mmtzb0RucFQ2WXF0ZEsxSGpqYURZbVdMNUdCeG5Ha0Jqd05jNTB0VVpqdkFW?=
 =?utf-8?B?WVgybDM3VFB6TmtQcW9aMzZqb2UrQ1NUUDlwVFREckM1NnZ5NVJhNjVyRnNP?=
 =?utf-8?B?YWhXSnNjOTZXeUl0Y3JKUUN0WmNvZVB6NVZjdDZ6TEhITFNmWXJCdjN3OTRV?=
 =?utf-8?B?dTk3RVJwS3Z0VERqZkNGSzMzQm5tVERxWmtlbytPOFB4ODN2YUM3dkFQSDJX?=
 =?utf-8?B?OE1ZemhGVmhsRDM0RTBtdmpIN21OZWRIVC9MNmVwM3ljUFcxb2VMMEc4YXZG?=
 =?utf-8?B?bEgzQkQyaUFmUFBmQU0vYnNBTzJtWCs2L2RDZGxYKzg1RGhuYjdJc3VJTS9k?=
 =?utf-8?B?UjFHOHl0bGw1NU9pbDhtM2ZldCtuTzVoL1l5ZXcyOXZwOGMrekFaV2sxSEQ5?=
 =?utf-8?B?d3hFWG00UTB0cmdRRHR0eit5d05RdnByenRJdUJZU0g2MVpNbS9xZ2pEazJB?=
 =?utf-8?B?QjNoYkVMWHkyWlVUZHRCeVJwUnZNNVBIVWhZc2h5MzVQSWM1VUhhaFpGbzlW?=
 =?utf-8?B?OG5ac1h6a3AwTSs2ZU1jaWNXSFFjaHJjZnJOV3JHdEZkbkxLbDFrVEFmTXFk?=
 =?utf-8?B?OGZ0Qy9kcCtrNk5wVjNyNkRqaUNRZ0V6YmpCNW0yR0twcjlLcWpkVVR4OWhT?=
 =?utf-8?B?N0ZwK3hNaGdHbWd0MG5sbHNMbG5CUUhTamRnRHAweEZHYjcrT0VnVzJmR2lU?=
 =?utf-8?B?cU9qYW9QK0NNZEZWQ1Q3eE1GQzFydnUxSUZKa0djRDRKSzVPVnRWTTk5aHBy?=
 =?utf-8?B?ays1aDcwSWpWamtXa1pJbEJqSVptMnhtajBqMkVXWjFlQy95UTZnZFloQlk0?=
 =?utf-8?B?QzFhL2N4ZTdLbGp3Ym9pb3NEbFZBRGc2RjhRWkxDbFh2c2RMbVliR05JL2xl?=
 =?utf-8?B?emtwRm9CaTFqaUd6TU9Ma1R5eGNmdUdPYVE3bThaRzZmSHlVdU9mNU5sMllh?=
 =?utf-8?B?TVRVU1VMb2tVQ3NPUHpqMGxFeFZjZ0FnbFRsd1orK2RIdEVZQUFKL1FGRGFV?=
 =?utf-8?Q?rdwkrZzSNkmCtaxWnV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8815dc-4e1d-4070-7978-08dea472501e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:33:21.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gmiopAvYxXZOpruXSClcrMzkgQJMHtqh7CN70cYxDjMi0Z10QSMRQfk1MdwYBRtlXMmm0lE3pEB0erWYcv3fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123



On 4/27/26 03:04, Sumit Gupta wrote:
> 
> On 27/04/26 12:36, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> It seems that mario has sent a similar patch:
>>
>> https://lore.kernel.org/all/20260427035520.1427080-3-superm1@kernel.org/
> 
> 
> Thank you for sharing.
> Yes, both look similar with below two change.
> 1. REG_OPTIONAL needs the 0x1FC7D0 -> 0x7FC7D0 update to mark
>     the two new registers optional. This is present in my [PATCH 1/2].
> 2. For Resource Priority, pkg_data added to cpc_entry.
>      This is present in Mario's [PATCH 2/6].
> 
> 
> Hi Mario,
> How would you like to proceed? A few options:
>    (a) Let both CPPCv4 patches from this series go separately.
>    (b) Fold the REG_OPTIONAL update from my patch 1/2 into your
>        patch, and pull my patch 2/2 into your series.
>    (c) Anything else you'd prefer.
> Either way works for me.
> 
> Thank you,
> Sumit Gupta
> 


Reviewing yours points out that I totally missed updating REG_OPTIONAL 
with the two new ACPI 6.7 fields being optional too.

In my series I only add in CPPv4 so I can build on top of the changes 
for CPPCv5.

So - I would say we should let your patches merge for v4 and I'll drop 
the relevant ones from my series and rebase mine on top of your work.


> 
>>
>> On 4/27/2026 1:18 PM, Sumit Gupta wrote:
>>> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
>>> _CPC package:
>>>
>>> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
>>>     lets OSPM inform the platform what it considers nominal performance.
>>>     The platform classifies performance above this level as boost and
>>>     below as throttle for its power/thermal decisions.
>>>
>>> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
>>>     Register Descriptor sub-packages that allow OSPM to set relative
>>>     priority among processors for shared resources (boost, throttle,
>>>     L2/L3 cache, memory bandwidth). Parsing the full structure is not
>>>     yet supported; such entries are marked as unsupported.
>>>
>>> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
>>> mark the two new registers as optional.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++++------
>>>   include/acpi/cppc_acpi.h |  8 ++++++--
>>>   2 files changed, 24 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 2e91c5a97761..a1c91ce20cc8 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -134,7 +134,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, 
>>> cpc_desc_ptr);
>>>    * cpc_regs[] with the corresponding index. 0 means mandatory and 1
>>>    * means optional.
>>>    */
>>> -#define REG_OPTIONAL (0x1FC7D0)
>>> +#define REG_OPTIONAL (0x7FC7D0)
>>>
>>>   /*
>>>    * Use the index of the register in per-cpu cpc_regs[] to check if
>>> @@ -751,18 +751,19 @@ int acpi_cppc_processor_probe(struct 
>>> acpi_processor *pr)
>>>        /*
>>>         * Disregard _CPC if the number of entries in the return 
>>> package is not
>>>         * as expected, but support future revisions being proper 
>>> supersets of
>>> -      * the v3 and only causing more entries to be returned by _CPC.
>>> +      * the v4 and only causing more entries to be returned by _CPC.
>>>         */
>>>        if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
>>>            (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
>>> -         (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
>>> +         (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
>>> +         (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
>>>                pr_debug("Unexpected number of _CPC return package 
>>> entries (%d) for CPU:%d\n",
>>>                         num_ent, pr->id);
>>>                goto out_free;
>>>        }
>>> -     if (cpc_rev > CPPC_V3_REV) {
>>> -             num_ent = CPPC_V3_NUM_ENT;
>>> -             cpc_rev = CPPC_V3_REV;
>>> +     if (cpc_rev > CPPC_V4_REV) {
>>> +             num_ent = CPPC_V4_NUM_ENT;
>>> +             cpc_rev = CPPC_V4_REV;
>>>        }
>>>
>>>        cpc_ptr->num_entries = num_ent;
>>> @@ -845,6 +846,17 @@ int acpi_cppc_processor_probe(struct 
>>> acpi_processor *pr)
>>>
>>>                        cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
>>>                        memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, 
>>> gas_t, sizeof(*gas_t));
>>> +             } else if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
>>> +                     /*
>>> +                      * ACPI 6.6, s8.4.6.1.2.7 defines Resource 
>>> Priority
>>> +                      * as a Package of Resource Priority Register 
>>> Descriptor
>>> +                      * sub-packages.  Parsing the full structure is 
>>> not yet
>>> +                      * supported; mark the register as unsupported 
>>> for now.
>>> +                      */
>>> +                     pr_debug("CPU:%d entry %d: package type not 
>>> supported\n",
>>> +                              pr->id, i);
>>> +                     cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
>>> +                     cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
>>>                } else {
>>>                        pr_debug("Invalid entry type (%d) in _CPC for 
>>> CPU:%d\n",
>>>                                 i, pr->id);
>>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>>> index d1f02ceec4f9..8693890a7275 100644
>>> --- a/include/acpi/cppc_acpi.h
>>> +++ b/include/acpi/cppc_acpi.h
>>> @@ -17,16 +17,18 @@
>>>   #include <acpi/pcc.h>
>>>   #include <acpi/processor.h>
>>>
>>> -/* CPPCv2 and CPPCv3 support */
>>> +/* CPPCv2, CPPCv3 and CPPCv4 support */
>>>   #define CPPC_V2_REV  2
>>>   #define CPPC_V3_REV  3
>>> +#define CPPC_V4_REV  4
>>>   #define CPPC_V2_NUM_ENT      21
>>>   #define CPPC_V3_NUM_ENT      23
>>> +#define CPPC_V4_NUM_ENT      25
>>>
>>>   #define PCC_CMD_COMPLETE_MASK        (1 << 0)
>>>   #define PCC_ERROR_MASK               (1 << 2)
>>>
>>> -#define MAX_CPC_REG_ENT 21
>>> +#define MAX_CPC_REG_ENT 23
>>>
>>>   /* CPPC specific PCC commands. */
>>>   #define      CMD_READ 0
>>> @@ -109,6 +111,8 @@ enum cppc_regs {
>>>        REFERENCE_PERF,
>>>        LOWEST_FREQ,
>>>        NOMINAL_FREQ,
>>> +     OSPM_NOMINAL_PERF,
>>> +     RESOURCE_PRIORITY,
>>>   };
>>>
>>>   /*

