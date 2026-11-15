Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794781679;
	b=jjTKTIW5YsjCjxffQCpaArPUq6XV5bhjN4US5xqTM75qdoishnaERTgKj0JlRRRrHxY0
	 2oqnHz7sbCeGEfrlN1Bf/gSB7M0I5iR2ToybrRVfWAg0Vq//Rd8RIA0mTkq5iw0gGrf4l
	 RQSDjiUgLv5mnEY5/jllpR/ZSEmAKZArezyFwODWnavunnnRvOuANMnyKO84XpHW18xmh
	 REs2Hn90sfWaNqb1HNCWazEqFrbnROVg0qhUveKFfldbu7V13QsN4vHmI+T/hGCifbTo+
	 elSgfE2szSFu5gRo8mxFSY9POW3XkKylPvMOnRp23kU4tL0PUAkIROFStpzKyXTZV+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794781679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=g+uoEVaY7o8GGV6KPfzfE+Dp0fwtZ6vxaUTvxsle11g=;
	b=XWv9IdzqLTp2nLkNwJrcBXIBsmZXVyyTE7MfIWje8cqulGIw9zq120Slm/gB91Low6MC
	 D2wnLUxHihLHN1+mnjpD6bDIIktWt6Tp44H+vMaeS9WegzNSO1gHrFdNqhdG5qo8+OEjt
	 j/d9kdYPu7qEnvqGDo0pBzqvxihSTtzgLF9ls/VFggLAa1XWtkq0AoAssdea5RJy35cza
	 J0/87rzKqt4xKgOm4R9FmL9a8couxeQSjqdb8sgBgo+YcoZm58QyT7XPS8ajVWF1JytY2
	 u0qNAfUbRF15nmsowJnxO1v/0hru2AYH9G98w1NrhvT0/Erttew97R/qTuC2IT7h4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G6pC8cLp;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D659606A31F
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 22:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D659606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G6pC8cLp
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ed1414df17so13964105ad.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 14:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794781678; x=1795386478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+uoEVaY7o8GGV6KPfzfE+Dp0fwtZ6vxaUTvxsle11g=;
        b=G6pC8cLpIK0jfEQ1EaG2k0/jn2AWzKMskaqIkfpUNLPN8lrhf3OGgIsRXCIvQixipB
         w4UG3ZiSr3quYy05zl0XHjBuLVR9buBzguerqlI1uUThBxtiXdkF/BM/0gL0dLJJvk2C
         SJqYqPRHISNy3stcLvZ7CUOae4oQakLs/gdz5E11pCgA3Y1sx/xV7/L8vf3wtYIsK3mh
         aT5c40XmP2bI5aNC+WxIzuP5dH7ESL0iFLts+fgENeRcsQV5jaq4KAk5rtpDZPz4rTBb
         gCUEFsFZq29yBKQcVlbvBguEVEAFS6GZ1O74Z65m2scVzoDgqMv5bym4pmahmEG3VjsL
         XbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794781678; x=1795386478;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+uoEVaY7o8GGV6KPfzfE+Dp0fwtZ6vxaUTvxsle11g=;
        b=kgKpzWwRp0mA0Ozx3ynGplzVTsKSoEp45yvx5lv/pmN6YFaq4SIDf/qgQwuqUE8kHg
         aFHykRAY1WBXrA5osPCZhP/Ypel9PO4exg1q9J+V/ScRG9icu+CtnVjE/Erdpexf9rnm
         UpjiQuqzmZP81h9po9SwYeuxaULOll+b9fG44xAyXL8kiApHn5iGr5gFdkG8/xKnyzNd
         mqvIQt++qvIpKK3EwNTNX776L3DqPX4kYV7ki5oA3O20iZdH5WMAvlaIU/dqQeUnw9Ry
         lAcBzdL4GgrYprwgQsRxS3noF535hPnUNgMowMJj4TCnlHS6qqK/0ncf8d6cWEzI8YGs
         kVrA==
X-Forwarded-Encrypted: i=1; AL+hErEiYDjH/YYq8H0xDU4YWeqqosFZPZhMOl/6HX4hG2oi2SJ8RjeTEeWqBHUb7z0a42FGyvRoVLX3sA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8UAUEvU3D1S7Fx2Q5+X5VW70Iez2HE1pmK+AajtbnssOxcnrBX
	tPz7Cr1h25ZmgO6J9w5gqlFQDtXnSn8w/Zwft4AV8JBV879qlqvgFzWy
