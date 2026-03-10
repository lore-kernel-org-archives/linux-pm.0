Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FE1386C9;
	Tue, 10 Mar 2026 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112501; cv=none; b=Y51YcP8tucucy6Zj5VZ/GeMo2kYZFNmzzEXSTw6UxWZR26MU+0qM6XLl6zd+OhmsNDEagK7YvMYGYTdnsQLrD05c7HZEiu+uZJF01wOfH6VuaUom+TO16ttAYFh1WdJGrH5K7PYgTHj/FDV/pYPImApinyM9b40/UPq8brdxgvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112501; c=relaxed/simple;
	bh=Uskka569QBSSXaiNnOlJRRYau5eVAyuazHZ7IbTF3LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PSFqx6V8UMQNMFrxnUdYiG9YfVJHDsikB169x19sCIg4BxnhxqLAGLDINnC5nurrcbLv6GZBxcJ2aM6qDRI0C1UzT3/zabsL6R8Bli9gZltTbTpNDWH+x/ZKLuJ9Rkffk50KsADGfOfF8gHcv+MLPkEM0trDhl93yHxRmSBn85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fVJlF3FH3z1T4Fs;
	Tue, 10 Mar 2026 11:09:45 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 23AAB20104;
	Tue, 10 Mar 2026 11:14:55 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Mar
 2026 11:14:54 +0800
Message-ID: <93bff819-b232-4047-93fd-7ec02ec417ef@hisilicon.com>
Date: Tue, 10 Mar 2026 11:14:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <8f50fe29-c2f6-465a-b04a-6eac79ed49dd@hisilicon.com>
 <541a8677-7482-4463-9463-21d7410f65b1@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <541a8677-7482-4463-9463-21d7410f65b1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/6/2026 5:21 PM, zhenglifeng (A) wrote:
> On 3/5/2026 8:19 PM, Jie Zhan wrote:
>>
>> On 2/10/2026 7:54 PM, Lifeng Zheng wrote:
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
>>> 	if (load > dbs_data->up_threshold) {
>>> 		dbs_info->down_skip = 0;
>>>
>>> 		/* if we are already at full speed then break out early */
>>> 		if (requested_freq == policy->max)
>>> 			goto out;
>>>
>>> Therefore, the target frequency will always remain at the lowest frequency.
>> I feel like this is a common issue that some special handling in the
>> governor should happen when the frequency limits changes, i.e.
>> governor->limits() gets called.  See 'limits_changed' or 'need_freq_update'
>> in the schedutil governor.
>>
>> Do you think it's reasonable to mark such a flag in 'cpufreq_policy' when
>> its limits changes, and any governor can use that for their own code?
> 
> Yes. This is why I said 'The branching conditions in cs_dbs_update() may
> not be strict enough'. However, using policy->cur to decide the target freq
> is unreasonable to me. So this patch set is still meaningful I think.
> 
Ok, ignore this.  I was thinking of extracting such a flag/variable to a
common struct shared among ondemand, conservative, and scheduitl.  But this
is unrealistic at the moment, considering the governor data between DBS
(ondemand, conservative) and schedutil is totally different.

>>
>> Jie
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
>>>
>>> Lifeng Zheng (2):
>>>   cpufreq: governor: Move requested_freq to policy_dbs_info
>>>   cpufreq: governor: Apply limits with requested_freq or next_freq
>>>
>>>  drivers/cpufreq/cpufreq_conservative.c | 14 ++++----------
>>>  drivers/cpufreq/cpufreq_governor.c     |  3 ++-
>>>  drivers/cpufreq/cpufreq_governor.h     | 12 ++++++++++++
>>>  drivers/cpufreq/cpufreq_ondemand.c     | 10 +++++-----
>>>  include/linux/cpufreq.h                |  7 ++++---
>>>  kernel/sched/cpufreq_schedutil.c       |  4 ++--
>>>  6 files changed, 29 insertions(+), 21 deletions(-)
>>>
> 
