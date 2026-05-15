Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE03AEF5C
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841153; cv=none; b=VrJQmEQ0/mmIoqx0isCbF8IbYHrrx/zFBlNikYrS6x30edIMBXfrzCWli/Z/9K1UkreA7mZrQ3N1t/4W50DNdkWblSDbnb+CfLl3iPle4ZjN1U2LKxZWodLsxhwPmAg5yqECm6VL60ufbNN0xdzCizygtIPvBCyECnry4xOdt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841153; c=relaxed/simple;
	bh=KdnKWhe20Fhw1rzh/I1+oQVDQfg4ni8WVoOR0a43RUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b8MkcpneOsPoRdqsvMmfmYiLeN/9AGgTWQ4WDiVFRrpDrTeqPbcfsHeclo47hAFflx216WoZevJcm0elZ/izQmnPK55e+GJrJN2NOixwM36Lnr/xT0umiuD1Q/1SrAg/hTFxOImN8dfdtH7FRMhgHeFClRQ5m/zmgSoqigP4WEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gH3Gn6NKmzLlTv;
	Fri, 15 May 2026 18:24:49 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id C2DA44056C;
	Fri, 15 May 2026 18:32:27 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 May
 2026 18:32:27 +0800
Message-ID: <b1c5e72f-6b8f-4601-b51c-c9aee56be8a4@hisilicon.com>
Date: Fri, 15 May 2026 18:32:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] devfreq: Add module owner to devfreq governor
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <cwchoi00@gmail.com>,
	<cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
 <20260513093832.1645890-5-zhanjie9@hisilicon.com>
 <fdcac90b-b253-45f2-81fa-81c980671f28@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <fdcac90b-b253-45f2-81fa-81c980671f28@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/14/2026 2:14 PM, Yaxiong Tian wrote:
> 
> 在 2026/5/13 17:38, Jie Zhan 写道:
>> Add an 'owner' member to struct devfreq_governor, such that we can find
>> the module that holds the governor code when it's compiled as a kernel
>> module.  This allows the devfreq core to properly manage the lifecycle
>> of governors.
>>
>> Update devfreq_add_governor() and devm_devfreq_add_governor() to
>> automatically set 'owner' to THIS_MODULE via helper macros.
>>
>> This is a prerequisite for implementing governor reference counting to
>> prevent a governor module from being unloaded (except for force unload)
>> while a governor is in use.
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>>   drivers/devfreq/devfreq.c        | 26 +++++++++-----------------
>>   include/linux/devfreq-governor.h | 26 +++++++++++++++++++++++---
>>   2 files changed, 32 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 9e3e6a7348f8..e1363ab69173 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1301,11 +1301,8 @@ void devfreq_resume(void)
>>       mutex_unlock(&devfreq_list_lock);
>>   }
>>   -/**
>> - * devfreq_add_governor() - Add devfreq governor
>> - * @governor:    the devfreq governor to be added
>> - */
>> -int devfreq_add_governor(struct devfreq_governor *governor)
>> +int __devfreq_add_governor(struct devfreq_governor *governor,
>> +               struct module *mod)
>>   {
>>       struct devfreq_governor *g;
>>   @@ -1322,37 +1319,32 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>>           return -EINVAL;
>>       }
>>   +    governor->owner = mod;
>>       list_add(&governor->node, &devfreq_governor_list);
>>         return 0;
>>   }
>> -EXPORT_SYMBOL(devfreq_add_governor);
>> +EXPORT_SYMBOL(__devfreq_add_governor);
> 
> It's a bit strange to use the __ symbol here. Generally speaking, functions exported with EXPORT_SYMBOL are public, while __ indicates internal.
> 
> The same applies below.
> 
Actually it's common (typically in some kernel core code) to do this for
keeping the API the same while extending an existing ABI with more
parameters, such that those callers (in our case, governor code) don't have
to change.

If this is not favoured, we can also touch the existing governors and make
them assign 'governor->owner'.

I'm happy with both.

Thanks,
Jie

[ ... ]
