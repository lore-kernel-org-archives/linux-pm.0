Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782197;
	b=ShCPCVPOZyJNvHCEsvkBM0ouTNmr6S/1bemAdHQwZfV1uD9lQzfYsBZFRwE2iGkD7sFe
	 cQqq17fnYdhDT55b60gu0jIdxyauJI3cAUTtoPW7ld2NxTPmXmKezlwFny+XD8PQvEOl2
	 24x81d4OZ6GpzPDS6dbCLrWaBxCsl37QKE9Y8ey7vwLV1nr7hD6KkvDjB1rBG4qVSb07U
	 5eOBvnm4o290nTr4pIojkPdYTwtB68Zg+ITU/Jf7nmv0F8b9IyYroffS7wcRdJCCjz6sJ
	 By0UeFFkZiIV5p804hazxGok3lw2oG50nW89ODN30SChYZTxsuimjPjP+g3KQ8OgQow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dCpJ51ujggena/DY0lnMQOWhNgzWqSe96IeE3HGzQzc=;
	b=wcr6xcMszIcnBMCb8AMVJsSkRRdgRSbiqfYiG75WwrfB3nEDqqDzmng/sDWye35ZfA/t
	 6EGjSrupLAqnLNHcJ7wtGo8y2M/aMPgoXV9vxuZh0tqPFIEYtGSUpmdWWau4g8pEpwCRe
	 uMxemsGaaWggUwzyRTQfk/5iNVbhjGcItqI+sdo/WPhaX7ruk1GExl2HBlHWWvWlkkcMI
	 XUNlDFJWus41VbFQocHIt/iYtQC0ymNxss8SxRv8CnPv5ZD1hbhCnxjmdjocdR3ByxOpD
	 K+RfdAAvQ82Ve9va41GfbDabf0tXp3S2HdZYVDbufjsykVCLrr9F4+pk04iQpBdy/rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pyx4IVzW;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E617606A329
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 22:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E617606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pyx4IVzW
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1487867a91.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 14:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794782196; x=1795386996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCpJ51ujggena/DY0lnMQOWhNgzWqSe96IeE3HGzQzc=;
        b=Pyx4IVzWejZkT3U4jTEdIEzskzRlP4cMAdBO6LKRF6jwnwSU+F4ujaWaKweVQfcE1O
         LesAKPAT2dNnKNEZO8puZ9BzD7gSl73kGZEahAB0FggmglBBa1bAuXkMOeuoXVf61uOW
         hJWpYVLbOlURrcpwsFad/+7pxGMbBKPAgB2udA/rD+s1ORtcBAOB9FeMHS8rPchk31R5
         6BX0qGTbVGoTYAD/IcJ9H0nLElIaV2iZ/RKHBcc1Wy7MLYdHcUG++eUfSYhzVbIP8ES5
         C+lwQtVdmr6Jii85/JqhLx7qvDjyhBT3YTNgsEdwUw9b4hAl18DdtHKTlpevd6WHTxNq
         4miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794782196; x=1795386996;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCpJ51ujggena/DY0lnMQOWhNgzWqSe96IeE3HGzQzc=;
        b=2K4IeUgZUJcn+W8c1TC9FOH+qWhJAutDc04GWTXYx2I0PAhjDHrUpNIq3dx2Wd44qH
         SgX5b1Emjz7X+ZG1ubQi3zkudHiUPq12A8EKfHsoryqMnj4WmHfj2CvYHY6n625OKzUG
         IPOX7tLU0mVUTqn6tkZIA4WGI7JFkH7r1DeZ/WODJKD4wUwN648BuLWTTr4g7toqvmnU
         cMl5sOYYAF9j/8PO0JoFP+nMaYKqj2sKrci9Yv8zV74JXT0+d2qDWUIyoOxfiQM8A0K0
         d0J5g1w+ZVTGmAiEJuJwkjxUL9R50hOwvkc60NQdxNRVHQkj2Oe2BAS3jNP1XbmIXxTo
         45hw==
