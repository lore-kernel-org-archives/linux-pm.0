Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FA3D16EF;
	Thu, 17 Sep 2026 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670203; cv=fail; b=QhzfNvTPfHEDgUnqRB+OltcrjAVWngdSnNvzWHERB+X7MwCcome6RwR3oDlp5iUP149gAfYiUIFxXJR4oBjCVuFpw7pC5S2O/CSTBrVZQhdnDo2HTwv7xvSUHjzdWKYo+cbKnAORlNpSP+wu5LA7ATeVL8xh4VQ/v2oq9RvIGw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670203; c=relaxed/simple;
	bh=dIJmHClj2tlCcSYfxhoc3Cj6vBXW8dQnoWoY8bs/NUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c3FCV3yL0XYdrZyvzYMPlVaBogClQaI9JEMkZPG/GGrjceK43poqaW2qMoKG+/p/+zO8zDXjyx9DtvqqwOUDaDh6MeoCWD4LPh4lfh4XNHoIiBoM4FW+mxWvbGyxv62zWTVjLT4mgzjMOTF8XWw8YDfcnWot99cnVZit/BLwRQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wXIsff5e; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXIsff5e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RraxD2OWjdLYhbQ6xQ1IBVz5XLWL4AOqtqFOdOMxoGf9+ARGh5Z9Jmh4kBxwz3K3kEsfoQ6Woqo4NOKRjT5ZssFRS5RfGYSAUOOZRdZ6AZLuWsE6IKcIHK7yMlFTQRg45umZVOXhDglioBtpg3z16FNpNJmtdABVc+IrllHmaLRTHg9qPajHMJD3p5Jn6hlCirp50wpxNSECmZBhVfe9uQA9aclJ9I+gG4+URq3XKTKQUIzQxlav+CaWqUkX9a9rISe+mo4AfNH1zi+N+8euz9sN6Q0HhPCgB0nI/RdJQltxAnM/zjtxxrqMJgZJH6II5VuVRK4+6+ml849AQfkb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIAWWVrE+swqtpKZ4RNQhgSZoHKpl+s3k7MwZ4bhQIE=;
 b=N91GakH2HHqyPIdohpGf0pSd0o3egLGOelb+ZCVRFh2DtzvCmKuqK7hxliWNn4/u8+BhNPyvV8meqFwkb4+pMM79mQVqbNrrLWQS0ngmIW7fggnYJMC58Oirgxl06yioczqyRgaziyaf2BT9c6RymFFMG88ftckYOVs47dK683mO2YIJlY3Yk0bCh1c6E5XOhjkq6mfvGweUoEsgyuJhhokPydKZ3XYzQDaluC3OKNR9L0Eoj/m12ShkZI+958/OWFEBHaKTE0fvuyPdHuNPH3JbbFcdxh35/IjSOBKsomQlV+s1ZvWUcNHphPA1EjVA1nwe+lku5vGhDuCOS5Xoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIAWWVrE+swqtpKZ4RNQhgSZoHKpl+s3k7MwZ4bhQIE=;
 b=wXIsff5eKJ2eYRroFAYcb2Ur1ib/5cbVn1Ynp1XAg9HDsubXfr1u61V8ta8gxlH0WteTVVtjkZoJnuYMkFB6t4b4yx7ZvVgikHp7JkYDrDsVW/iqaADsczmgWbHrj3iQ0H1xTtF7TxKmZkQbvJgW69Qt254DqclmGh0LR8psyUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 18:34:26 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:34:26 +0000
