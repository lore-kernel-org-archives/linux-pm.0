Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CA51118F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544672; cv=none; b=sI+nWZqecTncC3P20qvTGGWGoK5VWZT8rsXWheSRGl00FRG16sKl6tIrkDWHzzAJ/u7m9cUvuvGThPyPNQokdAf0oAM2rssh7C2U6UfPS/cLp+oo2wSTkrFomkEfTUzrLphhLTFBDTMDhVtUneK98v92kBJxgurCAEf7dC0xJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544672; c=relaxed/simple;
	bh=SSdKA8aPi6Eb8JDii0pSei85yNM9d7eeM43+xAQL63M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raYNKCXKJA3HE1nnHN1s0xS0dfnLn7VYg7gUEYHYnxuZhnYEiLoxazTDP7WDRumhbnwrRCrgh83cMGFJSmqxzedI0uLqeoVqzQe8vAQguXowBDVT8UoUnn8As0itjvB6J2dWu2DuRDAitQiJSLWFraJPUyA+yKuW0ZgRQr6oMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZIUjUm8i; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZIUjUm8i"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b28df1f600so1135472b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788544670; x=1789149470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxL9xWJoyXLMWiLXTBKm65nu9qcQOBFMxo0Z1T8WZso=;
        b=ZIUjUm8iqfXDPwqblE+3Jgr2Nnl5f9fAaJGIRy/Ta7WGOYLYKVxjnzksOvTJReU3rK
         trsN7ZkLYDyhhwkST8NQBRmIcC0bDsrB0Pf/6/OZzZ+ddLedZSwJ1TnmZVcoQxZDYzap
         uPml95VEs97OIvyhhGoylYOpPuVJp/kasVrw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788544670; x=1789149470;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxL9xWJoyXLMWiLXTBKm65nu9qcQOBFMxo0Z1T8WZso=;
        b=X6neSAIWyYqXzHLsSm+z79IOavc7ACURvWvFE1gUMZ81cXRLp9vyM2Rf/B9cNuJxyP
         IqaoVNsShrttBFHLR+te6wjc73q3Mc7gH/OzvUq7I3mg+FBEX7BRMFm0nit+jL8e40ht
         3DKFO4Bcg3OjZM8DqY4vEkRIntv7AO98eLRmMNdX0u+LUjTm/1nz2EVfyp6Uu6QAP5pn
         +nob3xyZIHHuORS6sYUl7b6+7jhA9N8MQzmK5K5HLQeziFtEI1FjdRELOzAfU0m25eFJ
         HeLBu5FnEe/J53ohDQDJ3DLM9K+ZotzA75ayMbcV+bq9KH8/Mbow7yKJ+RHEptZn/RJq
         UiGg==
X-Gm-Message-State: AFuF++miPU4soGA29Pz58pJHZvz9aN4XLsVifgbtei/OUW3f9KnKrOO2
	cDqhQ7004fkTghfkn2hfaXIzHc7cnpFjONL0AxwUIMpSzIqiiPodoyiFtmc7SLduFRk=
X-Gm-Gg: AYBFou20+VfyqjDl30SF+EVG145FM7RxY/IxrmqyHfu0O66/uee34hLQ+bZOawIBvq5
	XsflL1z/tA90v1MwHvR4NQ5ZHhEfjnbDD/q23ME/43/MfzRNQPCWuk8Z8zYejhwWjDca5cujL/8
	s6/npKI6bg/21Re6LsFD8mCrCwF/ZeAXXYnOYdqwb0UZc3gYh1XIY/c/osxVaHuH2AbHhQk7Vkb
	NjGxpe/Yv7rHZd1CO1nQc6BScSvEkWzYyCC6Y5dgPLztjlWwRguDg2RwUgW/r7EiXxNEfFCjFgV
	OHmZzy8UoXck8WCcbqh4mjxZlmOYnP5Q818jLnNuCe/RZ0O9+FrOzMZ9MunxxoXETXqUPpEsa5h
	KgO4J7NqWt+HRH3ReUJ/vG339KqYHBqsu1NnN2L3GVg2w6H7E1DWZri8XMMt1DudphMCzZE1H6D
	skqwdrrEn5RQv3oUsPDBnXhA3tWstb5J9W5trCNf4dYmL67JA81m42YZdXWh8+D1sA9Lgan7Cww
	h28B2iZMg==
X-Received: by 2002:a05:6808:13c8:b0:4b2:9d0d:ffa with SMTP id 5614622812f47-4b95bf9c315mr6608717b6e.0.1788544669623;
        Fri, 04 Sep 2026 10:57:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b97167bd69sm3087057b6e.13.2026.09.04.10.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 10:57:47 -0700 (PDT)
Message-ID: <14f16376-a0fa-4ea4-b14f-65eac5839bc0@linuxfoundation.org>
Date: Fri, 4 Sep 2026 11:57:43 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools cpupower: Fix signed shift UB in amd_fam14h_idle
To: liujing <liujing@cmss.chinamobile.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260903082644.5149-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260903082644.5149-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 02:26, liujing wrote:
> From: Liu Jing <liujing@cmss.chinamobile.com>
> 
> In amd_fam14h_get_nb_power(), the expression `1 << 31` performs a
> signed integer shift, which is undefined behavior in C.
> 
> Fix it by using `1U << 31` to perform an unsigned shift.

How did you find this problem?

> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
> --- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
> +++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
> @@ -270,7 +270,7 @@
>   {
>   	uint32_t val;
>   	val = pci_read_long(amd_fam14h_pci_dev, PCI_NBP1_CAP_OFFSET);
> -	return val & (1 << 31);
> +	return val & (1U << 31);
>   }
>   
>   struct cpuidle_monitor *amd_fam14h_register(void)
> 
> 
> 
> 

thanks,
-- Shuah