X-Forwarded-Encrypted: i=1; AL+hErGXgjIjrPPeORYpQ1PvTQBecgr0nXjuchUOzAGQQH0oHySZ3pgq4Yj3vF+AIaM9zBip3I9xn9qpvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z91yk1puAmvlXc/KD2Y+PVPYX9LoctnRO/GUJc1m0sFwqoY+RMd
	0sEyCPbBQ/z6yXyy0hXax4NzkbUe43S680ml4/bIOuSg0ZV+cegC+Jzp
X-Gm-Gg: AYBFou05IrLshRvn5kHDGe8VPlf1iH3/Ao8aw3D1pio8nWimztIo8kl9WQxQ/6ZcS8o
	ZL/AxCqQGtcXku3ufb0ejNrr+pqoMyOg+9SV2Rm8PmzZ51SrNrt3fMMzbnOB+833Kk6SxbAFs8+
	Nrm/xGBQGpZvBLy7yE2BTLxl67XKqFH5ArfUCjS6i6oZIUuuaZ43q0Yb/rZ/WOx2XB1bZFoOmqb
	g4biVnGj2iQIY6vvDrbV3vbioI/lWtKiZCJ4zCC48Q6oXcKKxj9nkvOD6irqHagYRsZTEqIkMmz
	euGtuG9QHptpnhDbGKoVQNv8uu4VepkH+SboIHzi9RW8XpfzO2RlBYlkdETO58TS/NhFu2hFdrA
	RAwIZwqXQbeE7vdSLSJF9pshVicyv6SnSIha4npV7vSgN+YAv1qJoij61/PyuxWEtn5xJohMoMC
	ggbH9mdESQnbtiHhKgE/2dRkdmfBTBm3hH/XJ4tOg6wC2MNwCQHVpzazdBrbaB485cct0tWnXAm
	FY5wFg+OMOBI3tkvTJcQOFqNa+oOtFmpM4LHbjYTuGocZiW/i2bYmk6XynJrG3Pj2hnCaWND+6Q
	8YMUGhrAu/yQb2hcL8iM9s3HtrMym9S9XvDhmuf/FjbLibiE7AeHJHJns+boD2TpiJAk
X-Received: by 2002:a17:90b:5150:b0:3b0:91ce:6726 with SMTP id 98e67ed59e1d1-3b1b0a42b97mr8059264a91.21.1794782195677;
        Sun, 15 Nov 2026 14:36:35 -0800 (PST)
Received: from [192.168.35.214] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f497sm18891520a91.8.2026.11.15.14.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 14:36:34 -0800 (PST)
Message-ID: <4794724e-456e-4efc-b5e7-536c8afad0fd@gmail.com>
Date: Mon, 16 Nov 2026 07:36:30 +0900
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v4 3/4] devfreq: Factor out devfreq_set_governor()
Content-Language: ko
To: Jie Zhan <zhanjie9@hisilicon.com>, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com, tianyaxiong@kylinos.cn, zhenglifeng1@huawei.com,
 zhangpengjie2@huawei.com, lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260729102348.3857779-1-zhanjie9@hisilicon.com>
 <20260729102348.3857779-4-zhanjie9@hisilicon.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20260729102348.3857779-4-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 7:23 PM, Jie Zhan wrote:
