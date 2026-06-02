Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E403E3170;
	Tue,  2 Jun 2026 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407702; cv=fail; b=CrXTSSFTq1+QOIS5H+61G/uoy+c/U9WOI33ldiFJv3bNum5CQDxjrJ1h/lw/mgV1G81F5zFCQH1jr++I1NMzlgBMyAEbonoa00dcgGnR/FO2akSbS8/iMSpYpiu45qxeU1PuyYulbiJxbxi7SxCJbkMitOabZ6bohWCx8FQx1Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407702; c=relaxed/simple;
	bh=I9yo023ndk5kIFRIAxzj0ED3EPyu0snaecF2o0gWSmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HmiuhgTRWkyqLbA8wrzbcS16II38y+NFnsizZLQFkZzWrFNDw6+daYlVTs9R/JU6oOrARavTI9NQmopnENMtEiv/jES3AKlsTriejaZS+NcEdFzyw2m2hGpIJlN65YioXmhHycp5UCEflfsaPMyhc8LtXT0pdEVmfrxxLSbID2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VfOsDKa4; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VfOsDKa4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9EvMCopyo7G5T6dV4XwJl9zeNfm0zKUSda108xncxneHMW0ghSSkKNRce1PTtaVn68rioQJ+zRXqKDqWuoNAgzjtz8ZLAEwkf9b2Ea26DaSVjJ99gUY6OsjUUM2O3NBMW3USsTMl/ey+jKmNRwHaNIpourRpMA6YohaGkatkGdxAKdHdUAvysgY2Z2hFL8E+sLJ3RtJBNETcG32WlVWA/HeHC8qerEPf6EXahoE+Ot4qdFBTLbaolkq6pAlbMqbzfa2t+eSi/F/MHIOsROZ38hTxhheG4KGS8CwdXpaSaihsuNJSSdSnrYQ6yb0IyqeIBSa613Ke3S/eOTfu2m7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ8qkEOhluLbfTOe9iKpQTBlKCtvgdj3njohbnl7kDo=;
 b=jqLIHZSE1/l7yWG9fnuLDgEIDET9hWZGd7DPS7X1cZeWkSpFA0TdOkycd+OJr0U3HIh5fMEjUCEr6fuYIqnuPQmUdTr/5bZ1oBSFWTk7HJ5Edh03Z7KSDtLRaoEDIxadl8xQPmdfm28wkx03zaAQmjm67Dxc6D5vfT2wskioOkXiBe/Boa6NPI8jrQ1pCQYLSXuipmwaO4/t/BNfj3JSVo5b/rso6PvuB8B1OyX9DGyRSo+XnfxNrScxTdMdLFu1w6cqRTask2MINglor8rcoj+I+9ECrWWdW+2Og9zZJeyN8oeYFeysdhPipBn5VEYs2TWGf/IE9WD+iiwk30yvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ8qkEOhluLbfTOe9iKpQTBlKCtvgdj3njohbnl7kDo=;
 b=VfOsDKa4dxVwztAluC8ea4aSyWfI6nYF7kEsxkRTjAwKrPZJqMfhUZfCCtuwwolkkJSAHInwbxPHgwFmCQ8UgO9d3mN65+Ur0Pf2Xbp6fp8yx7fJopgbgtotsInXZJHnNt24IjCjEayc013Jun8R16OGStMpIedbc4D+VPAvlaBuglmO2hVaIUAwWA1TjA7RZcp7qMJy4hBglSoE0W/mfiolcbmZibt+rsiauywREz6wZsDXNlfSR/Px/RZG1giFWtoI2RxwpCULMS0pYg1QqliyrNUkSPxKZJL/Lf56iFRsMnIhNqCU6xt0LqLVGPAOnYOACPQqVcDf4lAAc7/qUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 13:39:34 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 13:39:34 +0000
