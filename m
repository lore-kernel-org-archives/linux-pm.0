Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388622D97B8;
	Fri, 13 Mar 2026 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773373904; cv=none; b=Oe86r4fOIKj7UFoahb/lvy5KlMoZ3M4QhKwA9IiPxhCocCin3pqyU3Eh3x0JGWnl+ppK6/suXTq+hSHloRKcjSCbzhxK+SndKsXO2vHXsjf/iUtbuGmzrbSWSYPS2Tx0f36N42y3MNinZXvh+9I9klj/npXlhL3ldVpkLUfxecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773373904; c=relaxed/simple;
	bh=+8f6D8fDI65DI5cN4zdAXnRnlZMQB1NLYme25a+wFbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=smt4OEji3Fny6pyhBfF47p2hSALBvZtO08GPuQX5nRFVadRQ8fWTbRgZBz9ytD2jqP05f7vYk49x8suaVvfKFXpdFQ9WCxgKxWhuV9Sz8DFJF3Q33bUldv+tLIRsxV2Ve1yP201mwBV5jZ4C9AbtlGJzU6+WQkuyPClVPb3FTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lkAy+fAw; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lkAy+fAw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fooETulObFbgruwf7hxF5g8pudAEyYFUZgJcTqVGQ2Q=;
	b=lkAy+fAw06su/bBopy2hkuvGS6zSNi/Mw7PH+tLfQ0qFWlYoNDQXSqD9d29YOmY3p5dD1JG8G
	0pvQfM1aoAv9fHBrEwnCsA1YTgZ/TdjcHiho4DfueCKAZy3spd1P75PGRKj/zc5F8bcIzm8h5/w
	aOt6Tx4l282J7B//bX3a6UI=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fX9QQ1kMNz1K9Bk;
	Fri, 13 Mar 2026 11:46:38 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 54D1F4056B;
	Fri, 13 Mar 2026 11:51:32 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 11:51:31 +0800
Message-ID: <8f29a0ce-4cbd-4c47-b866-b4f015f0792b@huawei.com>
Date: Fri, 13 Mar 2026 11:51:31 +0800
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
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <dqyn4dv3ecbzzmqr4l3jxfctuxpehstjhean5gi2iqfllwso4g@i4nodkyrhwpb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/12/2026 2:16 PM, Viresh Kumar wrote:
> On 10-03-26, 21:11, zhenglifeng (A) wrote:
>> I basically agree with what you said. But I have a little question. Do you
>> think the target freq should be updated when querying cpuinfo_cur_freq? I
>> think it should only be updated by governor or when limits changed.
> 
> I am not sure I understand the question. Where are we updating
> target-freq ? As far as cpuinfo_cur_freq goes, there is no need to
> make any changes when that is queried but..
> - cpufreq core caches the currently known freq as policy->cur and uses
>   it everywhere.
> - When cpuinfo_cur_freq is queried, we go and check with the hardware,
>   what the frequency is.
> - If a difference is found, we align policy->cur with that, given it
>   is still withing policy limits. That's all.
> 

When querying cpuinfo_cur_freq, based on the following call chain, the
target frequency will eventually be updated if policy->cur is out of
limits:

show_cpuinfo_cur_freq()
  __cpufreq_get()
    cpufreq_verify_current_freq()
      handle_update()
        refresh_frequency_limits()
          cpufreq_set_policy()
            cpufreq_governor_limits()
              cpufreq_dbs_governor_limits()
                cpufreq_policy_apply_limits()
                  __cpufreq_driver_target()

At least to me, it's strange that querying frequency would cause the
target frequency to be updated.
