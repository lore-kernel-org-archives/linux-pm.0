Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793576888;
	b=hTDOlNg9KKgvgOGZB6xWnKw2aS44Uil0bnlVwpaPrJ6hj3kBbLUK8pIby8TcKejL/v2R
	 qgTeoU0EDCmT/RJ7ACw5HGpb5KoalaHt7fOybjKwMet+S6If3I9lrDo4JpuC3WmrvoSgB
	 0RJ9VklByWHdQ8WEvyBbdiohPYrW8bgErG17qHulG4rV4T/TzuWGYqafW6wXXsyy+EJNF
	 u4p1a69aAFIUnS6yl6w99M/kj/ZiERH9lggTA44y7XdkE5L7NaQqtAjxi1rm/IOX07JPr
	 PGcu7syaFd1LMmsaLbVitw/5dkTt3cbSS7ZaV3oUUi9YbFnhPPrfupWxilCwskdc44A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793576888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=V1PNsriSOXNXk9F4i3pS/7KJmz2B+6Azrj9cQd9O7UM=;
	b=EGUU+ILrYHDN9rCA2M1qeTg6PS6oy6zGKhNxSZRYNWe7NiyVBhYx7jwmwJb0nNVRo3UQ
	 Zv/6GLCEVffxbTXHKPYQQ7IBFeAN4YZayvQeFg6Xi1tvpSLxFXf/p5Q+vTKCDDhngFq7V
	 fA+vLWEfti5XvhnTDskxMEm5Oa++tb1f/GgcqL/qt/nb3yl9ODsXlTX9Nh1mPKFeGxA6N
	 Mqbb889dEznkmdNYW/3DFVREjVM1ui4oU9GTiC9rCz/pJOnme94jt2R0St1eUXOkXTyDf
	 da1m+SloOxHmWaqu3HW73+w3JuCFkeqToJHvUzbx/Ljk/RF97mu0B7UISjIKFx9ivrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=layalina.io;
	spf=pass smtp.mailfrom=layalina.io;
	dkim=pass header.d=layalina-io.20260707.gappssmtp.com header.i=@layalina-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2MjKH7O;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF3606A326
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 23:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45FF3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=layalina-io.20260707.gappssmtp.com header.i=@layalina-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2MjKH7O
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso20993955e9.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2026 15:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20260707.gappssmtp.com; s=20260707; t=1793576886; x=1794181686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V1PNsriSOXNXk9F4i3pS/7KJmz2B+6Azrj9cQd9O7UM=;
        b=n2MjKH7O6SY9pxL51xLt1JI7VMyOAtlcscbZYAwKMR25twYjomrrDYMYvQtmiX6b6n
         rUHnef9wUGXE0NaH5d9eD4BusJ1/XQs3FhAkkWu1bMiuVgair81IC/91+723D8lrF7ym
         trBgJaxhCeIIjP+g1kOxHDmzp2lPJvjO7nnI5m76RyUT96JMTOo7F/Ko+8a0Lm6AgpM4
         XEEqZfAUZrY2xQskuFsTYSg+2Nap+3Ya0HfAf1LTPb1zYSwjfxsk8VeA9Ii0caMxoWVm
         dSV/pWlj9X2mDoWtevSTP3FhxwYmakJg4ucn4hJZ1Guq4Ka1kPIUB4KKgcDwYBMfD3E6
         j1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793576887; x=1794181687;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V1PNsriSOXNXk9F4i3pS/7KJmz2B+6Azrj9cQd9O7UM=;
        b=ZF9JLxPI3FAbJhYYLxO0JZjAY84cVaJ+4G+HP7jcDk5ZWaJH4frcJ4H25pDqx27Lh2
         MIPwAfZoJtx3LNTvN+ViryuwzNvZooy/838U6gI701cB5FZZfBu/lJxiD1KjwtJm4zWh
         agB2kDrLw4VAr43Ld8YUeRuIoYWdhLt0CCQnqqu7o0D4QGN4JVAwV6UBhIpkjp46C09I
         lArABhkjB6zm6dbwd9gdLMEMIRZnEywbG1ImJnn7R70nl6hpaw2SM2R9oeo+MfA/laAZ
         2B6NErXDe0M5cj4CimBFGuB9sqg2QHLgDSgW8HlPSJlDXXT5R6CnmZ6okZG2Z9WmFHwF
         UBsA==
X-Forwarded-Encrypted: i=1; AKwUvBxFk4CSlX9jV7c3Sw5L1PLoJtKyoYmtgC3z49XFMcFbhV1tWEX5h8k1X6r8XPzzX1Xho+YxfzlMDA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIAINh5qpRVPwawpvs1M5r6wilNs1VgtN9wJRvoPbNAmZNssTd/
	3vjPuIMmvSERWOQur2pQKvCXdPkzabcqu5YW/dQh5eYqq4kniOeyi8qATuKoBE25ao4=