> governor_store() and devfreq_add_device() contain similar logic for setting
> a governor when devfreq->governor is NULL.  Merge this into a common
> function, devfreq_set_governor(), to reduce code duplication and unify the
> entry of setting governors.
> 
> This also prepares for further changes that get / put a module refcount of
> the active governor and prevent the governor module from being unloaded
> while it's in use.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/devfreq/devfreq.c | 128 ++++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 53c40d795a13..959f0b08ed36 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -318,6 +318,70 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  	return governor;
>  }
>  
> +static int devfreq_set_governor(struct devfreq *df,
> +				const struct devfreq_governor *new_gov)
> +{
> +	const struct devfreq_governor *old_gov;
> +	struct device *dev;
> +	int ret;
> +
> +	lockdep_assert_held(&devfreq_list_lock);
> +
> +	old_gov = df->governor;
> +	dev = &df->dev;
> +
> +	if (old_gov) {
> +		if (old_gov == new_gov)
> +			return 0;
> +
> +		if (IS_SUPPORTED_FLAG(old_gov->flags, IMMUTABLE) ||
> +		    IS_SUPPORTED_FLAG(new_gov->flags, IMMUTABLE))
> +			return -EINVAL;
> +
> +		/* Stop the current governor */
> +		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
> +		if (ret) {
> +			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> +				 __func__, df->governor->name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Start the new governor */
> +	df->governor = new_gov;
> +	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> +	if (ret) {
> +		dev_warn(dev, "%s: Governor %s not started(%d)\n",
> +			 __func__, df->governor->name, ret);
> +
> +		/* Restore previous governor */
> +		df->governor = old_gov;
> +		if (!df->governor)
> +			return ret;
> +
> +		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> +		if (ret) {
> +			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
> +				__func__, df->governor->name, ret);
> +			df->governor = NULL;
> +			return ret;
> +		}
> +
> +		ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
> +		if (ret)
> +			dev_warn(dev, "sysfs update failed (%d)\n", ret);
> +
> +		/*
> +		 * Old governor restored successfully, but the new governor
> +		 * failed to start.  Return a distinct error so the caller is
> +		 * not misled into thinking the switch succeeded.
> +		 */
> +		return -EAGAIN;
> +	}
> +
> +	return sysfs_update_group(&df->dev.kobj, &gov_attr_group);
> +}
> +
>  static int devfreq_notify_transition(struct devfreq *devfreq,
>  		struct devfreq_freqs *freqs, unsigned int state)
>  {
> @@ -942,9 +1006,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_init;
>  	}
>  
> -	devfreq->governor = governor;
> -	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
> -						NULL);
> +	err = devfreq_set_governor(devfreq, governor);
>  	if (err) {
>  		dev_err_probe(dev, err,
>  			"%s: Unable to start governor for the device\n",
> @@ -952,10 +1014,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_init;
>  	}
>  
> -	err = sysfs_update_group(&devfreq->dev.kobj, &gov_attr_group);
> -	if (err)
> -		goto err_init;
> -
>  	list_add(&devfreq->node, &devfreq_list);
>  
>  	mutex_unlock(&devfreq_list_lock);
> @@ -1380,7 +1438,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	struct devfreq *df = to_devfreq(dev);
>  	int ret;
>  	char str_governor[DEVFREQ_NAME_LEN + 1];
> -	const struct devfreq_governor *governor, *prev_governor;
> +	const struct devfreq_governor *governor;
>  
>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>  	if (ret != 1)
> @@ -1391,59 +1449,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	if (IS_ERR(governor))
>  		return PTR_ERR(governor);
>  
> -	if (!df->governor)
> -		goto start_new_governor;
> -
> -	if (df->governor == governor)
> -		return count;
> -
> -	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE) ||
> -	    IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE))
> -		return -EINVAL;
> -
> -	/*
> -	 * Stop the current governor and remove the specific sysfs files
> -	 * which depend on current governor.
> -	 */
> -	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
> -	if (ret) {
> -		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> -			 __func__, df->governor->name, ret);
> -		return ret;
> -	}
> -
> -start_new_governor:
> -	/*
> -	 * Start the new governor and create the specific sysfs files
> -	 * which depend on the new governor.
> -	 */
> -	prev_governor = df->governor;
> -	df->governor = governor;
> -	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> -	if (ret) {
> -		dev_warn(dev, "%s: Governor %s not started(%d)\n",
> -			 __func__, df->governor->name, ret);
> -
> -		/* Restore previous governor */
> -		df->governor = prev_governor;
> -		if (!df->governor)
> -			return ret;
> -
> -		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> -		if (ret) {
> -			dev_err(dev,
> -				"%s: reverting to Governor %s failed (%d)\n",
> -				__func__, prev_governor->name, ret);
> -			df->governor = NULL;
> -			return ret;
> -		}
> -	}
> -
> -	/*
> -	 * Create the sysfs files for the new governor. But if failed to start
> -	 * the new governor, restore the sysfs files of previous governor.
> -	 */
> -	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
> +	ret = devfreq_set_governor(df, governor);
>  	if (ret)
>  		return ret;
>  

Actually, I didn't want to merge it becaus there are fully test for all governor
and various case to switch governor(stop/start/switch). It makes the problem.
Also, there is an AI report indicating that this patch has a problem related to passive govenor.

We must guarantee the safe operation without any side-effect.
Don't update devfreq_add_device and better to make the separate function 'start_new_governor'
and then do next update separately.

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
