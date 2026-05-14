Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB03ACEE6
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741420; cv=none; b=tvrmiojulBY9vzwszAonZC//escPjrwkhQJW8QSYOcKPDGHbnik6Q9lcrJcT7gdf5Vc0/hsH1kWRPH3S4ZTIz/uEEpIh7EZw7gD8Q5rRtwifYtG29dENhYhvQuk8UyjtPIhEPLWZpaqL00ae30F8IBfDQjZbXPqO1JG0T6x/xt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741420; c=relaxed/simple;
	bh=7lixEJGW37cgoaf540i8WcpieCLKC4SNj+MkvhUQP6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUoRhQoBw9NXwsC4MOUE+wdMORaGpYvl7tYVCbuXFR9O4J5ncWJ5GiJthia8V/ND58B/gzSlsnt1wRRnUOi2uDPGRFXbBdAvlapRZ/81JUKnGggB+hi6uNHTgSXnusAg04ss21kDWLb2Fl+SWSjDJHq7OFb8gKOQK/W7bik8N+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 224752c84f6111f1aa26b74ffac11d73-20260514
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:63e7205a-8e25-4f65-afac-26ae373565ac,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:a2c195f5f2aee2e1dd99cf710420ad53,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 224752c84f6111f1aa26b74ffac11d73-20260514
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1526372202; Thu, 14 May 2026 14:50:03 +0800
Message-ID: <d6e83d90-0c2a-40a7-a939-298c3b393602@kylinos.cn>
Date: Thu, 14 May 2026 14:50:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] devfreq: Get and put module refcount when
 switching governor
To: Jie Zhan <zhanjie9@hisilicon.com>, cwchoi00@gmail.com,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com, zhenglifeng1@huawei.com, zhangpengjie2@huawei.com,
 lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
 <20260513093832.1645890-6-zhanjie9@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260513093832.1645890-6-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/5/13 17:38, Jie Zhan 写道:
> A governor module can be dynamically inserted or removed if compiled as a
> kernel module.  'devfreq->governor' would become NULL if the governor
> module is removed when it's in use.
>
> To prevent the governor module from being removed (except for force
> unload) when it's in use, get and put a refcount of the governor module
> when starting and stopping the governor.
>
> As a result, unloading a governor module in use returns an error, e.g.:
>    $ cat governor
>    performance
>    $ rmmod governor_performance
>    rmmod: ERROR: Module governor_performance is in use
>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>   drivers/devfreq/devfreq.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index e1363ab69173..2ea42325d030 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -345,24 +345,37 @@ static int devfreq_set_governor(struct devfreq *df,
>   				 __func__, df->governor->name, ret);
>   			return ret;
>   		}
> +		module_put(old_gov->owner);
>   	}
>   
>   	/* Start the new governor */
> +	if (!try_module_get(new_gov->owner)) {
> +		df->governor = NULL;
> +		return -EINVAL;
> +	}
> +

Here, new_gov has already been checked in try_then_request_governor() 
for whether the module can be obtained.

I think it might be more reasonable to merge try_then_request_governor() 
and devfreq_set_governor(), so that when new_gov cannot be obtained, the 
operation of the old governor is not affected.

>   	df->governor = new_gov;
>   	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>   	if (ret) {
>   		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>   			 __func__, df->governor->name, ret);
> +		module_put(new_gov->owner);
>   
>   		/* Restore previous governor */
>   		df->governor = old_gov;
>   		if (!df->governor)
>   			return ret;
>   
> +		if (!try_module_get(old_gov->owner)) {
> +			df->governor = NULL;
> +			return -EINVAL;
> +		}
> +
>   		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>   		if (ret) {
>   			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
>   				__func__, df->governor->name, ret);
> +			module_put(old_gov->owner);
>   			df->governor = NULL;
>   			return ret;
>   		}
> @@ -1040,9 +1053,11 @@ int devfreq_remove_device(struct devfreq *devfreq)
>   
>   	devfreq_cooling_unregister(devfreq->cdev);
>   
> -	if (devfreq->governor)
> +	if (devfreq->governor) {
>   		devfreq->governor->event_handler(devfreq,
>   						 DEVFREQ_GOV_STOP, NULL);
> +		module_put(devfreq->governor->owner);
> +	}
>   	device_unregister(&devfreq->dev);
>   
>   	return 0;
