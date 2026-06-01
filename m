Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093841CD2C
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279409; cv=none; b=l1mY3JXZJR06y7srgvccuIUmTrUyGjnINw/cuvU191m86cwd5XoFlxDJTd5qnYufxUDEfXWLG5b56SKrJ89aSNw2op0ZasoKqkn4TYYm62KI8J4KSLRYO3d3HtYmG6J2wfvfi5mB/fy2hJBBh7dXBx+rLIcdR2fEp2cR0qnPQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279409; c=relaxed/simple;
	bh=DQex9vHOwyHt20ScAKmXyC4wBGSdaO87xvQbHIgTkPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nhc2YeEnOZ+pFxizlBCy35sBRkDlEDa9t8TIImSj9RakNXAx4PMAAPq55atWbZ3KZlVcIgnd3wppzlCN5tGE4yKcmoe2f/GWEXUk/1lVUWtqEQyOgJm0z/IDKEevZkGIuAqzrItpm0dyeP4HBRRsHlTpdXyTfpU+3M0Du8146KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gTH9X3dkMzpStM;
	Mon,  1 Jun 2026 09:55:44 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id D5AF440569;
	Mon,  1 Jun 2026 10:03:18 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 10:03:18 +0800
Message-ID: <ceb7d509-39d1-4d80-91a0-e129d0c2ce7b@hisilicon.com>
Date: Mon, 1 Jun 2026 10:03:17 +0800
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
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <5e503177-95e6-460a-b6b8-39f725da34a8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/21/2026 4:13 PM, zhenglifeng (A) wrote:
> On 5/19/2026 7:32 PM, Jie Zhan wrote:
>> A governor module can be inserted or removed dynamically when built as a
>> kernel module.  'devfreq->governor' would become NULL if the governor
>> module is removed when it's in use.
>>
>> Add a refcount mechanism for governor modules to prevent the governor
>> module from being removed (except for force unload):
>> 1. Add an optional 'owner' member to struct devfreq_governor so the devfreq
>>    core can identify the module that holds the governor code.
>> 2. Get and put a refcount of the governor module when starting and stopping
>>    the governor.
>>
>> The new 'owner' field is optional:
>> - Common governor modules (performance, powersave, simple_ondemand,
>>   userspace, passive) set 'owner' to THIS_MODULE.
>> - Governors that are bundled into a device driver module must leave 'owner'
>>   NULL.  The device's lifetime already pins that module, and setting
>>   'owner' would create a self-reference that blocks the driver from being
>>   unloaded.
>>
>> As a result, a non-forced rmmod of an in-use stand-alone governor now
>> fails with -EBUSY, e.g.:
>>
>>   $ cat governor
>>   performance
>>   $ rmmod governor_performance
>>   rmmod: ERROR: Module governor_performance is in use
>>
>> Force unloads (rmmod -f, if configured) can't be blocked.
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>>  drivers/devfreq/devfreq.c                 | 17 ++++++++++++++++-
>>  drivers/devfreq/governor_passive.c        |  1 +
>>  drivers/devfreq/governor_performance.c    |  1 +
>>  drivers/devfreq/governor_powersave.c      |  1 +
>>  drivers/devfreq/governor_simpleondemand.c |  1 +
>>  drivers/devfreq/governor_userspace.c      |  1 +
>>  include/linux/devfreq-governor.h          | 11 +++++++++++
>>  7 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 9e3e6a7348f8..1cee43636ded 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -345,24 +345,37 @@ static int devfreq_set_governor(struct devfreq *df,
>>  				 __func__, df->governor->name, ret);
>>  			return ret;
>>  		}
>> +		module_put(old_gov->owner);
>>  	}
>>  
>>  	/* Start the new governor */
>> +	if (!try_module_get(new_gov->owner)) {
>> +		df->governor = NULL;
> 
> Shouldn't the old governor be restored here?
> 
Yeah.  Perhaps we just move try_module_get() before stopping the old
governor so as to avoid another hunk of restoring governor.
>> +		return -EINVAL;
>> +	}
>> +
>>  	df->governor = new_gov;
>>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>  	if (ret) {
>>  		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>  			 __func__, df->governor->name, ret);
>> +		module_put(new_gov->owner);
>>  
>>  		/* Restore previous governor */
>>  		df->governor = old_gov;
>>  		if (!df->governor)
>>  			return ret;
>>  
>> +		if (!try_module_get(old_gov->owner)) {
>> +			df->governor = NULL;
>> +			return -EINVAL;
>> +		}
>> +
>>  		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>  		if (ret) {
>>  			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
>>  				__func__, df->governor->name, ret);
>> +			module_put(old_gov->owner);
>>  			df->governor = NULL;
>>  			return ret;
>>  		}
[ ... ]
