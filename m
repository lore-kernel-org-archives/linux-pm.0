Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAD4A13AB;
	Wed,  9 Sep 2026 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948314; cv=fail; b=jn9n2H0I6ncsMlzFP36L5vur424ZhvBm+ezTFLWJPYlbpLigPH46ShCvvpgTvgNSlqM0/Smgn5TvJgRj7Z97hFfxWSZilh/GVfL7F94GFgRqyjOc3EErOQn2V0QUfR5WXIPTqWHeMsdb6TBCzI1XHUwtfLlsvVOwDugWiRWVd8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948314; c=relaxed/simple;
	bh=mommDlIfr6v5iIyjDxB9GdHf4/OtrIPvNV3g7Pj7dLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VqsdbJFzArcOs9GnvdXaa8bdiNkprzXkBYxyoe6PS7+Ub3/xWUuqtoOFv/6r+pkpeR4KqzBg5xLNZYxjJVcxnWd9WsvGs7+tkWbsvvtXksUct1cAHp/kIebjvezSvCobc8W+mnQd8+N6RhejJRTrxhr1aGeLUaleVkAM/wy4DQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kajTagdN; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kajTagdN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBS6E88mfh9XG2ZvfzHH03UYtEzqVaNR+D8RhCi2ut3JoHwgFz8G1P8weLHEY81SVxWWEsZS8+PMbf6n/b00lgSUWAOdAJXwJN1tkhLnaA9HaUYB73Fjp6TStql+yD9QqDutBFOD9+9jkJywS3QeYgUMfr+x9jr2WvuFtJnPqEWA8NXk6Np8wNt27AzigcWxcBl8IyIussAkpCb8uGhLhYT+xpK33H09YK2Tpka55c4RXhGIMX77e5gxdNDGiVcNf79fYrLCUwvqmcSdgUYEMFb2M8zudOVKPsgMxbh/XiSx2cfMwOfTJld+l7Estee+pkYkxuLubCi94VImfhk8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBulYzLuaXm5q0fyfFP1a0ec8oPVMx2WQpmz46oT4sw=;
 b=ZhRDoaEuf43KZcP098tOXS6gFXteP7h46ouq7r+gHgpIJrNF6Dpr4tdqxU2ey6pYa/CTOFKPvuLhayc/0D1lMp3cRBe4/EQIKHyDe5MkQrN5oCvNBM5jVc0FF1orJsu1CjpckvglYQljqnK7nuxZptF4FqacvNYkhkIGYLrBjMwJRrNt2hjJcNIgvMeBh7isTUfNBNZ27MGICo0yMGHnD+7us3Hc9LyS7iVyQLtN9xxGZlfcXTTZEXcAR5ZVkYhYin++b3GLg3dHO4fbGVJADrBwR4vdyjQFMpWJSAgev6fH5ok9QGSiEsATGU0UMSSQUqcNDiBv16nU+SaGaQuYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=transsion.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBulYzLuaXm5q0fyfFP1a0ec8oPVMx2WQpmz46oT4sw=;
 b=kajTagdN/qTlYv8iiObdR9rEl2EtEbRGF2SMAXG7l4DQ4mXXCUBn/nnOvepHQhBbPt0Ze318QwXMJNbGUdE90uh/T1cpcn9JevmbNJeloo6/m6jNtQa9V8lSZ63ZdTSFV6JUq+4kHGXsMWIQxQajO+oUPb5hPp8MlbJ/dbOO45o=
