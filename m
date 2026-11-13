Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611371;
	b=qZAW+mXQtWen7FUnCNiVPbMvDLl9TvxncSyvBZPjVtwnrtWsFXLzk0+uZ8qA/Rx6/szj
	 d6a0eFuJQCx04nd2abWXD55lY3gLmzLdSf+WIzT8v0n1OPkHRz+py11IExGuHHYDKuxOF
	 SzFkElOVeLioaGPS1qBRS7b9UR+87pOSkJwLeSubIxrtDGIjguzqK1FRDjbW2PhBzHt2I
	 oIwgRij0npiOb9UY0h0UvJDaSiuW+7tPtTwW+/oiRF+HaA2CBWopkM8k70+Aa2Fd+T5L/
	 3Fg5NwWBQjy2LLDdFLwEaSEu2BxVuOlVKgiAlbKrimm1y3KeO5mgTG51J3cnA3fiRLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fB0t+BHdm8gquUsqjkMApis458GyXNfzybJEV2rTreg=;
	b=1VsArIcBOb7MYyPKC+0dhf5sxcdnfkCaEbB5tdr19a5jM61y46W1dUaZfFAGXBywYv15
	 EgZVeriAeyil1DZLnTJmzARh8Rt2Et1S0xMhJDJRmPLGeFtIT9lBH0zlOPpEhfeIQSFTH
	 8Me2PLkzR/I3zuL/4yXThQV9owThm4qqSaLAjkiIcGg92SAaDdcAWiZzIhKmnQUKPI7N2
	 VsqrCiSTcF4HLkkNDVC6FI44YRR2bkeS8JOEJwhhEIJygsXrBDdQ8ewyU1tbAuzgMvkCT
	 ZK3TTc/MWsbwyamLWqWJ+KE4Gool35/x+Pgk4th+kT11QBYD2DcABbf7LKoOtXhEkVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=K7YvMn41;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A3606A88F
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 752A3606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=K7YvMn41
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-571eb508ebbso12473b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794611366; x=1795216166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fB0t+BHdm8gquUsqjkMApis458GyXNfzybJEV2rTreg=;
        b=K7YvMn41KR6tVPwBeJl91RFDq29ZYp/ZlzDyqPQCS2X+nfer5MYiNrnPHp1Z58Jd9r
         3Q0xPLOugNSX3jQfPiiF2UnhssorwnbShaj20/BFNP+Dj9emq9QAB+h9RI7Jr+qRNIj7
         KjpCq6QmkuLc/bFVP9TJduftQv+0z4nyf/N2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611366; x=1795216166;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fB0t+BHdm8gquUsqjkMApis458GyXNfzybJEV2rTreg=;
        b=Kqo/NK4t9/aQYSgETDKgoyUdHY6wGFhGDFrtAKP6Z4FOliPbgpoKJNmBoZg7FP804G
         0mO7MEuvPPf/4XQO1yY0j346SPu/oey34vpodI/Y9uoNBYxJXQMWLCmCI20vjFrMA5d0
         JOIZY1uKCcNKrGluI96bAnNuOPq2qrbKRulNDzqv6iGzuiqs+0AFPnacfbH2yTTKim7C
         TtcMhRMrdO8jhLg6DiKyOKGDuHJ8Z7Lwl7kPDdHnjED2gSVZ43aAYGaUl+e9XBydH5Ck
         3hdvIcjwP3OL69usWiCQtD94+WfUCO8xNvSvCb3QZhWihPtw33gZuaVUZX8KR5v+Ahip
         nzzQ==
X-Gm-Message-State: APuU4Z89Gga6EgfN7hSZOYN7Rpxxl7DskmbuJJ60ceiQ7xSzKu7/kEA9
	+z4qC4WuZzugpnpMhAVSf4by3bX7XC48LnQYF0SDsZ1wMLruHz8VXpsPQE4qglxSOzk=
