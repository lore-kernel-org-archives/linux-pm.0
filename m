Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929D3F4122
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147652; cv=none; b=fqFICg9sZg1cPkBiivScdW5agQA/uVGoWzspvOAdQcer0ggLprqVTrrD03KI1bpT2pXSOGJ55YwbJRzzlKOutaw6gYhXRC6HmZ2dsD1zZ1Gx3g2M3tU+DRl9J5Pq08UZI5OjEfKzpAbOp/5MlswudYqbeqbZm/4zReYOosRJUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147652; c=relaxed/simple;
	bh=VoXS2qISjgbEj7DrZplv9UdB9S9LcMbT7fAL2IrBvoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7SAQ7J5vN1RVGolFxUfqVLZWBznlIUvBiZgMciOUNEyAM0cRhUHxwZKmMufe5a6hGyQQFR3yhyarZn6sTnbMWl0XTyC5SXw0tRRBjnCPJjGTmzbkDdDxDNMJI5RObjpXUUFVJWMhMkTQsU75SfAoft2vwXR7+OmLgm6+zfsxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a67h0+/l; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a67h0+/l"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so1865219a12.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785147651; x=1785752451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uMEQZfc1c9H83jiVzjz2a7rMNH747ZhRmD+viGRTQsc=;
        b=a67h0+/lLQW0OFGmTVtm5p/QujWnIYEgX8qY6aYqv9fbBAiGhfkXPQ+dsnMzGlU0yg
         pfAtHD2tjAk6sPie7jSGTd+ws6TBa8+rkixAvGeNmBg3Zwn336/Onhbzubovkbrz9LZR
         JML0gR4hghUtzJrFMZhS1nELzPJsfQLGI95qvPWgYxi9eGBBEq9/9X/TNibZacbj2e3G
         vXsZZrni1fCaQ3axT8rsA95ynlMG8F3Ibo2PwX+YtgYxz6x4v2EKOfc49BpfSb5Yf3u5
         i3Z5dXJF++ESXDjOco34vg1iEcsS2WHNAc4evH/DYKw79JSq7rqN+lTZzgeT6r68xirg
         8OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785147651; x=1785752451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMEQZfc1c9H83jiVzjz2a7rMNH747ZhRmD+viGRTQsc=;
        b=OCy5o8+fiigq1d5Ncp1zNgX9QIO4vObGvCecTfURyCSRn4Nf6b7C9pDoXsvbE+UH0v
         SqD9cgobf/KHJ0wgSO0+obmj/iEyeXgorfAfijQYx0YTo/b9hAhMH2fqzG4gbqWMg2An
         aKqI34vhH/mu1AnzUWsifrBmjjfGi5eIj4GAEH57XhHT+gW6YJESjl95rd42x6O64scm
         AniqdWAyxoridzWX1R9EiXJLdrfnImJEaGxRuB7aRlb759dj84Q+ljV9805uksrbea1W
         /nbQWdGMpCQ7CMPwvIf6AZxvDQVsWhNl8D3cHiRyqLk7o6H2tXDnLc+nRWysUqJLLSTc
         afNw==
X-Forwarded-Encrypted: i=1; AHgh+Rrkar5+1bzXnHYAEo6OrTAunEGInfjMX01sGMFxwgqE8vX2SP68vfTOkkeiQhO1WG13Db1X8S347A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfMd3WMAYiO+/VkCk24XZlGiqSQl3Hvn7tgiuwJNV3D3z6O+d
	AT3dUcpiAjqI14nZY88mjEbt9t2oxwUNgHILEIFDbI6uaQLJmikWFAUv8IM3oBPJtl4=
X-Gm-Gg: AR+sD11iz9Yt+Q94OyhgZNHHEy06cQS5MDE3nO3SfjyHXJSs+vJUvbBEJx+9T48wYpU
	PhPNFizhP1ltVu7N78/xIJRccwpj5bJmT2txhIU5fbafYsS7YoLudKXxlQS0ZpGJWTMc8e7Fvg0
	YBbaijNlKi7QYmD/9aUM+bq0xS86sCtM50xBcpcNxWL56UGcqCjPU3YODlSsskI7kNRPiCAAajK
	UrplDcgjYqJJzttbAJZ8D77HVx+4lcGa9lxcLj4nTLVWdcPQcWEkA/lx5k8bd5NdaeUWtM4QZ9h
	paE6jnAwngDWWRnCFDArRERvABV8fZz8A08Bez86DAvnzMTJgiYe1WWhgYLFm5sGGaCFrqB8Oau
	7AqV4I2Z9GFk1d/wsnJvoAW2wB1SCIn30xnJm16FftfEpenIEr80p+if1uQP39xu5FTzK+sh3j/
	3Hr8CAUZn6cnlz
X-Received: by 2002:a05:6a20:d497:b0:3b4:8f18:33a with SMTP id adf61e73a8af0-3c67dadcc25mr8054267637.1.1785147650540;
        Mon, 27 Jul 2026 03:20:50 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc593b57sm43881131eec.25.2026.07.27.03.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:20:49 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:50:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix possible memory leak in
 powernowk8_cpu_init()
Message-ID: <5zxdn4jnqu22k2s7roo3wxykwsusah7mp4telybmzlc5zgilac@pf5svblpx7nj>
References: <20260727093553.98246-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727093553.98246-1-nihaal@cse.iitm.ac.in>

On 27-07-26, 15:05, Abdun Nihaal wrote:
> The memory allocated for data->powernow_table inside
> powernow_k8_cpu_init_acpi() or find_psb_table() is not freed in one of
> the error paths in powernowk8_cpu_init(). Fix that by adding a kfree().
> 
> Fixes: 1ff6e97f1d99 ("[CPUFREQ] cpumask: avoid playing with cpus_allowed in powernow-k8.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/cpufreq/powernow-k8.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index fe1f499b4fc0..c9bcc6f0ab7b 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1085,6 +1085,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
>  
>  err_out_exit_acpi:
>  	powernow_k8_cpu_exit_acpi(data);
> +	kfree(data->powernow_table);
>  
>  err_out:
>  	kfree(data);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