Message-ID: <a92b1050-5f67-463c-977a-87af9682656d@amd.com>
Date: Thu, 17 Sep 2026 13:34:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Use a non-boost reference frequency for pressure
 calculation
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Jianyong Wu <wujianyong@hygon.cn>
Cc: viresh.kumar@linaro.org, kprateek.nayak@amd.com,
 vincent.guittot@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ray.huang@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, pierre.gondois@arm.com,
 sumitg@nvidia.com, srinivas.pandruvada@linux.intel.com,
 hongyan.xia@transsion.com, zhongqiu.han@oss.qualcomm.com,
 jianyong.wu@outlook.com, wangfengyu@hygon.cn, zhongyuan@hygon.cn,
 huangsj@hygon.cn, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <20260915065747.1671965-1-wujianyong@hygon.cn>
 <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::7) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 556fa067-c664-4bdf-df1c-08df14ea4d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4lW2ADQ4eP/R4Uy6Q9RCklVXcsKEyC5Oja+zO7Sg7RySSS8ElAQDzqztEV+AFrDqeZE9PcPQ/EZI9RORhcSi8b46AcHWd95HJ65m1v0a6S4Htsux0ZMexYreeMvc3wPpxG3dF56NhISIqCTz/rRmZMZwLg15KrOlEtu+JxFbA1VM46/DUkfJ/n9VTJ07FtPsR7cRA2IX99PlW51skin9RFRkuzfOLfGy97rNYmEBN/aIvZPYgrOnxxQTOgCDpXui+b1uNme8d23Zk+VW3CrFdcI3KqK0Wu9e1qgijSIT01Ba87rj6vA7QdyypkPYFF0yGVF7ePBuDkJFcRrl9j9Hg3T7JbSUGch38gn9G47qFl1lnqKLT2M+zM9voLaaPO9wHMLKlZP97ggJYQF71/IcM2b1iUz6FV+U7eJdLKlEuYEcSr4LbYEKPchMVRyKyhJGoCJmQSjtlUt1YZaKxThAjE2ZAj34XVxdu+RcIkTv4AMTRNWl6rFBrJSmSurjEbLQXHE/VUtja8S/QO6J9i3/ClfIeWapKEniucKSwrAL0ssxWm7QwmjYbjTIjE8pvJo46zxcaoGq+L6du7h/Gr/hDUP8EMGAKiC43sMDzbHU1Tw3GcERdwcpodgvkwHRrUOcTNhl6wolFCqg3htomWwyFLKSsMotYmNt7MoRegB7RWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1poa051ZkY4QUYrVHhmZUNqMjJsTHAxMXN5WVcrMWdoVXkzV1VKejBZTmpC?=
 =?utf-8?B?bER3dkdyNmxwbjM2VkJYTzBnWkJUcDdHcVdQNWJPM1lkNklRVCtXKzkyS2VH?=
 =?utf-8?B?dlFSRDQ1Q3o0TU54Q2F3d0hLSmpOemE3czZIQXZtMVF1M0NIc2srM2d0SnNW?=
 =?utf-8?B?czlmb1IwRVk2ejBBcVlJWEFJa01wVzhsdjUyaTlTeWRObGVPWHdEd2NxZzRp?=
 =?utf-8?B?TmZ5bnc1MjVrZ3ZtbmQvVjgyOTlsYXZHVzV5Zk5tS3FPNFl3dDhKeU5tbmVH?=
 =?utf-8?B?bkdtZnBJY0VkZTAxSDVpY0EwZWY2eHJ6cWdPRnJVUEZVUVVvaXppV05ZbXFY?=
 =?utf-8?B?enpteEhsbG9mdVRLdXVWdlQrR3ZHUVQ1Nm13eWJEV0N1U2ZnRXlFU3N5ZHJ0?=
 =?utf-8?B?MU9haEtQY2FVbk8vWlhYSGV1cjhrV3JPS2x3S1VLSEs4ZXl5dnpES053dVQ4?=
 =?utf-8?B?cDUzNnZVRXZ5Z3dOYlRKNEU1RnV5QzVkcjlnMHhzc0RzYUxJSHVUZkNlZHZH?=
 =?utf-8?B?cDIzZFl4dFQvTGJXalM2UVQxbTl6V0Rpc3ZheE5ESjNURkg2WEVsSUQ1N0VW?=
 =?utf-8?B?N1J4Y1Z6TUwrdVlOd09aZFlsNUtPME4xQndDY1Z1U0JkV01QOXdGOEFxclJS?=
 =?utf-8?B?K1RhUGZ6RzU4cXk4Mjg4OEtvVWJPRlpTQ0FNWU1BTHFlb2Z6ekQ4NjBhbDNW?=
 =?utf-8?B?T05INzVnMWFFNTNVREw3WUxxSUs2UnpFOUNKeFcxYytuYjNlZ24rS1hjaWpu?=
 =?utf-8?B?azd0NzFLK29kL3E2YjkvalM0SW5DRU9TZHF0bG5PdVB4VEsvTGtxRzczdzVh?=
 =?utf-8?B?VGYvRVJ0Z0dROEd5RjcrMkZQeHlOV3hneFhFVjJzTlhMUWVNNk14WkMwWXZQ?=
 =?utf-8?B?WUFLWkJTUWV6QXhpcEFVbzlHSTc3RDNIdUxZdExxQlM5NitjTFBabktPOGIw?=
 =?utf-8?B?ekVQRHdBbzdncjZiS1cwNEJGSVlad0FZTzgzc0NhY0ZacmZPcmFVaWM1Y0lt?=
 =?utf-8?B?bXgxTDBpWElMdTZmUnZUb3dEMjNySjR5ZmV3Si8zMjdyRzE0c3NGVU5aUzE4?=
 =?utf-8?B?MWRXZmpRUm9lWkRoeHNESDBaWXprYzVFSmlJc2RSdHhaZTJzelRhRnlVY0xM?=
 =?utf-8?B?RXFiMlluY0ZmcFg3bjgyUWpKZk8rMWljbmJOd2pIWEw2eEF6RXRBZUhNWDlw?=
 =?utf-8?B?cVBuR29VVUFKQmJ2aEdaQVpCVlprMDRZSzQ5NWVFRmtBQVd6R1BlQXM5eVRQ?=
 =?utf-8?B?UjQ3WGpDc3RLWm5GWTJZTFJyeUZsUm95djhVVXk0TEpZbEFna1duV2tvczdF?=
 =?utf-8?B?OWNOeGpCSVp2NG1aVnNPQTBSVDNnQngyTThmdjdIWDJJdldNYUV4S2V3aXZ5?=
 =?utf-8?B?bFdiRkZ2NDBhZzllRFduNjBnT3kyZ1k2YW9CODk1RVJ3OW1ySklicHRrUDkx?=
 =?utf-8?B?REhxc2NERGtXUDlrSzdHcFBRdWtIK0hXVUZKWXo2WXlzRGYxTm1XSjZ3WGVV?=
 =?utf-8?B?TVBEVkJYK3VpSXlTMWp2aVNvZFdncHl0YjN1ZkJqQk1pSGpkOFd0S3pTTHVh?=
 =?utf-8?B?SDU0eGVralBYR1BxWTI3Ri9BQ2JEakZJcTk1dXYwNkZaeDgraFRrczgxVGVi?=
 =?utf-8?B?dnUvTzk1RktKM2RtWFJtRFNMQVo5SlUzTm5hbkR1cmxiK1Y1R012dkRJb1Jw?=
 =?utf-8?B?NXlCcHVKQ21MT1p6S1RxOFUrWndjM0FjamdHdHdPcDB4d2RBbEV5RUszKzRN?=
 =?utf-8?B?Tm83bURGRWtvNEJYcHlWS3V1MlJ1N080MjBrbk5qelZWVlhUeFFrdjJyNzQ4?=
 =?utf-8?B?cDJneEtRTURJZ3VHRmhqQ2wwV3JsSnlUaUxXRERvRUVWcHB0WmxLdHI0THhK?=
 =?utf-8?B?ZzNHQXpodmFySzRwbHBBK0c5UEpHM3ZxaGdHOXhMckFPZUIzMW9yY0hGd3lo?=
 =?utf-8?B?aGYyQWRaZkM4WFVRL3dEQ2RhTTBYeDBpK3hhRU9JU3hpRkZMaWRGRVpOTzg4?=
 =?utf-8?B?RWlaZUlDQW80eHNpVDVGK1BhcDlzY1hHU0lhNGV3alNGWEw2cFBhMGJnTmE5?=
 =?utf-8?B?aGdYZHkwT3dpdjBtbWlwQ0dzcHRkZERxTjNOdHQva3RKZmtJQ2tqM3lLa3Ix?=
 =?utf-8?B?MzROSDhKc1JWa0RKazEyNzBUcFlsb2d3MlFocXd1OHE4cW1mS1VpOE5MTW9l?=
 =?utf-8?B?KzZXSDBVT2xQdGVwYVUxUVlIRGN5dkxLcXBtWW56dktnSS8xUlp5dm15SFZM?=
 =?utf-8?B?eGFuZ2d3RHZMM1IxQnVKTXlodmd2b1lGOHBXU0V4VTNyRWxiNnZ1UUY4dTRo?=
 =?utf-8?Q?77+Us6jq8PURYhSrJU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556fa067-c664-4bdf-df1c-08df14ea4d6a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:34:26.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKtPalklJeWL3qz3g8mBfc6DsemMTEzxd5eFvE/6EHsxydtvE0omRZEhLxYl8JVN4WODi3C8v/C1Ft8wWXSsZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944