X-Gm-Gg: AYBFou02toI7vG9K3Feh1esZ20WtvTp3QWoNcpom/evi0HT3U3ANOEPL2vR0M/v3u3v
	1W8eoWM75bWYLTsfw+XTFnx+gd5lLtNEWngDlYtgDXmQQPYvrZczaLctrNa7RVZP8A8quJ28h8l
	5UTkrTyuR8e/oXlJCZrvz8+Mbr98LgnGaepI9xvd7tx2QRY5yQnNnI9eZkGcoQD0NdbQjLcek7j
	4ZF4reqOaojZUouLvMHftjlUVflolX7+AYkvdL6gDgQtFz5xFLZI+F8QpkzTQE5UXuZ8GpFR7ME
	tJn/8JGnO60dcaG/gabnywACj0z7EfWvKeKM8nL9GTGf7U05yh0v35hS7HqmXCLKEFyno0KRHsI
	zhs/vUPuF/zwIcVCtLVo2eYLSS1tbLxbz336Y4zoW45ZmvArc04fYXRQU1ZUGzq6+C6WDpV8Qat
	UqRYOhYBJfSFjbLUcnAjFKLFh0igI+5wwWZcGzF1Qk0gq7M8X8hf8E/ITEacz5tMAWGyzXoTDaf
	WC+yRRYgSm6DE8WqwlknuGfCi3uMvqD3Cca6A8i1QDcAlf1uUd3K+MMAXFkG7S0z/amb4ByS7m5
	d00M9cl1DeQkFYiGgU+EB5a4t/deJWlCFQBzvo7deHyuR4i+Oehd9/bpku7o0hlLzyDN3FUSguT
	/PXVWttQKDLYl
X-Received: by 2002:a05:600c:8b54:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4ac16bc547dmr204281285e9.9.1793576886582;
        Sun, 01 Nov 2026 15:48:06 -0800 (PST)
Received: from [192.168.0.219] (host86-128-182-179.range86-128.btcentralplus.com. [86.128.182.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm300812595e9.3.2026.11.01.15.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 15:48:05 -0800 (PST)
Message-ID: <3228e523-3819-4c59-a523-49b6d381e533@layalina.io>
Date: Sun, 1 Nov 2026 23:48:03 +0000
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
Subject: Re: [PATCH v2 04/13] sched/fair: Remove magic hardcoded margin in
 fits_capacity()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Stultz <jstultz@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
 Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-5-qyousef@layalina.io>
 <20260923065407.3451520-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
From: Qais Yousef <qyousef@layalina.io>
In-Reply-To: <20260923065407.3451520-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 07:54, Zhan Xusheng wrote:
> On 05/04/26 02:59, Qais Yousef wrote:
>> -#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
>> +static inline bool fits_capacity(unsigned long util, int cpu)
>> +{
>> +	return util < cpu_rq(cpu)->fits_capacity_threshold;
>> +}
> 
> This does not hold on current tip anymore: fits_capacity() has picked up
> a second caller that does not pass a capacity, and the new signature
> accepts it silently.
> 
> kernel/sched/fair.c, invalid_llc_nr():
> 
> 	return !fits_capacity((READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads),
> 			(scale * per_cpu(sd_llc_size, cpu)));
> 
> The second argument is a scaled count of the CPUs in an LLC. sd_llc_size
> is a per-CPU int and scale is an int, so the product binds to the new @cpu
> parameter with no conversion and no warning, and the test becomes
> 
> 	cpu_rq(scale * per_cpu(sd_llc_size, cpu))->fits_capacity_threshold
> 
> With the defaults (CONFIG_SCHED_CACHE=y, sysctl_sched_cache_user=1,
> llc_aggr_tolerance=1) scale is 1, so this is cpu_rq(sd_llc_size), which is
> not a valid CPU id on a machine with a single LLC. invalid_llc_nr() is
> called from account_mm_sched(), task_cache_work() and
> can_migrate_llc_task().
> 
> Separating the two uses first makes 04/13 safe to apply. Something like
> the below, against tip/sched/urgent (3cb0243767fd, where the cache-aware
> fixes have just landed; sched/core still has the older mm->sc_stat form).
> It is a no functional change, since x * 1280 < y * 1024 is equivalent to
> x * 100 < y * 80. Built with CONFIG_SCHED_CACHE=y and =n, no new warnings.
> 
> I can post it as a standalone patch if you would rather not carry it in
> the series.

Thanks for catching this and reporting it. I am preparing an updated version and
would have missed this tbh.

I'm happy for them to be split; but not happy we have a new user with magic
numbers :( I am trying to remove these numbers, so seeing more added is unfortunate.

If you don't mind posting a patch to split and discuss the details that'd be great.

Thanks!

--
Qais Yousef

> 
> ---
>  kernel/sched/fair.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 57360f5cdde4..97ce56fcaf85 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1526,6 +1526,21 @@ static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
>  	return false;
>  }
>  
> +/*
> + * The margin used when comparing the number of a process' active threads
> + * with the number of CPUs in an LLC.
> + *
> + * Mirrors the ~20% margin of fits_capacity(), but is kept separate because
> + * fits_capacity() describes a utilization versus CPU capacity relation,
> + * which this is not.
> + *
> + * (default: ~80% of the LLC's CPUs)
> + */
> +static inline bool fits_llc_nr(u64 nr_threads, unsigned int nr_cpus)
> +{
> +	return nr_threads * 100 < (u64)nr_cpus * 80;
> +}
> +
>  static bool invalid_llc_nr(struct sched_cache_group *grp, struct task_struct *p,
>  			   int cpu)
>  {
> @@ -1542,8 +1557,8 @@ static bool invalid_llc_nr(struct sched_cache_group *grp, struct task_struct *p,
>  	if (scale == INT_MAX)
>  		return false;
>  
> -	return !fits_capacity((READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads),
> -			(scale * per_cpu(sd_llc_size, cpu)));
> +	return !fits_llc_nr(READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads,
> +			    scale * per_cpu(sd_llc_size, cpu));
>  }
>  
>  /*

