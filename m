Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4663AB27B
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501687; cv=none; b=RwXJPzSI9cDh1uMG1XcUmQm4sounUcLySl1BW+7nLXwMgWRpZY36whmhYCZUWszzn7BjmnG+x9XhA1Yn7ZDt6DzGtd+Vqs/XQD65hCb3/YT/ArsoCWXbUuxYjvT6rALSDISTEpeUctciLqVsQkZyz3QRrLIKpiBxOYxkd7BVOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501687; c=relaxed/simple;
	bh=YGkGsWgqqWAT9nVr7bQlMTOIvCR3z3KgqkrISvLLqk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Px4oGJ4EgzHpiQGhXY++kcfZjSoHAu0bq02V+d6Ub9i7QYy5MQkl5QLyXBYATJXLjlDliXH4XNMTfZp9B+T2ZJ8cirdTrS2zfI/D1y6gK+kENEicqCAPXB+0sAmb62Py9awN8yTwQ6ZUCj85h9+/G+rK4pZkbj2d1GjV2zGzwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhN+hqVe; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhN+hqVe"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35fbca04006so104088a91.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777501686; x=1778106486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9qSMs+FiZwAW1GTwxABlbTdgwMZuPgzmIWW6Xnl7NI=;
        b=DhN+hqVeA16PEm3KyuiBSydCeTtUaEh+oyY0/7O75vp9M/cnrkKVIAUp2YSCLyUbX5
         dK1gORqfPZhujCB9reTbgBp4n16cguXeg9E4/cTaPiaMydOc1Z2rZ3Tnp4kvzmdWjXHW
         sx4En04q9zC4T66Lz39HW263csiuGOCnhI5VJw7Z3Uu1nL7zW9BnbuASMYfi+U3qiQWP
         CfCx5hUQ0KH3X5z0k6C6g/1AD+GaV3KFKjYUgub+0MW6XKw+EUIuscXR8Tj0/JChKx1L
         Di6JZC4p+peraNMgHTBu6/nzDDiezQWftjH0KDAdUlHsVjBqQ3EsCXzJHR697IFg2MSe
         Zr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777501686; x=1778106486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9qSMs+FiZwAW1GTwxABlbTdgwMZuPgzmIWW6Xnl7NI=;
        b=dnNd50P1/tsJlfgwd+zlQoKcFJI8ffXayyc5XH8Logu9kfFis1lI/RycN7e9sPMitm
         QfjekuOk4qsgVdAg/5sp6qw7EAHaykrQ31kDdtrVWqjITinfHlFSTlk8OZ005M8nuBAi
         1rMRsDtklVXVFB6v4ZaFbP8v+fdLPcdu8gnyG1ZJocnMzP99Nraf09w6bqow3lICltdf
         HHTKxKWG0LKO/WBvrfOTujVfrZgswQJIEg2xH8YDLO3Ee2WaErQR/wyG9UvwFs92nEEa
         buzJ18DhEUUJw+GMTBYEgmCWBnSmF7two0Cx+ec50MFXLeIoaMiPT2ozTZM1B2LRl5e+
         t/SA==
X-Gm-Message-State: AOJu0YyzBwGTQerR57X8Rnjm4Ep2kEdNgD8wpFnfthz3s8VnvgUhDHM1
	OGPJZi2rX8Gc2y9ov8GmgocApdKvolseymdoRXTggRB5PWKkWUrJBmJG
