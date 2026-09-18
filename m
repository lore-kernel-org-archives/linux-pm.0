Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012053.outbound.protection.outlook.com [52.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626131E857;
	Fri, 18 Sep 2026 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711056; cv=fail; b=UOhIKEOUphYDi8fjBez3TvZ4h8IH2vtEY+EPcFMbIQl5mj6aIOPJcy8CnsPo7M0FTUIuUZtmY+gQMN6TmKE3VvTnF9oGdJ3AmziL2MxSVGAOSnJ6EadRY3tbBv75T+0YYdG0tdeC3VOqyNMI6Oa3msGXFfwerFucWl1G9oeiwV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711056; c=relaxed/simple;
	bh=thpeCKr4iUnjw08Is8mxGxMaSK2TXIrQNZfXLIHs2Mg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BRyYeYtVUfdU/NBzVmAGXWEec+kJcW0QO0hzz0GcY8UGa/iO32TGxMEaVp3+BPHW9YShxrey/qNpQNWLoku91INlFVIlGJyAOC+97GsUkA6pkYaKDOdpJ7jGbufRdDGL85Dd3jjGzDzi6avWBco5sTj6MOrJsuyS9i3dQOF1Svw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BDX3UHFp; arc=fail smtp.client-ip=52.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BDX3UHFp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab667oIIk4Rmrzs7RKHzR+yzQlStgH1BStm3n12x4pBtkQCdqDNc+Phbvq84vHw0pApENQ7SBJZ6HlUl2zvwiB8gMh0sb5br6RIKpi+947+iypQLg8cTvNSNQlTaww4EfFiTpjhF4qRw4w3B3ZuMW0VH3iBJV4wU5QFq3bRYK8rlBrAveINK7B3V4D7xRrqdXmNz7wlY3Sg0mKdYEfznlf+0PHTK3gBsHeNOcOJUJe6cCgl48wyyz9HNE5szKAn/7Of9KRe6KfTn5MsTLm+oTv+aAONrRUYMGRd9YkoN3v+0Fo4Nq8IgeRI90Srlo52JGEdgGyrslloaC7P45w36vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjsArxAGaWlYybPyExXaICX5nTblHtstwGrCtpifCbY=;
 b=toAHPJKOMjndLaXBoTU7aXquG8DToyM3XWKVuKGr4Yvu5QCIVmPMCB/l2oVu4OQK00/fy3D6Tz7/YHiVufbOI8kAO5QgMREtFBRsrU7crjZaNeXRnYHefoli4VK4y+Y0Eh9V61x0qgjp7MM/Ywzn0BQ+38TaqE7ZaatKvVvSzhVDfY+mZsveqYzb4Nk4mZL6g2nVUCXLxecMneqzj8NAztbfik+2zflqC7C4vAkAJXe7HOE99em+ywVluS1E9SwJBB/XXFn7wOBnoFasSz2XoLURz+jZD6KAW070HMd1lxWAcM6d5vcdzO7QMSuTGOTJ1ln7gKlfKXf90ezrlA5TfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjsArxAGaWlYybPyExXaICX5nTblHtstwGrCtpifCbY=;
 b=BDX3UHFpC612ea7jT6B7L45JqNXZMO368AM6IvM1cZNUZ7nj5qkMTKcANEIelvnrHNhqOwD4tdrUimApAheI88vOtLRFp7d0JIQmq3hAJ6gWsWWzYdEhdEvNwZQHbpYGA7nbv6ZmO6uVKdhWFvicJ375L1KkhlkfYxPdYNKmvEkRUS/mJPYUYgovKbizzmRDY9tZ360fAc6sUmZWHZmQxziOLnl5k4cx8PNYNY1duCxPdYiDeSIIXrbnQtOoWJ/7u0aZcGJbKkWM5Gl/knFJqp50EvGjU6iqK+6ZxQqc3zsnmEw+Inah9lFh4ux/tU7RSd6EjRZ1dggt5Vx1/ZPHdw==
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
 by TY0PR04MB6421.apcprd04.prod.outlook.com (2603:1096:400:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 05:57:22 +0000
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78]) by SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 05:57:22 +0000
Message-ID:
 <SI2PR04MB493195062A01D3EE2559D555E3872@SI2PR04MB4931.apcprd04.prod.outlook.com>
