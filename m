Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2739B4BC;
	Tue, 17 Mar 2026 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736970; cv=none; b=s6X05JRNmRIAcBqbOSy92+1CNirB4ZKOtnom//zDEeagN0u0eO6oiQYRdfpiw7LKHuBAfX64vCfZtwuyhp4lm0XkHivlfFPcSfmmydOeiUw+xFQ/vxStLzVZd/DvqwLQNRjlPhYAydRSFgUcxhGrxmpt928J6d1Vpr8PybUNTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736970; c=relaxed/simple;
	bh=39i0FKvjbnLo0UcB1HUzCVNIP0REpjbkijj1jKEeZKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ElB2D6wyHs4yJFVxcXPfI5JcFAQHvgf9TuGyAos8fcNil58k2P3RWkjd0IzVBELCKIPUMeeRh3ZmAA95rVD819TR2uCbPwTtcznTA0fJZqBX+x7HE6A968XwzP9hMKCM8EWAJA4Vu8D4wqgrduyVTIAdx2yBM0oataKTI5rmQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ggz+E/xp; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ggz+E/xp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TnIUpYSoUJH43ZHFR5aKdHD8AMHQO6zFXhEONnGc1d4=;
	b=Ggz+E/xpQrytBBwhFN28wbfvZfu3Hb+ZF7efQvSxMVjHbla7VLAnZb0DFFl/5qMYj4BGuJVI+
	E+nTjnbsw+Fv9L9BWfeb519SJH15zeN1sTe/VouLH07HaXupEMdBvJBZW1gEMK+oVz6PruAxgjk
	GIe6a52knXH29CkElz+jAfk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fZlh40MgQz1T4GV;
	Tue, 17 Mar 2026 16:37:24 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id CE50340567;
	Tue, 17 Mar 2026 16:42:43 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:42:43 +0800
Message-ID: <4c1bec09-4a13-4bbb-a0a5-0014157c3297@huawei.com>
Date: Tue, 17 Mar 2026 16:42:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] cpufreq: Remove per-CPU QoS constraint
To: Pierre Gondois <pierre.gondois@arm.com>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, Ionela
 Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-2-pierre.gondois@arm.com>
 <zvk6qqwde535fiimjrtwhkyjnhymliv5acubtho3ge5hgj7y5g@3wolynnix3gz>
 <de26c436-bc6d-49bd-ab88-e055f1665c2f@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <de26c436-bc6d-49bd-ab88-e055f1665c2f@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/16/2026 10:45 PM, Pierre Gondois wrote:
> 
> On 3/13/26 09:57, Viresh Kumar wrote:
>> On 25-02-26, 09:49, Pierre Gondois wrote:
>>> policy->max_freq_req represents the maximum allowed frequency as
>>> requested by the policyX/scaling_max_freq sysfs file. This request
>>> applies to all CPUs of the policy. It is not possible to request
>>> a per-CPU maximum frequency.
>>>
>>> Thus, the interaction between the policy boost and scaling_max_freq
>>> settings should be handled by adding a boost specific QoS constraint.
>>> This will be handled in the following patches.
>>>
>>> This patch reverts of:
>>> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
>>> a CPU")
>>>
>>> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>> ---
>>>   drivers/cpufreq/cpufreq.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 4472bb1ec83c7..db414c052658b 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>             blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>>                   CPUFREQ_CREATE_POLICY, policy);
>>> -    } else {
>>> -        ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>>> -        if (ret < 0)
>>> -            goto out_destroy_policy;
>>>       }
>>>         if (cpufreq_driver->get && has_target()) {
>> Even if this change is required, I don't think this should be applied
>> separately. Just reverting this will get the bug back, which was fixed by
>> commit 1608f0230510. Individual patches shouldn't break kernel (and bisect) as
>> much as possible.
>>
> I could not reproduce the original issue.
> 
> At the time of the patch and still now, calls to
> freq_qos_update_request() are checked against negative values.
> The only exception is when using the scaling_max_frequency sysfs
> entry, but this is out of the scope.
> 
> So I don't see how:
> 
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging a CPU")
> 
> can prevent a CPU to reach the boost frequency.  The only path that
> could fail and that I could reproduce was fixed by:
> 
> https://lore.kernel.org/all/852ff11c589e6300730d207baac195b2d9d8b95f.1745511526.git.viresh.kumar@linaro.org/
> 
> So the current conclusion is that "cpufreq: Fix re-boost issue after hotplugging a CPU"
> was not the real fix
> 
> 

Yes. After Viresh's patchset, the original issue was solved. So commit
1608f0230510 is not needed anymore and can be reverted.

