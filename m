Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54243AA1B0
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242908; cv=none; b=A2K3pnuh6+sigq52rdc6YyI3bv+Lpd6rdxTlCEZFqZds3p5QYOTHcN2XC8LRiQMkQMV5ZkVUX9K+S/l2F8U6TKYJ9IBV7cEkJHsxUKQI87+UZk0YPnBZc5Klr72uPW/NW+M3zjouNRIXqU9Wt5MGDHIiqujb+u9hXTvowK/JI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242908; c=relaxed/simple;
	bh=O2lZN+g/+jmL2bQSsuFX8GqrsHx8a4o2KM9iAshYPdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mxlk1CFf/GjcUVR+Fx0y4gKmQoHRKX1PiBiqX9EyvwVVuO5jFOonaipknZppkg1GHHdu06oVlarU07MWTLpQdRps+WylJTtZBWQPGBwR3qXVe/fTms6Te4gBYvuDjGadqxIycMpCyW4hCpoDEgMNvF4VQ/f6AcGFQmjgtmB9QAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h8ZlD15Snz12LG0;
	Tue, 28 Jul 2026 20:38:48 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F42F202E6;
	Tue, 28 Jul 2026 20:48:18 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Jul
 2026 20:48:17 +0800
Message-ID: <649b3e33-8829-48bc-9e60-5d2935ec9cc9@hisilicon.com>
Date: Tue, 28 Jul 2026 20:48:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] devfreq: Refcount governor modules while in use
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, <cwchoi00@gmail.com>,
	<cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20260519113251.3745140-1-zhanjie9@hisilicon.com>
 <20260519113251.3745140-5-zhanjie9@hisilicon.com>
 <5e503177-95e6-460a-b6b8-39f725da34a8@huawei.com>
 <ceb7d509-39d1-4d80-91a0-e129d0c2ce7b@hisilicon.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <ceb7d509-39d1-4d80-91a0-e129d0c2ce7b@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 6/1/2026 10:03 AM, Jie Zhan wrote:
> 
> 
> On 5/21/2026 4:13 PM, zhenglifeng (A) wrote:
>> On 5/19/2026 7:32 PM, Jie Zhan wrote:
>>> A governor module can be inserted or removed dynamically when built as a
>>> kernel module.  'devfreq->governor' would become NULL if the governor
>>> module is removed when it's in use.
>>>
>>> Add a refcount mechanism for governor modules to prevent the governor
>>> module from being removed (except for force unload):
>>> 1. Add an optional 'owner' member to struct devfreq_governor so the devfreq
>>>    core can identify the module that holds the governor code.
>>> 2. Get and put a refcount of the governor module when starting and stopping
>>>    the governor.
>>>
>>> The new 'owner' field is optional:
>>> - Common governor modules (performance, powersave, simple_ondemand,
>>>   userspace, passive) set 'owner' to THIS_MODULE.
>>> - Governors that are bundled into a device driver module must leave 'owner'
>>>   NULL.  The device's lifetime already pins that module, and setting
>>>   'owner' would create a self-reference that blocks the driver from being
>>>   unloaded.
>>>
>>> As a result, a non-forced rmmod of an in-use stand-alone governor now
>>> fails with -EBUSY, e.g.:
>>>
>>>   $ cat governor
>>>   performance
>>>   $ rmmod governor_performance
>>>   rmmod: ERROR: Module governor_performance is in use
>>>
>>> Force unloads (rmmod -f, if configured) can't be blocked.
>>>
>>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>>> ---
>>>  drivers/devfreq/devfreq.c                 | 17 ++++++++++++++++-
>>>  drivers/devfreq/governor_passive.c        |  1 +
>>>  drivers/devfreq/governor_performance.c    |  1 +
>>>  drivers/devfreq/governor_powersave.c      |  1 +
>>>  drivers/devfreq/governor_simpleondemand.c |  1 +
>>>  drivers/devfreq/governor_userspace.c      |  1 +
>>>  include/linux/devfreq-governor.h          | 11 +++++++++++
>>>  7 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 9e3e6a7348f8..1cee43636ded 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -345,24 +345,37 @@ static int devfreq_set_governor(struct devfreq *df,
>>>  				 __func__, df->governor->name, ret);
>>>  			return ret;
>>>  		}
>>> +		module_put(old_gov->owner);
>>>  	}
>>>  
>>>  	/* Start the new governor */
>>> +	if (!try_module_get(new_gov->owner)) {
>>> +		df->governor = NULL;
>>
>> Shouldn't the old governor be restored here?
>>
> Yeah.  Perhaps we just move try_module_get() before stopping the old
> governor so as to avoid another hunk of restoring governor.

Follow up (after a long while though):
I found it quite hard to restore the old governor here while keep the code
clear.  I'd suggest that leaving it NULL for this rare error path.  The
current devfreq-next code is able to handle a NULL df->governor.

Thanks!
Jie
