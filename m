Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50D390987;
	Thu, 10 Sep 2026 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073985; cv=fail; b=FxfDs3oHJHUR3tR+eNtozDSrr4l0oWPk04ziMf+9CX2UcyW/X7yk26M4vGwHoDKHV1bu3sa1pdUvFB0Sw9dcmp+F9zakAVgHm9+y9guYtsQ0p/kzf3KhgM5gPysctooJjcU5V+K/unac24hthX2Ga8ChwQHflwnyzfYms2RWS38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073985; c=relaxed/simple;
	bh=dYwiBDN1aCohz7rImgW9Sq5IJDFG18yxpmit8+HV930=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFPi9LEf5UUppPj5junND2eh/D4YjcOrM0AtXBbEUymIceiiAZpgPcNZW9QMv+LzVUTHZ+Ml20uz/yPRQGpAI4mSjyLFh6cWFpYhAHu9l3QEQbf0uwa61zWv3IFyYB/AfB0hu3Mn41ZpE8u8RVrZRQVTBlQ1K87G4GSusm6SVHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cG+bnnxU; arc=fail smtp.client-ip=40.107.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cG+bnnxU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKrH9AOJrMhG6yD1U8ATYjMZiRTUMf1t1FUygmfjX0iO37EGdktx1390KZn9HnZFh7vv0bATBSUFw83kZsQaInZYTtvsr1G7QSiOFVk1tQIvRrKIOrVn2seceWU/OEuuNkVMZ8eJbBGSatEI+RhB+dd46OjYJ2gUtHp3x5/X5VBPZMAk7vIH5PJH+kXCkwmdSwC9MfnbOKNwf4JehTn/bG6D4yLddj68fccnz5oIAxtfT5NhXysLZn/lk7oVfvjX787pH5/ilv285DxmIWXUYVz0cZU9PbLVnyN9Ruc30JICMFgFmtejHFHVfRV04T3DwiE2vXy8ljdLvFmT7HtWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxxYLrq/Xb3hvlt/M44wtNLizDqeh8wnx497xYneJFg=;
 b=vhF/jeCQoRE1REaqqhB2YcMEfxZsksYjFa1q483KxROYyvs7OHdzwRdIuZ216rUTlCq1Muviiy45RL1DgJczLY8O8I1TjvDBXOCq9IMbzQsoLQpoekHMyTWuB1U7nNPQFOnvvM/0eyeUwcn5l5ocT3Z4B2/KVGIAdnGSfXlbcSTda6Y/FiUgmIA84FtFjNfMc+ANhLPv/dbhVpVrBrzjIwE/13AnR9Udh+6auFLf+6BkTjmziNlsoPr0SjS0Emv2x0vItcEco4ETFbpP1xhSaUz/U7lmmbdIuvNMwWvzIfHHdaXeSPc1tb5mWxeF0PlAs2dz5FM/1pdKLCkDTmUV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxxYLrq/Xb3hvlt/M44wtNLizDqeh8wnx497xYneJFg=;
 b=cG+bnnxUbi+hHc5PLJLr8m/S2HeHB0iEr+JQU5cAHzYi9ftTqQ//D1KQqsswuLIJ+siRJHMw+Hi2uF7xbYdvWd2ZKp2U90kFvdzWlnmAMePQrCrYM7JOKUQ8Aay/E47jh5rYHTzmx1BXsVAot+5jYAHJbN+u4LmvAaGW42QQt3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 20:59:41 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 20:59:41 +0000
