Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26E440625;
	Fri, 21 Aug 2026 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286488; cv=fail; b=h3Zw45BnYy3XLq4AEgPDVgTvFMd8UnevBHOlOKkFufCKhRJQam0CUzpf/8Ff4/97LgAZuXwPSmHrz8wdKdH2TcdVd7zYYPLIrdkDv1VHAamSqUJcR+8FW2gKhRax7L4cXWKD3PwL4FuAmsyDOJOee1Ft3ES/iSQ98mZxhPhuy+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286488; c=relaxed/simple;
	bh=k30F85gIAsZxN2RAS4fJ8/iKovFmcmvtsZQoYXGfC78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WgFTfL68Qv9Q2I1WbiGIoKqyG3nv158rp4k+FS973HJFyP2wtS3647TYqRuqGzDSPvy38rh3dpF/PDktb+7SHh9CT5lgfV/x43CG8PuF6n5Brry9GOV1GAm6juynH7UNVxeh+w4ZpJgaxs03hXVWxHn2u6fozc4g9sKi0KTegCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rJYYeK5F; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rJYYeK5F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E16FTOnwpgVZmYyTkw9ufXbE/jFKrkfi7tNMJmJKQYi7t1nFF3LjCWuwfXaCFMUyBV7cY2kdEy2lAMq1XhZ/d+Mz2K98LNcV//8/J5tC3S+mPbpbenbYF+sRJPCHNg4te2vrFmKJV5VkSVYK26PHGJjuWdEOmMD+nFTb4+FNxeCJG9s02tQdI7E2+/o99uh4M3Dre31dPadTPk/NwAJxl3bERxFQcnHP5Ne/nngrICbv2ow8q5EQtWBjx1HMOje9D6F5M6rJJ43xRJrE9LK2JtDFaDm0Nthu6pM2Ewo4mU3Z4OhUVjNZw+bwHOBCvxExn4Zcs4H/DAr5u01US2MhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQUzvakqCKTZ2KEwsy641aPUscenx3BFjIPUkcYvhE8=;
 b=Y6dwo33OysRI/aJ2Te6lkhGD/GqKiDx/7Hf/PHay5RuoXYG+nblRFnc7fh1h5PzubSb1XBdeoWiMNN4hB/SXf+qBt7Ac1FLH3bfgW+iSY0d4szDYx2WYzcqFzMHjJBK8n+1Scj6C8ItS8DpsAHBMhI8cOFj6pTxXdLVX8Pd2wVA8MhcYdgNPUBy0AovurQ8W+6gELOPs/3V5eadP6t8qYt2GUJxDQzQNKn0AYzf5t/JArmFr66npWCpWm7Rd6lcDZN9aPqJ1T3nL+pTPetRrlsiDqXGDMrHGbLiO3ABtn5KTVud5WBVF7yHgabwqoqqA/VyoLA/ryNs2/p3yGYiLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQUzvakqCKTZ2KEwsy641aPUscenx3BFjIPUkcYvhE8=;
 b=rJYYeK5FF+phq/xfhQGfO+BIZUwyObp9Gfh3TVSeWqCkXVICBHWqEVFZ6libi3fJuTwtSwzTiFtlWMhGYpoBtdzVTuRZ7dG9Xssis7I2Eg69pHYtUVjCSAd1EBkDEeLKHOi5VHt13LgtxlWBM1D1+KmF5uPW5k5PXgmAQj/A3Q0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 04:27:58 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 04:27:58 +0000
Message-ID: <25b9e249-053f-4560-ab3c-eaa30bf0b240@amd.com>
Date: Fri, 21 Aug 2026 09:57:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] dmaengine: zynqmp_dma: Fix PM usage count handling
 in probe error path