Received: from SJ0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:33b::18)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:04:52 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::43) by SJ0PR05CA0013.outlook.office365.com
 (2603:10b6:a03:33b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 9
 Sep 2026 10:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 10:04:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 05:04:51 -0500
Received: from [10.136.42.177] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 05:04:46 -0500
Message-ID: <a2466e7d-2dd7-4de9-963f-6eb8c58d4a49@amd.com>
Date: Wed, 9 Sep 2026 15:34:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Hongyan Xia <hongyan.xia@transsion.com>, jong wu <jianyong.wu@outlook.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
	"huangsj@hygon.cn" <huangsj@hygon.cn>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
 <d709498b-9572-44bd-a93e-bbed23fd7372@amd.com>
 <4e39e935-2339-442b-8b14-a688b605c35e@amd.com>
 <a9dc111b-21cb-4bcb-ac91-f6be04bc2e06@transsion.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <a9dc111b-21cb-4bcb-ac91-f6be04bc2e06@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8403efda-aefd-45cc-14bc-08df0e59ca1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|32650700020|1800799024|376014|7416014|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/xFaefZvtT3/p4wvmtOvBk/Trt/iTnwbeFU01Hh+QlItsTI9pa1iI3TFqowGbIks0M5kFxE7TsW51W3HQsh9vPLYbxRQ20nVDL/m3cWgl2KiiF2uJ7RH59vIBWUU49IH5KRFfrVteQ1s9DeDFLpY3iRo1Vh0pmWTgGEsTgPkJnhfaJANXva1MDBSHeP+CSU45clv3T2ZQNY11lz9/8aGz0DnYjGdhfMMsOp3HMk5Vuys5B7w4KyWdPLhHWHvHXFXK9kZ1RNMGFFL5Zbi401u80b/haYT9fzNMque7GjQpczmCUo+H2Rw2HaVff1cIBwNHUjjNBmv6/7/arHfs7ap+NUhlKQiBxWB+81PEtHzrqW6q7N8XHigiFsMU20J4iH6xNcKLW12fyKJHLFwo7zqG+RxGEUaucGdNv23xHGut/pk5GNQHVw9cUZ9A8bdgjgv5ETP0oJOn8tIZiiH8GeUem8JVY3ondAUJor2/I3TjZy9WVrcmDM6mxdgDn5kEOVv6M1TgKemJwnkzdr83CPZJxN/XuVVeItOJFqrM5VA1SSewvb54yKFcXwL1yyRo67pQcPc9k5Rje9L60VQuXwp+rj1666avSxOjRflJqHH4yJXpyRjzUTmlSDzwrPBEkU/x6s721SA7wLukeElMhecZfieyLIZ54bvO2yOaw0uRv77nzL1aRSwvKPQPo0oqN9+20uJy8cV7QMMyqBz7+JSBg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(32650700020)(1800799024)(376014)(7416014)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kug2vdRF9EInY7oKTC6IXNHcXK7KhFfFBvqCmn/ySjN4ErsfYM7sBORlVYFGainGXvxMmm+/yqqSgqYSA4lqkhzuHAVhUkXk3JD0U3hHnwSghm5GCf7ONXV5y8y6Z9UjC9VNWd8q393SDLKiTEDZPboey5jquCW6D4f6G+96WegPSnMTjKe/erOVNm45snZVvoJPn/iWxxCWfIW9AqCubiQbhtlg3U+0vzJz2mbAG1FI2QCnQc7hPETPbblTg7laX7UDd/nxL+d1vXsixPst38riZDzKoAJfrrio+JHYofCXwy0PyLYTQ2OjF0lG6QQxp8YksQB1x4QUT2WWPcFjvRASESiWW79SH/npPYV6xqqtibKm4M88ysAH6gitwWbBYmIyX+CDE1gJcQUZxNfhC4+d2W1K27WgV8jU6MsgSuW0iZahxj+1SbFMNoRTCbMt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:04:51.4675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8403efda-aefd-45cc-14bc-08df0e59ca1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

Hello Hongyan,

On 9/9/2026 9:39 AM, Hongyan Xia wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index b898b6544069..97f4a3ba5107 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>>   
>>   	cpu = cpumask_first(policy->related_cpus);
>>   	max_freq = arch_scale_freq_ref(cpu);
>> -	if (!max_freq)
>> -		max_freq = policy->cpuinfo.max_freq;
>> +	if (!max_freq) {
>> +		max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
>> +					  policy->cpuinfo.min_freq, policy->cpuinfo.max_freq,
>> +					  CPUFREQ_RELATION_H);
>> +	}
>>   
>>   	capped_freq = policy->max;
>>   
> 
> LGTM.

Thanks a ton for taking a look at the suggestion.

> 
> NIT: I do wonder if we need a full __resolve_freq() each time. We could 
> cache the highest achievable OPP on max_freq updates, but that's future 
> optimization.

Sure! We can cache it in the policy object during
cpufreq_policy_online().

Jianyong Wu would like to take a stab at it? If not, I can send it out
early next week.

-- 
Thanks and Regards,
Prateek

Disclaimer: Hygon emails are routed differently in our organization.
Response might be slightly delayed until my NNTP rule finds the email.
Sorry for any inconvenience.
