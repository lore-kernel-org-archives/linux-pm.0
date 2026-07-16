Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDD3D5666
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240172; cv=none; b=LGgfxW3TqB1K2UD7EyQ2JzqIm6tk5Mc3H5PY4GRwmTzehIkV1YMtiZRJKBACDUrpThqfO237BwU5nehE51+SzFmwDaUkKb5advelWIH7Uv0OkFwn7C4aW3mDBer0pLvMQp4tX+8xPLizuugXzO0K39cT7jpQWEmuNBnVajQdPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240172; c=relaxed/simple;
	bh=nVcYram5qpUVW7KgNAVqxKC45xcHyj3dMYgE2oW7dlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFanTZ0DOJWV/I9xOPAniDjbpPV4B3cg52OxHd7Wp+2sDh8GKynpN4cqvJ4Ow97xdcfAUAP+FdzvVyPkaQvTU+N40f4jIjVsIttEfLMqU1zGy95keof2ePsNGXZgsXx4UUpS6fm0Rq0SZzPvvmz1Z8jrqK0AJb4ynN5SR9Nix1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ghDfFKCb; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ghDfFKCb"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4566a5bc186so599022fac.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 15:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784240168; x=1784844968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1sBmXlOpVH98WdcMMDI8e0pxb+Bu4b2dLUtCYrsF68=;
        b=ghDfFKCbau3DOaQ/h9B/Ze4QQJCFSSf4qcfRdbBuZePEZiEBdzBE6Nub9Bn3hc1VOc
         bxEi/yqjUQKXzfXe6xYFNYPIrb7zFmhrRqsEBTD726s5QRUanv6akDKQOiF44A7b4oQw
         2BhT9eJ7/RkRI0RncZOhqTpXKRIfex0DkokCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240168; x=1784844968;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g1sBmXlOpVH98WdcMMDI8e0pxb+Bu4b2dLUtCYrsF68=;
        b=tYUN5bDjwiBEsXmJJWaofrG+XKTvoGn4NUIEZxUGN+saS6jErW5KH/yYnmtazjlti8
         kYRkcN0qdaCJNxJfPu9LQWVxNisZpSpplzk0EblU8SdC2n6a5KMraAlUdOeA+9sRbUzX
         qVQkGzCosWzYCy3ZIrOiw5WCsgnCAVcAqfP4UyHLmbGJBoelJN0PleokAMLzbPXZ64e0
         9Y41RaPiqk/E3K2lXDg4mcX2aO6UpPf3NdQWJ3mvquyPnFQK9f4IJvfE3vercEdgkZHz
         FagloVGORT6XZ1JxeMbFW6M8Lush6bUy35aAFngt6aWDbs65cEzoMBnipwBWGRf2jAo/
         raNw==
X-Forwarded-Encrypted: i=1; AHgh+RpmB2+vNqSTFVnoipcS05YA+PNOhWYH9d+3GicqbgZCVcAGzOmjuAvlCikFNhY4qfQGvBOrTwXYoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3IhbJbgdYBwMlb9yMJ3zO4D1ZAhjFVpgvKCdQ6z9AEjYYP9B
	pfEdLjofvxOHeNxvnkSNF/wbMMVPIrRzcHnThH1krvGUi5cxGLs4l7Cn413QxIk5kgU=
X-Gm-Gg: AfdE7cnJ2wGbDcWf898ExuXf78YEh4733Af1LyI2TzcQyCtuHpbZzA6pmy/ssyvY/EW
	3zU1kpKRPS6iwliLPkUM71bn5MgLcgmrtG7yHLQkCksKRAj21DuZukFo0x+TcDh0idrZXuhdIDL
	nIXLhkekqkficl3KcfL/FSVpxDTt/5Fjkry9SjXk0sRZfGaLypbEE1FLKy9MRZdZZHWa49Rzb4A
	pWQTWtjBJrEBgDmSyR771IfxDrGHeP6USy+6nBrQOMsUnT95i21XJcQ5NNbDG79X5gd6J0bgeRX
	VxZPArCokoUF99tlNe9+63gC2p6twiI+HNhaL3s+2Yfq+mv54ozflZcZGHsdsrkvgQ/3yNPj17s
	LGqtAAq6HGSjIl5VgXpw2VTUEsiHBtXs5NwdR02ZfyWkph0enr9J2a6OtQu6t0tolV27lA2UaxF
	KCOfhRrI8VxcU=
X-Received: by 2002:a05:6870:950d:b0:455:c1d1:9cc0 with SMTP id 586e51a60fabf-456828aadadmr731648fac.19.1784240167924;
        Thu, 16 Jul 2026 15:16:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455ad91df9esm14010377fac.9.2026.07.16.15.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 15:16:07 -0700 (PDT)
Message-ID: <71c8ae0d-cc20-4b99-92c6-69641b2a0f85@linuxfoundation.org>
Date: Thu, 16 Jul 2026 16:16:04 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Fix NULL pointer dereference on allocation
 failure
To: Malaya Kumar Rout <malayarout91@gmail.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: mrout@redhat.com, me@brighamcampbell.com,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260704084303.86113-1-malayarout91@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260704084303.86113-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/26 02:43, Malaya Kumar Rout wrote:
> The bitmask_alloc() function can return NULL if memory allocation fails,
> but the code in main() does not check the return values before using the
> allocated bitmasks. This can lead to a NULL pointer dereference when
> bitmask_setall() or bitmask_parselist() is called with NULL pointers.
> 
> Add proper NULL checks after bitmask allocations and exit gracefully with
> an error message if allocation fails.
> 
> Fixes: 748f0d70087c ("cpupower: Provide online and offline CPU information")
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>   tools/power/cpupower/utils/cpupower.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 9ec973165af1..8f7b18b8bb43 100644
> --- a/tools/power/cpupower/utils/cpupower.c
> +++ b/tools/power/cpupower/utils/cpupower.c
> @@ -184,6 +184,17 @@ int main(int argc, const char *argv[])
>   	online_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
>   	offline_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
>   
> +	if (!cpus_chosen || !online_cpus || !offline_cpus) {
> +		fprintf(stderr, _("Failed to allocate bitmasks\n"));
> +		if (cpus_chosen)
> +			bitmask_free(cpus_chosen);
> +		if (online_cpus)
> +			bitmask_free(online_cpus);
> +		if (offline_cpus)
> +			bitmask_free(offline_cpus);
> +		return EXIT_FAILURE;
> +	}
> +
>   	argc--;
>   	argv += 1;
>   

Usually these small allocations don't fail to warrant checks.

thanks,
-- Shuah