X-Gm-Gg: AeBDiesOCaF+FddErtHnHWW9mYqByHpbrcHawcQAT0onyerjcki2q+Vw61IIH6qvMHJ
	YbQP0dAGPH2VsW8nJi+OtWuucnQNVQ+1iuaE4S5PgkaJfdXZen1oFy573MFTFkzMQ7Tl1x+T0yq
	p12CAQIxMujQEproSjM3Aaw39HwXZE1c2WAzK8kIoZ+D0qxcAwuqAZgM/xPpo2I35pH9qZV+tTT
	2///OSpMcZiM0DwPtwKzFPBh4zURjpBixxgFnPZiK2B3NOi82jK08AXE903st2M/CLX5QH4rIcW
	FciRLj5ProhaISrQhi9J6/s21327GnyI0fOpVpQnxyxExn48PEagMJbHo+npvNfmGo3LHFKHI+T
	VHVEcog2/2lCV+pqd6kV8SeaImWwgbRDc5gupW+xFQeBfeEUsIfnuV1THVaeebh7vZMR2/HFJm7
	LyDhHDbbyoGshUnrEISaZHC6fHRttguma8X0uJloYwOPvQ57+ZHpfkIrR5WGsC
X-Received: by 2002:a17:90b:17cc:b0:364:919c:b52f with SMTP id 98e67ed59e1d1-364c30ff32fmr159196a91.24.1777501685581;
        Wed, 29 Apr 2026 15:28:05 -0700 (PDT)
Received: from [172.30.1.27] ([222.106.243.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772e9csm31710065ad.9.2026.04.29.15.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 15:28:05 -0700 (PDT)
Message-ID: <7a500e85-d20d-47f8-b4ce-7015052193c7@gmail.com>
Date: Thu, 30 Apr 2026 07:28:02 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PM / devfreq: Fix governor_store() failing when
 device has no current governor
Content-Language: ko
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, zhanjie9@hisilicon.com,
 nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033119.67821-1-tianyaxiong@kylinos.cn>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260401033119.67821-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



2026-04-01 PM 12:31에 Yaxiong Tian 이(가) 쓴 글:
> Since devfreq_remove_governor() may clear the device's current governor
> in certain situations, while governors actually exist independently
> of the device, directly returning EINVAL in this case is inaccurate.
> 
> To fix this issue, remove this check and add relevant logic for when
> df->governor is NULL.
> 
> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/devfreq/devfreq.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2977b07be939..975f82d7a9d1 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1390,9 +1390,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	char str_governor[DEVFREQ_NAME_LEN + 1];
>  	const struct devfreq_governor *governor, *prev_governor;
>  
> -	if (!df->governor)
> -		return -EINVAL;
> -
>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>  	if (ret != 1)
>  		return -EINVAL;
> @@ -1403,6 +1400,20 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  		ret = PTR_ERR(governor);
>  		goto out;
>  	}
> +
> +	if (!df->governor) {
> +		df->governor = governor;
> +		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> +		if (ret) {
> +			dev_warn(dev, "%s: Governor %s not started(%d)\n",
> +				__func__, df->governor->name, ret);
> +			df->governor = NULL;
> +		} else {
> +			ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
> +		}
> +		goto out;
> +	}
> +
>  	if (df->governor == governor) {
>  		ret = 0;
>  		goto out;

Hi,

I think that the following patch is able to support on your case.
Could you please check it?

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e5d3f9cf94dc..f08fc6966eae 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1390,9 +1390,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
        char str_governor[DEVFREQ_NAME_LEN + 1];
        const struct devfreq_governor *governor, *prev_governor;
 
-       if (!df->governor)
-               return -EINVAL;
-
        ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
        if (ret != 1)
                return -EINVAL;
@@ -1403,6 +1400,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
                ret = PTR_ERR(governor);
                goto out;
        }
+       if (!df->governor)
+               goto start_new_governor;
+
        if (df->governor == governor) {
                ret = 0;
                goto out;
@@ -1423,6 +1423,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
                goto out;
        }
 
+start_new_governor:
        /*
         * Start the new governor and create the specific sysfs files
         * which depend on the new governor.
@@ -1436,6 +1437,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 
                /* Restore previous governor */
                df->governor = prev_governor;
+               if (!df->governor)
+                       goto out;
+
           

Thanks,
Chanwoo Choi

