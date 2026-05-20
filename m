Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF95367B83
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264705; cv=none; b=li6Tu+hH1ypwg/gBRZ07WqnZ3nbi8mOcx9mDk6CVF8jAsVxbeKHdif7GPCdir3ZwfotiIWcL6fi0VrSev51Frv/7e93ouLq38yq6e/CSiLDeFg7an8hsf15w1YUOIvIsUg2moCJmmI3PSoZ+IE7DBVz79Zz5KtflJTYY0TYgHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264705; c=relaxed/simple;
	bh=dZTSqSu/MbSK1ONQ78RX/lDGhqUwxiThKPfbDd81m6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEsDztkJ+MZD0X3rd6E1FCNBT1E4X5/x//b2J1AxTMmO2Zt+jMNYirRTPjxRKK2iK789oAtL/zK0a8KUwZ0wArvPS+2s3/ivNVelxapSUSp/Xqzyw97yc+Ig74Z0bgInjIVtsIgC976H/FHYyFnvrCxirCtsU3y0tGuyme4yO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqaNudvy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqaNudvy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2baef9f5ecdso36263895ad.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779264703; x=1779869503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=peIkH2jFEWiVrxLLP7kGKRZpoLe54YD0k6sn0w5+ggY=;
        b=RqaNudvyI0r4XQ6HjnCjFTd4NbkHx/9PhLE689pqztfcpsL98tyhWeif4jGGwshFxO
         9scuZbrGZajkeLVljKnPQBSwwXxB3vG3hFVIvReqXoX5mTBpSlBwPiKHwSnv7VuGra1b
         vFYjCuRSzg+bC9veNKVzFSkVmOT0y27hgGaPXD8Ltzg8dfstwhotkliCb6AHw5DL5IyC
         N/81VFh07u3C6WL0vcf3EqrWgi+onY2C7LF4a39uq4bXdgCqNUd3dBzZVbPretJKShXP
         pOAEFzetMeJbDo12GQ01PPbkKAIiuVaT9wl9f1RkG8C0155fE1e98fnjg/RBk6je7XXp
         afew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264703; x=1779869503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peIkH2jFEWiVrxLLP7kGKRZpoLe54YD0k6sn0w5+ggY=;
        b=n9tz+WN82t/RlFRbaMj2MjNsrf2w4F+qW/PjqZTaFNA0jeZy841c/xstlDPR77P2Rg
         RXkOqqDN4TCKQM3r5YFkP0XKAyYPsjJCvdTovtKR+SzhbeeiFyTNPaM3/KGl0k2+g5Ai
         GsMQ57gYQyzDn8cRPViykKVVPTPpMLTz7XHH02ziwWlfiEWAhCTqZ5rEBsdOcBf3BeRg
         yIwmOOeu3VZl169bSc9MjHAGcOkhjDqvA4pEx6qc8deMmiZ+nNgC+X8DJUO9a/8XSSvQ
         lxRXEO0NyilmV3FNxENFHJ4WarQSMv8DQruKeCSc06vmu5kAT4C4pmj88z+xldW3+OR6
         v9IQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jg8VehMqR/KX87f3Ng0rd+arZQi/747bIMLGj2tlCn59HzhgPODosHxJX1t6ZFVAI+bIO40UdxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytXYu3ZB6AQwnchQ8rFdeklwxE/Dhb9wbKU2u+ZVGF84iQssQJ
	c1TCYVnrOpGWIUU5cfnQuhIuLQ9GPIW19x2yahuCeMRkdgyrC7MbDN6s6ANHSK4SlP4=
X-Gm-Gg: Acq92OFAtkTqEMlkwhQPsfyVj7n7D0yUC+TCviKYlSZ1WnxZ2Y60jpoiAoavVn0sLbi
	8JQmo6yT+hV0+rOaiiA2POGzo2udZrilkzB90AaMPO1RHf3bmedXubH/WDU1ztNAZP1yf//s78u
	WSt7Qg0CyNHySoraFgyzI77DtYFXphMz7vr6PfNyhyJiopg6kISdnAj5E0v2cc1ZquzFPUiBLDy
	qTQ0onA6+EezS1lLOOWY7qOUXIPHC2yS/YIW+o55VA0ZAwYSAJmwt7Ovlt2fnEf+onFClvUqrl3
	rPWrpgEc+FSCO1OOXASIeAhPTTmAzWQOqOOZXZYZTLLQUrKhgnHzUqdZ+V155FwK2KJBu+LXpYl
	TbPErGQ4w+tMS1RH2X3llfWa/epV5+q+FAF4oReAlA0Hop9FfKe8vI2uu2f48DT854+ERtrhtj8
	HakV9u1fXipEvo4swfUmrm+hdrIz/MrCj3DA==
X-Received: by 2002:a17:903:983:b0:2bd:8395:fed8 with SMTP id d9443c01a7336-2bd83960609mr258908775ad.27.1779264703294;
        Wed, 20 May 2026 01:11:43 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2dcsm210199835ad.13.2026.05.20.01.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:11:42 -0700 (PDT)
Date: Wed, 20 May 2026 13:41:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
Message-ID: <uydxaaj4laiaashghutb6h42ltb7qr4oyt5s2cxxqchnmffoam@uj7bl6t4rzsd>
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
 <6cq7e26levlhwh6aoq6aii3vsyjqtvp2ksymovkosfhuuunv6u@cyab7jjd2fgy>
 <066010f3-9973-4076-9ea1-0c675dc84420@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <066010f3-9973-4076-9ea1-0c675dc84420@arm.com>

I was away on vacation, sorry for the delay.

On 11-05-26, 15:55, Pierre Gondois wrote:
> The above code can be split in 2 functionalities:
> A. Adding QoS constraints
> B. Fetching the min/max QoS constraint as initialized by the driver.
> 
> I think the main constraints are:
> cpufreq_table_validate_and_sort()
> \-cpufreq_frequency_table_cpuinfo() [1]
> \-policy_has_boost_freq() [2]
> 
> [1] policy->cpuinfo.max_freq is updated
> [2] Boost support is detected
> 
> So the QoS logic relying on policy->boost_supported
> or policy->cpuinfo.max_freq (i.e. A. and B.) must be added
> after cpufreq_table_validate_and_sort().
> 
> ---
> 
> if (!new_policy && cpufreq_driver->online) {
> } else {
>   cpufreq_driver->init()
>   cpufreq_table_validate_and_sort()

Even we can remove the update of policy->min/max from
cpufreq_table_validate_and_sort(). Just set cpuinfo.

And right after the call, we can set policy->min/max.

>   // [3]
> }
> The else branch is executed if the policy is not new and there
> is no .online() callback. To avoid initializing multiple times
> the QoS constraints, A. can be done at [3] but only if
> new_policy==true.
> 
> ---
> 
> I should have sent a V2 which does everything in a
> cpufreq_policy_init_qos(). Please let me know if this
> seems reasonable to you.

Setting policy->min/max should be considered separate from QoS I
think.

-- 
viresh