Message-ID: <5de9eac9-c2cd-4442-8412-c25e38b48c44@nvidia.com>
Date: Tue, 2 Jun 2026 14:39:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] pmdomain: tegra: Add support for multi-socket
 platforms
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260602083959.350689-1-jonathanh@nvidia.com>
 <ah6_-WJrMOiPkMVS@orome>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <ah6_-WJrMOiPkMVS@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::8) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bd1dfb-4cfa-47ee-fb7f-08dec0ac61f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|11063799006|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	GQw3C4ujitG1xZ/w58436ajS9SDm3+c6g9yUn8u+z25TgvInX+uLL2Zkap7hwMH7mf1BS+OGU6q9m0jM3Jf2y/hL0Ndo/gWFFU4+vTHTtBUlTxhW9DHTqt5BoeEfrGDJmLNp5sDvJpImIL88q8QL7D5psIgFNsp83BRs2vm6zSoqFyYujjFzdy9j0elBvr59uqsSjFwiw9wwadoYY6XZufsvHtADAXz+1SCqaXjSXnfU7bJZYL3/U7Oi9ZHrVTCbFUUxfPZIA4DFKY2Cxw5Yivzam1VW5wO6S3COGmVzUWXonyCsRvoFuQ/IdplclhJK/jfqWboZoMbqWWpylIO1KeJfIR3nyJE/5JItOY9SnDfziCO1M41wbkvnOfAk4ls0AFZbSbhvHdTv0CJCXTVU0ZwK8sP/SkhdbFPFqwz6H/mV4k+oNkKHHQxxEppptXir/t9/uzKSG4dxI8XS4RAmXb2ptHy8JXvOPljO0R1t4SFRGf66QjFWisrFX6bWbC0D+6VOy+aTbkEPZ2yUfcbk+5IpqaTCJ9HXaE6A5QBJSRKllbmCtqu9qM3WRVynDhtE1UffFGDuZlXxlPNE8ZS0ixYqiz7r0I6DFX+VA4D8F2jDcDbITrVKscgUWqTgowwMIvjgElnknWxghpVztuuV+jF0POkW3uEODnc6Zj97oLH9+0kD7HWHA5XvqkRunzXQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(11063799006)(4143699003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpET0p3YjlSc2Z3Nm40MktvTU1VS0RXVCtaSU1hOUEyUmRYT1NEOGFzRWxQ?=
 =?utf-8?B?RzFQSXdyYU9YblIyWnlhMHp4czJPNkVZenZKelBNdjBzNDBPVTI4MWpmai92?=
 =?utf-8?B?aFk4QkFVWnB6cFQvR3R5NklyRFpFcCt1Um53VCtUNGZYTDdhbHdtb2VFZFJI?=
 =?utf-8?B?UWJLT3c3NjJva3NwZkEyTlU5YXVDb3RXSkcvNmVBVm9yR00zVCt2NUxrdnRl?=
 =?utf-8?B?WnFoNXdhTXdnQzVjbmVGZTQzeFZNd2s1NTBlQ05jQmZ6eENpVDhvYUpFYkhG?=
 =?utf-8?B?N25yQjJ2Q3VTTWFuNWptTGNCU083ZDdMYncwemIvbWhIUjBTaEJiNUM4UnRi?=
 =?utf-8?B?VVcvZlMzZVgrRTFtWmwydFBNbjE1cktTcXZzeDh6WE9BL1dDMDZKVU1MVERO?=
 =?utf-8?B?b2NseTJjRUFTbXNRQ3RvRktNWjJVRlpzajIyM1RSWE9pbURBRjVDTWdoUkxm?=
 =?utf-8?B?bjUvL2VSRU5XZFZ3cURkbEVwT3FrZ252UXB1ZmxKSlF4WmdvbHZYUzduOHZU?=
 =?utf-8?B?Q1Q5U25mUHBzYk1WYXFsZXRyODdlK1dzQWtMNFBLREJjZWh3ZmZuM2h1VzEx?=
 =?utf-8?B?dEd4Q0JGMVRiREVlUFM5bnZrTkVJZXpZNHpHRmtjUjg0akE4ZmQyVXlUVlVp?=
 =?utf-8?B?NjBQd1pCdjZ3WDJ5MGY4WjYrVkNvREtiYUJIaXJrZVR1b3hZRS8vQVlOb1Bo?=
 =?utf-8?B?VGhrV2xGUklkQkF1ZWNLeVVwZW1wV1NhbDdCV3JmZUJXTU5FMkZqM24xNElR?=
 =?utf-8?B?VlhpTVNkZDU3MkVNY3Y0dTl0YklMOXpXUUdVQ0VtcEQ2c3dBNUNTaEJZUWl1?=
 =?utf-8?B?Y2ZaTWp3TkxwMXBVeGM1ZWxWbVh0WmFVZUszKzc5eGgrQVVRTXY2cE9SQkZH?=
 =?utf-8?B?UDFmT2tsbTMvWUpmNDlpU2lhVHZ1R200TUc5MVhmbHhmT3Z1VDZvMStPeXFU?=
 =?utf-8?B?YnRLUHVKS1VuOU1Cam1ESWw5YVM5SDhjZFlBZ3FRa0h0SmFUdlJWMDFZbzZn?=
 =?utf-8?B?bVkxK1NhVitQV3Q2OG5tVXRDY2RtNzczYzdVdjZBQnV2ZXl6dWh3QjMvYWRs?=
 =?utf-8?B?Skw5ajRHbURlR0FEWVlzeTF2VzZNdGpXd25rTm53NENtQzNHbkczb21wTE1P?=
 =?utf-8?B?b01SZUNDMDdvdFhxNVdPekRsYTRqNUNtYmp2bk1HZ2w2dnhoM2ZaYjdHVGx6?=
 =?utf-8?B?ZmhoREYxbzVLTDBnRGhkaUI0bVV6SE1HS0JZYXR1SkNqemRpL1JEbjNaSjlE?=
 =?utf-8?B?TWM4d0ozRFVXcDFTMGRTbFhBUHN1UHYrWG9ZSlVkUkNUOXBsZFBVcVJOS0xK?=
 =?utf-8?B?QVhXbnRFMjllK0FHdmxNR0M1aWRsbm94SlNyNWIyakhUNXZhd1EvSVZ0eE9U?=
 =?utf-8?B?VUYzSmh6UjFOdkx4ZnJWRHN3WFFCNlk0L0Z3RFhVQlY3UU92WjIzdnQ2YXc1?=
 =?utf-8?B?S3dmRHpKdElOMWhvWTdkeVdjcXlHbFNuYmIwQXN2UUl3RWRHSlNvTEo2U1pE?=
 =?utf-8?B?YTVScDdvT1FuYlN3VmVXT0NMRjl4S09QNmUzNHpkM3N2VWEyYTd0OGlkZ253?=
 =?utf-8?B?b054TTl2TVdyeXQyNVVJMDJKTmRsVkw3OXRMZGgwb3NjcU0wQnIrd0dBQWxJ?=
 =?utf-8?B?WDc1OUptYmdmVC9la1hkWDJ2NjI0Sk5DdkM4dFdoVEFzai8rZXdkQTJEV01H?=
 =?utf-8?B?NXRFUENRVGtrSlJCUmhOUDNpZzRGWXZVRlNZdzlkandNaUkzbUtaMFByOG1W?=
 =?utf-8?B?T2FPNkU4aHRHY013NG9nOVBlUEorOTFqUWdLeE9VM011QmZvelMvTHMrbEUr?=
 =?utf-8?B?b2tMT2hIM0poL0s0Rk5oZmRkNUlrRlhBdlBwRTBOSGQwMzVOQ1NsT0FUbThX?=
 =?utf-8?B?VE9mU1ZTRC8rQUl1RVlYbDRGakJvYzZ4VEQ2Z1N4NFlSVk9sS0VRWm1EZiti?=
 =?utf-8?B?N1dEaHBJdVJtMkk2RzlIem5WRjUxRDZFV2p0VTBBRm5iQnNiNGlqYmw1NDlW?=
 =?utf-8?B?V2N5WHJTUVRFaHBYSFpINEZld1RYWDVtdzM1UnRlbno4djhrRVhFK2xkOXBq?=
 =?utf-8?B?Q25MbG5FRVU5WC84WjdSMWVrRGVNYmcyUEd2RWlWSmZacndkNS9nR2dOUDQ5?=
 =?utf-8?B?enBnTkFzY0w1VzllaG5vZEE1V1JqbXIwTDc5OU5NUUpkTVBrbytyS0gwUzV5?=
 =?utf-8?B?cUdEVGpEZ20zVS9yUGY4dDVING9wOEZoTFhvWWJoaHdFQTV1VWMxSG53UER1?=
 =?utf-8?B?TmFueTYrMmtwYWt0NE42bHNRMW9QYm9LRjhIc2k0Z1NyenB1am8vcjNyUmRK?=
 =?utf-8?B?bjVTVU02aHhjN1d6dUFpY0dGcEQwRVJmdkZ5ay81TzVzZFdRV2t2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bd1dfb-4cfa-47ee-fb7f-08dec0ac61f3
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:39:34.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZtV7x34voWxzy5JS9Xx4f4zVd85Gve4B8+rgMEh3KQrHHSajtftiY4BDZUP0oRkxO9bf4EmIwYbdc+sadYsmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208


On 02/06/2026 12:59, Thierry Reding wrote:
> On Tue, Jun 02, 2026 at 09:39:59AM +0100, Jon Hunter wrote:
>> On multi-socket platforms each socket has its own BPMP that is
>> registered with the kernel. For such platforms prefix the NUMA ID for
>> each socket to the BPMP powergate name to ensure there is a unique name
>> for each power-domain. Note that we only add the NUMA ID for powergates
>> that return a valid name because an invalid name indicates that the
>> powergate ID is not supported.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> Changes since V1:
>> - Use NUMA ID as a prefix and not a suffix for the powergate name.
>>
>>   drivers/pmdomain/tegra/powergate-bpmp.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
>> index 8cde4f384846..5e869b0eb96e 100644
>> --- a/drivers/pmdomain/tegra/powergate-bpmp.c
>> +++ b/drivers/pmdomain/tegra/powergate-bpmp.c
>> @@ -137,6 +137,11 @@ static char *tegra_bpmp_powergate_get_name(struct tegra_bpmp *bpmp,
>>   	if (err < 0 || msg.rx.ret < 0)
>>   		return NULL;
>>   
>> +	if (response.get_name.name[0] != '\0' &&
>> +	    dev_to_node(bpmp->dev) != NUMA_NO_NODE)
>> +		return kasprintf(GFP_KERNEL, "%d-%s", dev_to_node(bpmp->dev),
>> +				 response.get_name.name);
>> +
>>   	return kstrdup(response.get_name.name, GFP_KERNEL);
> 
> Why are we not checking response.get_name.name for the empty string in
> the single socket case? Or the other way around: why is this important
> for multi-socket if it isn't for single socket?

Simply because we don't want to return a valid string such as '0-' or 
'1-' for the case where we received a NULL terminated string. The caller 
would interpret the name '0-' being valid when it is not.

> Looking at the caller of this function, it will check for this case
> itself, so I'm thinking we should rework that as part of this patch and
> simply return NULL early for both cases when name[0] == '\0'. That way
> the caller is simplified and we get a bit more consistency in this
> function. It is going to make for a slightly bigger diff, but I think
> overall it'd be an improvement.

Yes I agree that would be better and then just check for '\0' in one 
place. OK I will send an update.

Jon

-- 
nvpublic

