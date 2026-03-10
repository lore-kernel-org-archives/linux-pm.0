Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999D38550D;
	Tue, 10 Mar 2026 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109371; cv=none; b=PQYGQWaXUCukovg5GtZdXUj/odE7yI0TmQGbQ66cmieVYj3i3nMlVWH6zmP9CQZeQcL6LgexM6yaJgJOPGBkULlZOsmA/EFev4RD/yL1Q6WnbQsKY6TSILbbRw+ePS6uxds0yzBhtOknuH/YtrNCrdqqBrB3Xph9AuybP8b8BNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109371; c=relaxed/simple;
	bh=Cx2jZDKd8GFI6DJrRFgL8C5sjCqiCQFGXHUFzTX7jaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kxw25dIB4fe4gLKLalgUzOZuTr4Csf8MlvOzG8HJ119/gyTY1O4KZUdX+r4HuXUYiDQpgzH5XD2NsYWh/xJrmbv+tHl3+8ekO8I3EcbVk6qR9iMJ877TIKIZqzvMPhthn5DTROPpVGn7eEFnxcKTXc5wOXZdO9jD72RIPI1ACzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jSBSTwvd; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jSBSTwvd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pa/zscm76YjIf6T4rKbeqXiqHfsOf/gheff7EQRPqKQ=;
	b=jSBSTwvdCvq3RjK9mafj9wTkQmI4He1QDSDnc/qo9YIMaZMBS4YC/aj9+y5oiKLMNx4AEEyP2
	MQ+Gn9svqxKILlKQONsnYojUWOLa47yyrUFeDfx91TpiiUww/QQoG5AfcruC0KIWxVCXp0UwLoD
	Ph7Ep6PekWzynaZz7S0RhFc=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fVHZY043xz12LCw;
	Tue, 10 Mar 2026 10:17:09 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 36F9740538;
	Tue, 10 Mar 2026 10:22:45 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Mar
 2026 10:22:44 +0800
Message-ID: <d21b9ad3-72d9-44b2-b194-4e2a24077eab@huawei.com>
Date: Tue, 10 Mar 2026 10:22:43 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
 <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/9/2026 8:32 PM, Rafael J. Wysocki wrote:
