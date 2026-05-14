Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ACB25B098
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739303; cv=none; b=BL5lWPQ64nTPCwzZT7SrJhUoML+UM1wAGu/UAWEbsYyhKuKaB6SsRJJBH82+eSSq6jxlhGdGtDZHt8/YempDRhlQA5ypadDnTAch9hnMl9RRnLvVLLDmSbZWQQJlAiqqcWbGBKyYTxEYv1wXMK81ucLNvPr7+NHLtNDaqX2wmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739303; c=relaxed/simple;
	bh=b8WRxpI6E8uzZo52rh40SNUXHfeL8DJr0bDCNWVVHRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPRs+3Fh+7TPZ8sM2vYCyokVy7/JI/LHMfilp203Z+SCLywDWl1sxzv1v9Oq8PcVOoqLcChItrkP6Uzr8/jngGBUw8Pck3P9MgsxjgdMvJHdmULXewfjGVPCt4Vks/JsGz83ZM76A8ITiFTMav3DS1TSM45kZnXIrB8N7AeApwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 39e1e9a24f5c11f1aa26b74ffac11d73-20260514
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8e74f2ef-5e73-49bc-9a16-f10d93106e10,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:292977be64a77d164356fa5b4f3e7cc1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 39e1e9a24f5c11f1aa26b74ffac11d73-20260514
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1098404912; Thu, 14 May 2026 14:14:55 +0800
Message-ID: <fdcac90b-b253-45f2-81fa-81c980671f28@kylinos.cn>
Date: Thu, 14 May 2026 14:14:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] devfreq: Add module owner to devfreq governor
To: Jie Zhan <zhanjie9@hisilicon.com>, cwchoi00@gmail.com,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com, zhenglifeng1@huawei.com, zhangpengjie2@huawei.com,
 lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
 <20260513093832.1645890-5-zhanjie9@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260513093832.1645890-5-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/5/13 17:38, Jie Zhan 写道:
> Add an 'owner' member to struct devfreq_governor, such that we can find
> the module that holds the governor code when it's compiled as a kernel
> module.  This allows the devfreq core to properly manage the lifecycle
> of governors.
>
> Update devfreq_add_governor() and devm_devfreq_add_governor() to
> automatically set 'owner' to THIS_MODULE via helper macros.
>
> This is a prerequisite for implementing governor reference counting to
> prevent a governor module from being unloaded (except for force unload)
> while a governor is in use.
>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>   drivers/devfreq/devfreq.c        | 26 +++++++++-----------------
>   include/linux/devfreq-governor.h | 26 +++++++++++++++++++++++---
>   2 files changed, 32 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 9e3e6a7348f8..e1363ab69173 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1301,11 +1301,8 @@ void devfreq_resume(void)
>   	mutex_unlock(&devfreq_list_lock);
>   }
>   
> -/**
> - * devfreq_add_governor() - Add devfreq governor
> - * @governor:	the devfreq governor to be added
> - */
> -int devfreq_add_governor(struct devfreq_governor *governor)
> +int __devfreq_add_governor(struct devfreq_governor *governor,
> +			   struct module *mod)
>   {
>   	struct devfreq_governor *g;
>   
> @@ -1322,37 +1319,32 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>   		return -EINVAL;
>   	}
>   
> +	governor->owner = mod;
>   	list_add(&governor->node, &devfreq_governor_list);
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(devfreq_add_governor);
> +EXPORT_SYMBOL(__devfreq_add_governor);

It's a bit strange to use the __ symbol here. Generally speaking, 
functions exported with EXPORT_SYMBOL are public, while __ indicates 
internal.

The same applies below.

>   
>   static void devm_devfreq_remove_governor(void *governor)
>   {
>   	WARN_ON(devfreq_remove_governor(governor));
>   }
>   
> -/**
> - * devm_devfreq_add_governor() - Add devfreq governor
> - * @dev:	device which adds devfreq governor
> - * @governor:	the devfreq governor to be added
> - *
> - * This is a resource-managed variant of devfreq_add_governor().
> - */
> -int devm_devfreq_add_governor(struct device *dev,
> -			      struct devfreq_governor *governor)
> +int __devm_devfreq_add_governor(struct device *dev,
> +				struct devfreq_governor *governor,
> +				struct module *mod)
>   {
>   	int err;
>   
> -	err = devfreq_add_governor(governor);
> +	err = __devfreq_add_governor(governor, mod);
>   	if (err)
>   		return err;
>   
>   	return devm_add_action_or_reset(dev, devm_devfreq_remove_governor,
>   					governor);
>   }
> -EXPORT_SYMBOL(devm_devfreq_add_governor);
> +EXPORT_SYMBOL(__devm_devfreq_add_governor);
>   
>   /**
>    * devfreq_remove_governor() - Remove devfreq feature from a device.
> diff --git a/include/linux/devfreq-governor.h b/include/linux/devfreq-governor.h
> index dfdd0160a29f..1c4ff57e24de 100644
> --- a/include/linux/devfreq-governor.h
> +++ b/include/linux/devfreq-governor.h
> @@ -12,6 +12,7 @@
>   #define __LINUX_DEVFREQ_DEVFREQ_H__
>   
>   #include <linux/devfreq.h>
> +struct module;
>   
>   #define DEVFREQ_NAME_LEN			16
>   
> @@ -50,6 +51,7 @@
>   /**
>    * struct devfreq_governor - Devfreq policy governor
>    * @node:		list node - contains registered devfreq governors
> + * @owner:		Module that this governor belongs to
>    * @name:		Governor's name
>    * @attrs:		Governor's sysfs attribute flags
>    * @flags:		Governor's feature flags
> @@ -67,6 +69,7 @@
>   struct devfreq_governor {
>   	struct list_head node;
>   
> +	struct module *owner;
>   	const char name[DEVFREQ_NAME_LEN];
>   	const u64 attrs;
>   	const u64 flags;
> @@ -81,11 +84,28 @@ void devfreq_monitor_suspend(struct devfreq *devfreq);
>   void devfreq_monitor_resume(struct devfreq *devfreq);
>   void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay);
>   
> -int devfreq_add_governor(struct devfreq_governor *governor);
> +/**
> + * devfreq_add_governor() - Add devfreq governor
> + * @governor:	The devfreq governor to be added
> + */
> +#define devfreq_add_governor(governor) \
> +	__devfreq_add_governor((governor), THIS_MODULE)
> +int __devfreq_add_governor(struct devfreq_governor *governor,
> +			   struct module *mod);
>   int devfreq_remove_governor(struct devfreq_governor *governor);
>   
> -int devm_devfreq_add_governor(struct device *dev,
> -			      struct devfreq_governor *governor);
> +/**
> + * devm_devfreq_add_governor() - Add devfreq governor
> + * @dev:	device which adds devfreq governor
> + * @governor:	the devfreq governor to be added
> + *
> + * This is a resource-managed variant of devfreq_add_governor().
> + */
> +#define devm_devfreq_add_governor(dev, governor) \
> +	__devm_devfreq_add_governor((dev), (governor), THIS_MODULE)
> +int __devm_devfreq_add_governor(struct device *dev,
> +				struct devfreq_governor *governor,
> +				struct module *mod);
>   
>   int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
>   int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