Message-ID: <9324cce8-aac9-4081-ba6c-65da18b80bc2@amd.com>
Date: Thu, 10 Sep 2026 15:59:38 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 0/3] Add support for Zen 6 client EPP tunings
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <superm1@kernel.org>
References: <20260909033623.454449-1-mario.limonciello@amd.com>
 <15beffa4-aa61-4e9c-86b8-764fd43989b7@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <15beffa4-aa61-4e9c-86b8-764fd43989b7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:610:cd::27) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: e66a2a91-7f2d-4ba7-71f4-08df0f7e6ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	C4bdoI06xOuTNmDLtzqfeCoEzsY3hVIhe3eiUSeH6NliHig3ZnnZITFEB72Eja1RrFWGq3Wh7EfGk+Sgt74Wv3KCopmXe03BH37rvLMNCsez9gVOGOP5LjDNNfohR7G/Hpf4RcumK4+OOJdXawQ3K1ra9O3ruBn0Vc+G2age1lmBCo5OkLxsi9y5z7fKH+2fzswrsDffJ1BaWJzkZBCiuYYxXOr6Zaibz/OHLvU6Hkh1T7J5ysaeO1JmN3V4QPI4QI87+jHvTF5HcZe7328yKehm7djebD65LjukcqoZXhJb1eaoygGI+IvTIWYHZ9qg8iEOGeKxuiPioY1SKEzaQgF1xl5ri/wmgW6LLvWeZhR47cMoVDeaq6uxKYCtBQ/h7yIF8Oq1gGRJEcMpKtyL5Z0xa/dIHfebCVILAyG0gyg8bUPU8CCuqkVRloJWjwes6t9IABHqOZ5S3uf1J0lH5REbJQqy3144z6QwzsgBnABumUkLvXDmO7l3SM9h3qp7hCUxHXU/lRhMYWvdltF3NxJWAte5FuOjYylVv5MGY3EhbzSmP0bZJFDSh/qSyT/096UCQkxEz/nAuLR+xfhDoSYO/FMWEZAymrCsBsEvkIPl4iovq1dZTHr5CUaRxHN4O2pZX+nmWDorX3NPGFsE/093fVC0cPfF5jq8Ql7Rmnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2FoOXo4aHJ1TEQzRE14R2tCb2VkNTMvdmZsOGhueGg2QnJDN29EK1NndEtR?=
 =?utf-8?B?TFRkUHJaNjkvcjhTdEtHUVM0QXp0aXFJcFYzZDJ3dGZkRU1YZWN5cU5kU01Y?=
 =?utf-8?B?ZlA3eWdhTXkxVmF3Zy9ETUxKd0FDS09mbVk0aTIvN1JOb2xjQWE5eFVTMlFZ?=
 =?utf-8?B?NE5XWDFkcUJtdU9LUC9sUnR2Q01ySFFydG9sNHpaVnVMc21HQ2JpMHVIR2dp?=
 =?utf-8?B?QXBHVldUUXk0M1R5cFRHWHNJUzI5QjVSYjZnbHAwenh6QVVpcFhkd1VyUklE?=
 =?utf-8?B?MXR0NDZjY0xxSyt3OXc2VHhkZERDVjhjVTdmSi9zWSsreXFZK2RoNmc0NUkw?=
 =?utf-8?B?OTQ0R0oydFlzbmVNMzJpakduZEl1cHRJSWVIaXoxVU1xZUxjZkdOak15OExK?=
 =?utf-8?B?L29UUmV5anExVllUTjhqd0dMTCttSXJ4dWhZNnRPcXBodGFCaUswRVFWRVlo?=
 =?utf-8?B?L2tqVHRHQ2MxbmYzMnRaZTZtSC9ZZmpKSHc4VUw4UjFXQ01Ob2g3Y0Q5Zjd1?=
 =?utf-8?B?bi9EbkZUYVFXcjNJNnhYQmhreHpsLy9oZlhQQ3B5ZGRiMjBLMVhJZnpmMzNE?=
 =?utf-8?B?UWF0NFF6bzhkVjViODdmb3l6NVpVSVNUVUI2am9GeDJiVFhoQUlwcFVwSXg5?=
 =?utf-8?B?UDlsK3VEWFJ0U0VnZDA4YjZVZFEybmVIa2dwWUt3eU9Ba0h4YTdTWG5xSHB6?=
 =?utf-8?B?dXFBREtBbHpCZFpjanBock5IckRyVy9uTFFUNjk5T1MvWkJaNm9DdFVVTStB?=
 =?utf-8?B?UmhkaUZ2SHpMOTZWWmU2Z3lpWS9mWk9mOUhmLzlRNExMQUhaQkl5K1BoS0o1?=
 =?utf-8?B?cWd5aEJzR0QyUzlhdHJzem4wR2tzdEhRNnV2UnlZNzJVcERmOGpWa0ZtTnJj?=
 =?utf-8?B?UmVRajlHNU11NVdFWmJVekZwdlE0Y1dEYkc4T0lEa01ma1lJR05kZWdibWYz?=
 =?utf-8?B?YnluYUdUeHRLTnpDdVQ1dGM2Y3dIUWcvUnM5Y3EyNEI4L2JWUER6S2crbWJv?=
 =?utf-8?B?WjNQcDQ2T3V1Ym42SFFGajZ4d0QyVlFjeU0yV2F6Vm9zOVc3b3ByMXJBWDli?=
 =?utf-8?B?dFNlMjFQTDMvWEVyWi9McS92dTlGb1UzamY4UDBHN1pwdTJmMGErNFprTXVR?=
 =?utf-8?B?ZFBaMjY5TjZvTU5nVzlwdk1oOG0rOERwTnRRbmhRbitabnBWY2d6aTlwQTdy?=
 =?utf-8?B?TU1kSkM5OXZ5VGdUd08wMnpiaEhmc3EzSjBRZGxzSWtLQ0orRmRvQ0JNWVpj?=
 =?utf-8?B?b1h6d3RQa2ZTcnlEYW43Um1ISlZheERyRDR3SHNkeEF3ZmZ2Q2lTWEVpbm4z?=
 =?utf-8?B?Z2lGakczY1djLzRZc2M4UHNXVGJub3daYWF0MmJnc3dvTUtLTDdFa2xkNitZ?=
 =?utf-8?B?bmx6MlVlbmZRUGUxMlJaMTR1Nkh2ckVpNGlzOEpUaUtpZU56clE1NXBlTGE1?=
 =?utf-8?B?S05wWVZUanZjZzdZUnppQk9JL1owUzdmWXlWWnpPTzhsaWl3bkFGakZHLzYy?=
 =?utf-8?B?YXRYclR1cEU0bVpxaGNxeXluNk4vanE1MDFWaWxNYThTY010RjFtYTZvWmlF?=
 =?utf-8?B?TU9hVFFZNDBzMGgvczIwZGl1RG9TNGtObEhPcXVMNjFKMmlGRDY2RWZkU0l5?=
 =?utf-8?B?dnZTbHZqdjVqdzVaWlY3QnZUby90WEZpREVpZVRlUlVsRTlCb0cxak9HcE9S?=
 =?utf-8?B?NEVpaWZ1N0hHaE1ueERYTXoyc2NnTWdlb3huQTE2MG5RL0ZSY2h5N09IcUpI?=
 =?utf-8?B?NVlTaFUvTWhoWlZlL1gxUXNJaENUMDlIVk9RcG9rMHpESStWc2dQaWJ1STh1?=
 =?utf-8?B?aU56TDJZeGljWnBsVUFsS3lHbmk1NDlvV3I4NWhZYzJWYytneDA0NFFWQ1VZ?=
 =?utf-8?B?aW1JOVhkVXowYm1xUUhjWktUQkI4c3hCWkZaYUpXQ0UvM2tPSUlndjBlUVhU?=
 =?utf-8?B?SmxHSFdCWHNVUkNScEdHLzFhajAvZ1laZVBOQi9lWjlMWWZGZG5zL2NNS2Z5?=
 =?utf-8?B?SURoVkNPRFo3Q3VyVzNxUVREMFBOcWtzQU82ekVMUXZBcUdPNlRoLzgrdXBi?=
 =?utf-8?B?L241bHlUd3lONUY4WDlBVnZvcTRweEdOYjJNd2VSRzZRWmFzcDkzb25yaGE4?=
 =?utf-8?B?NnJYUStqM2VuRWhkN3FsZi82YnYwY0JEQ2Y5aWc3UEQzR0hTNS9uT0oyQS9k?=
 =?utf-8?B?TzRJaXpZZmpJdGV6VU41TmsxelhXdGNLb05XZlJLTHhoQ2FRdlRHSjNPR0c0?=
 =?utf-8?B?VVc2QkV1bjBsYTQxVnlkSUVFMEdzVWROaXJwR1RJUXFHSkZNWDNkQ2YxSXJx?=
 =?utf-8?B?NUVWc004Y2Noc2ZSZ3E3UHRub2J2K0U3cXZQQTc0RHRaclpHU1ZGUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66a2a91-7f2d-4ba7-71f4-08df0f7e6ebc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 20:59:40.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbGlJuDX3FxA8Jhk/LWwKkHf3S0SWF5tlFvU5//wW7MFIDKKuYtjF3pmNRrfHwbZWMFppzOEZRc4dA+6MVRJZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348



On 9/10/26 02:32, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 9/9/2026 9:06 AM, Mario Limonciello wrote:
>> Zen6 client platform firmware uses EPP values differently than previous
>> platforms. To optimize performance and power consumption tunings are
>> applied that match platform characteristics.
>>
>> v3:
>>   * Enhancements suggested by Prateek to patch 1
> 
> I took it for a spin yesterday while debugging another issue and
> everything ran fine. Feel free to include:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 

Thanks!  I'll bring it to my bleeding edge testing tree.
