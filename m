Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDF39936D
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263306; cv=none; b=EpBkF+QlPdhdDEkhM4OKtdb04NUEApQ2ekxRTIQ3JBQs4qHkzV5RMs67CmFg6h19ILa7in/8gMwh5D57BtmUyyMLpUEi9R+4h9myqDkGffMChkESxMatNp3IZy5ufb6Kda/+DDiuO2BRhzv16lZqSilwLuMoTLc22d5Xm/ownEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263306; c=relaxed/simple;
	bh=oFSeNPvE58yGMQ0f0/O+YxS1OjMxV8qFEpOy5KNdyQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM0/G0hwo1LkUVjENuR1bNTHIf1YsXzHMWRPDMGGuiUtU9RNrW2uTTw4xIluO7e6qIuT39mxd5GPbW48AA1SMBVWXxIPlTZr22AIeG3q1aWTeKUWuZlk18Qo2E0HgnThjp7PzPsiZVuFznOT1UFU3DGP9RdgzbKhGegwFe+lGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XTW4eezI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTW4eezI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bd2c147abaso26677825ad.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779263304; x=1779868104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u8ngOMwMUPn4goFmdfrfEJw+jnZw3MbGMRB3PBXgcq4=;
        b=XTW4eezIPAqcLXpD55j5MvQdNSrvNFKxxWf+SgVl2aJLe61aZ2lwpCIjoPofo5kBCE
         tihx3knCMQEA1qxqKHZyeg8vFdFMLxOkgjFJsRIKPdo7wdkR3BLoAtRrjGktqovJKKo+
         TN4ETeTLg5yfXTh3t21eUpFQx/UnXvzi9fbamApptE8k1pyZbeLqMBToVYV9ENf3qwM6
         dm+4PPAvHUJ6ivslnxEjXXV7X3id3adcNYHcJweQoNGkPedxiVl8J8zwIFj9fHYkN2Yi
         5uZzdsklEI7/VwcSukDo0fUZFMD0Ban008Bacl/t0H1qxuCNmzhSPwbcknAWSjE3pDo3
         tT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263304; x=1779868104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8ngOMwMUPn4goFmdfrfEJw+jnZw3MbGMRB3PBXgcq4=;
        b=KVSLoFWQvYaOLhodSwvFWicPO35LJ567FgeDbcfQuOfb7qwunTsVE4HplD8VcNEvGb
         aZItI29eaj9IpCR0sATga8EgkBPK7/pNnRBLU+iLsloChdGWhnbjl6tetuF9eKcT57vU
         BWsZPqA5371xk/cWHWo5q7LREbav/6qDo2/0jrvqkNsOkYSMXzE8wI4RskkNtUgWWm4X
         rh0mbgiRGdrF4mzr1yd+BmTx0hOLgwt6ZvQd42LKaYeYA5IH10XAL/ykrn1uFka0o/xs
         p61cCtQr5crndxRafDXO5UPVBL7ohtzIxLn7VY3JtEB69LSUap1M2A5b0OvmQjA4fBQE
         ZNuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9K7+ySLhQBrf+DWnaiHk0Y9OTQTNnJlxFvRwV0+Lu9iyUUkN7arrn1HDi4SBolUdLP/gj6xuzjpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEN2jiT6qxwTv4Nv/hmoJ0P8Pv0Gy9fI//jAX/IFRrH3jg1ME
	Z9jLC6nwm+A1rJwPjR7589YAm8fe6uZwLB1ifrJ8485Ir90T2qLvbBqfM1A1FubcHEE=
X-Gm-Gg: Acq92OE9Bh2l2cRwYSirQTOJ8jrt9D44NLxFIZG/ZGYIi4/MxcdIQLis+fur8ZdDdQ9
	ewJHqBUCu9zZYU6KEB3sDz3l46qOYnD1OM9iGsODU8NnMm7pEBH7uR4j6ENXKb+wdreoGCHqCgK
	MLoSZ3t6NrLXuXgwWqBca+fYo+YFHIbM3kJNMT3NW9tN8hfzY55pBD6MaVrYk9+MaWAAQxwDkbn
	069nBjlYvZvl/Yndqs4qFS21uC4jVIVdjTnAK2JI3b0fxuoUYZRtiry4slwfttBkiJjxY7nCoHJ
	oWaYDDTRJzxIVRQvJNSi/LmQWI5J1xND52Xzv9liWOjMqJ7MvQC+N/RrS3Eec0Kdhwmxtrn8aTq
	lUAveAlhbkyaqDi/YTEXKTKiZyFFxcqMjZpSCs45SI0vkET2YusrcmLvAXhtznf0xCzqYxDWZ9O
	VrWLJfopHyGG3wvrfvxfAehDY=
X-Received: by 2002:a17:902:f790:b0:2be:9659:591c with SMTP id d9443c01a7336-2be96595a89mr2876805ad.4.1779263304202;
        Wed, 20 May 2026 00:48:24 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11b495sm219143235ad.69.2026.05.20.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:48:23 -0700 (PDT)
Date: Wed, 20 May 2026 13:18:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org, 
	stratosk@semaphore.gr, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
Message-ID: <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
 <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
 <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com>

On 11-05-26, 12:03, Zhongqiu Han wrote:
> Just one small concern is that requested_freq may underflow as an
> unsigned value; perhaps this could be improved by:
> 
> -		if (requested_freq > freq_step)
> +		if (requested_freq > policy->min + freq_step)
>  			requested_freq -= freq_step;
>  		else
>  			requested_freq = policy->min;

Looks fine.

> or use min() func?
> 
> Additionally, it seems that dropping the early‑exit checks also appears
> to be a nice side effect fix for CPUFREQ_NEED_UPDATE_LIMITS drivers when
> updating internal upper and lower frequency boundaries.
> 
> As designed in commit 1c534352f47f ("cpufreq: Introduce
> CPUFREQ_NEED_UPDATE_LIMITS driver flag"), a cpufreq driver may need to
> update its internal frequency limits when policy min or max changes for
> drivers setting CPUFREQ_NEED_UPDATE_LIMITS.
> 
> However, the early‑exit in cs_dbs_update() can prevent
> __cpufreq_driver_target() from ever being called.
> 
> For example, when policy->min rises from 200 to 400 kHz while policy
> ->cur is already at 400 kHz, under low load:
> 
>   cpufreq_policy_apply_limits():
>     policy->min(400) > policy->cur(400) ?  NO -> driver not called
> 
>   cs_limits():
>     dbs_info->requested_freq = policy->cur = 400
> 
>   [next sampling period, low load]
>   cs_dbs_update():
>     requested_freq = 400
>     if (requested_freq == policy->min)  /* 400 == 400 -> true */
>         goto out;  /* __cpufreq_driver_target() never called */
> 
> With the early‑exit removed, __cpufreq_driver_target() is called with
> target == policy->cur, and CPUFREQ_NEED_UPDATE_LIMITS ensures the driver
> is invoked to update its internal performance boundaries.

I think we are all in agreement on this now ?

-- 
viresh