Date: Fri, 18 Sep 2026 13:59:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Use a non-boost reference frequency for pressure
 calculation
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, kprateek.nayak@amd.com,
 vincent.guittot@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ray.huang@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, pierre.gondois@arm.com,
 sumitg@nvidia.com, srinivas.pandruvada@linux.intel.com,
 hongyan.xia@transsion.com, zhongqiu.han@oss.qualcomm.com,
 wangfengyu@hygon.cn, zhongyuan@hygon.cn, huangsj@hygon.cn,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wujianyong@hygon.cn
References: <20260915065747.1671965-1-wujianyong@hygon.cn>
 <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
 <a92b1050-5f67-463c-977a-87af9682656d@amd.com>
Content-Language: en-US
From: Jianyong Wu <jianyong.wu@outlook.com>
In-Reply-To: <a92b1050-5f67-463c-977a-87af9682656d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0005.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::15) To SI2PR04MB4931.apcprd04.prod.outlook.com
 (2603:1096:4:149::12)
X-Microsoft-Original-Message-ID:
 <30a516c0-d0a9-43c7-bcde-beacf71664b7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR04MB4931:EE_|TY0PR04MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dffcf78-cd1f-4447-b830-08df1549b41c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|25010399006|24021099003|5072599009|15080799012|23021999003|6090799003|19110799012|8060799015|52005399003|40105399003|2607281247196008|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXVCNUpJWFE5OEZBd3FpSzdmY2dFT0dWZVJDRDBqTGRnK3JPMU9JNTd3VnA2?=
 =?utf-8?B?cEhEY2RIUUVtQ1RUa1AyQmZQN3ZZbkIvS2IzNDZETXhGeHgvUUNRc3NwL1A5?=
 =?utf-8?B?ZXQwSzZmWEVJbjNrbXpUS1I0NUdVcU5uSWFzNmRqVGIyZHJJTTI5cTlKV0ZC?=
 =?utf-8?B?bjl6bXRCYWdEZTZLTjJOalFNS2pWSDlkRThtQWJZZEJ0M01YUHI4bjR1SjBv?=
 =?utf-8?B?QWZ2d2lYZ0kvYW5MNmhqc0RaMmVmZHdheHRyaE52UHV4NU9qSi9HdTNRWk0x?=
 =?utf-8?B?Uzl1eno0MTBYaXFNZXBmZ2dpeWwvS0lENWxLU3FpSTBVMGdqbFpONzNIMzJW?=
 =?utf-8?B?THNBalUvdFVwU2EwV1hNa29NVDR5OVBiaDhxUmE2T1RDelZXUTlQTXFNVG5H?=
 =?utf-8?B?YlBseTNldUJVemtkVVl6L3phZzE5R0hpUWoyZzdUQUhtUlRsR3dzVEE4QXI5?=
 =?utf-8?B?QkZ3U21EQ05nWkJ6ZXFYRUE0dUkybHlicFczdnZDdlZlZVdhZEtFUXN0UENp?=
 =?utf-8?B?VlZwajZWTE1yem85RnAydG5NWVZ5cGxLd0NkQVBOWDFXaXZQbGRIVlRsK0Y4?=
 =?utf-8?B?dGx6KzhBTE1hTDJlYVVLQUJlbTdyYVBna2RoN2NKdU9TcEJjcmRNOFpzaWQ3?=
 =?utf-8?B?U1B5dUJSUWhjWGZVK3g1dHdrcVdVSUc2aTM0WmZXYXNLaW0vSm12UnhnRWVp?=
 =?utf-8?B?KzQvVDA3OVQ4OHBKWGQya2NwN2hIUldmVlZ6ZnVPYkdhYmR4WHZkMVpxV1ZL?=
 =?utf-8?B?OUg3STdUWnI4dnQ2eDJMOVRPdGtkcXJyNm4wemNkaHdLanA1WHMwaGJxRWNo?=
 =?utf-8?B?VEY2WUxwRGRYYmUrVjdmUWhURkEvZmhHTTFQZHJzR05qQ3U4NEdYS0RHaTdu?=
 =?utf-8?B?cFljaWRnSG92UlRXNHg0bEJWVWRrenZvRUNBaTBkcWROamwxbnRnMlptM3Vt?=
 =?utf-8?B?UGo2R1VsOHZHQ2JybzR6Rk5pN0RCamRjZzBLYSszdmRvL1RlZEpDdFpmV3pK?=
 =?utf-8?B?UUE2c2c3MkIwOXBOQkFyRkhWQnZ3VkdOZElyK0tXTTIrMjYwQm1pYjVGZXU2?=
 =?utf-8?B?TjZRYTRtN2FzaURHQ2N6bTBsVkxzL2kvbWQzeHdFK0NKUHRZN212ZE9mWFpM?=
 =?utf-8?B?bzlwQWIzZCt1d2sxVEovUnJzRDY5eHl2bUxwRXhKV2cyQ3ZNTzEzbkNFTisr?=
 =?utf-8?B?THorbVZFODZLNEp4czJ0WmdZTlRFMWNSTVRlNTEvZnFpanh1SGRwcE5Wa1Jz?=
 =?utf-8?B?K0t1ZHdNcTFLMDRQNDJRVmR1dFBQdUhYOWpqb0VjcEtDS05tZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anFhdnFSbmRjYXJ1ZzIxN3ExZmRsQnRyWUExSkxTaXVSR3BFbzZHY0lFT3oy?=
 =?utf-8?B?QkpPZlNCVi9xTUY2TGExVUVqbzAxc0pXOW03SVRDbTJxSmRzUFRsN1o3WTd1?=
 =?utf-8?B?R3NFSk5vZ0xjNFBDdkI3alNSZFlaYjFIT2RZdXRMR01DUnpaT3o5QnlpWG1q?=
 =?utf-8?B?NWJaTTNJVnZoaS9rdzJoQndsVWtOZ012eFpYNEVES2pYTU5pblFROHR4YmxC?=
 =?utf-8?B?MFkzTW1WZ2xwSmwyT2xrMDZTYk56T044VW0vT3J2L2RvLytZSlJlWmtnUmZW?=
 =?utf-8?B?SWsxbUg5UHNaR2tGZDdlRDZvbVJCZkNGSnhLOFlmUTkrRGxYRkc3RkdUVFgy?=
 =?utf-8?B?VDFVd1ZYWVZoWVRZcTB0dmRlQ05IUG14UFI5MmxMV25zNkppcm02eVJlNlJU?=
 =?utf-8?B?UE5BNnNRUkI2WFhrYzZjVkZJU0RKVWREZkgxT3ZQTVVuY21ZVWpZMERkdlJT?=
 =?utf-8?B?VVNVcnRxMWVZU3hLa0Z1QWMvTHVMUkQyZDQxZEd4bzkvM0IzNnpXQnJiVGNF?=
 =?utf-8?B?ZEFyTG1PT2JHWmp4SFBVNC9Tc2xiaTdJek5NVlp1TDhNR3gyNWhWajl4YkJK?=
 =?utf-8?B?ZmVYNW1pb2pUMnhNMHZUWDNwQmRTSWlWOWRINWdmUnR6WUtrNUV5dElsYSs4?=
 =?utf-8?B?OFl5YytHZXpTNmJ5Q2FKSFh1WmlPTC9qZzZScFhmdmtwMitNdTlNcGlaOVZs?=
 =?utf-8?B?R2l1dW5aQklEUzJOaU1INjV6Q0Fzb05UeGt3cE1SSEh0SWJ5SGk2U0EwNlk2?=
 =?utf-8?B?L2xzSUNLNnZpUDRuMzJ5K1E4bEpXbm0rUDJIVUZod3M1dzlleUFYenExT2ZZ?=
 =?utf-8?B?TW9lNER0MktWT2dHQ0Z3ZHgrbmp6c2RXaWozMTgwYjM3TW9BM1prZjBla01j?=
 =?utf-8?B?M3JaWEZuVTJkRy82SU1jdzB0U2FERE1MaVRidTArWjVYMjNSWVFzejUxUzFp?=
 =?utf-8?B?Tm13ZHdWVW85dGt0Y3VXMDY0WjRSOGxVdkw0Q2M3aDNRRXcwTXkveWhUU3Z0?=
 =?utf-8?B?Sk9PWmV6aFJZaXpCSjlDY2U3ZFlmSHQ0Y2JQVGU5ZW5GZ1V3bjEvQ1lyNC8x?=
 =?utf-8?B?ajYrSkh3eWlqV2c5WmZNTkdCc1BmcndhWnQzTXRFMWg4aTdaVWRXblVuZEtV?=
 =?utf-8?B?Zk9abkJ4MWo5b21lU1NPUXJBNkhieXpvTEJKdVR3eVVQTk9MZHYvQ3hqRXRO?=
 =?utf-8?B?N0hEcVJQYlY0YkxMTXdOQ0dtOUNNY205SCtoU1NURjZJVDJlYXlCR2JCVUNz?=
 =?utf-8?B?K0l5TXRwallFKzZhNzVsVzVQTzhiTTFQb2g3dVhyMVRDWXErWVVkNllTa0tq?=
 =?utf-8?B?eUxSdHArbEVnODdKL0ZWUDRLVGxSd3hqaVVlSG9vQWNieDlVWkhmcDNVd0NJ?=
 =?utf-8?B?OGxFSDVhTkNEcHp2K280M3Qvd00xcEdKV0g2QXZwMW8rUUl4WGorSitCeTRp?=
 =?utf-8?B?UHpCOGVIK3JIcmZmcFJKTjIzeHBJQjZrcXozaFBXVkpZVjg1SFY3OUh6RzVK?=
 =?utf-8?B?OGZGZFNkMlpKSjhkRTZsa0wvTGU3YWU0U2l1RHBKNVJBZ1RjTGpGV1BvTVNh?=
 =?utf-8?B?QzJHb0pobG5sbDFXQXM5b29CWkoyWUwzd0pmSlFTMSt3TG5qbGhYZUpXTStz?=
 =?utf-8?B?MzVQOGtPS25BUi9lNnMvRjd4cG9HK0Z2VHl6blJ0d0d1d0xseDRteDN1dTVP?=
 =?utf-8?B?MjhSbjNob3ZhSE0vUWlYcmNrZ0ozU2NGcGVkaEtNMk5TK2g0eHhKWnQrdy9B?=
 =?utf-8?B?d08xVFRQNU5oblpwZHUzZk1NQW1NQUJMa0ROZEtMRnVMMk5NTTVRTDFYMTlz?=
 =?utf-8?B?K3RYc3Zyc1ZzUUdZTHBIMlg1NGQzRE04aUJEWmZsU3pXV3dVYnZBZmN3K3Fy?=
 =?utf-8?Q?Kr1NC/hLaOjQt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dffcf78-cd1f-4447-b830-08df1549b41c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB4931.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:57:22.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6421



On 9/17/26 13:34, Mario Limonciello wrote:

> 
> Maybe I'm missing something, but it sounds to me like it would make 
> sense to just:
> 
> policy->cpuinfo.nominal_freq = freq_table[0].frequency
> 
> and then use cpuinfo.nominal_freq everywhere, no?

I think "nominal_freq" is better than "max_sustainable_freq". I can
change it if this solution is accepted.

Thanks
Jianyong



