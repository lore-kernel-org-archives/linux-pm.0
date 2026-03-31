Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E38370D65
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939408; cv=none; b=Vq4leHJF0KeMrAO8sbMyEaMxZHuEXg4R3bftqrQje2j5rkkZ7WErgRVBeFN79Bn9XQl7iWnyAwbK+ZSspTMlJSt9S4/Jvb89NYGctxlGOlvUpGVK+8j3T/gFUF3YG7lH/CHWB150icbfcxzTzuUoLiB8aS6qvlVCGEQ3TFdA0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939408; c=relaxed/simple;
	bh=lb7QPZdaU2BloAAL3adrty2MJCzmZbDhZdnCJOpKfNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cy+3/X5BnQxEPrPvq3vivsxcifPI/ggqgJt+ztV7ZDSp0AoeMuJL09/UgNs4zbNKQfIlvneVzMkj7Ag5Hw1Kf0D050tdk5XPnNh/TNgaSXj+4aBiVjgcDwuxAXZ8XfWaXLE2VnpUSji+SZCYNQlTibegUnx5zvufmkkrgiIGjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4flJMM63qXzpSwM;
	Tue, 31 Mar 2026 14:37:35 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E160040569;
	Tue, 31 Mar 2026 14:43:21 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 14:43:21 +0800
Message-ID: <8281a0af-aa2d-496d-a826-ddbf334b248f@hisilicon.com>
Date: Tue, 31 Mar 2026 14:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] devfreq: Fix NULL pointer dereference when a
 governor module is unloaded
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <cw00.choi@samsung.com>,
	<myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
References: <20260326123428.800407-1-zhanjie9@hisilicon.com>
 <1774576755240654.100.seg@mailgw.kylinos.cn>
 <2f9ab345-5940-4298-87a5-bf9121fe219e@kylinos.cn>
 <1774919144945331.7.seg@mailgw.kylinos.cn>
 <94f5b6ff-f610-44f6-90e4-2e538b4f99c9@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <94f5b6ff-f610-44f6-90e4-2e538b4f99c9@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/31/2026 9:30 AM, Yaxiong Tian wrote:
> 
> 在 2026/3/30 14:29, Jie Zhan 写道:
>>
>> On 3/27/2026 10:06 AM, Yaxiong Tian wrote:
>>> 在 2026/3/26 21:14, Jie Zhan 写道:
>>>> On 3/26/2026 8:34 PM, Jie Zhan wrote:
>>>>> When compiled as a kernel module, the governor module can be dynamically
>>>>> inserted or removed.  'devfreq->governor' would become NULL if the governor
>>>>> module is removed when it's in use, and NULL pointer dereference would be
>>>>> triggered.  A similar issue was also reported in [1].
>>>>>
>>>>> To address this issue:
>>>>>
>>>>> Patch 1-5 rework mutex, factor out a common governor setting function, and
>>>>> clean up some unreachable code.
>>>>>
>>>>> Patch 6-8 prevent a governor module in use from being removed (except for
>>>>> force unload) by getting/putting a refcount of the governor's module when
>>>>> switching governors.
>>>>>
>>>>> Patch 9-10 allow 'governor' and 'available_governors' to work normally even
>>>>> when a governor module in use is force unloaded.
>>>>>
>>>>> Note that this series is based on [1] or devfreq-next, otherwise code
>>> Sorry, please ignore the "remember to CC me on the patches." in my previous email.
>>>
>>>   In my opinion, it would be better to prioritize the FIX first before proceeding with the lock mechanism optimizations and other work. This would make it easier to backport the patches to lower-version kernels. I noticed the patch is already in the devfreq-testing branch. I hope the FIX work can be moved forward smoothly to resolve the null pointer and other bugs. Thank you!
>> Hi Yaxiong,
>>
>> I don't think this issue is urgent because it can only possibly happen when
>> governors are built as loadable modules, which is typically used for
>> development rather than production.
> No, loading/unloading modules is also a user operational requirement, not just for development.
> 
>>
>> For downstream kernels, feel free to go ahead with quick fixes.  For the
>> upstream kernel, however, I'd prefer to make the devfreq core clean and
>> sensible.
> 
> I don't think code cleanup should take priority over bug fixes, especially when you already know there's an issue with the functionality. In fact, the version users are running is not the upstream version, but rather individual stable releases.

The point is to do the bugfix in a different way rather than cleanups.

> 
> Most users don't have the time or energy to research and fix kernel issues themselves; they rely on upstream community patches most of the time.
> 
> By the way, although your patch subject says "FIX", I don't see any fix tag.
> 
>>
>> Your approach is to prevent kernel panics when unloading governor modules
>> before changing governors.
>>
>> This patchset achieves that, and additionally let userspace get a friendly
>> warning when trying to remove a governor module in use, e.g.
>> "rmmod: ERROR: Module governor_performance is in use".
>> This requires using the module refcount stuff, and brings out a set of
>> cleanups and refactoring.  BTW, cpufreq implements a similar mechanism like
>> this.
>>
>> I may carry your fourth patch that changes the return code of
>> governor_show() in v2 and address some Sashiko review comments along the
>> way.
>>
>> Please let me know if this works for you?
> So I don't approve of this. Maybe you should ask for others' opinions, such as Chanwoo Choi.
> 
No problem.  I see your point.
I'll take a closer look at your version and see if that works.
The module owner refcount related stuff can be rebased later if needed.

Thanks,
Jie
>>
>> Regards,
>> Jie
>>>
>>>
>>>> sorry, based on [2] or devfreq-next
>>>>> would conflict.
>>>>>
>>>>> [1] https://lore.kernel.org/all/20260319091409.998397-1-tianyaxiong@kylinos.cn/
>>>>> [2] https://lore.kernel.org/all/20251216031153.2242306-1-zhangpengjie2@huawei.com/
