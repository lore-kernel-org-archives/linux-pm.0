Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90E92264A7;
	Mon, 27 Apr 2026 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277087; cv=fail; b=QeYUQ3Z2XO8VFaOmBHbHZaH7gA+fWwUFJCUAL/Q4rAJeMZsfNwJOuLNU14dbhCLQfsF1egdipiCY7cE2BBIwRCDs+2NkZ9PitW+UWbA1dZfyP43uYhGDDRCBNF+FgLhuWrOFzXLeZlSVqs2NH1oS7on7xkdwemMuILJSWoDMzg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277087; c=relaxed/simple;
	bh=CAgTOquqQqB0D7zs5OidfD582RJptSicdS8CKDvEnX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KdKORc79SsUm0rj/zPuaZZDtX/ib85opp3CQ0C8NZ52MS+8YDiyqcT7amyhWXqgXqz3Pqw29XIxP/2VggjHm7DVBTfUCrGDfkHJ4N4q9Ws9FzFNWOGYwd26Bf1OmtHasj3LNFVU7kMrOK0MTZ5/tWYjetROPFWuHZTjstJl3i3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=di0GXFJF; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="di0GXFJF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wl8cqiCLEtALAJP2H6gfFhyHktZC2w41pTtdYxIIBMSse/rLIMKnMp4mC4fbjd0fdLKbkVjtMq0bAqHc2qZZneMzIBKUcDwo4nPqvtznvvV79qJPbJRLU5rqr4brm4kGEYh27CEyqovsOapT2RISflWR6kBy+SsYvg4X7JGX+DJVEqeNX4jUMZ9TfyvX2vswkm8dnr3SdzZODQ9lk3ESub69X3LjT0kLP1RPdnwSjC79bOeb7y5gHakiOlmJcX/a4z15b+912xCMKMRRrVv7wXbOzZpHMphFvPL1NnrlI8uu6/0LpKWKDDiBvhw2IPesFf0ABqP+CnukgEoc8ls+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4siq7YdbMty74/pvV2+GqYFs2EXVkJvvXtN78tIMgM=;
 b=cT78rb1CIXbFHTGy+LGYF+9Dt38as+eTEV6nFxm9189AwNu/LPwP7L+J5/TpqaBJNHegXJglq8HxrHxzrY/9ZKPNhJRtZQHNHqXIKomr8ta9aOJrNhGMAKpSWNfJ+4dYvx8BUp8DSaDkWwFydLkPGyVXCxCvcvYkAxowObLTvWvtjJEKCjtpFOXEgPG4LK9RN6rdEUiqb4+Oy8jhwl65mC8WVQDwMWghD0DN15Ig3oWFLovNjgcrMehYdc5NVrXb0nDarj7DKnm0z1dg4I8FVuD0rTB3VYO2lGilXUhb9/KvZR5o1NtFLWDAsN1pl0FL6yEJc1YrjdgPcjdGzz3mIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4siq7YdbMty74/pvV2+GqYFs2EXVkJvvXtN78tIMgM=;
 b=di0GXFJFZhs2UG2H97MvADw0EyEMpRpNYiG0BSPru8MDgjynZR8K+wsXobs4xn1eEDUPUVftVG4JHx4M36ZIRd3Oy+PckX05DxuaYvx0af6Sj9jGHUOnrhDvHwlXN2LuOFgazrCVkzPpPeXaY8YXzUuPBTxJ7FfhNlfqRDO1414tRjNpiVCMwyfjFhly0Dtw8eY01IDchNvguPq4w1rAeBUEz+c7HebyWiwJk2gbDDK9xp6z2Oyt90b04fooQRwKgUzUTEoVCQgkEpqqb93y2DTNSpO4IgMAO0qBQktqgKXlb2gDR2CgoRWgO5MdHK0V4X7t6XCoemyoijL0QVTu4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:04:39 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 08:04:39 +0000