On 9/17/26 12:38, Rafael J. Wysocki (Intel) wrote:
> On Tue, Sep 15, 2026 at 9:03 AM Jianyong Wu <wujianyong@hygon.cn> wrote:
>>
>> Commit d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall
>> back to cpuinfo.max_freq") introduced cpuinfo.max_freq as the reference
>> frequency for cpufreq pressure when arch_scale_freq_ref() returns zero.
>>
>> However, cpuinfo.max_freq may include boost frequencies and therefore
>> does not necessarily represent the maximum sustainable frequency.
> 
> And then it really matters what is sustainable and for how long.
> 
>> On some systems using acpi-cpufreq, cpuinfo.max_freq includes boost while
>> the frequency table only contains non-boost frequencies.
> 
> In which case selecting freq_table[0] may give the processor a license
> to go to the turbo (or boost) frequency range.
> 
>> Consequently, cpufreq pressure remains nonzero even without an additional
>> frequency limit.
> 
> So when and where does this matter?
> 
>> Furthermore, drivers may update cpuinfo.max_freq when boost is enabled
>> or disabled. With a fixed policy limit below the maximum non-boost
>> frequency, this changes the pressure reference and hence the reported
>> pressure, although the non-boost frequency limit remains unchanged.
> 
> If the capacity is updated though along with the cpuinfo.max_freq
> change, then this is all fine because the pressure is then computed
> relative to the new capacity.  intel_pstate does that.
> 
>> Add max_sustainable_freq to struct cpufreq_cpuinfo to provide a reference
>> frequency excluding boost. Populate it from the nominal frequency in
>> amd-pstate and cppc_cpufreq, the maximum non-turbo frequency in
>> intel_pstate, and the highest frequency-table entry in acpi-cpufreq.
>>
>> Use this value when arch_scale_freq_ref() returns zero. Preserve the
>> existing cpuinfo.max_freq fallback for drivers that leave the new field
>> at zero.
>>
>> Tested with acpi-cpufreq, intel_pstate, and amd-pstate in active and
>> passive modes. With no additional frequency limit, pressure is zero.
>> With a fixed limit below the non-boost reference frequency, pressure
>> remains unchanged across boost transitions.
> 
> Which may not be what is intended.
> 
>> Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq")
>> Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
>> ---
>> The earlier fix was incorrect and has been abandoned. This patch takes
>> a different approach.
>>
>> Previous discussion: https://lore.kernel.org/all/SI2PR04MB4931A8BA0EF213B0238BD9E4E3BD2@SI2PR04MB4931.apcprd04.prod.outlook.com/
>>
>>   drivers/cpufreq/acpi-cpufreq.c | 3 +++
>>   drivers/cpufreq/amd-pstate.c   | 2 ++
>>   drivers/cpufreq/cppc_cpufreq.c | 3 ++-
>>   drivers/cpufreq/cpufreq.c      | 4 +++-
>>   drivers/cpufreq/intel_pstate.c | 2 ++
>>   include/linux/cpufreq.h        | 2 ++
>>   6 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 21639d9ac753..e7b22456ebb8 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -856,6 +856,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>          }
>>          freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
>>
>> +       /* Init max sustainable cpu frequency */
>> +       policy->cpuinfo.max_sustainable_freq = freq_table[0].frequency;
>> +