X-Gm-Gg: AYBFou22lKvH2FywQuxuoRqEdIEQR+vWGcwKRukwDYG8UDkSX4U9y/bitcQU8QL0A6l
	GwCJ6cdfP5ei+znXOgQY6iqQkrAeOTBdzibzK5Gp5Q19pbpktaugNwEHeA15SMJildeUyVIc/cD
	C5enX6UdKvSUDz2DAr5VxhOEhlV3DOE4EoauTgCZbdnnbopPhD5PkYu7rYDW8ej/suZzogjTmpD
	fhIQ1oxeJjapfLHwN6A1LicyevtoAAXgmBNf95TxPhf0AIracqg775pr+bkvrqt+A7QVygLXhv8
	Ss6wO+spnfQByX9ANqfXi0QAR/et0YZMQcc8kvSM2bt6E5J2M4E3WelLdKCTr+zeZCx77bBbpI2
	6unrcxNVDpWjTDDTUwilrI6a1waSdvMbIB1iEHmdLtelJGW0FgMs1VDIZ/jostZmvy0WxLsbJ72
	8d4pH/I5cXNVIf74WEEuZFxmfkekuYTz5575Yl9l7dDVLlbNc+kEXNV2iGdZvmxX7WNkXiPKLUQ
	R6ZBbDEkDWGNnd/Wxu9rTiddggKxPOCc/SGTKrka0eBxNcASxG5HisqJINQJ8KK7+7JsQOZprjT
	nKYFhxrwHwwg3SZufJJxn4UR7ipNdawnwTi3UPbW+hrFV4ieEJrbbjG319S9hoLyZ7fUwFgJqVv
	ctbYxOlgRvxiL8A==
X-Received: by 2002:a17:903:f88:b0:2ee:2557:4069 with SMTP id d9443c01a7336-2ee255742c7mr54507105ad.23.1794781678304;
        Sun, 15 Nov 2026 14:27:58 -0800 (PST)
Received: from [192.168.35.214] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0fa27c23sm28191145ad.71.2026.11.15.14.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 14:27:57 -0800 (PST)
Message-ID: <e1298d8c-7b10-4552-9c6a-9418e8e26329@gmail.com>
Date: Mon, 16 Nov 2026 07:27:53 +0900
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
Subject: Re: [PATCH v4 1/4] devfreq: Use mutex guard in governor_store()
Content-Language: ko
To: Jie Zhan <zhanjie9@hisilicon.com>, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com, tianyaxiong@kylinos.cn, zhenglifeng1@huawei.com,
 zhangpengjie2@huawei.com, lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260729102348.3857779-1-zhanjie9@hisilicon.com>
 <20260729102348.3857779-2-zhanjie9@hisilicon.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20260729102348.3857779-2-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 7:23 PM, Jie Zhan wrote:
> Use mutex guard in governor_store() so as to simplify the locking logic.
> 
> No functional impact intended.
> 
> Reviewed-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/devfreq/devfreq.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index f08fc6966eae..7a70dd051644 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1394,23 +1394,20 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&devfreq_list_lock);
> +	guard(mutex)(&devfreq_list_lock);
>  	governor = try_then_request_governor(str_governor);
> -	if (IS_ERR(governor)) {
> -		ret = PTR_ERR(governor);
> -		goto out;
> -	}
> +	if (IS_ERR(governor))
> +		return PTR_ERR(governor);
> +
>  	if (!df->governor)
>  		goto start_new_governor;
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
>  	/*
>  	 * Stop the current governor and remove the specific sysfs files
> @@ -1420,7 +1417,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
>  			 __func__, df->governor->name, ret);
> -		goto out;
> +		return ret;
>  	}
>  
>  start_new_governor:
> @@ -1438,7 +1435,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  		/* Restore previous governor */
>  		df->governor = prev_governor;
>  		if (!df->governor)
> -			goto out;
> +			return ret;
>  
>  		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>  		if (ret) {
> @@ -1446,7 +1443,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  				"%s: reverting to Governor %s failed (%d)\n",
>  				__func__, prev_governor->name, ret);
>  			df->governor = NULL;
> -			goto out;
> +			return ret;
>  		}
>  	}
>  
> @@ -1455,13 +1452,10 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	 * the new governor, restore the sysfs files of previous governor.
>  	 */
>  	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
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
>  }
>  static DEVICE_ATTR_RW(governor);
>  

Hi,

include/linux/cleanup.h includes the following comment
"148  * Lastly, given that the benefit of cleanup helpers is removal of
149  * "goto", and that the "goto" statement can jump between scopes, the
150  * expectation is that usage of "goto" and cleanup helpers is never
151  * mixed in the same function. I.e. for a given routine, convert all
152  * resources that need a "goto" cleanup to scope-based cleanup, or
153  * convert none of them.
"

A Patch should be atomic. This patch still uses both guard and goto.
even if you removed goto on patch3.

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
