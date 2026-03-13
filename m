Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D738C40F;
	Fri, 13 Mar 2026 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396781; cv=none; b=fB8eAMUIpS/1Zgo8rnRsVvX8a5GXAswYIqQSOYvl6wLnjJFShxyzM0BhnBAzEBomf4jZHHyUgbbgneUsBje43gkEv6ZLIF+Y0VmuCjAs4p+ZAyzYa/+ZJEstGod8X0XaKbZ8DSz1m8/LbCU7BZ/7xJvtAlNZGZp94StOBOi3L6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396781; c=relaxed/simple;
	bh=Onma6eKgWAI82T5E6L/sSo0Gu7TGPC/RIO/F+zzrB0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N0aq1Bnyi8FUoEUtP4iqt2WlI3VlNoJT+nlNIrt99rQci/4bzeNMSs2WAGO3Pe/XjKjeqwMPWf/PJurLepJQLR0AwjdZyJXMwiF4enTFpC5bvD2tI+XtVsrRyR7jnwloQdyrigUGZUYNd8C5txNSYf4yEjMl0VLAmefZUFLR4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2bzO3Cpa; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2bzO3Cpa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QzG+I+qmV/xENeitVxkNoq7Ieh1D3Fxp5yppsvVHoYU=;
	b=2bzO3Cpani8gDFx4BvQDJgF0YA8rRE1ub2pwbMI5jTfJFmb2SYcyjsldMlOyXt/IwZJ3I/N9F
	RunkUqyQ6Os/Qto2Hds3QvLzDRciJxQ9JKGEDMFF7XEJy0bAaIFv4sXZ/KQ/nT9Ss1DY3Iy89Te
	gAKJ4jMcxPgIDMsznsLnQng=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fXKtR0J8Pz1cyP2;
	Fri, 13 Mar 2026 18:07:59 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 5996C40565;
	Fri, 13 Mar 2026 18:12:55 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 18:12:54 +0800
Message-ID: <08b96039-e31e-4278-8077-1f1b7c244f3d@huawei.com>
Date: Fri, 13 Mar 2026 18:12:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
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
 <d21b9ad3-72d9-44b2-b194-4e2a24077eab@huawei.com>
 <utvxk3rn6icadx4llmzfu32auqk4ql7rckh7kxtgdgmtoyovqz@vo2lmhip5vk7>
 <b7d3819f-168a-48f7-99f2-2ba04dec77e6@huawei.com>
 <dqyn4dv3ecbzzmqr4l3jxfctuxpehstjhean5gi2iqfllwso4g@i4nodkyrhwpb>
 <8f29a0ce-4cbd-4c47-b866-b4f015f0792b@huawei.com>
 <swdjuguqfniecaqxgdjwihjieiwdzxjv3vq2agq5sbd5kcftuz@qwzhr43ydzxy>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <swdjuguqfniecaqxgdjwihjieiwdzxjv3vq2agq5sbd5kcftuz@qwzhr43ydzxy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/13/2026 2:05 PM, Viresh Kumar wrote:
> On 13-03-26, 11:51, zhenglifeng (A) wrote:
>> When querying cpuinfo_cur_freq, based on the following call chain, the
>> target frequency will eventually be updated if policy->cur is out of
>> limits:
>>
>> show_cpuinfo_cur_freq()
>>   __cpufreq_get()
>>     cpufreq_verify_current_freq()
>>       handle_update()
>>         refresh_frequency_limits()
>>           cpufreq_set_policy()
>>             cpufreq_governor_limits()
>>               cpufreq_dbs_governor_limits()
>>                 cpufreq_policy_apply_limits()
>>                   __cpufreq_driver_target()
>>
>> At least to me, it's strange that querying frequency would cause the
>> target frequency to be updated.
> 
> Yeah, that is an optimization and not a feature. Normally checking the frequency
> shouldn't lead to anything, but cpufreq core needs to fix itself and it actually
> thinks that this won't happen. The hardware (yours) doing something secretly
> isn't right and breaks the design to be honest. One way to fix all this mess is
> to make your platform not do this and instead play with policy->min/max like
> everyone else, instead of making a hard change secretly.
> 

Let's forget what happens on our platform. The current discussion is no
longer about applying this patchset. What I really want to discuss are two
questions:

1. Is the platform allowed to adjust to frequencies out of the limits?

My answer is YES. policy->min and policy->max can be modified by the user.
policy->min can even be increased to be as large as policy->max. However,
due to some other limitations(temperature, power, current etc.), the
platform sometimes has to (secretly as you say) reduce the actual
frequency, inevitably falling below the OS's frequency limits. I believe
this situation will occur not only on our platform. The OS should not treat
this situation as an anomaly, and leading to unpredictable behavior. The OS
should have the ability to self-regulate. I believe that your patch is for
this purpose.

2. Is it reasonable to update the target frequency when querying
cpuinfo_cur_freq?

My answer is NO. The idea that "observation can affect the outcome" should
only apply in quantum mechanics. If querying cpuinfo_cur_freq results in an
update of the target frequency, it means that the target frequency should
indeed be updated, regardless of the query itself. So I think the best
approach is to handle this properly in gov_dbs_update(). But I am not sure
if obtaining the actual frequency in gov_dbs_update() will burden the task.
Perhaps this is why target freq updates are made when querying
cpuinfo_cur_freq now. But this does not mean that it is reasonable. It is
what you call a band-aid I think.

Please let me know if you have a different opinion.