Message-ID: <8badf464-a44b-4636-9202-6fcf00fc50eb@nvidia.com>
Date: Mon, 27 Apr 2026 13:34:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: CPPC: Add support for CPPC v4
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 sumitg@nvidia.com
References: <20260427051823.280419-1-sumitg@nvidia.com>
 <20260427051823.280419-2-sumitg@nvidia.com>
 <bdcc0785-9930-49e4-9918-c1255bd296a4@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <bdcc0785-9930-49e4-9918-c1255bd296a4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1a3840-86b5-4b8c-adf8-08dea433a11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	rVVqoLzmVzhFRM9kOvAYnIG275y7tzruUQe3TjTPAzTykYVFMLXFEXmGwXUv907JlGf4ovtAzCI1vjVRRdbt4ZcDhiUy1sU4RFdKTDWinCURcKocSYJxMOsibZPZ0ZNagvvI99rGzw3gTZi5g4qqxjdIUz4XPI0Ol8lCyQKh0MPScRqQ4O+iMbX0ZPRMV1yfCA6tqe0kn8KpanGIUQscHu6Xlh3nYs8SOATmaVWFr0OZPy4pgTzyDIlOlM0wSDuoprP3fe/siUoDdrAisNSHNr8DguasEMYEQUNCb5dp4h2zPkHKowSTPl+MmiXly0spdubvOd5ar2uiETOuvkSDVB6RqmLoC240c9HSV4kNDw56nwaP111AYSmWoQso24t1iZJ+UfH1D/YoS0a+BEMEbTLR97Wv0GLvNmC+Lv0He5jfgq7XutaFMjrnQxKHvCW6OsKylsUGa5LQAr2/2ZACEfYZr+w4jBFzmjCrjci6gXtpsDaa9+mho3Iym5o2gOS+LqBPXZ4+gUkz4YYtIcdxabwLKhCmAltRtewwztC5RoDvG7AP7F5SPT6Sh7lV3mKYhzez0zfCcxy9xO/PMek8BhwW+ppbGCRB2DXrHYSqjsln/mH+OwAJUnKbXRz/iDFiAj/rrXr3mE+dPt9dnJ0TYN9XhSBxfRBpXLtk3+4sH9DSWN9EfCnQSUV3NX61wrEplUqDENAc/HPhdZscS3l7W44GI5FsHtNd6pgmiCxJVjJS9oUuD8U7KDZ48GWylQvpF7JiAaZLRoxg4LFb+EgDT3ugNp5U/kEIWW0Y9KaxRqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0FZNDBiUXhOSEJrV3hiRk9HKy9WZm9md1d1YWdHRW5kalJoRzdrb2hXWlZJ?=
 =?utf-8?B?OWJhUitUdTZVWGxPTW5FT2hkVloyeWJXM0Q4V1djOTRRUjRGTzI4TXZ5MEkr?=
 =?utf-8?B?dVgwN21YZWdxS3hKY3BFUStxYlppRkxqMmFXU1pRMUNzZHBBRC9qSHAyYTIv?=
 =?utf-8?B?NytaMGNkRGZmNEExdVhtdXdQMzBEdnVIQU1lRkN2UUFJYUs4V0JPRlJqNnh1?=
 =?utf-8?B?WmpBeXB4MWVxelhxMUc0aUx5dUQ4aHFkbVF5L2NGcW10VytMVWREU0NwU1Rx?=
 =?utf-8?B?NUpaYndYTVNPNUtlY1JadmRNL2JqSkdRQStkbDRYSTNnM2tOdms1R3Vhb3Zh?=
 =?utf-8?B?Si9CUUJKdTBDRmZkTmgwUnhBam5LU0ZmS0E2d0tucTFMT3lFTGM5ZXZyOXNl?=
 =?utf-8?B?bkFnUFA5aTlTdkVBTk1PUFRWb05odnIwMEZTN0xHTEEyNUtWWXFwUllzcjYw?=
 =?utf-8?B?Um9ya1lWZ0RjZVlwKzc4ZjVWTFlnN3F3djV3MjJmdldoNldKNWszdGZvWlJP?=
 =?utf-8?B?MkdWZndLd2ZsNTVCRHNWdmFiczZ2NUordXlQMlFzTm51b2xpa1JFYkQ4L3hQ?=
 =?utf-8?B?ZDRldnJMSW12VnFsaEQ3Qm0vUWdtTm1LQ2x4VHdlVlhjZUkvYTNXajEwNmdi?=
 =?utf-8?B?cU1zQTFESUJvNnYvZ3dyU2NnOVBrNER5Zkk2R2hxR2puSWtndGZrOElNZEYr?=
 =?utf-8?B?bWFCNXRJNDJ1TS9pK2RvSzh5ZzFlREtUTjdHb2pORHVhNTRhcjN1V3dXZC9L?=
 =?utf-8?B?cSttd2pETHpCSXpEZmFqdGZGV2tnZUV2ajQyNHoxUDZ5ejRLWDRPMFVoWUJk?=
 =?utf-8?B?eTB1KzZhSThueCtxbWI4VzBWRjRnS2FFbzNJc2JoQWRxZFVSNWZ6ZlRzeWVG?=
 =?utf-8?B?andLZEh5aERkTndHK3pQYkZkMTVUakY3ZURVWTNHbi9VVWk1emN2bi9qTzIy?=
 =?utf-8?B?YmUwemF6U0dHVzZQYXF3U29HQVljRTZMK0xrZUM0bkd4NURZWHdGbjVEZm5S?=
 =?utf-8?B?RTBTVWYzTHpzMWRhYnBFdkpoVUhlTEFMdjlyMVIvb0crcUFvMGZVMEw5MDM4?=
 =?utf-8?B?Z1FwS1BYWDFXNnliekJJcmVuQ1lFOGw0Zkg0RHNOb2tWQms4L1ZEY0NxRGlG?=
 =?utf-8?B?RDE3NjFpVkNQNE9IdmRlTGlyODRuZ0RaU0lCTk54QU1yY1l6OVFFQjJ4RHVq?=
 =?utf-8?B?MTEzQWpFNHQvWjJ4QXVPM3FaMEhDZnpNRjZpK1F0NGVQTVdXVmR3eWxzSk1n?=
 =?utf-8?B?Sm9vNlNXeWlqYjc2bHova2I2NHlDK1V6eEU0TmxPblFoRmNVNXc4TVdTY0hq?=
 =?utf-8?B?RTFlZ1doZVlIZWlqOXdVZU1KdkhqTVo5RHlTUTZmVURwSHYvQk9BNm9ZM1pB?=
 =?utf-8?B?VVpoM2YvZGFRQzIxazdHVFR4MlErb1NqYmJSL3VOa0RBVWZjV2M1THRVY2NL?=
 =?utf-8?B?OVhOSzFMaDJLOWYxV2VhRnl1eDN2S3Z6ZzZ3SjY2L2t5cmd5Vm9nWFhzVnBX?=
 =?utf-8?B?MWprZGFNOWErckZWWlFjZXNEYXo5bGNaU1RabzVGWHFQclpxSEJ2Nk1RRldw?=
 =?utf-8?B?Z2x1ZS9SLy9UUTRrcWJLL1ArdTlyMXl1Y0hFbTV6OFg5eTd4VS9Ha1Y4NGFW?=
 =?utf-8?B?MmFXVWxPYS9RWkVUMnQ5UkNLT1lFZzhaUTVHdWxmZXdIRGdMSFZTRC9nOWNq?=
 =?utf-8?B?QkdsejAvb2NDVWlZekRmdysvbmVnN1Q1cjVxSVQxWVFFTzJGRFhkRnVoNEtk?=
 =?utf-8?B?ay9QYWpxZjV6czZ2Qml6VDlSU0t2NW1yQkZMaStzTjlsY3lwUFJLc2hkMjdK?=
 =?utf-8?B?L0tza3ljbC9yTk1SbW40MXhMekZlbUVORFo1MEt2NkdiWW12amk4dDN4VGxL?=
 =?utf-8?B?MSs5V1NSUmxYVkpBNWo3amtNdEg4Sno5S3J0UVFTWWdvS1ZBbDRkcVFzMzE5?=
 =?utf-8?B?d3h2blZoNUxYaWVjQ3RURExXUjZHSjFpUnRFc0t0TlBWdk9IZmx4NnJCT1h4?=
 =?utf-8?B?VUx6MFl3TkpBNzRCenNXTytuUVhqNHlQZVBjT1VxOTJ1dk42Y3hLd3A3Qm1R?=
 =?utf-8?B?b29WOXBtaTRWRFlDTWJRMVk5a0g3YnZWcW1qT3JadGN4WlZnb1RJUWg5enlY?=
 =?utf-8?B?QlFrd0tiU3ZpaXRQQkI1U2F6NzFGN3pzdVJaM05DOU9UMENLb3Nsb2R2alM2?=
 =?utf-8?B?R1NLYkl3MGFYdGN3N1BLR3JqK3VJd2xLS2NVWjVsL0M0RTcra3ZybzhEZ1hI?=
 =?utf-8?B?V3BGZitOaitDNFFMNEZYUXBvaDQ4OU8vLzAzY2tTTG5HYVNhTHhhK0Y2c1Nh?=
 =?utf-8?B?WllzZTErc3hLY2RWUUMyRjluTTJabUxQVDhvT1pvZWlxa0dKTkFGdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1a3840-86b5-4b8c-adf8-08dea433a11e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:04:39.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxjNOPYrRwIfcExG4mJNUgPwraIqUYf1hZh5aMwkurv8tUR6eWrxAWE//RsK1R7db9gIJHpAUen9g6+Zd/nPgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137