To: Frank Li <Frank.li@oss.nxp.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260810100452.426320-1-nagendra.golla@amd.com>
 <20260810100452.426320-2-nagendra.golla@amd.com> <antKJr1N3A111W_V@SMW015318>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <antKJr1N3A111W_V@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To DS4PR12MB999075.namprd12.prod.outlook.com
 (2603:10b6:8:2fc::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB999075:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eecc757-7b4b-49dd-bf9e-08deff3c941f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qn8MSFk9K53f1bweGhV6r46GwpFwMWV5ghly6M2RuFILXFvQDmv9hqx6tN02MzYzGhHUBdiwGQv3b1mjqYFWLqu0w6GMADPQR3ZKVykmO2tZQMMV9D6H4LbJYoWYSQd3P85pWOh2A9vlh0OmsxdncXTiTWu4iIWU4qu7ooaCHonMrbDGgVQ5d3TexsVLQD3MBhj1/ajlgGJPyoKUugaEuLjitwyM/b9rUrEW3w0FgcQJ182Vcc8SaZUjp6s+1Eg/TcMtNbm9NhN3h1nXRgWNAgJjVHWsyoMlG+qmQEPTKPK1uEzGiXbN5FHAzAfgJUt2uaJz9Y50Hs9ARSniBh7LEF2LC0hMNciNC7fsoNUvhTDHl0l/pQmBxlLiVMZC4UTFn+miK3M28xhuuY77L8OLsbRtvvo70t3DuKZOYJgBooJXq+81s5anpY5nKpal8NM2j4vzUcz9k1Ebvfm1qgOc8sBw5uZKx31Didm8X2T8MPfGmpMSj/S6ZUAIVA76Vkd49ujzoughaW88Qc3QSLugatVXybg8Eiedofw+CuUXDZEuWYTKl5AN8/zciD0LvMKybqLGRRhggFr4yKdhJSxszvoh5ycQA4SFEnHD9EuibdUONJcUbLAIbuKFImuj/OesXa40XwstBDPNesvanSGJz47CV/Up8c5mJTanVq5FpCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1hvNUJabVM5VndrVm95cGdVQ1VtdktVcG1KeXJZUzJzS2JXSmJsSklqR0lN?=
 =?utf-8?B?dlFXMkw1Rys2bk4xK3hyUjE4ekp5NWw1YnBqUU45ZnJlQXdtSG9XZXlaZlQ1?=
 =?utf-8?B?Vkp5L1Y0TWE5UktqeVEyRUpxRkgvSHcrMnZTMUJ3NG0zbEZpV0pHOXVyRS8y?=
 =?utf-8?B?cHVBNlJGTk5EMVU4aW1QQlhhek1CQWZpUmQva01Kc1VYcUY4NGxHNHlMbUdI?=
 =?utf-8?B?OVBHOEdsM3kwS2dEMVZqaThJdElSY2lOM1BZcWRVTlZxTW00empzclBmTVo0?=
 =?utf-8?B?MHNlMWtTVjIyQTYwMVRpT01BMXVrKzh5TVZEblJxcjR2UFlhZVNHb3JEckFj?=
 =?utf-8?B?WE1naC80dms0cEZhRk1ZVThIM3BqUlNTOVJxK0hqa3daZENDRlZvYWNMTDhO?=
 =?utf-8?B?WnRDWnMyYWNIVk40ejdoL0J0NmVCTVZiR3dmOFpnTVNtMjRJMDdPdGpxL0sv?=
 =?utf-8?B?STh4YjFIMjdZdnJZeXR6KzFkUFpmMGJ1alhhSjBXQXlkeTdGMTBYSkZKTlFN?=
 =?utf-8?B?YjRmODdpUmpUZlAwTGhleWdPSFd2TDdDMlF2dmRhUDZFNTFUcitBSVA4aFpk?=
 =?utf-8?B?cjUvTzZKQklyRGxORTQvOGExdTRzak5DRTNLYkF2L2gzb1NSRDIra2JZVWo5?=
 =?utf-8?B?WlUxRDBPYlc3MHpKdmpaTEx1bG5kenY4RlRIMnZ5czZtU1pKcFJBZHhacXoz?=
 =?utf-8?B?REh3Z2NseTYwU25LVzQ2YmJsNmZDREt2U3FmTGF5dVloV2ovMUpIcVVZVFFa?=
 =?utf-8?B?enJzeEZ1TVQ0U01WRGlaZ1NqM1VwelpEcjlVTWEyTlRJcGpxSDkxSHk1cG8w?=
 =?utf-8?B?NTdoVlpESFlhQmN4VmxGemtnSk5LQ0tqWXI3bDBsLzFGRzR2Y1BFenhpenVh?=
 =?utf-8?B?RExVUkJYUVlDYmVLSTRvY1dmVkdWd3Q1MHdGZWNYNVVCckI5WnU5REpsV2Z3?=
 =?utf-8?B?clJKU1BYa0lVeFRxdzBFZlVESXBCTDZpQ2dMU2NTRGcxRkpmcWRrMVJlY0Yy?=
 =?utf-8?B?U1VLOVprMFN3bklNN3o3bnkzR05adFVjK0NoeXVCZ0pNc1dseExzZTNZNnVp?=
 =?utf-8?B?WGx3K2JIRytRRk12Sjl5ejROK0tZTE5FTDNKZXo0N0lDbmcxdnA4SXgxWmxp?=
 =?utf-8?B?NzEwMEVUTUVaL1NjOVlaTFNEemRreGprN2ZwTjBhd1hDYUxFdVpYdEx6R0lL?=
 =?utf-8?B?T0FTSlBGMmc1K3JNZkZYS1d5dVhmQmJ0TmVaenpDZithMDdDeVZ6YzlEQm05?=
 =?utf-8?B?TzNabG1xdkhDQWZ5SldDb2MrY1VFdVplNlBEd2JXOHNwZk1zZk5SMWhoLzlk?=
 =?utf-8?B?cTdQTTlRSmdaaVRwSmdvWVpPNkRDVVoxVGtSQ1hMV245SDhpVE45RHlxckpw?=
 =?utf-8?B?QnJ5dFhPdUVzNjgya0RCdzBPMC9RbERSMlVFay9IS2pBYmtEMk1KV0FYT2RC?=
 =?utf-8?B?YTFaM0dWbHB5NWpFVm5JTXZDWThvZjl6YlVmckk3RzJuU1Q5dk1zRnBGWS9n?=
 =?utf-8?B?SU1mQThuNUZabm0yaXYyYzJkRitrVVlaRklqRmRsMks0dFpqU3JWaTJxWS95?=
 =?utf-8?B?MkVkWDZXTWo3WjJOamZYOFlNeFpFa1ZENWRPc2VOc1ZLZFJPK2Q3WmQ4RDlT?=
 =?utf-8?B?ZFBXOW9MWmJFazcvQm5YU05OQXFIdVFKb0ptdm8wb25Sblo1VFphcVp6SEVj?=
 =?utf-8?B?dTJ5SFdPdC91YXRhZm1kOE85ZHFSSFVGTDVtcEdRVUg4cGovbTFmQ3VOYytU?=
 =?utf-8?B?Z3RJM1k4aXJ4TUE0aWpuZkVCWngvRFlnRitOcnk4WUFMOWtNcnFzeWpIUUdx?=
 =?utf-8?B?Qm55eHY1d2p4RVRqTDZGNlgvdlVNMnVFRk52dzMvYzgxaFZPUDFRMS9pNUI0?=
 =?utf-8?B?M0lZN0g4ZmY3cW4wc3NuSGVDSEFqd1dzTmYwL1lzSE5mc01zZGRzbStxVkFH?=
 =?utf-8?B?azQ1WnZ2T1BMSEFjclQyU2IzS1JZYkt5NW1TUFMwOGt5S2lnN2lyK3drQy9v?=
 =?utf-8?B?OGdoTWtqck1OMm9jaTAvRkJaSDlobzhaV2pQMmVmZ1hQN2diUENSTU1DRzdl?=
 =?utf-8?B?UFMzaVFRYVJSWHhHaDJwTU1leXJ0MVVMZ0p0M2Nlb2p4OUFiMnVoZ3ZrU0xO?=
 =?utf-8?B?TjVIbFFvMTI2QTdMS0lad2VWc0M3ZmpOZW5iYXBGNlg5bmhKME52ZzluVDFs?=
 =?utf-8?B?MHIvL3lOYW9hMWtrNy9DTDIrVFFVZGo3UTF6RUhYNEZRNWtmWngrQmYxTjk1?=
 =?utf-8?B?UDVxRzJqbVF0L3RMajhIb2xpbnJjZkFGeHB4TWlFTUQwemxWU1lpdE5XQWh1?=
 =?utf-8?B?VFptSndtTllQb3dqS0NvUk1hWUtZTUxsN1hHSzBIWmlZL1dwWENxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eecc757-7b4b-49dd-bf9e-08deff3c941f
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 04:27:58.4685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCE5B8BzCPTKjF6vb8v88mjLoxvJGkZGB6p0yx1156kYxxXn4YxRgbEffnJoJC3+7rYxOriGH0sinhdpWuQUvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696

Hi Frank

On 8/11/2026 9:43 PM, Frank Li wrote:
> On Mon, Aug 10, 2026 at 03:34:47PM +0530, Golla Nagendra wrote:
>> When pm_runtime_resume_and_get() succeeds during probe, it increments
>> the usage count and enables clocks. If a later step (e.g., channel
>> probe) fails, the error path only called pm_runtime_disable() without
>> a matching pm_runtime_put_sync(), leaking the reference and the clock
>> enable.
>>
>> Add an else branch to drop the usage count acquired by
>> pm_runtime_resume_and_get() when runtime PM is still enabled, letting
>> the PM core suspend/disable clocks on the success-then-later-failure
>> path.
>>
>> Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
>> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
>> ---
>> Changes in V3:
>> - New patch: split from V2 2/3 per Frank Li's review to keep the PM usage
>>    count fix separate from the per-channel reset changes
>> ---
>>   drivers/dma/xilinx/zynqmp_dma.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
>> index f6a812e49ddc..87986f65d24c 100644
>> --- a/drivers/dma/xilinx/zynqmp_dma.c
>> +++ b/drivers/dma/xilinx/zynqmp_dma.c
>> @@ -1152,6 +1152,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>   err_disable_pm:
>>   	if (!pm_runtime_enabled(zdev->dev))
> 
> You just enable runtime pm above few lines.  Is it for CONFIG_PM?
> 
> You should check return value of pm_runtime_enable(), or change to use
> 
> devm_pm_runtime_enable().
> 
> if devm_runtime_enable() failure, you can direct return. Need check
> pm_runtime_enabled() here again.
> 
>>   		zynqmp_dma_runtime_suspend(zdev->dev);
>> +	else
>> +		pm_runtime_put_sync(zdev->dev);
> 
> This one suggest use PM acquire to fix this.
Thanks for the review

The probe error path already holds a reference from 
pm_runtime_resume_and_get().Using PM_RUNTIME_ACQUIRE_IF_ACTIVE() here 
would acquire a second reference on top of the existing one incrementing 
the usage count to 2, and the guard releasing one at scope exit would 
still leave one leaked reference. The guard is designed for cases where 
no reference is held yet (like the IRQ handler). Here we just need to 
release the one existing reference, so i am using the 
pm_runtime_put_sync_suspend().

Thanks,
Nagendra
> 
> Frank
> 
>>   	pm_runtime_disable(zdev->dev);
>>   	return ret;
>>   }
>> --
>> 2.43.7
>>