> On Mon, Mar 9, 2026 at 9:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 10-02-26, 19:54, Lifeng Zheng wrote:
>>> The motivation for this patchset cames from a test on our platform:
>>>
>>> With conservative governor and some pressure on CPU, the frequency rapidly
>>> reach the max supported frequency, such as 2GHz.
>>>
>>> Later, some frequency division strategies on our platform were triggered
>>> and the actual frequency become 500MHz -- 1/4 of the OS distribution
>>> frequency.
>>>
>>> At that time, if someone excecutes 'cat cpuinfo_cur_freq', the actual
>>> frequency will become 250MHz -- 1/4 of the min supported frequency.
>>>
>>> After the platform recovering from the frequency division, the frequency
>>> will stay on 1GHz, until the pressure disappear.
>>>
>>> The reason this happens is that in cpufreq_verify_current_freq(), if
>>> policy->cur != new_freq, policy->update will be queued, which will
>>> ultimately lead to a call to cpufreq_policy_apply_limits(), and update the
>>> target frequency to policy->min. And then in cs_dbs_update(), since the
>>> pressure never vanish, it will always hit the following branches:
>>>
>>>       if (load > dbs_data->up_threshold) {
>>>               dbs_info->down_skip = 0;
>>>
>>>               /* if we are already at full speed then break out early */
>>>               if (requested_freq == policy->max)
>>>                       goto out;
>>>
>>> Therefore, the target frequency will always remain at the lowest frequency.
>>>
>>> The branching conditions in cs_dbs_update() may not be strict enough, but
>>> the root cause of this problem is that the target frequency was updated
>>> when querying cpuinfo_cur_freq. For ondemand and schedutil governor,
>>> although the frequency will not always remain at the lowest level without
>>> rising, will still be min_freq in a short period of time when the query
>>> action occurs.
>>>
>>> Using the freq requested by the governor to decide whether to update the
>>> target frequency is more reasonable in cpufreq_policy_apply_limits().
>>
>> I think I understand the problem now. We are tracking the current
>> frequency state via two cached values, policy->cur and requested_freq
>> and a mismatch (because of your hardware specific quirks/features)
>> between them is making things tricky.
>>
>> Rafael, will this break anything we can think about ?
> 
> I can't recall, but the new code is simpler, so unless anyone has a
> particular heartburn with it, go for it.

Hi Viresh,

Sorry, I don't think the new code can totally solve the problem I met.

In the example I showed above, policy->cur will become 1GHz when someone
query cpuinfo_cur_freq, because the real freq is 500MHz. After that,
conservative governor has to take some time to get to the max freq again
step by step in your code. This means the real freq will shake whenever
cpuinfo_cur_freq is queried. This situation also occurs with ondemand and
schedutil governor, but they don't need to increase the frequency step by
step.

I still believe using policy->cur to update target in
cpufreq_policy_apply_limits() is not very reasonable, because OS never
knows what the platform will do to affect the final frequency. OS should
determine the new target frequency based on the previous decision.

> 
>> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
>> index e0e847764511..c69577e4f941 100644
>> --- a/drivers/cpufreq/cpufreq_conservative.c
>> +++ b/drivers/cpufreq/cpufreq_conservative.c
>> @@ -14,7 +14,6 @@
>>  struct cs_policy_dbs_info {
>>         struct policy_dbs_info policy_dbs;
>>         unsigned int down_skip;
>> -       unsigned int requested_freq;
>>  };
>>
>>  static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
>> @@ -59,10 +58,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>>  {
>>         struct policy_dbs_info *policy_dbs = policy->governor_data;
>>         struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
>> -       unsigned int requested_freq = dbs_info->requested_freq;
>>         struct dbs_data *dbs_data = policy_dbs->dbs_data;
>>         struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>>         unsigned int load = dbs_update(policy);
>> +       unsigned int requested_freq = policy->cur;
>>         unsigned int freq_step;
>>
>>         /*
>> @@ -72,16 +71,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>>         if (cs_tuners->freq_step == 0)
>>                 goto out;
>>
>> -       /*
>> -        * If requested_freq is out of range, it is likely that the limits
>> -        * changed in the meantime, so fall back to current frequency in that
>> -        * case.
>> -        */
>> -       if (requested_freq > policy->max || requested_freq < policy->min) {
>> -               requested_freq = policy->cur;
>> -               dbs_info->requested_freq = requested_freq;
>> -       }
>> -
>>         freq_step = get_freq_step(cs_tuners, policy);
>>
>>         /*
>> @@ -113,7 +102,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>>
>>                 __cpufreq_driver_target(policy, requested_freq,
>>                                         CPUFREQ_RELATION_HE);
>> -               dbs_info->requested_freq = requested_freq;
>>                 goto out;
>>         }
>>
>> @@ -137,7 +125,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>>
>>                 __cpufreq_driver_target(policy, requested_freq,
>>                                         CPUFREQ_RELATION_LE);
>> -               dbs_info->requested_freq = requested_freq;
>>         }
>>
>>   out:
>> @@ -310,7 +297,6 @@ static void cs_start(struct cpufreq_policy *policy)
>>         struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
>>
>>         dbs_info->down_skip = 0;
>> -       dbs_info->requested_freq = policy->cur;
>>  }
>>
>>  static struct dbs_governor cs_governor = {
>>
>> -------------------------8<-------------------------
>>
>> This always pick the next freq based on policy->cur instead of the
>> real last request. The two can differ if:
>> - the hardware plays with current frequency, as is the case here.
>> - or the limits change and that changes the current frequency (in
>>   which case we will be at policy->min/max anyway).
>>
>> --
>> viresh
> 