On 27/04/26 12:36, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> It seems that mario has sent a similar patch:
>
> https://lore.kernel.org/all/20260427035520.1427080-3-superm1@kernel.org/


Thank you for sharing.
Yes, both look similar with below two change.
1. REG_OPTIONAL needs the 0x1FC7D0 -> 0x7FC7D0 update to mark
    the two new registers optional. This is present in my [PATCH 1/2].
2. For Resource Priority, pkg_data added to cpc_entry.
     This is present in Mario's [PATCH 2/6].


Hi Mario,
How would you like to proceed? A few options:
   (a) Let both CPPCv4 patches from this series go separately.
   (b) Fold the REG_OPTIONAL update from my patch 1/2 into your
       patch, and pull my patch 2/2 into your series.
   (c) Anything else you'd prefer.
Either way works for me.

Thank you,
Sumit Gupta


>
> On 4/27/2026 1:18 PM, Sumit Gupta wrote:
>> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
>> _CPC package:
>>
>> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
>>     lets OSPM inform the platform what it considers nominal performance.
>>     The platform classifies performance above this level as boost and
>>     below as throttle for its power/thermal decisions.
>>
>> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
>>     Register Descriptor sub-packages that allow OSPM to set relative
>>     priority among processors for shared resources (boost, throttle,
>>     L2/L3 cache, memory bandwidth). Parsing the full structure is not
>>     yet supported; such entries are marked as unsupported.
>>
>> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
>> mark the two new registers as optional.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++++------
>>   include/acpi/cppc_acpi.h |  8 ++++++--
>>   2 files changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 2e91c5a97761..a1c91ce20cc8 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -134,7 +134,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>    * cpc_regs[] with the corresponding index. 0 means mandatory and 1
>>    * means optional.
>>    */
>> -#define REG_OPTIONAL (0x1FC7D0)
>> +#define REG_OPTIONAL (0x7FC7D0)
>>
>>   /*
>>    * Use the index of the register in per-cpu cpc_regs[] to check if
>> @@ -751,18 +751,19 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>        /*
>>         * Disregard _CPC if the number of entries in the return package is not
>>         * as expected, but support future revisions being proper supersets of
>> -      * the v3 and only causing more entries to be returned by _CPC.
>> +      * the v4 and only causing more entries to be returned by _CPC.
>>         */
>>        if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
>>            (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
>> -         (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
>> +         (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
>> +         (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
>>                pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
>>                         num_ent, pr->id);
>>                goto out_free;
>>        }
>> -     if (cpc_rev > CPPC_V3_REV) {
>> -             num_ent = CPPC_V3_NUM_ENT;
>> -             cpc_rev = CPPC_V3_REV;
>> +     if (cpc_rev > CPPC_V4_REV) {
>> +             num_ent = CPPC_V4_NUM_ENT;
>> +             cpc_rev = CPPC_V4_REV;
>>        }
>>
>>        cpc_ptr->num_entries = num_ent;
>> @@ -845,6 +846,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>
>>                        cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
>>                        memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
>> +             } else if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
>> +                     /*
>> +                      * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority
>> +                      * as a Package of Resource Priority Register Descriptor
>> +                      * sub-packages.  Parsing the full structure is not yet
>> +                      * supported; mark the register as unsupported for now.
>> +                      */
>> +                     pr_debug("CPU:%d entry %d: package type not supported\n",
>> +                              pr->id, i);
>> +                     cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
>> +                     cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
>>                } else {
>>                        pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
>>                                 i, pr->id);
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index d1f02ceec4f9..8693890a7275 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -17,16 +17,18 @@
>>   #include <acpi/pcc.h>
>>   #include <acpi/processor.h>
>>
>> -/* CPPCv2 and CPPCv3 support */
>> +/* CPPCv2, CPPCv3 and CPPCv4 support */
>>   #define CPPC_V2_REV  2
>>   #define CPPC_V3_REV  3
>> +#define CPPC_V4_REV  4
>>   #define CPPC_V2_NUM_ENT      21
>>   #define CPPC_V3_NUM_ENT      23
>> +#define CPPC_V4_NUM_ENT      25
>>
>>   #define PCC_CMD_COMPLETE_MASK        (1 << 0)
>>   #define PCC_ERROR_MASK               (1 << 2)
>>
>> -#define MAX_CPC_REG_ENT 21
>> +#define MAX_CPC_REG_ENT 23
>>
>>   /* CPPC specific PCC commands. */
>>   #define      CMD_READ 0
>> @@ -109,6 +111,8 @@ enum cppc_regs {
>>        REFERENCE_PERF,
>>        LOWEST_FREQ,
>>        NOMINAL_FREQ,
>> +     OSPM_NOMINAL_PERF,
>> +     RESOURCE_PRIORITY,
>>   };
>>
>>   /*
