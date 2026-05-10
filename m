Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D019F11B
	for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417428; cv=none; b=C8aipTd+tW5xv4GB7KySGS+WX3yswAll6pG6BhxdKEo2HfgtzRt+dTsT8PolPFhOtHBFsYSDgFEG2wCDEY1qOQgd5WPZKf42HfHqETuOqrHP5EapGjlaWpm1mPEmkaLHs+lW0cKVvMmQCbqtFt7O8njZs7PDkNAW5N/9cfPF0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417428; c=relaxed/simple;
	bh=UafUibLCTmG3CSFzMCAr9BFMG6tkTktSEXnpR5iA2SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diAlvwietTKaqlxlYuSu+nzTCivWu/JPcd5WWWzCAXbSwWUNxsc0L7WZ/WrTftbPryMRCDyFUt3mk86F9ikWdwnv05cR7HGbytXEopk9kvn9rQ8JnK1w+C2mMlu4LQWZKX+i1MRZ7DW/6aZNfyweSDPliz2rgvJyXGKr8IhYf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqvxSMa1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqvxSMa1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3660b84347dso2006435a91.1
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778417426; x=1779022226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6S1mD+xx8x/tCfEbDPDZAW2paOh+aCEmBzds2w+qTLA=;
        b=qqvxSMa1BEowzMuO2H+92WOJaYVoPVcIi7DAphMsmULztjlgV+EbgLELRS1VL/cMtz
         0lJU0okjlxezwx1W0BtePG1NWiSVP4/xWbz4ccDmeyDNEYnbGtQCaHKW7eqvvL8MYPC0
         oWgJJyIHyTFWd0vS94ospANSFoM61/OHaclBWbPL/RsCj7PealUSakkuQtXnluiQX1xu
         97S4jn61cg4zPGDXWrK2jOuK/DAAnauHNY9A0lAkosQ/nBfCId06s6zbhAbeGpmaFSM/
         u8iXsaI3FDTS5x+cxRWq30ioI8sKpGAVJs6Y6CvmVWQnzgGAL22KXt2/mg6ARDK0Xmeg
         PFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778417426; x=1779022226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6S1mD+xx8x/tCfEbDPDZAW2paOh+aCEmBzds2w+qTLA=;
        b=siHzTSYkBkEkzrDSGi3eWOu8uONtHWxnolk+7ua0IhDTQYS1x6+kcxm70QdXcoPQNl
         lbnyz3TCHfgsc+z4+bRR/Tq1MXieEC/eC4YnM9EkPk3hta08IM4OGvWvUfKw+YJtyf3k
         8H4i4HIPZa/p9Uv4yih9WA7MKMJkldpYbTIvuN7EKyd9pgJVXdGDZ/sD/lDsUi7QLMVp
         aViqGsrwtunPFryf15+RG0QW8eZPftIPUPp98uG7PPEusEiPLl9Sw1WL1o5F5/TS5QvK
         OozdC7fxgt0aJ3JdX/NOU3Hr9Q4Phw+TvIeDdAZGU4mWiGP1mZqyTtRLrQxP7HSslu6G
         +H5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9/k0sd6/fsLFfJKmtuC9JDkSdNRK/67BLxaHs/AUb4/PpijZIrZBP6dVNHXqaWkBycRtKtd5JsIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdp/MUH611tJKTfKJC2S2Eg2J083NPLuV6400RWHnKRxMFAaSF
	mv2jl5r/sMtO7HIGsjbcHt4NL+XfFMXe9g9kpiPnHaWKJJYIhARNZ4hd
X-Gm-Gg: Acq92OHxtiYMsmckNdngiXaxofkFd6Fbs60xhJeh9LFZZVl7xH/0oidm0e4vUBJFziY
	D5Yes/yM/dCroqLkfLHjfgLaWF2gA9ZJxpczCol6NNF6SF7AyZTWT0L62ZTAEF3A1fQyCyQYvej
	8MIXLSSUnqP0t8UQeAM4lgImXR3RO+GBCjkG1n/vA4O/WtJ0CjmJq7Z4kw7REV4Vu8kCWoJizDR
	+5LlQLS/aiu9ZuGrjDDDl7i7vLADlXqoy1C4Ka7zuIovo27eR2C783IdEhe7tHzHNo23vzeSHnu
	evJqxEAar52bVYilpMsIquS/+QZKZYEe/x7ITrbZ5U1FKUzuqXcm5cJ7uGAXw9nDTJszS1e5M6w
	3R3bOe1we1k8yz5/iMI1v2If/v89mSrUkazWhRBp017iv8voXr8EZZlPgQmBEnYzJVjBmgea8lQ
	wsI9gcR9GpLMcl0Z7hPJOuH0J85lbdHrgGBcPQIJw=
X-Received: by 2002:a17:90b:3f90:b0:368:119b:be07 with SMTP id 98e67ed59e1d1-368119bc130mr3007006a91.18.1778417426229;
        Sun, 10 May 2026 05:50:26 -0700 (PDT)
Received: from [172.30.1.54] ([222.106.243.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267688fe2sm8403087a12.9.2026.05.10.05.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 05:50:25 -0700 (PDT)
Message-ID: <bef25c54-07a4-4d4e-83b6-b520ce572c68@gmail.com>
Date: Sun, 10 May 2026 21:50:22 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PM / devfreq: Fix governor_store() failing when
 device has no current governor
Content-Language: ko
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: cw00.choi@samsung.com, kyungmin.park@samsung.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 myungjoo.ham@samsung.com, nm@ti.com, zhanjie9@hisilicon.com
References: <20260401033119.67821-1-tianyaxiong@kylinos.cn>
 <20260430032035.75496-1-tianyaxiong@kylinos.cn>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260430032035.75496-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



2026-04-30 PM 12:20에 Yaxiong Tian 이(가) 쓴 글:
> Since devfreq_remove_governor() may clear the device's current governor
> in certain situations, while governors actually exist independently
> of the device, directly returning EINVAL in this case is inaccurate.
> 
> To fix this issue, remove this check and add relevant logic for when
> df->governor is NULL.
> 
> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
> Co-developed-by: Choi Chanwoo <cwchoi00@gmail.com>
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/devfreq/devfreq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2977b07be939..76e3700577ca 100644
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
> @@ -1403,6 +1400,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  		ret = PTR_ERR(governor);
>  		goto out;
>  	}
> +	if (!df->governor)
> +		goto start_new_governor;
> +
>  	if (df->governor == governor) {
>  		ret = 0;
>  		goto out;
> @@ -1423,6 +1423,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  		goto out;
>  	}
>  
> +start_new_governor:
>  	/*
>  	 * Start the new governor and create the specific sysfs files
>  	 * which depend on the new governor.
> @@ -1436,6 +1437,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  
>  		/* Restore previous governor */
>  		df->governor = prev_governor;
> +		if (!df->governor)
> +			goto out;
> +
>  		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>  		if (ret) {
>  			dev_err(dev,

I'm sorr for late reply. I applied it.

Thanks,
Chanwoo Choi
