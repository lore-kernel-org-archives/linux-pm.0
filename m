Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA8361DA2
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920653; cv=none; b=jnpexXEHGnCBRIDa1eCfWhnQGa7SuehDbm/U3s63VtrjhULHHV04jHbHO40IIMv8TtHdKk1l4YTBHCIXh8JiGBHWeeZY3zGAtJtc6vT76zyBT5uu+9K8EWmHfnl+g3XfdgSRZToBpRsikFbQdwXBlWNG3/+4KEENJQjmoyQLF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920653; c=relaxed/simple;
	bh=ifkskKPCoctAtdQ2mfpIdjwQ+eiIekA90yNwYYr5vRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULxJ/VFsm1+onKMFyFuu8w+dIxN7nsATwrjxsGu2zTf/qORgqXbHWS9Oft0SbajvAsoGJaJ2HRgUtLoVVnZl52ZGdVbUNRiQ1tBZCutqXJruebX/iFdZr8pLodhJkgh6BE9AYBqayA4BDX9qjbPardSfa6bwMNg7ZXrYn/83BF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3cf8b11c2ca111f1aa26b74ffac11d73-20260331
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1dd40214-ec31-4c13-a291-064a9144bd8c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:194d303e2251d4e1a1e2a2b38ed01a82,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3cf8b11c2ca111f1aa26b74ffac11d73-20260331
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 461168864; Tue, 31 Mar 2026 09:30:44 +0800
Message-ID: <94f5b6ff-f610-44f6-90e4-2e538b4f99c9@kylinos.cn>
Date: Tue, 31 Mar 2026 09:30:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] devfreq: Fix NULL pointer dereference when a
 governor module is unloaded
To: Jie Zhan <zhanjie9@hisilicon.com>, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxarm@huawei.com, jonathan.cameron@huawei.com, zhenglifeng1@huawei.com,
 zhangpengjie2@huawei.com, lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260326123428.800407-1-zhanjie9@hisilicon.com>
 <1774576755240654.100.seg@mailgw.kylinos.cn>
 <2f9ab345-5940-4298-87a5-bf9121fe219e@kylinos.cn>
 <1774919144945331.7.seg@mailgw.kylinos.cn>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <1774919144945331.7.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/3/30 14:29, Jie Zhan 写道:
>
> On 3/27/2026 10:06 AM, Yaxiong Tian wrote:
>> 在 2026/3/26 21:14, Jie Zhan 写道:
>>> On 3/26/2026 8:34 PM, Jie Zhan wrote:
>>>> When compiled as a kernel module, the governor module can be dynamically
>>>> inserted or removed.  'devfreq->governor' would become NULL if the governor
>>>> module is removed when it's in use, and NULL pointer dereference would be
>>>> triggered.  A similar issue was also reported in [1].
>>>>
>>>> To address this issue:
>>>>
>>>> Patch 1-5 rework mutex, factor out a common governor setting function, and
>>>> clean up some unreachable code.
>>>>
>>>> Patch 6-8 prevent a governor module in use from being removed (except for
>>>> force unload) by getting/putting a refcount of the governor's module when
>>>> switching governors.
>>>>
>>>> Patch 9-10 allow 'governor' and 'available_governors' to work normally even
>>>> when a governor module in use is force unloaded.
>>>>
>>>> Note that this series is based on [1] or devfreq-next, otherwise code
>> Sorry, please ignore the "remember to CC me on the patches." in my previous email.
>>
>>   In my opinion, it would be better to prioritize the FIX first before proceeding with the lock mechanism optimizations and other work. This would make it easier to backport the patches to lower-version kernels. I noticed the patch is already in the devfreq-testing branch. I hope the FIX work can be moved forward smoothly to resolve the null pointer and other bugs. Thank you!
> Hi Yaxiong,
>
> I don't think this issue is urgent because it can only possibly happen when
> governors are built as loadable modules, which is typically used for
> development rather than production.
No, loading/unloading modules is also a user operational requirement, 
not just for development.

>
> For downstream kernels, feel free to go ahead with quick fixes.  For the
> upstream kernel, however, I'd prefer to make the devfreq core clean and
> sensible.

I don't think code cleanup should take priority over bug fixes, 
especially when you already know there's an issue with the 
functionality. In fact, the version users are running is not the 
upstream version, but rather individual stable releases.

Most users don't have the time or energy to research and fix kernel 
issues themselves; they rely on upstream community patches most of the time.

By the way, although your patch subject says "FIX", I don't see any fix tag.

>
> Your approach is to prevent kernel panics when unloading governor modules
> before changing governors.
>
> This patchset achieves that, and additionally let userspace get a friendly
> warning when trying to remove a governor module in use, e.g.
> "rmmod: ERROR: Module governor_performance is in use".
> This requires using the module refcount stuff, and brings out a set of
> cleanups and refactoring.  BTW, cpufreq implements a similar mechanism like
> this.
>
> I may carry your fourth patch that changes the return code of
> governor_show() in v2 and address some Sashiko review comments along the
> way.
>
> Please let me know if this works for you?
So I don't approve of this. Maybe you should ask for others' opinions, 
such as Chanwoo Choi.

>
> Regards,
> Jie
>>
>>
>>> sorry, based on [2] or devfreq-next
>>>> would conflict.
>>>>
>>>> [1] https://lore.kernel.org/all/20260319091409.998397-1-tianyaxiong@kylinos.cn/
>>>> [2] https://lore.kernel.org/all/20251216031153.2242306-1-zhangpengjie2@huawei.com/
