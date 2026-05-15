Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C7044B66E
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841554; cv=none; b=naDIyrknAkPMRucG43M9Cbe+i6MotlDL6G8tNtoRsMBYuHQGuYTYA8RpPndrCyKzNMKmBLq+odvyzq/bOMNOOL6vYAgK+sTnnRE/aXCzO4bAOXfSZFQ1LNZ4+1OgJV37ySC0JUZlx4pap2l2TxDA7vz+Ra/JMRqsRawzM4kzh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841554; c=relaxed/simple;
	bh=XpB1hUSuFArN1MAWTh4YUrU+WzGunzy+3jVTNDnBKRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SL3nhWh5Qj8Biij3pyS+jakjw8ptb8i5e3Y6wuoqiZ1Zxe5wXkJ2YjJv4Z7mBhiaT98duLAFiZo1DafxVgTlkCsnLJJXumI0otElcvvIcnmtR77dqXkKp3Iks0TKHXw8dUlZpQWDo1l7JctcM3+StC0jKH1z7wlg/BS8aWEbg98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gH3R63NwnznTXv;
	Fri, 15 May 2026 18:32:02 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 123874048B;
	Fri, 15 May 2026 18:39:04 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 May
 2026 18:39:03 +0800
Message-ID: <6f160e25-9903-4f49-8a95-1192b7acb96d@hisilicon.com>
Date: Fri, 15 May 2026 18:39:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] devfreq: Get and put module refcount when
 switching governor
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <cwchoi00@gmail.com>,
	<cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
 <20260513093832.1645890-6-zhanjie9@hisilicon.com>
 <d6e83d90-0c2a-40a7-a939-298c3b393602@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <d6e83d90-0c2a-40a7-a939-298c3b393602@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/14/2026 2:50 PM, Yaxiong Tian wrote:
> 
> 在 2026/5/13 17:38, Jie Zhan 写道:
>> A governor module can be dynamically inserted or removed if compiled as a
>> kernel module.  'devfreq->governor' would become NULL if the governor
>> module is removed when it's in use.
>>
>> To prevent the governor module from being removed (except for force
>> unload) when it's in use, get and put a refcount of the governor module
>> when starting and stopping the governor.
>>
>> As a result, unloading a governor module in use returns an error, e.g.:
>>    $ cat governor
>>    performance
>>    $ rmmod governor_performance
>>    rmmod: ERROR: Module governor_performance is in use
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>>   drivers/devfreq/devfreq.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index e1363ab69173..2ea42325d030 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -345,24 +345,37 @@ static int devfreq_set_governor(struct devfreq *df,
>>                    __func__, df->governor->name, ret);
>>               return ret;
>>           }
>> +        module_put(old_gov->owner);
>>       }
>>         /* Start the new governor */
>> +    if (!try_module_get(new_gov->owner)) {
>> +        df->governor = NULL;
>> +        return -EINVAL;
>> +    }
>> +
> 
> Here, new_gov has already been checked in try_then_request_governor() for whether the module can be obtained.
> 
> I think it might be more reasonable to merge try_then_request_governor() and devfreq_set_governor(), so that when new_gov cannot be obtained, the operation of the old governor is not affected.
> 
Well yeah, indeed! I'll take a look at how to implement this.
Thanks for the suggestion.

Jie
>>       df->governor = new_gov;
>>       ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>       if (ret) {
>>           dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>                __func__, df->governor->name, ret);
>> +        module_put(new_gov->owner);
>>             /* Restore previous governor */
>>           df->governor = old_gov;
>>           if (!df->governor)
>>               return ret;
>>   +        if (!try_module_get(old_gov->owner)) {
>> +            df->governor = NULL;
>> +            return -EINVAL;
>> +        }
>> +
>>           ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>           if (ret) {
>>               dev_err(dev, "%s: restore Governor %s failed (%d)\n",
>>                   __func__, df->governor->name, ret);
>> +            module_put(old_gov->owner);
>>               df->governor = NULL;
>>               return ret;
>>           }
>> @@ -1040,9 +1053,11 @@ int devfreq_remove_device(struct devfreq *devfreq)
>>         devfreq_cooling_unregister(devfreq->cdev);
>>   -    if (devfreq->governor)
>> +    if (devfreq->governor) {
>>           devfreq->governor->event_handler(devfreq,
>>                            DEVFREQ_GOV_STOP, NULL);
>> +        module_put(devfreq->governor->owner);
>> +    }
>>       device_unregister(&devfreq->dev);
>>         return 0;
