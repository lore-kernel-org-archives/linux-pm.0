Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1A3C1D4B;
	Mon, 21 Sep 2026 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021308; cv=fail; b=sQUU39kO25+LfnzDQPpYjxKZ5ihXlUznSWS1l9BR4plLM5t24MlUZ7y3L5ac6WRVQSBNn8a8Z31wksXqXJnIH2038EaQKH8j7jntgF5/d+V1XT0G0bu2lhjO7DV1qpDtfN192c5K8/2Z8FkgwM3BM3AR2NnV1JhhKja0KSKI+QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021308; c=relaxed/simple;
	bh=BwjmeLmuvoGbnmMbopMnSpTNqGuJ/sFLuxudiaZcPtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQgLVBF+lhfD3N44PAgXGyL51VUN7kDrrqyJC1l8lpDwQexfqumEdNR36ybM7t3Zn3vhbFszFWK/tBmO5jYtGfZNBBZTpE81upMJSWbTJOALd2ig+01c3NU5rkQxSk6cLCpgV8LmtuEVSuItIKBzSYU1kh69wWlr4aBzAjmRCJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LPZsLNOu; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LPZsLNOu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bB92UItTRzG1BFXrAFdu7iOhqA0/8wqVX+VUbeQz8ymQ69MWSwqCwlvbNaJpl0PpmRxU0MDYCLhJfj0zFTiq3wnb22Q5jglh0v/9/l6AlxRPM3uE58KixvKMTNpO6qCi3Is3y3JrpCiYSuplZiHx9tb3OH8VbJxleqwymUrxPVit+u6BAu/vwLWcnY6EgkHr8GTswQO12OQqaxj8OpvfbKH5dHc1vrRrdfKJrjvRoliivGbufENvLBNfHD1+t5ktwik7+tTgUXUnkCfGc5Ji+ckBQI2yqundJfKxnjA9kBFwNEv3zSGT4OQg9mOCVT0Wnwthxh9oi1tJnNLsj2i+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiyRL8VOKqLC+xOEujHtBXp38cE+yDsiCG/DOZJ2rQ0=;
 b=pGZIH/XPfI7TAjEgPqLMg5YTG9yU5XLJYSjWmoFYQbmaJUOPUqt6aXtkqIPdbEeO5oH6FWteML0KFpAZmWq0WudDf8WkGcRdwM0izhiLsD934lRa4jfAXwBsMmp+0nUZ5D9F8rAMYPZRx7/6PPny/KQbX77OG48uis9IiY/wVOmWfpDB1kNUYbgPpM0RYwoYJmtoygaF0Rg8fD8SJ/BAbn+YyfV/TJH26+C0I8DspTszYOs9Bb72d0ZALHLW7DfwpQ9vKNFlOHjugIYgDmGqdzLMaf2IJO7NzmVobAfl4IYYv9fh4yajDnFOE6QnwUIMeEA4d7z3T/oshPtKSxkI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiyRL8VOKqLC+xOEujHtBXp38cE+yDsiCG/DOZJ2rQ0=;
 b=LPZsLNOu3SZrKaVyVxMCH9liT2mtC6rlhSeJZRLSXm48mwoDgx/zsyt/SLKNBF6yI7908x82NRQRw7ww4Hl/vwHbFzbpJAVAit64WpXqIEtt0eaXjK8ZHshnSKY6NQhB9SPwiMaXAe6KcY/KXmepMWr3SoGAdXrWFlyAyyE5vt+6UuMs+wbzQH8G/14Isp9SS9ZMUM6VEM6FyKrgdseNnuN5dp7HkbwUzm1/BnoHhJ1gdO72Gusux6KciHGalL8/Z6Fi2M6A6PxBu8kaVButY7Bsc5xEiSqVQgqtMFU0JzO4OQkTPW+TI5Is1S3c/tinjYw1/nhlMscQ17C5oF7mlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by DS2PR12MB9823.namprd12.prod.outlook.com (2603:10b6:8:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:08:19 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:08:19 +0000
Message-ID: <01d7f07e-839c-428b-833d-713ed2128f4d@nvidia.com>
Date: Tue, 22 Sep 2026 01:38:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Christian Loehle <christian.loehle@arm.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, lenb@kernel.org, saket.dumbre@intel.com,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260806200857.601152-1-sumitg@nvidia.com>
 <20260806200857.601152-2-sumitg@nvidia.com>
 <c30ddb21-2c97-4b9f-bae6-b29e30aa5e5e@hisilicon.com>
 <753b98a6-b3f7-431b-a867-eccbfd15d357@nvidia.com>
 <26439302-6759-446b-a498-310c218e4102@hisilicon.com>
 <404f0fea-4980-4e7f-ae05-eadcc2b13d7d@nvidia.com>
 <7d250745-bed7-4e75-a3b5-17565d8ff662@arm.com>
 <19b236de-ec1d-4abd-a78e-17e4faa3b75a@nvidia.com>
 <1be30b2b-e1e5-41ed-a0dc-0dd5ad3c47cd@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <1be30b2b-e1e5-41ed-a0dc-0dd5ad3c47cd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0054.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::32) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|DS2PR12MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1cc1a1-f0c2-4b57-796d-08df181c13f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|56012099006|4143699003|10067099003|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cUOm0Z+hP4GyJMb05Apxcxu4STG978lKN4qBB5Aa0M6uLWojX+8j6WryUjAp0aNEYrMCLAMsS9otFrXH7ndT0JltNAEhOKZ9Q5MEeru2ZgONwB8bGTPJzCXVOfgU0h9nmCYhMCjkc8SwVzL5sLTw18px+LadtCkva4aE4XNVDoIWRx6pR3bTpOoELL94EZgBSHELVHrG0ogiGcaiaHHUYezdIrxTkHSUueP2d1gyYOaU1nMheoHH2wj03j+0lm8y19ewosg1ErJiNiQ+apQMPbxStmixcb/OsrV7nOpuh8f6ePfuxQkKit0PcxCJGlu3ZBR0UHfQmxagPWrdmCzUyyUr8WiVPklkIm5PXHOC+KWxqvQHQc1Sc143dKuNcZgk/L5tchgWvHfmqDNteYb22KNB4DhphBC+55lu26ljOEZdeurDtQlccsbVO4ciMPU+mwCM4W/EhGyCBe2HPPM6wCxNk7ZCJJV2IA14IZuayTe7pyMpz4kNHPix4TwmjBB5/YCXt1ISgqbgjRNh+0NmzJ8tdCXdFC6xwvzJ5kJTFqtetQJjNGQ6OhjH0q0fqMwqQnp0vDu7ec5ybNBxySUNslkRArC8r1IjOVa3WCEaetmUhWoEZekDGPZI9XnSc+ig4n9nnbTp7JnKOVHm48SJqo0i5oI5M0wOZPA47gj04gP7qlAESdfuJIeCuUsWw6QTuUc0ppZ87rBD1g9Qi5zcOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(921020)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGtjSG53bVdvUHBXTmZFQkh6cVZvUkR4UXQwL2lRSWNjRzlSa0lhUCtaaHRN?=
 =?utf-8?B?di9acVpyTzNZOVpBZklrUEpOZzV6QUhJRXFXZWNuR1pkWVlKLzZBQTVOYlgz?=
 =?utf-8?B?WlI5dXBkYXY5SFgxc0JSOHhrd0hGUFcwT054c3NnTVUvMUc2R1d3aWkwclVz?=
 =?utf-8?B?TS9ZRHQzTXRiSE5yU0JINTI4cU53a3JUQTlMeXNuaWZqVW5FR052U1ZZVEFM?=
 =?utf-8?B?bThnR2s2RkZmRFVveCtzTjZLR3BzamFORGd3MWlFdnR1bnl3UzZXWGJVcVJs?=
 =?utf-8?B?NGNxeE0xeGkyYUlUcVRrTEJUNVovdXNuNS9POGY1Q0hxbm4rOUpqbzYzcmxH?=
 =?utf-8?B?emlmdzBFSGlNRk5LTmFOc2NObng5YzNLNlgwZHRvSUxGVG13SjZCNjBOVzls?=
 =?utf-8?B?WHBkN3RLV3BUYjQwdnJEOG15UkhkeTVqT3FWcE1aSGVYeDZpRE5BRXZlK0Fo?=
 =?utf-8?B?a0xKY1JPeUZhOFZPTTBEamptRTFqWDJtVWtTM08weS9HZnY2MlRUVTV0b21a?=
 =?utf-8?B?QlV5SXlyNnBveTI1bk1vMHNrMDljN1dQWm1NdXNIQlMyREF4bVhxSnR1TFJ1?=
 =?utf-8?B?QWt6VlpGNGVTYkU0RVJLazhoakV0ZjZOM200bzhwMzVQSHJWVDlGcEE4NElH?=
 =?utf-8?B?L0pESFhTVWNPa0ZIcEl5N0JwRDVqRUJTeDB1QStrQzF6Y0tIMmgzam14Q1JK?=
 =?utf-8?B?UDJ5cE1lMEhmQnVVbGpvZ3RiMllXWFIyTmtDcGI4WVRUR1hNaTRGOGF2eStv?=
 =?utf-8?B?Mi8wTGFzYmtxa29DQnR2SXM1WlA3VURRZ2VBd2U5UDNWUEVtdU1JOXdqZXhq?=
 =?utf-8?B?VHZuK2JLalZ6OHZZd3d5Um9kR2NadXA2dUFJbzlFMkFrVjhuWmYrc2VqZ1hU?=
 =?utf-8?B?ZytRRWVyL3NBZDVBLzFkMjdpdU8wSUd0d3ErZ3phanNheTNYaHZNTmVRUFpO?=
 =?utf-8?B?a2xVelFZSFlybTJ3b3JoOHBEZGh6N1Q5R0hkM1djSmpUWlBpczlwUDM3SkhT?=
 =?utf-8?B?NFdodm5TTG1GcGlFTUZyZmlQMzVNeVJvWjFIaVFabFhmcnZOMlN0ck8xSCty?=
 =?utf-8?B?ZGUvQmdWaUZqWmdPTjlIUnQzMHhuSWFUcGJDWnIwejQvdTFJclJ2bURkQ1JV?=
 =?utf-8?B?TXFydVhsTVdwbGdZWHFyRHRtQjdCSnIzV1YrMjRtczRhSDRxT2IrMWxPMnM5?=
 =?utf-8?B?Yk1xRVZGbmYwakJnYjJoSHFKeENnTzJvTTNDMFAxZ0RReHBSbENBZDVaYi8r?=
 =?utf-8?B?UzNTSHFDUTN5NlJ1M0k3WUk5VVMxZ0ZtVUxOZDRLRXlQc0RoamR6ditaWVFW?=
 =?utf-8?B?bWhoU0k5cStUZkVwb20rMEhPRGpvSkU0Y28xTmNacHhrMlAydE1wZlAxblhl?=
 =?utf-8?B?QnI4a0ovOTBxd2tLSFlzV1RoRTFFQTZFbDdTR2VQNCt3S1ZQdFVJdU9adTEr?=
 =?utf-8?B?eGwrY1U2VzhCM3NNZXFpM1RhZ1o5K2ZlWnhsb0w1L0ZlSWVheE50UGI3NDFD?=
 =?utf-8?B?elJMbXZ5bFk4WUY0dE1GemJvRURYRUlZajlCNjlxY3J4NDNIYUkrTVJQb3VI?=
 =?utf-8?B?c2ZDSjMyTjJHWVQ3TDRVbmFSc0gzc2hselQ3S3ExV3ZBMklnbGM1MEo4Yi9Q?=
 =?utf-8?B?QVhPaXRCYm1RZVYrSGtQUUdwcVNURFBLV3g2c2VvRGVKNmJiNVN6SmJqTWxw?=
 =?utf-8?B?R0llWDBHT1ZyTVBlUExiUjcyMHkxQkc5b3UyS25mYktFb3pvRHNiKzdHUjhD?=
 =?utf-8?B?MDVtMU16aS9KTzUvTUFOOTdaM2ltUi91aFYwVVBBZnhoR1h3VGUvUE5qVW81?=
 =?utf-8?B?VTJyb0tEOUtVWVdIZnpZTHFLd2g2YWI0OW1rMytGdTlPUHZoVzZreHBxOFNs?=
 =?utf-8?B?SmFkMHRpU2dCckFha1dRMjdTN25uTEdsckFRckF4eDBHQTZ3VitKN1lDWXBj?=
 =?utf-8?B?RmdkaDZyT2ZpcHdpVWlLZHdyR0lISkkwUGNPSlhGOEpCZUpZSk4wUldBV2NR?=
 =?utf-8?B?eWt4MTRNVjZVRlZXblhnTlowbEtLdXNMVDVvTERwZm5iNWhqRVNVamhERURk?=
 =?utf-8?B?dzBIWHg4SFdGckFVZ3k4YWVjcEI5cHlqN0VnSkxLdFlMb1c0VW0zaFE5dFk5?=
 =?utf-8?B?VXUraHFBU0owMEdpVkd6QkFTSmV6NE1XUWQvbG1kbmpZaEZaazhqQmFnWWpu?=
 =?utf-8?B?QmhOUFBEWDhSMmtkcGdKVmZkcUZoY3dhNnpNRHlTSFZKdHpJVHVIcWwvWHFm?=
 =?utf-8?B?Skw1SzVRSmhIYzdGWkJHc2REejhSamt2Ui9rVk91NGQxSEgyVkoyRDJnVEYr?=
 =?utf-8?Q?LwvFKNO0iD76+OQb+R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1cc1a1-f0c2-4b57-796d-08df181c13f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:08:19.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiGC6pBRz5ZAUNwqKvYprkHCcvr924SlUEvVaGHw+LuMu4n74NZO2h8gppF/Boat4i6wUsfC0loUIMshGj6YeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9823



