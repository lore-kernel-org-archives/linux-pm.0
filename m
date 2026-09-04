Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69833481673
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543080; cv=none; b=O+Pmr+Fbfc1jVqhZsskC1BzHIwOVheTFhKuuLFHTsNcYX8JIWAUD/ILOTAJW0xzDoxy9yOA/hqUQE0X7/tN3R2yBK8xJZBjCf4qmOg6Hdgz7JS70d1E47/1uo9ZC72wmrHM4NHoqNNknnpIwV/OjmvFSQtOoSa/CVeXY5bsN3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543080; c=relaxed/simple;
	bh=1o6KRoN44DSCBsEysacGHYHuD0OPx3QcKtHFyX8sd4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITUpNADRdTxXVNlDd+YfXTeunPs9c1EpaNua6UMcJG0lvBHoTRBAMOnagJTA1kHcGL4tEoYf+Tt3vaiB5OLtsIpSFSZdHNYC0K2S/5zzIS8dW5x00KSKEX8pjLoqCwX9PIQu/qG7ki4B6lGIFREa9PnN+Bp8lN6wtVXj1MTH7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DxxcnajC; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DxxcnajC"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-495b27007d0so1117614b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788543077; x=1789147877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZOIo2HEBu3h7pqrMStXOScgEdgGJQw6u08wXyRcXzU=;
        b=DxxcnajC0he1SOcAFrrSuAfXyZv4oOA8yvbURCKp8Vvku4CTKqu3dG+FomGWlcBBYN
         vle9M6Vy+Dr8D7iE4yic42ZcoRy61lbZJFVlpKvSxrX7/xAg/S827ZfADe3G0okllIOx
         fNY+OYkw17dUULwPOW7GZY84Idw3NTdY73Iqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788543077; x=1789147877;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZOIo2HEBu3h7pqrMStXOScgEdgGJQw6u08wXyRcXzU=;
        b=LuFWN72/a6D/3tfuQIR7jgslbpbAwa5MRrhv5aqrIBh4FQN8vclD6xc+2nUpBIgnN8
         oNfJqHQG4Rww3EYxLTcbC1bPqO6RfzerQs+CyEELN+uydvZ0uq9DTP2VaHD49WP0nWbN
         QapJCkpbarXNspYXOgH6T0351uGjyogiCRXWUesUPqmR0NjFGpnZDyYJYmZmxoe0px6F
         Ke4zKy0+b1vvjkhy6GxUTKx5s5ZTvEwZTM4dOyHzSbQLwO3qL+o4o4EaI7rwSIcq83YZ
         UQMEEoAa4gGaHVEVAXteSZXRF5y1jmR0FAn0VNY+2DhcYjsGP6YBP5zVA7vLUFMpK0lb
         c4Xw==
X-Forwarded-Encrypted: i=1; AKwUvByPDUE5jFkyLsa7Jj4Sc3yTILVQCcssk0eT7fAYgRo+G3+2sOQ4ngm5aLodhqDAwBs/7jSHdLRkUQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kRuBqBRoFpBoLJMtVEjAESTvJTzE9EO15wQrqNeSXEaIcPe8Z5
	20KD3tf7rQBkELk/LyxnhC0lY4tEioKaLS7QCh7nl1UpQpZJAVdks3bP5g/cKv1R2x8=
X-Gm-Gg: AYBFou2COKmF62yHMxZkqleofuwQLekKZLbSIsV0zQkXUSbs+rkySCaaqWJSDw9s0Rt
	HLS1le3SaIwsdlN4kavYeE+y69LimBbVsRfW4SygVun4MirkB6CMMacMVeVYf79IPkv9QdVskMJ
	3G4Nq5arjktaYESs+D1PtZwjqLSrC8HruwGktOJiTU+dDX0tmLZbWnWG7Q1TxXXdqV6vbt/YbnA
	gGHD8qbrC+1kasF6QxzmXV4z58pO0wmllz5prA8WkKihk9PnxXmRuDuujuNAtcBAcPQH4N2WodW
	os/ZAkHoU4FkcBiien5PmwEqhL7LIl0hK49JeZ1D6zyBzbzj1EsU/nfC7q+Yoje1hLPidzcWuHv
	HdkoLRB9inCjrlDE8lzv/KcNTdjs26n41PLMzxtBwvLU6AxsQxAlfH6ROS+YRCyFpxBwsN7W/Do
	pEYH17QX/Z3EK2KLAmtpJCKflLaSbv5bFXsaZxik4R99PBGdJBasWERQHfmwClBkDGrrhY
X-Received: by 2002:a05:6808:67c6:b0:4b3:880a:f08d with SMTP id 5614622812f47-4b9622c002amr5220754b6e.11.1788543077130;
        Fri, 04 Sep 2026 10:31:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d23c8dsm2733250b6e.5.2026.09.04.10.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 10:31:15 -0700 (PDT)
Message-ID: <f1b5ae1c-f6cd-4f9f-9143-4bdd3b8c2b46@linuxfoundation.org>
Date: Fri, 4 Sep 2026 11:31:13 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260904124005.3270-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260904124005.3270-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 06:40, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.

> 
> Assisted-by: Cursor:claude-opus-5

Why do you need AI assistance to fix typos found by checkpatch.pl?
How did Cursor:claude-opus-5 assist you?

> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 4 ++--
>   tools/power/cpupower/utils/idle_monitor/mperf_monitor.c    | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index e8b3841d5c0f..b15371e3e6bd 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -72,7 +72,7 @@ void print_n_spaces(int n)
>   }
>   
>   /*s is filled with left and right spaces
> - *to make its length atleast n+1
> + *to make its length at least n+1
>    */
>   int fill_string_with_spaces(char *s, int n)
>   {
> @@ -263,7 +263,7 @@ static void parse_monitor_param(char *param)
>   			 "try -l option\n"), param);
>   		exit(EXIT_FAILURE);
>   	}
> -	/* Override detected/registerd monitors array with requested one */
> +	/* Override detected/registered monitors array with requested one */
>   	memcpy(monitors, tmp_mons,
>   		sizeof(struct cpuidle_monitor *) * MONITORS_MAX);
>   	avail_monitors = hits;
> diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> index 5ae02c3d5b64..62b8cfb02040 100644
> --- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> @@ -276,7 +276,7 @@ static int init_maxfreq_mode(void)
>   	    cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
>   		/* MSR_AMD_HWCR tells us whether TSC runs at P0/mperf
>   		 * freq.
> -		 * A test whether hwcr is accessable/available would be:
> +		 * A test whether hwcr is accessible/available would be:
>   		 * (cpupower_cpu_info.family > 0x10 ||
>   		 *   cpupower_cpu_info.family == 0x10 &&
>   		 *   cpupower_cpu_info.model >= 0x2))

thanks,
-- Shuah