Maybe I'm missing something, but it sounds to me like it would make 
sense to just:

policy->cpuinfo.nominal_freq = freq_table[0].frequency

and then use cpuinfo.nominal_freq everywhere, no?

>>          max_boost_ratio = get_max_boost_ratio(cpu, &nominal_freq);
>>          if (max_boost_ratio) {
>>                  unsigned int freq = nominal_freq;
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 3a6b4b224a66..6fc28bb1499b 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1085,6 +1085,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>                                                  perf.lowest_perf);
>>          policy->cpuinfo.max_freq = cpudata->max_freq;
>>
>> +       policy->cpuinfo.max_sustainable_freq = cpudata->nominal_freq;
>>          policy->driver_data = cpudata;
>>          ret = amd_pstate_cppc_enable(policy);
>>          if (ret)
>> @@ -1912,6 +1913,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>          policy->cpuinfo.min_freq = perf_to_freq(perf, cpudata->nominal_freq,
>>                                                  perf.lowest_perf);
>>          policy->cpuinfo.max_freq = cpudata->max_freq;
>> +       policy->cpuinfo.max_sustainable_freq = cpudata->nominal_freq;
>>          policy->driver_data = cpudata;
>>
>>          ret = amd_pstate_cppc_enable(policy);
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 6fe0e972952a..f803fcdca483 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -682,7 +682,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>          policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
>>          policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
>>                                                      caps->highest_perf : caps->nominal_perf);
>> -
>> +       policy->cpuinfo.max_sustainable_freq =
>> +               cppc_perf_to_khz(caps, caps->nominal_perf);
>>          policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>>          policy->shared_type = cpu_data->shared_type;
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index b898b6544069..c1d54a22265d 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2587,7 +2587,9 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>>          cpu = cpumask_first(policy->related_cpus);
>>          max_freq = arch_scale_freq_ref(cpu);
>>          if (!max_freq)
>> -               max_freq = policy->cpuinfo.max_freq;
>> +               max_freq = policy->cpuinfo.max_sustainable_freq ?
>> +                                policy->cpuinfo.max_sustainable_freq :
>> +                                policy->cpuinfo.max_freq;
>>
>>          capped_freq = policy->max;
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index 6e984c114d96..daef7e99fead 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -1474,6 +1474,7 @@ static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy,
>>
>>          policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
>>                          cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
>> +       policy->cpuinfo.max_sustainable_freq = cpudata->pstate.max_freq;
>>
>>          refresh_frequency_limits(policy);
>>   }
>> @@ -3052,6 +3053,7 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>>          policy->cpuinfo.min_freq = cpu->pstate.min_freq;
>>          policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
>>                          cpu->pstate.max_freq : cpu->pstate.turbo_freq;
>> +       policy->cpuinfo.max_sustainable_freq = cpu->pstate.max_freq;
>>
>>          intel_pstate_init_acpi_perf_limits(policy);
>>
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index ae9d1ce4f49c..aa3f60a167be 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -45,6 +45,8 @@ enum cpufreq_table_sorting {
>>   struct cpufreq_cpuinfo {
>>          unsigned int            max_freq;
>>          unsigned int            min_freq;
>> +       /* Maximum sustainable frequency excluding boost, or 0 if unknown. */
>> +       unsigned int            max_sustainable_freq;
>>
>>          /* in 10^(-9) s = nanoseconds */
>>          unsigned int            transition_latency;
>> --
>> 2.34.1
>>
>>

