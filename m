Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3630371040;
	Fri, 20 Mar 2026 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001100; cv=none; b=Fw8PhPOlEvpima+GyrY4blLloBcNHk8h7VZ0ZKyWQktKm/L6CeWnzRCqqMzx9kSHXmZ1s2fvW0tycEsYwIy37ttqqpNqQZCftKpEUdaUXIujKTtuHmMqufJrIa5SosWqHAyEAyX8wZq/uDDos5aj6kNeOZoTJ+my5aKrGUGBUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001100; c=relaxed/simple;
	bh=/noOU6HyHpAGL/UG4lFLhJySuRkW9nWA7CoYetHU85I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EF90xLWYvZVK1N27UVDkk8uqK01707bxxSjwEUH1OO3EbYOUHBMqMNSO/UBrfnGMcWES3e9H6lqncbHiOYnJ5zlEratQrw6D0Vs9lKYqqLreS9LvGBzi5wHFOPuXioFnBHRmP/LDbl3smRGDaskbfl9dAI0ZqdZTFGIdLljYsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=x1aHSAhY; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="x1aHSAhY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fMWR27TOBA+cwuZq2AW3Smi592idmeH04ycq7cL9OPA=;
	b=x1aHSAhYZd0qWJHCrr8ECZFXpeQ57keG1LKaSnfUddmB3X/4aPqvntDLjq2DB+jiNlafwBXwR
	4yhGGUwdXia5Cjf65+jJ5T4eM4+uWLb3Ewhx3cUF9/MQJo6xOVaKEuFdjdZt5bssiMVgmf7F859
	+11Oo5cwwfi+kx1KR0OKm2A=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fcdLb47MczLls3;
	Fri, 20 Mar 2026 17:58:47 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DC8040363;
	Fri, 20 Mar 2026 18:04:49 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 18:04:48 +0800
Message-ID: <4592550c-6c56-4e71-a989-4e9ca90c97de@huawei.com>
Date: Fri, 20 Mar 2026 18:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] cpufreq: Remove per-CPU QoS constraint
To: Pierre Gondois <pierre.gondois@arm.com>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, Ionela
 Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, Huang
 Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-2-pierre.gondois@arm.com>
 <46wu76e25pscn5tkes6uabtgsqxev6wvi5pihrlozobyadmuqq@ffvqv43nys23>
 <ad23c89f-776e-4788-88ee-08583c0aadaf@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <ad23c89f-776e-4788-88ee-08583c0aadaf@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/19/2026 5:30 PM, Pierre Gondois wrote:
> 
> On 3/18/26 12:13, Viresh Kumar wrote:
>> On 17-03-26, 11:17, Pierre Gondois wrote:
>>> policy->max_freq_req represents the maximum allowed frequency as
>>> requested by the policyX/scaling_max_freq sysfs file. This request
>>> applies to all CPUs of the policy. It is not possible to request
>>> a per-CPU maximum frequency.
>>>
>>> Thus, the interaction between the policy boost and scaling_max_freq
>>> settings should be handled by adding a boost specific QoS constraint.
>>> This will be handled in the following patches.
>> I don't think the above is required anymore. This patch is removing stale code
>> now which isn't useful anymore. It has nothing to do with a boost specific QOS
>> constraint.
> Yes ok
>> And it would be better to know for sure why this isn't required anymore and
>> which patch exactly fixed this issue.
>>
> On a kernel based on 1608f0230510~, and replicating the
> process described in the commit message of
> 
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
> a CPU")
> 
> I could not see any issue regarding the values of:
> 
> - policy1/cpuinfo_max_freq
> - policy1/scaling_max_freq
> 
> The following sequence however had an issue:
> 
> 1. echo 0 > /sys/devices/system/cpu/cpu1/online
> 2. echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 3. echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> as after 1.:
> 
> cpufreq_boost_trigger_state()
> \-for_each_active_policy()
> 
> doesn't enable boost for inactive policies. This leads to
> CPU1 having the non-boosted frequency as its max freq.
> 
> The above sequence is fixed by:
> 
> commit a153c6049ab8 ("cpufreq: Introduce a more
> generic way to set default per-policy boost flag")

Yes, I think this commit fixed the issue but I didn't realize it before so
I sent them both. 😂

> 
> ---
> 
> @Lifeng, should I check something else than the value of:
> 
> - policy1/cpuinfo_max_freq
> - policy1/scaling_max_freq
> 
> in order to reproduce the issue fixed by:
> 
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
> a CPU")
> 
> ?
> 
> 
> 

