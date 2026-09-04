Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41184DA545
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544834; cv=none; b=hJ/c5uiZEfpjkWxP5yNBKxxfWlGdN/hK4/Q+3u7SRFXVvYk+mRi9xczyT8X0uBEb86dApqXVgzIZwsv9Xw3wkHrkzyHzxpPfOUToxLENpWjvlO/lEt+9r4joWsEpPnaKgB8daZYJxC38WYKS5WmdQjCjWPpGPR6k4O70VufsI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544834; c=relaxed/simple;
	bh=YxiKBx//2sUyFwX1S42S7TPTcxzk4U6BBJBEU0T6h/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAkPBFHsA3Qaz2vpnAo33poUU9z0NV1jfmv0XIUuW3AaIOdvwj6je0hZEiZW2cTg+tfF4PqIpfiOTsyVcuHk1jGD+FtKRIDUSpEmc0b61Xmx+dK6S2rTfeyt9KcwYOJJyIRqZLD75jEZA7yMPBD468Kp+HnqdLbuTQwmUp4loW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gW0qpvAa; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gW0qpvAa"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43b7e186a0cso818845fac.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788544830; x=1789149630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJ4z45aMbFmWqyZKcuBn3UhHwfccm26z5b2Jk9Hp5CU=;
        b=gW0qpvAaVgRiwRsXec9HNBy22aBb54Oky6fcNf9tx3KHHAgntdOOWG/0Hom7Q3549H
         o+uSGh0a8NYBCFLEHEkKEQYlsg49y+qPmVG1phk20YV52GCIskv0eODGxrrZff9bf/fz
         0b9Zv9Uo0qkr2A2ByV5KuM335dnQcv9Zdattk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788544830; x=1789149630;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJ4z45aMbFmWqyZKcuBn3UhHwfccm26z5b2Jk9Hp5CU=;
        b=CBNajH3Qw6SM52YR3ObgywHHo69he2+BxjxDTJ60Sv0jh7BaZa3hCPmSq/TS2qkmAE
         /rtHh+KuleHIaXlxBWDYC2lKiix5JD7lU2YW0ywwrT/A03kuVU2SScsmgihWUpE7nMmE
         OSWOWfvpNWkI/U2GSyAqGeLtXb6VkErgNadqYpWQr3WxLCJqrTPXN5JhBVym40nn1+DV
         rFXOi09NMdvEEXZ/qXcZymgS7O3eY2Qj8WdBoOCJ0Zhzf/Kk/+WBOmruuP3jUzlCCnLW
         oZzaG8XT1+E6YOrFhUo5HGutVz4OUKvUa1JpVU5lj68zpSySzLCOVzb9lBTfzoEh/XyX
         De+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzILJ+CpQmjeUIJgVR43GIb7uQYNKGCSo1lYumUXZJ+KOKAvO4QN/yRYyAK/LzhpPzJnat89fsoLg==@vger.kernel.org
X-Gm-Message-State: AFuF++nOXkrjI0EKxWvefofkxaQ81H0EqoYRouMzeS1ty3LCFU3wwNoI
	y+MrZiveU/N5E2FKVpXVAmfmxISlsi3uRABa89nqgfD4JNsbky68ZyA2Po23quMr4uk=
X-Gm-Gg: AYBFou1qrFggZDoINbOzOv7xo1FIZXX0dpfyFhZBEjBhhQpcBSQrrbdpz1Y9DoL6SI/
	SpkPjo7qoB1NJkbqlUtmDI5qii9pWOzINrXQ8g+u9RwVMok3cXXNokzo50mrFGYxmDmdwURAgKl
	ZLbUO1UKP8unazA7D5MoVjbVS6aW/IoOJybjGwqC2PoS9uM/kLAndTHEbkYn/KEGIyoKjxQWkBM
	ATkufLzxENoWxHGREfynkRAm6v8nMFrJLtAt1LegK3TTsvjYxKibI1jv80Toligt+oMmw75njbg
	sL0HBb0JjGZnJDFvhm6AcrrqcTov2c2v209SmUHolUsuPMh4gy9QiOG9Hae+s0RLMHzaKN2M563
	/ZhSGbIDCXCdaSZBKrx0X9rQiiyq1KyXWXE+ebjfKcxPq+C2szWvYkrpR2Criiu7XXE5oKOdYZt
	EYqVSyxjqaKmPep4AdSplGb9JamnwruBdEazt/Vxn1kh+pi38uzoX+TyW+gyk6NDfT093/NQ==
X-Received: by 2002:a05:6820:810a:b0:6b7:46e9:96fc with SMTP id 006d021491bc7-6b746e9a31cmr3985828eaf.44.1788544830464;
        Fri, 04 Sep 2026 11:00:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6de03fa6asm4348054eaf.12.2026.09.04.11.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:00:28 -0700 (PDT)
Message-ID: <269fd99d-b031-430e-a917-78ae97d9bd0e@linuxfoundation.org>
Date: Fri, 4 Sep 2026 12:00:24 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: idle_monitor: add NULL check after calloc()
To: longlong yan <yanlonglong@kylinos.cn>, trenn@suse.com
Cc: shuah@kernel.org, jwyatt@redhat.com, sageofredondo@gmail.com,
 jkacur@redhat.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260902065224.1392-1-yanlonglong@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260902065224.1392-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 00:52, longlong yan wrote:
> Twenty calloc() calls across five idle monitor files lack NULL return
> checks, leading to potential NULL pointer dereferences on allocation
> failure:
> 
>    - mperf_monitor.c mperf_register(): nine consecutive calloc() calls
>      for per-CPU counters are used directly without any NULL check.
>    - snb_idle.c snb_register(): is_valid and per-CSTATE previous/current
>      counters are allocated without NULL checks.
>    - nhm_idle.c intel_nhm_register(): same pattern as snb_idle.
>    - hsw_ext_idle.c hsw_ext_register(): same pattern as snb_idle.
>    - amd_fam14h_idle.c amd_fam14h_register(): per-state previous/current
>      counters are allocated without NULL checks.
> 
> Add NULL checks after each allocation, returning NULL on failure,
> consistent with existing error handling in the same functions (e.g.,
> hardware capability checks already return NULL on failure).

There is no need to add null checks for these small amounts
of memory from tools like this one.

How did you test these error paths?

Sorry I won't take this patch.

> 
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---
>   tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c | 2 ++
>   tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c   | 4 ++++
>   tools/power/cpupower/utils/idle_monitor/mperf_monitor.c  | 5 +++++
>   tools/power/cpupower/utils/idle_monitor/nhm_idle.c      | 4 ++++
>   tools/power/cpupower/utils/idle_monitor/snb_idle.c       | 4 ++++
>   5 files changed, 19 insertions(+)
> 

thanks,
-- Shuah
