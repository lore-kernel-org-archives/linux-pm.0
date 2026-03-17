Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF281396D25;
	Tue, 17 Mar 2026 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736013; cv=none; b=H7lpaJ9ovEy+3qGRA/E5o2SJofjHx7Do0ufmHD9GLxAXm67lD3gsQYYu25Zh3nDyN/K5RPQCb7duQ2y91opHpVwJuM/bo3dnMnNYRlBMaSG7muDAlNJ7MckgCiUv5CKYHcO8IaW29mSWgIuQ0yl9OnTM9xaKrEzHPwjriblUNWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736013; c=relaxed/simple;
	bh=1ZC802MooITiT/dsWjptuk4f7Tev1+KC9l2nmvQ99Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ht3rg5q3ah5N71n9C9lJlWbLm1vjsvX4a4op8Em2qTsZtZgkP6uz05NXtOVmmD75JxdE1nV7SIlAIm0++tTpX6UGhkMyK+9SD5CZIh5F5nJHSbrhlDTM4pU2+t/IMlB9y3p45vBKa0wmiZQu8QcN4T9G2Ovllvy0Ka2c/mX14Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2XABj9ss; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2XABj9ss"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qoPRgzWd0zetSPddF8fJUr1EELED2B/HfRXYMdXdzx4=;
	b=2XABj9ssr/ktEuO8FGR6I80PKsj5mA8KzSYrglZqOq3auGergUc++ozbzuYQ3YKzz4ZGO/JOV
	VUH68Q/rZ7JHSFseZUInP+BB7MPGoXssKvVhH04bSGCPjzD7LUVFHq96/kDAsVoF7YXLy02Ost1
	U7845HV0es+3lraYA3RFtCU=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fZlL574bqzLlSF;
	Tue, 17 Mar 2026 16:21:49 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id C908F40565;
	Tue, 17 Mar 2026 16:26:48 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:26:47 +0800
Message-ID: <214213f5-6932-4ac7-8d4c-e4a994622890@huawei.com>
Date: Tue, 17 Mar 2026 16:26:47 +0800
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
 <08b96039-e31e-4278-8077-1f1b7c244f3d@huawei.com>
 <uo46emkyvpr4lzvnbdlkcgdrkvdzolkwuiqqey3pu3j3qqrbqz@z5ezeqhowy5a>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <uo46emkyvpr4lzvnbdlkcgdrkvdzolkwuiqqey3pu3j3qqrbqz@z5ezeqhowy5a>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/17/2026 2:20 PM, Viresh Kumar wrote:
> On 13-03-26, 18:12, zhenglifeng (A) wrote:
>> Let's forget what happens on our platform. The current discussion is no
>> longer about applying this patchset. What I really want to discuss are two
>> questions:
>>
>> 1. Is the platform allowed to adjust to frequencies out of the limits?
>>
>> My answer is YES. policy->min and policy->max can be modified by the user.
>> policy->min can even be increased to be as large as policy->max. However,
>> due to some other limitations(temperature, power, current etc.), the
>> platform sometimes has to (secretly as you say) reduce the actual
>> frequency, inevitably falling below the OS's frequency limits.
> 
> It is fine if you want to do that, just that you should use OS to make that
> change.
> - Update freq table to contain all valid frequencies (1/4 of min in you case).
> - Update policy->min to current min, so you don't go to those low frequencies.
> - Use freq qos or sysfs to change min/max when you want to go really low, like
>   1/4 of min.
> 
>> I believe
>> this situation will occur not only on our platform. The OS should not treat
>> this situation as an anomaly, and leading to unpredictable behavior. The OS
>> should have the ability to self-regulate. I believe that your patch is for
>> this purpose.
> 
> When the OS is kept in the dark about such a change, it needs to figure out a
> way to get back. That's all we are trying here.

I see. Then I think the point is how to let OS know when hardware change the
frequency. It's worth thinking about.

> 
>> 2. Is it reasonable to update the target frequency when querying
>> cpuinfo_cur_freq?
>>
>> My answer is NO. The idea that "observation can affect the outcome" should
>> only apply in quantum mechanics. If querying cpuinfo_cur_freq results in an
>> update of the target frequency, it means that the target frequency should
>> indeed be updated, regardless of the query itself. So I think the best
>> approach is to handle this properly in gov_dbs_update(). But I am not sure
>> if obtaining the actual frequency in gov_dbs_update() will burden the task.
> 
> Exactly the point. We have chosen to do this only when cpufreq core gets to know
> the real frequency. Reading current frequency is a time consuming process and we
> don't want to do it unnecessarily.
> 
>> Perhaps this is why target freq updates are made when querying
>> cpuinfo_cur_freq now. But this does not mean that it is reasonable. It is
>> what you call a band-aid I think.
> 
> Of course it is a band-aid. No doubt about that. It may not be the best way out,
> but it is how it is right now.
> 

Thanks for the answer.

