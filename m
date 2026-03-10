Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CD38B143;
	Tue, 10 Mar 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148319; cv=none; b=thuq4IKDDbOrPRmVmGHGP8GUpNmUYkTVd9RhXs1hk8za29x4KjThKv6jMbVdyO1SUQVS3H/sWv6Arv8QMM+HeS0X1pGs5v7ltmLi58PjLrXgtdn6RF87/jKX0MujIUxTIhCalg7+yNyd5rCjBHfGqvNCKxLkaMkeDdSBO3/p7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148319; c=relaxed/simple;
	bh=eda1JSclU1+4S1CmEs+PQHUhUGVZBhex1Mx+AgvRf+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hKjl4akKO4nYYMjfJ45tQrTEV5/BhqHT3C8bN9r9a748CmZNtzBR6GjDbimBOSvs0NKno4HqErovgn0BZ3uIQja818BHYoMOornrqKMBchtZ3wBrvTyAhynrc5wCGFnGu6AdnFSd8AKFuoocsHtbter+dYa45ekJw0XjdX4yD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IQpyUEsp; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IQpyUEsp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=INCZIp7uHJrFTEvf8TXTlJxijgbp7/SECIYD7QtUcbU=;
	b=IQpyUEspln5WmQol2Rl1BY5hqdhVhijOw/DAZHBFMxvRcwkomqfwOtT9XjhdM+9n2SltXMDk0
	QKOw5fizRwILAs4oKVpGXSwHbApUc0paDyUQmRPsFmhkrLOxpvnMBZzdMA4uZYAU+dPQwWx9Hqn
	cVBUUcya1sU/AB1B2FD9la0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fVZ095KSmz1prKT;
	Tue, 10 Mar 2026 21:06:49 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id D22D540363;
	Tue, 10 Mar 2026 21:11:46 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Mar
 2026 21:11:46 +0800
Message-ID: <b7d3819f-168a-48f7-99f2-2ba04dec77e6@huawei.com>
Date: Tue, 10 Mar 2026 21:11:45 +0800
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
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <utvxk3rn6icadx4llmzfu32auqk4ql7rckh7kxtgdgmtoyovqz@vo2lmhip5vk7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/10/2026 12:29 PM, Viresh Kumar wrote:
> On 10-03-26, 10:22, zhenglifeng (A) wrote:
>> In the example I showed above, policy->cur will become 1GHz when someone
>> query cpuinfo_cur_freq, because the real freq is 500MHz. After that,
>> conservative governor has to take some time to get to the max freq again
>> step by step in your code.
> 
> The problem is that your platform is doing some tricky stuff (by
> changing the frequency for some reason) and it expects the governor to
> still work the same. The software is trying to get a target frequency
> based on an algorithm and you are ending up breaking it. If this is
> software controlled (instead of hardware), I think a better solution
> is to play with QoS requests and limit the policy->max frequency, so
> the cpufreq core remains in sync instead of reducing the underlying
> frequency without informing the software. All cpufreq core can do now
> is go adjust based on what you are doing. Yes, conservative governor
> will start again from scratch here but this is what you are doing
> anyways. Either, don't change the underlying freq or use a different
> governor. I don't know how this can be fixed otherwise.
> 
>> I still believe using policy->cur to update target in
>> cpufreq_policy_apply_limits() is not very reasonable, because OS never
>> knows what the platform will do to affect the final frequency.
> 
> The software is doing the right thing by using the cached current
> frequency (best known to it).
> 
> We are using policy->cur at too many places and we will not be able to
> change all of them assuming the hardware is not in sync with the
> request made earlier. The change you propose may fix your issue for
> time being, but it is just a band-aid which I don't want to apply.
> When the hardware changes underlying freq, there are far too many
> things broken elsewhere too.
> 

I basically agree with what you said. But I have a little question. Do you
think the target freq should be updated when querying cpuinfo_cur_freq? I
think it should only be updated by governor or when limits changed.
