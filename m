Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964B2EB84E
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738585; cv=none; b=IhV5FSR/iGZ+FBgadSARika8CgLbsZQ2hh0iHVc2AWe67qj+2JQR4eUy1Cnz+iKqFyQhLbRBSmin/Rb1rzNOo+nij75HtL36RNLK1d+lPTeGHL/Qt6CtNY4kcAKZYq+D0zprFZI1K/bdyCiS9/X4jVeneaT8K4PK6e9eBBDalZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738585; c=relaxed/simple;
	bh=auRoNkBinpIwwSSyMO1xbQggRlwIKw3XNNwyhyyi1OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLvaDW3fL3o6gY/XDoBsiACV//GRNlQpCOO+KJxP05BFdCsiS8WV+BKX7YedUi7pFO13gkCfYDbIS9YFzQS7CGmS0BK5uiPkLEWqZNTcJX8Rcw0Q0Ckf3FnAf0Ns/aesbwTMB742vqQ6MOY9MPqSjrnT1KVT9uXrxMhFep/rLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8bc731b64f5a11f1aa26b74ffac11d73-20260514
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:03109eba-89fe-4522-82ae-73a005aa09a2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:232ba708cf382797efbad0345395cd12,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8bc731b64f5a11f1aa26b74ffac11d73-20260514
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 189337449; Thu, 14 May 2026 14:02:53 +0800
Message-ID: <55fbdfeb-28c0-458b-a3a5-2603fbbf41ea@kylinos.cn>
Date: Thu, 14 May 2026 14:02:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] devfreq: Use mutex guard in
 devfreq_add/remove_governor()
To: Jie Zhan <zhanjie9@hisilicon.com>, cwchoi00@gmail.com,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com, zhenglifeng1@huawei.com, zhangpengjie2@huawei.com,
 lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
 <20260513093832.1645890-3-zhanjie9@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260513093832.1645890-3-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/5/13 17:38, Jie Zhan 写道:
> Use mutex guard in devfreq_add/remove_governor() so as to simplify the
> locking logic.
>
> No functional impact intended.
>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>   drivers/devfreq/devfreq.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7a70dd051644..53c40d795a13 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1261,28 +1261,23 @@ void devfreq_resume(void)
>   int devfreq_add_governor(struct devfreq_governor *governor)
>   {
>   	struct devfreq_governor *g;
> -	int err = 0;
>   
>   	if (!governor) {
>   		pr_err("%s: Invalid parameters.\n", __func__);
>   		return -EINVAL;
>   	}
>   
> -	mutex_lock(&devfreq_list_lock);
> +	guard(mutex)(&devfreq_list_lock);
>   	g = find_devfreq_governor(governor->name);
>   	if (!IS_ERR(g)) {
>   		pr_err("%s: governor %s already registered\n", __func__,
>   		       g->name);
> -		err = -EINVAL;
> -		goto err_out;
> +		return -EINVAL;
>   	}
>   
>   	list_add(&governor->node, &devfreq_governor_list);
>   
> -err_out:
> -	mutex_unlock(&devfreq_list_lock);
> -
> -	return err;
> +	return 0;
>   }
>   EXPORT_SYMBOL(devfreq_add_governor);
>   
> @@ -1320,21 +1315,20 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
>   {
>   	struct devfreq_governor *g;
>   	struct devfreq *devfreq;
> -	int err = 0;
>   
>   	if (!governor) {
>   		pr_err("%s: Invalid parameters.\n", __func__);
>   		return -EINVAL;
>   	}
>   
> -	mutex_lock(&devfreq_list_lock);
> +	guard(mutex)(&devfreq_list_lock);
>   	g = find_devfreq_governor(governor->name);
>   	if (IS_ERR(g)) {
>   		pr_err("%s: governor %s not registered\n", __func__,
>   		       governor->name);
> -		err = PTR_ERR(g);
> -		goto err_out;
> +		return PTR_ERR(g);
>   	}
> +
>   	list_for_each_entry(devfreq, &devfreq_list, node) {
>   		int ret;
>   		struct device *dev = devfreq->dev.parent;
> @@ -1356,10 +1350,8 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
>   	}
>   
>   	list_del(&governor->node);
> -err_out:
> -	mutex_unlock(&devfreq_list_lock);
>   
> -	return err;
> +	return 0;
>   }
>   EXPORT_SYMBOL(devfreq_remove_governor);
>   
Reviewed-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