X-Gm-Gg: AYBFou2Lh23oHu8Hd2WNQVRAGC/zXHBa2kQrsOQymVZ9oDnFnPY+i2fYTik9JMFPb+p
	l8fb1EMQw0qIRVBNLzAOho7monn45vAW7L2miWbm7bRDHIWKKAhi5VwsOJ2m9pgnyxbKErxiF77
	PgoW6faJMkKHT8Q4Xx+hpE/70dmlu0GEM2blE+FlQU5tJ5tntqj2dQ3tk8OAGA5D5uVa1xFdMbz
	LqhG4vG6zKXB0eWR3mkiUm9JlnaxEBF3zVt+kd9vhnh18zHYJ+TJUWWbX38TX9SmK/2why7J/Pb
	yG9S0MKxL4g75BwpdqkGiDVNlhE7q+w/Cydu7cYcaYI1p3ciNc0VzSkX0LcBAEAjji0oUZ/Ll/4
	qCW58Nd4Wn9xPdXQq19V2HuvQXgyeNodfadxpZvQ9LfpfaHU6TSnLXfNWHXfmn9vmN/hL8sQNUg
	p4zXDsGMDe60lqFthufsBPmjU1vW7U3dWAdF0i/4jSWJUT7qCOIpY/SDJKPhrEtlgXU+iJcfVMv
	xLygZiStRIDSw/OheJw+p/Nhj7WuDUp+/Kwaec5Z++tAXpPfXiNIQANcy3n2z9B+XdnOOlYZ15a
	YvmKc++fZYL2ZriIf8lLf26PmsrIWJEWmp1yBQ==
X-Received: by 2002:a05:6808:3505:b0:536:611a:7fd9 with SMTP id 5614622812f47-56e6015e8cfmr3238393b6e.7.1794611366089;
        Fri, 13 Nov 2026 15:09:26 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6dcfcf4esm3285492b6e.2.2026.11.13.15.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 15:09:25 -0800 (PST)
Message-ID: <1bb7b407-0e69-421d-8ee3-81489abd1dda@linuxfoundation.org>
Date: Fri, 13 Nov 2026 16:09:23 -0700
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
Subject: Re: [PATCH] cpupower: fix use-after-free and stale limits in
 frequency-set
To: Lukas Beckmann <lbckmnn@mailbox.org>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 12:49, Lukas Beckmann wrote:
> cmd_freq_set() currently has two issues:
> 
> 1. use-after-free
> 
> When cmd_freq_set() is invoked with --max and --min, it eventually calls
> do_new_policy() for every selected CPU with the same cpufreq_policy
> struct. do_new_policy() first retrieves the current policy and copies
> the governor pointer to new_pol.governor. After that the policy is
> applied and cur_pol (including the string to which new_pol.governor is
> pointing) is freed. For the next CPU, cpufreq_set_policy() reads that
> already freed memory leading to an error message (because verify_gov()
> fails).
> 

> 2. max/min is not retrieved for each individual CPU:
> 
> If cmd_freq_set() is invoked with e.g. --min and --governor, max is set
> by do_new_policy() on the first selected CPU by retrieving it from the
> current policy. Since the same struct is passed to the next selected
> CPU, it is not retrieved again, resulting in writing the first CPU's
> max to all selected CPUs.
> 
> Fix both issues by using a local copy in do_new_policy().

Good find. The change log is rather long and confusing to follow.

> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
> ---
> Testing:
> 
> Issue 1:
> ASAN run of the (unpatched) cpupower example:
> 
> ./cpupower frequency-set -d 2500MHz -u 2500MHz
> Setting cpu: 0
> Setting cpu: 1
> =================================================================
> ==386949==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c17340e0350 at pc 0x7ff73559241c bp 0x7fff5d8114a0 sp 0x7fff5d810c58
> READ of size 2 at 0x7c17340e0350 thread T0
>      #0 0x7ff73559241b  (/usr/lib/libasan.so.8+0x8841b) (BuildId: b8a4241051a1621937fdc46e867ba7ecb56d96ea)
>      #1 0x7ff7353cb475 in verify_gov lib/cpufreq.c:585
>      #2 0x7ff7353cc0dd in cpufreq_set_policy lib/cpufreq.c:631
>      #3 0x55f590fb79ab in do_new_policy utils/cpufreq-set.c:163
>      #4 0x55f590fb79ab in do_one_cpu utils/cpufreq-set.c:192
>      #5 0x55f590fb79ab in cmd_freq_set utils/cpufreq-set.c:327
>      #6 0x55f590fb3ee6 in main utils/cpupower.c:235
>      ...
> 
> 0x7c17340e0350 is located 0 bytes inside of 11-byte region [0x7c17340e0350,0x7c17340e035b)
> freed by thread T0 here:
>      #0 0x7ff735634e91  (/usr/lib/libasan.so.8+0x12ae91) (BuildId: b8a4241051a1621937fdc46e867ba7ecb56d96ea)
>      #1 0x7ff7353cb8ef in cpufreq_put_policy lib/cpufreq.c:283
>      #2 0x55f590fb79b6 in do_new_policy utils/cpufreq-set.c:165
>      #3 0x55f590fb79b6 in do_one_cpu utils/cpufreq-set.c:192
>      #4 0x55f590fb79b6 in cmd_freq_set utils/cpufreq-set.c:327
> 
> previously allocated by thread T0 here:
>      #0 0x7ff73562efce in strdup (/usr/lib/libasan.so.8+0x124fce) (BuildId: b8a4241051a1621937fdc46e867ba7ecb56d96ea)
>      #1 0x7ff7353cb1c8 in sysfs_cpufreq_get_one_string lib/cpufreq.c:156
>      #2 0x7ff7353cb845 in cpufreq_get_policy lib/cpufreq.c:262
>      #3 0x55f590fb7a4f in do_new_policy utils/cpufreq-set.c:146
>      #4 0x55f590fb7a4f in do_one_cpu utils/cpufreq-set.c:192
>      #5 0x55f590fb7a4f in cmd_freq_set utils/cpufreq-set.c:327
> 
> Running ASAN with the patch shows only an unrelated memory leak which
> was already reported in [1]. I can fix that in another patch if needed.
> 
> Issue 2:
> Minimal example without the patch:
> 
>      echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>      echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
>      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
>      2000000
>      3000000
> 
>      ./cpupower -c 0,1 frequency-set --min 1GHz -g performance
>      Setting cpu: 0
>      Setting cpu: 1
> 
>      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
>      2000000
>      2000000
> 
> The maximum of CPU1 is set to the one of CPU0.
> 

The real issue here is not that the maximum of CPU1 is set to
the one of CPU0.

The real problem is that stale new_pol is used for all cpus
from do_one_cpu() slow path when more than one policy value
changes.

Please re-write this in your own words in a simplifies way
describing what lead to the problem.


> Minimal example with the patch:
> 
>      echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>      echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
>      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
>      2000000
>      3000000
> 
>      ./cpupower -c 0,1 frequency-set --min 1GHz -g performance
>      Setting cpu: 0
>      Setting cpu: 1
> 
>      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
>      2000000
>      3000000
> 
> The maximum of CPU1 is no longer set to the maximum of CPU0.
> 
> [1] https://lore.kernel.org/all/20250827-power-memoryleak-v1-1-e4baf7b59a41@uniontech.com/

The above patch doesn't make sense. I need more information
to determine, if it is needed.

> ---
>   tools/power/cpupower/utils/cpufreq-set.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index 06cd4b280132..d9f6ca522fe5 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -141,9 +141,10 @@ static unsigned long string_to_frequency(const char *str)
>   	}
>   }
>   
> -static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
> +static int do_new_policy(unsigned int cpu, const struct cpufreq_policy *new_pol)
>   {
>   	struct cpufreq_policy *cur_pol = cpufreq_get_policy(cpu);
> +	struct cpufreq_policy pol = *new_pol;

Don't assign new_pol to pol.


>   	int ret;
>   
>   	if (!cur_pol) {
> @@ -151,16 +152,16 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
>   		return -EINVAL;
>   	}
>   
> -	if (!new_pol->min)
> -		new_pol->min = cur_pol->min;
		pol->min = cur_pol->min;

Use new_pol in the if logic using pol as temp - changing
pol to temp_pol

> +	if (!pol.min)
> +		pol.min = cur_pol->min;
>   
> -	if (!new_pol->max)
> -		new_pol->max = cur_pol->max;
> +	if (!pol.max)
> +		pol.max = cur_pol->max;
>   
> -	if (!new_pol->governor)
> -		new_pol->governor = cur_pol->governor;
> +	if (!pol.governor)
> +		pol.governor = cur_pol->governor;
>   
> -	ret = cpufreq_set_policy(cpu, new_pol);
> +	ret = cpufreq_set_policy(cpu, &pol);
>   
>   	cpufreq_put_policy(cur_pol);
>   


thanks,
-- Shuah