On 19/09/26 14:02, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 9/17/26 19:59, Sumit Gupta wrote:
>>
>>
>> On 17/09/26 18:38, Christian Loehle wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 9/17/26 12:01, Sumit Gupta wrote:
>>>>
>>>>
>>>>>>>
>>>>>>> On 8/7/2026 4:08 AM, Sumit Gupta wrote:
>>>>>>>> Without online()/offline() callbacks, the cpufreq core fully tears
>>>>>>>> down a policy during exit() when its last online CPU is offlined, and
>>>>>>>> rebuilds it during init() when it comes back.
>>>>>>>>
>>>>>>>> Add lightweight online()/offline() callbacks so the core instead keeps
>>>>>>>> the policy live and reuses the driver's cpu_data across CPU hotplug.
>>>>>>>> This avoids re-reading the CPPC capabilities on every offline/online,
>>>>>>>> making CPU hotplug faster.
>>>>>>>>
>>>>>>>> Move what init() and exit() did on hotplug into the new callbacks:
>>>>>>>>
>>>>>>>>       - offline() requests the lowest desired performance, as exit() did.
>>>>>>>>       - online() re-enables CPPC and restores the performance controls, as
>>>>>>>>         the platform may have reset them. Failures are logged, not returned,
>>>>>>>>         as the core would free the policy.
>>>>>>>>       - online() also resyncs the frequency invariance counters, so that the
>>>>>>>>         first tick does not measure across the offline window.
>>>>>>>>
>>>>>>>> The restore in online() uses cppc_set_perf(), which writes MIN before
>>>>>>>> MAX. If the platform lowered MAX while the CPU was offline, writing the
>>>>>>>> saved MIN could briefly leave MIN above MAX on registers not accessed
>>>>>>>> through PCC, as PCC delivers the writes in one transaction. Raise MAX
>>>>>>>> ahead of the restore when the saved MIN is above it.
>>>>>>>>
>>>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>>>> ---
>>>>>>>>      drivers/cpufreq/cppc_cpufreq.c | 128 +++++++++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 128 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>>>>> index 80893844353c..4b3da9a3e122 100644
>>>>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>>>>> @@ -211,6 +211,29 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>>>>>           }
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * Resync the counter snapshot, as the policy is kept across CPU hotplug and
>>>>>>>> + * the first tick after online would otherwise span the offline window.
>>>>>>>> + */
>>>>>>>> +static void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>>>>>> +{
>>>>>>>> +     struct cppc_freq_invariance *cppc_fi;
>>>>>>>> +     int cpu, ret;
>>>>>>>> +
>>>>>>>> +     if (fie_disabled)
>>>>>>>> +             return;
>>>>>>>> +
>>>>>>>> +     /* policy->cpus still holds related_cpus here, so skip offline CPUs. */
>>>>>>>> +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
>>>>>>>> +             cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>>>>>>>> +
>>>>>>>> +             ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
>>>>>>>> +             if (ret)
>>>>>>>> +                     pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>>>>>>>> +                              __func__, cpu, ret);
>>>>>>>> +     }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static void cppc_fie_kworker_init(void)
>>>>>>>>      {
>>>>>>>>           struct sched_attr attr = {
>>>>>>>> @@ -281,6 +304,10 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>>>>>      {
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +static inline void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>>>>>> +{
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static inline void cppc_freq_invariance_init(void)
>>>>>>>>      {
>>>>>>>>      }
>>>>>>>> @@ -735,6 +762,105 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>>>>>           return ret;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * With offline() defined, the cpufreq core keeps the policy alive when
>>>>>>>> + * a CPU is hotplugged out.
>>>>>>>> + */
>>>>>>>> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>>>>>>>> +{
>>>>>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>>>>> +     struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
>>>>>>>> +     unsigned int cpu = policy->cpu;
>>>>>>>> +     int ret;
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * Request the lowest desired performance while the policy has no online
>>>>>>>> +      * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
>>>>>>>> +      */
>>>>>>>> +     perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
>>>>>>>> +     perf_ctrls.min_perf = 0;
>>>>>>>> +     perf_ctrls.max_perf = 0;
>>>>>>>> +
>>>>>>>> +     ret = cppc_set_perf(cpu, &perf_ctrls);
>>>>>>>> +     if (ret)
>>>>>>>> +             pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
>>>>>>>> +                      cpu_data->perf_caps.lowest_perf, cpu, ret);
>>>>>>>> +
>>>>>>>> +     return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * Raise MAX ahead of the full restore when the requested MIN is above the
>>>>>>>> + * current MAX. cppc_set_perf() writes MIN before MAX, so the platform would
>>>>>>>> + * otherwise briefly see MIN above MAX on registers not accessed through PCC.
>>>>>>>> + * Lowering MAX is safe, as the MIN written first is never above it.
>>>>>>>> + */
>>>>>>>> +static int
>>>>>>>> +cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
>>>>>>>> +                               const struct cppc_perf_ctrls *target)
>>>>>>>> +{
>>>>>>>> +     struct cppc_perf_ctrls cur = {}, prep = {};
>>>>>>>> +     int ret;
>>>>>>>> +
>>>>>>>> +     ret = cppc_get_perf(cpu, &cur);
>>>>>>>> +     if (ret)
>>>>>>>> +             return ret;
>>>>>>>> +
>>>>>>>> +     if (!cur.max_perf || target->min_perf <= cur.max_perf)
>>>>>>>> +             return 0;
>>>>>>>> +
>>>>>>>> +     prep.desired_perf = target->desired_perf;
>>>>>>>> +     prep.min_perf = 0;      /* Zero leaves MIN unchanged. */
>>>>>>>> +     prep.max_perf = target->max_perf;
>>>>>>>> +
>>>>>>>> +     return cppc_set_perf(cpu, &prep);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * Restore what the CPU may have lost while offline, as the platform may have
>>>>>>>> + * disabled CPPC and reset the performance controls. Never fail the callback,
>>>>>>>> + * or the core would free the policy and leave the CPU without cpufreq. The
>>>>>>>> + * governor redoes the control writes, so they are best effort, unlike the
>>>>>>>> + * enable, which only a later online() can retry.
>>>>>>> Sorry, I don't quite understand the last sentence.
>>>>>>
>>>>>>
>>>>>> Will rewrite in v5 as below:
>>>>>>
>>>>>>     Report failures without returning them, or the core would free the
>>>>>>     policy and leave the CPU without cpufreq. A failed write to the
>>>>>>     performance controls is not fatal, as the governor's next request
>>>>>>     programs them again. A failed CPPC enable stops the restore, as the
>>>>>>     writes that follow may not reach the platform.
>>>>>>
>>>>>>>> + */
>>>>>>>> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>>>>>>> +{
>>>>>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>>>>> +     unsigned int cpu = policy->cpu;
>>>>>>>> +     int ret;
>>>>>>>> +
>>>>>>>> +     cppc_cpufreq_cpu_fie_resync(policy);
>>>>>>>> +
>>>>>>>> +     ret = cppc_set_enable(cpu, true);
>>>>>>>> +     if (ret && ret != -EOPNOTSUPP) {
>>>>>>>> +             pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
>>>>>>>> +             return 0;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * The platform may reset the controls while the CPU is offline, so
>>>>>>>> +      * recompute min/max, clamp desired_perf into range, and reprogram them.
>>>>>>>> +      */
>>>>>>>> +     cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>>>>>>> +
>>>>>>>> +     cpu_data->perf_ctrls.desired_perf =
>>>>>>>> +             clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>>>>>>>> +                     cpu_data->perf_ctrls.min_perf,
>>>>>>>> +                     cpu_data->perf_ctrls.max_perf);
>>>>>>>> +
>>>>>>>> +     ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
>>>>>>> Actually, I don't quite think this is necessary?
>>>>>>>
>>>>>>> The motivation of doing this is fair (as mentioned in v3), but what's the
>>>>>>> real consequence of transiently setting min_perf larger than max_perf?
>>>>>>> Platforms should be able to handle this.
>>>>>>>
>>>>>>> Even if we have to fix it, it's supposed to be done in cppc_acpi.c.  The
>>>>>>> current ABI wraps many things up.  cppc_get_perf() reads 4 values -
>>>>>>> min_perf, max_perf, energy_perf, auto_sel.  cppc_set_perf writes 3
>>>>>>> values - desired_perf, min_perf, max_perf.  The cppc_cpufreq driver would
>>>>>>> be able to handle performance setting cleaner if those are separated.
>>>>>>>
>>>>>>> I don't suggest we complicate the driver for now?
>>>>>>
>>>>>> Agreed that it is not hotplug specific and can be done in the
>>>>>> generic API.
>>>>>>
>>>>>> cppc_set_perf() would have to know the programmed MIN and MAX to pick
>>>>>> the write order. Separate accessors would let it read only those two,
>>>>>> but that would add a read before every write, including fast_switch().
>>>>> fast_switch() doesn't have to touch min/max_perf, but it did at the moment.
>>>>>> Caching what was last written would avoid that, but the platform can
>>>>>> reset the registers while the CPU is offline or suspended.
>>>>> Yeah, understood.  My question is still whether it's practically useful and
>>>>> we're complicating this.
>>>>>
>>>>> Two reasons.
>>>>>
>>>>> 1. Platform should be able to handle min_perf being trasiently larger than
>>>>> max_perf, otherwise it would be fragile.
>>>>>
>>>>> 2. It depends on the reset values of the two registers.
>>>>>
>>>>> I went over the ACPI Spec and didn't manage to find a descprition on what
>>>>> the default/reset values of min/max perf registers should be.
>>>>>
>>>>> For a sensisble design, min_perf defaults to be 0 or lowest perf, and
>>>>> max_perf defaults to be all 1s or highest perf.  In those cases, we are
>>>>> safe to directly restore the saved values.
>>>>
>>>> Hi Jie,
>>>
>>> Hi Sumit, Jie
>>>
>>>>
>>>> Agreed, those values would be safe, although they are not required
>>>> reset defaults. A platform could reset MAX to a lower value, such as
>>>> lowest_perf, while the saved policy MIN is higher.
>>>> Restoring MIN first would then temporarily result in MIN greater than
>>>> MAX on non-PCC systems.
>>>>
>>>> This preparation was added in response to Christian’s v3 comment [1].
>>>> I had already posted v5 [2] before receiving this reply, and it retains
>>>> the preparation.
>>>
>>> I basically agree(d) with Jie here when I commented on v3:
>>> "I think cppc_set_perf() needs some prep first before using it on reset values.
>>> We assume that reset value may be Autonomous Mode on, right? So we must never
>>> write MIN>MAX and vice versa. I think we may just have to read and write
>>> the 'otherwise-offending' value first on reset."
>>> So I wanted to have this (as prep work) within cppc_set_perf() not in cppc-cpufreq,
>>>
>>>>
>>>> Christian, are you okay with dropping it and restoring the controls
>>>> directly with cppc_set_perf(), as in v3?
>>>> Any general requirement for ordered MIN/MAX updates can then be handled
>>>> in a separate CPPC core series.
>>>>
>>>> [1] https://lore.kernel.org/lkml/40d72385-0b3f-46e5-9f32-a27be3842d7c@arm.com/
>>>> [2] https://lore.kernel.org/lkml/20260916103820.1760297-1-sumitg@nvidia.com/
>>>
>>
>> Hi Christian, Jie,
>>
>> Thanks for the clarification. I will drop the preparation from
>> cppc_cpufreq in v6 and restore the controls directly using
>> cppc_set_perf(). I will address the MIN/MAX write ordering in
>> cppc_set_perf() in a separate series soon.
> 
> I don't quite understand why though, if anything it should land before
> this hotplug series? (It really should've landed with MIN/MAX_PERF
> support or at least to prepare for AUTOSEL support?)
> I don't disagree with Jie that a sane platforms should be able to handle
> transient violations, but IMO just adhering to the spec here (which
> is absolutely doable) ensures that we never have to support a bunch of
> quirks sometime in the future, when we do want to be more strict about
> the spec.
> 

The ordering affects every cppc_set_perf() caller, not only the restore
here. So I planned it separately on top of your v7. Taking it as a
prerequisite works too.

> In any case, after my v7 ACPI CPPC fixes land (fingers crossed this time),
> it seems pretty straightforward (and even a tiny optimization at that!).
> Here's what I had in mind, what do you think?
> (Lightly tested, without seeing any violations. Needs some wiring
> into your series and would appreciate testing with AUTOSEL.)
> 

With your v7 and the ordering patch applied, cppc_cpufreq probe fails
on my platform, where both MIN_PERF and MAX_PERF read zero until OSPM
programs them.
- init() passes max_perf = 0, so max_update is false and the ordered
   path keeps that zero as the upper bound.
- Desired then falls outside [0, 0], cppc_set_perf() returns -EINVAL
   and init() treats it as fatal:

     CPPC Cpufreq:Err setting perf value:XXX on CPU:X. ret:-22
     cpufreq: cpufreq_register_driver: No CPU initialized for driver 
cppc_cpufreq

The change below makes init() request [MIN=0, MAX=highest_perf] when it
reads a zero MAX:

--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
+	if (!cpu_data->perf_ctrls.max_perf) {
+		cpu_data->perf_ctrls.min_perf = 0;
+		cpu_data->perf_ctrls.min_perf_valid = true;
+		cpu_data->perf_ctrls.max_perf = caps->highest_perf;
+	}
+
  	desired_perf = caps->highest_perf;

With that, cppc_cpufreq probes and the MIN and MAX registers follow the
policy limits with AUTOSEL both disabled and enabled.

There is another case. Two updates to the same CPU can also interleave,
as fast_switch() is not serialized against a sysfs update, leaving MIN
above MAX. A later request should be able to repair that, so I removed
the early rejection of a live MIN > MAX. The target_min > target_max
check still rejects requests that would leave an invalid interval.

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
  	if (min > U32_MAX || max > U32_MAX)
  		return -EFAULT;
-	if (min > max)
-		return -EINVAL;

If you agree with both changes, I can fold them into your ordering patch
and carry it as the first patch of my series, or would you rather post
it yourself?

Serializing that race needs something the fast path can take, as
fast_switch() cannot take policy->rwsem. It only affects policies where
fast switching is enabled, which excludes PCC. How would you prefer to
handle it?

Thanks,
Sumit

....

