Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8033ADB1;
	Mon, 30 Mar 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774836635; cv=none; b=nt0p0huUcP2+sk4cZSBItIunTW3810dq4R+A5o4d0XXMnthCjzEFqPBVeS2ikjZl80+q5YZgarJ+g6FgsL6zeEO4WfEkMHUjh4JfqbghRnCkioJjWBR3F83nVOo+mlCGQnrjKc6oW7SuCpoZhYZa2yDbWuJUGbymgtHYo7zEQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774836635; c=relaxed/simple;
	bh=PMfK5kCv+eH/oP0UTHnyaxbPb5H8eK5evHv218L4zT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cF6lPpkdV/Nz+r9mNG/NoI0phmTa/idawlhpnZmjkEtHoRps+hKSYhjo47MjQZDCJi6SeETQKtlAc9DIcxwQ9BP+srkpE0Nc5mV5WVrFNpswNm8AYvb5FV6T83bOThJAl7MqexktTCOu895SWLqhksdQmhSomIiZDqxQeaVJCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WLhgiMrm; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WLhgiMrm; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WLhgiMrm";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WLhgiMrm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YK8r3/u6ugLrLvdQ09eMBcyYoPZIaP56LLhvqX9IbY8=;
	b=WLhgiMrmLrKy1YKyJqqNAEHijBlgaEDuy+vP+q260vAwnvp4srJL7NEoBdvxjF9NJIAlLTkWn
	e6k+l4Jwi/ZVb0a5ExIHqOwavT86YZsnSnm+SsUMyk1UItHl1qslW7mwrCMObgJ0+q19Atgrrw9
	bug2N4sZ1wfYPiB0Z57z6WM=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fkZTH0Mzfz1BG7G;
	Mon, 30 Mar 2026 10:10:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YK8r3/u6ugLrLvdQ09eMBcyYoPZIaP56LLhvqX9IbY8=;
	b=WLhgiMrmLrKy1YKyJqqNAEHijBlgaEDuy+vP+q260vAwnvp4srJL7NEoBdvxjF9NJIAlLTkWn
	e6k+l4Jwi/ZVb0a5ExIHqOwavT86YZsnSnm+SsUMyk1UItHl1qslW7mwrCMObgJ0+q19Atgrrw9
	bug2N4sZ1wfYPiB0Z57z6WM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fkZM72gTyz12LJm;
	Mon, 30 Mar 2026 10:04:51 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 033BB40561;
	Mon, 30 Mar 2026 10:10:16 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Mar
 2026 10:10:15 +0800
Message-ID: <f61f81ff-7e42-414e-a196-d20f8717f5f7@huawei.com>
Date: Mon, 30 Mar 2026 10:10:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] cpufreq: Add boost_freq_req QoS request
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Pierre Gondois
	<pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <20260326204404.1401849-3-pierre.gondois@arm.com>
 <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/29/2026 5:00 PM, Zhongqiu Han wrote:
>> @@ -1377,6 +1386,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>       }
>>         freq_qos_remove_request(policy->min_freq_req);
>> +    freq_qos_remove_request(policy->boost_freq_req);
>>       kfree(policy->min_freq_req);
>>         cpufreq_policy_put_kobj(policy);
>> @@ -1445,26 +1455,38 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>       cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>         if (new_policy) {
>> +        unsigned int count;
>> +
>>           for_each_cpu(j, policy->related_cpus) {
>>               per_cpu(cpufreq_cpu_data, j) = policy;
>>               add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>>           }
>>   -        policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>> +        count = policy->boost_supported ? 3 : 2;
>> +        policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
>>                              GFP_KERNEL);
>>           if (!policy->min_freq_req) {
>>               ret = -ENOMEM;
>>               goto out_destroy_policy;
>>           }
>>   +        if (policy->boost_supported) {
>> +            policy->boost_freq_req = policy->min_freq_req + 2;
>> +
>> +            ret = freq_qos_add_request(&policy->constraints,
>> +                           policy->boost_freq_req,
>> +                           FREQ_QOS_MAX,
>> +                           policy->cpuinfo.max_freq);
>> +            if (ret < 0) {
>> +                policy->boost_freq_req = NULL;
>> +                goto out_destroy_policy;
>> +            }
>> +        }
>> +
>>           ret = freq_qos_add_request(&policy->constraints,
>>                          policy->min_freq_req, FREQ_QOS_MIN,
>>                          FREQ_QOS_MIN_DEFAULT_VALUE);
>>           if (ret < 0) {
>> -            /*
>> -             * So we don't call freq_qos_remove_request() for an
>> -             * uninitialized request.
>> -             */
>>               kfree(policy->min_freq_req);
>>               policy->min_freq_req = NULL;
>>               goto out_destroy_policy;
> 
> Hi Pierre, Viresh,
> 
> Sorry for the late follow-up on v8. While re-reading the patch, I
> noticed a potential UAF issue on an error path — I might be missing
> something, so I'd appreciate a double-check.
> 
> min_freq_req, max_freq_req and boost_freq_req all point into the same
> contiguous kzalloc'd block:
> 
> slot0 (min_freq_req + 0) -> min_freq_req
> slot1 (min_freq_req + 1) -> max_freq_req
> slot2 (min_freq_req + 2) -> boost_freq_req
> 
> If boost_freq_req is successfully added to the QoS constraints list, but
> the subsequent freq_qos_add_request() for min_freq_req fails, the error
> path does:
> 
> kfree(policy->min_freq_req); /* frees the entire block, including slot2
> */
> policy->min_freq_req = NULL;
> goto out_destroy_policy;
> 
> policy->boost_freq_req is not set to NULL here, so it becomes a dangling
> pointer into freed memory.
> cpufreq_policy_free() is then called from cpufreq_online() and does:
> 
> freq_qos_remove_request(policy->boost_freq_req); /* UAF */
> or this boost qos req will leak.
> 

Good catch!

How about remove the kfree() here and just leave it to
cpufreq_policy_free()?

