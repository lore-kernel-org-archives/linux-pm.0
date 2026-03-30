Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8D1B4F0A
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852166; cv=none; b=gF+0x63riVqXEmFX4LM3Mc9BALCmLB9CxB8r+gQmuGgvXrcTZWiwJp6kIEbUvjsiG8lxKfRH9jfbmwQvXAA8U9nIJoRC7IT4PRoeEvZS2zyUYwQmKartC1+tyvpHF1Fg9IESiKDAWPyW2LxABzDXcvlr2aTtrN4UJSujmLzC3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852166; c=relaxed/simple;
	bh=0DFyfvWmG3s9IP3Fmv+qC/Fd7V/d9btSUp69SUM56mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jchDuWUkkLP0/NGrt07rbwPSmLCzbcwQUKGA/Soat3bwQj+ytXVxKUUn2mY0/SJYIilta6md0jwfasn0cBtSyBsIOmxml/fXfrIzt1jXkk4Q0GTa0QKuQzesNUbLT2Hv45OubkxpfAbkZ8qIB5j1uFwdYT7339ApVgmhWCsPrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fkh5D18SWzLm2K;
	Mon, 30 Mar 2026 14:23:12 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id DF2C240565;
	Mon, 30 Mar 2026 14:29:19 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Mar
 2026 14:29:19 +0800
Message-ID: <47b32b11-fbc8-4e9c-9b04-da3d1465ae7c@hisilicon.com>
Date: Mon, 30 Mar 2026 14:29:18 +0800
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
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <2f9ab345-5940-4298-87a5-bf9121fe219e@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/27/2026 10:06 AM, Yaxiong Tian wrote:
> 
> 在 2026/3/26 21:14, Jie Zhan 写道:
>>
>> On 3/26/2026 8:34 PM, Jie Zhan wrote:
>>> When compiled as a kernel module, the governor module can be dynamically
>>> inserted or removed.  'devfreq->governor' would become NULL if the governor
>>> module is removed when it's in use, and NULL pointer dereference would be
>>> triggered.  A similar issue was also reported in [1].
>>>
>>> To address this issue:
>>>
>>> Patch 1-5 rework mutex, factor out a common governor setting function, and
>>> clean up some unreachable code.
>>>
>>> Patch 6-8 prevent a governor module in use from being removed (except for
>>> force unload) by getting/putting a refcount of the governor's module when
>>> switching governors.
>>>
>>> Patch 9-10 allow 'governor' and 'available_governors' to work normally even
>>> when a governor module in use is force unloaded.
>>>
>>> Note that this series is based on [1] or devfreq-next, otherwise code
> 
> Sorry, please ignore the "remember to CC me on the patches." in my previous email.
> 
>  In my opinion, it would be better to prioritize the FIX first before proceeding with the lock mechanism optimizations and other work. This would make it easier to backport the patches to lower-version kernels. I noticed the patch is already in the devfreq-testing branch. I hope the FIX work can be moved forward smoothly to resolve the null pointer and other bugs. Thank you!

Hi Yaxiong,

I don't think this issue is urgent because it can only possibly happen when
governors are built as loadable modules, which is typically used for
development rather than production.

For downstream kernels, feel free to go ahead with quick fixes.  For the
upstream kernel, however, I'd prefer to make the devfreq core clean and
sensible.

Your approach is to prevent kernel panics when unloading governor modules
before changing governors.

This patchset achieves that, and additionally let userspace get a friendly
warning when trying to remove a governor module in use, e.g. 
"rmmod: ERROR: Module governor_performance is in use".
This requires using the module refcount stuff, and brings out a set of
cleanups and refactoring.  BTW, cpufreq implements a similar mechanism like
this.

I may carry your fourth patch that changes the return code of
governor_show() in v2 and address some Sashiko review comments along the
way.

Please let me know if this works for you?

Regards,
Jie
> 
> 
> 
>> sorry, based on [2] or devfreq-next
>>> would conflict.
>>>
>>> [1] https://lore.kernel.org/all/20260319091409.998397-1-tianyaxiong@kylinos.cn/
>>> [2] https://lore.kernel.org/all/20251216031153.2242306-1-zhangpengjie2@huawei.com/
