Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED72EB84E
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738559; cv=none; b=TslFHTnT8GIsqB3oa4djR9HVKbEGOXQlPpIYKIXvI0ffztA4PK+LbIAq4xC+1JYkT/psHjul4I6Oiq1SVTJ9kmta989fGFPMh5msJM14WFCygGXB0o3CMlyrGDZrzDJ82nieiJnyROu75JIU4V5ZY6HQg8h7fvNclh7UZhf1zSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738559; c=relaxed/simple;
	bh=KubvF/4kmZiWKNqmSB3VQoBGTht4jqmyOQLppcnE5XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yadau+RLMqBBFRBQV9IlKR1J2Pda06TWz/R5A32dRVeM1YL/lhaxZOnLheiYtetuJjnaucb0PopQMR10pCXsGhTnvq03/jaosCTydt1fM7AOZSDa2SfLid8oyFHZ+eMiT0fNNjI93+2h2+jVzlcEx3dsk7OgooMoHUSfx9Lr0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7c5d575a4f5a11f1aa26b74ffac11d73-20260514
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0dca3a92-2aec-403c-9fe7-2ec9c99fcbec,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:4b39685cc00937d0a29ed64d45ac5e2e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7c5d575a4f5a11f1aa26b74ffac11d73-20260514
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 483086167; Thu, 14 May 2026 14:02:27 +0800
Message-ID: <dc3cda4f-8e4e-4d6a-94a4-d5b34d481204@kylinos.cn>
Date: Thu, 14 May 2026 14:02:24 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] devfreq: Use mutex guard in governor_store()
To: Jie Zhan <zhanjie9@hisilicon.com>, cwchoi00@gmail.com,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com, zhenglifeng1@huawei.com, zhangpengjie2@huawei.com,
 lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
 <20260513093832.1645890-2-zhanjie9@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260513093832.1645890-2-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/5/13 17:38, Jie Zhan 写道:
> Use mutex guard in governor_store() so as to simplify the locking logic.
>
> No functional impact intended.
>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>   drivers/devfreq/devfreq.c | 38 ++++++++++++++++----------------------
>   1 file changed, 16 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index f08fc6966eae..7a70dd051644 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1394,23 +1394,20 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   	if (ret != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&devfreq_list_lock);
> +	guard(mutex)(&devfreq_list_lock);
>   	governor = try_then_request_governor(str_governor);
> -	if (IS_ERR(governor)) {
> -		ret = PTR_ERR(governor);
> -		goto out;
> -	}
> +	if (IS_ERR(governor))
> +		return PTR_ERR(governor);
> +
>   	if (!df->governor)
>   		goto start_new_governor;
>   
> -	if (df->governor == governor) {
> -		ret = 0;
> -		goto out;
> -	} else if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)
> -		|| IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (df->governor == governor)
> +		return count;
> +
> +	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE) ||
> +	    IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE))
> +		return -EINVAL;
>   
>   	/*
>   	 * Stop the current governor and remove the specific sysfs files
> @@ -1420,7 +1417,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   	if (ret) {
>   		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
>   			 __func__, df->governor->name, ret);
> -		goto out;
> +		return ret;
>   	}
>   
>   start_new_governor:
> @@ -1438,7 +1435,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   		/* Restore previous governor */
>   		df->governor = prev_governor;
>   		if (!df->governor)
> -			goto out;
> +			return ret;
>   
>   		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>   		if (ret) {
> @@ -1446,7 +1443,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   				"%s: reverting to Governor %s failed (%d)\n",
>   				__func__, prev_governor->name, ret);
>   			df->governor = NULL;
> -			goto out;
> +			return ret;
>   		}
>   	}
>   
> @@ -1455,13 +1452,10 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   	 * the new governor, restore the sysfs files of previous governor.
>   	 */
>   	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
> +	if (ret)
> +		return ret;
>   
> -out:
> -	mutex_unlock(&devfreq_list_lock);
> -
> -	if (!ret)
> -		ret = count;
> -	return ret;
> +	return count;
>   }
>   static DEVICE_ATTR_RW(governor);
>   
Reviewed-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
