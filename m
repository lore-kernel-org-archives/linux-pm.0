Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871817;
	b=fjZugyfiIV63mFM7sIlKDWOAwFv67tjjeKyPHY+EIDWEDk9ZlvCAkq93JeQQ6hk2O9Z/
	 hpPVRlrGtGSpIB1OtE2saZAzHRJsSK4HgZQgZMzOtoXiI7HZTu5TITp1UzsEf7OCW84Rr
	 0pHzstxxgu6AbtGpPqCCR0PoaZ0IkIThh/nEddAOS/1NegbypDSNHvCKnowy+93r8OzPt
	 eC+w2eumYAcZz0/4wpy+iZ6Nshvt0Lfb2zhT1M+qGj7cIkuf/tP8mbynQTTsiELeDyV2u
	 aE9+FZEeoAo19CiStxo1f72E27UwoLLOccox5x8tzPtSd0z3ZQIV/L779t4QU5J4EDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8Jvac7JX9KkPIGhfc6fkFsKH/kz8/M9SpUKhnHGt+uw=;
	b=Pxq9MIUt2IJdLGuryvoJDxfUz2OjEz/sTYWdxOgdr0klQ04p+ecFJqfE1FGyE1/6fcAF
	 3qo2JfsJMrlrCEblWDgRxb6wA2t0BERToMJgrdNLapsPRj6XPoBnSv9Kdx/X7pQIm4rA6
	 fyrjWZ8wtrWmbHQzNIgGUwcHJ26GBmR3YKr5T6JAYA6nzSs0ly/knNi4zKh0iymBOEMGT
	 Nq40vipztpxK9ZkCu71m6x7wig9qyWb8ousDUWJdj4OMPEOhae6nuGB4U1cUd/C6NYe2W
	 28PwA52J6vRWTE0gz5HwASKkK0ozE/Qy6DwKHAyztqwtix6MoeXLVxWoohMhSxXmKfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=OBqfboG8;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DCE606A32F
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 23:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99DCE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=OBqfboG8
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-48ed0b68895so3114512fac.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 15:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794871814; x=1795476614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Jvac7JX9KkPIGhfc6fkFsKH/kz8/M9SpUKhnHGt+uw=;
        b=OBqfboG8yfgrjuTaEKrp2coI9OBrM/b6NybUkYZSEaanNfbvkjungjo6R+ITq7MkWq
         POiKAO+st9W9FJs++7oRlJuiU8VQBoh3JG5Qd/qiHP492Us+8Nzm5Nh/wy6GTQFcUMAJ
         s8rJoQuTHyoBxxue3mjfxIbQ4AXN49lnfNTlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794871814; x=1795476614;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Jvac7JX9KkPIGhfc6fkFsKH/kz8/M9SpUKhnHGt+uw=;
        b=Lqmq/8NT2bt5Fw01Ld927rd/fjSuY6dHuTeLVsAp+Iq1yv3qP4wEjR/j7zfkwlDFTQ
         kl9ebShylI3wHkJejkpUMaNlOa5SMlMyO1ZqiyFxss9z0eKTa2Vfa+BTBnnY/6MQt1Se
         k4Q1FAv7M+gUb6SgtCCUq+E1RbHcmJCsBKgMKe9OH5UCDacd/cDOkdDS5w56pcyxeRQb
         ca+uyQjFaqSIOVNS1XNTLHLLdZrq7gVPnoTps6/rKardVadHM1ojlyS9h1Sc8tIGcDU/
         CTZ9+mRH5+luxf6XAQin6ugyh3sXJXFIqgncTXurEmCYBjDfLRgCyx53B0tcl4YWR1TW
         8iRg==
X-Gm-Message-State: APuU4Z8v/H8IIKhI/ZUsu2x6coTRRLIRjfx47CrOgT9RXuZrkRRv8pTz
	+wSvXCkNQjJYCynGbZWNpNNih7/599M3fgdR+1DwtPitUoqLoV6+SALNgPbB+D3tM9/ZXbSaVem
	CoxTBqeo=
X-Gm-Gg: AYBFou3G6t+cIDr8V00bYaDzSYhMToa9V6HNItgcC+rS20m49fDPCf118NPuz0106N1
	oEirE9qkxcpzQFjaCk9mV7Wp/EkE7rOMnNmRQHZb935bFvGGtbxdSo6C8fbC01Ad7YH+zPIwhtP
	2ptFzJCmzOrtBlAm9nBQMinjyw9OY7k6MJQaKIC/XSfvtybV42pwJGFjOS3CF8qNWgU/A4eTjwE
	SVDSfPx9QmhY96l3syLrABY49m2wAV2fJVwiWTJRhGsomxpM4GB+Wc3+X2Q9Ps+YrHn6LknO+PH
	VMfLOlaSiW4gruYJb/vZCB7kBBgFFrqpZmqwC84xRUSs5fSUSQwqQZClOwTmRj/CDcA4JUpA+/y
	MpcX2utECI0ind6P/aG/J7uMe27Yk0B1R0iUmB8OX4vgHWfo9pZDXv0YfdOxddJjOLOKzDRIVls
	x7HCvUYiFJKGqEMQLDJ/OAoiKJbPRJImfy7TEU697BC1OKWv7ic0T9r3c+BS0zHPNpfkihSQ4mW
	9EyjzQOJ0kHRPTD4WKPHr1LQA/Q5Jg5yrTUBfyWdLZJkKNM2Zw2GzozPe4a7ksxNTkeRsTz0yu/
	8ELZwqUTKarfzlLZuFxlkI5eLhSloa1ahZKkPw==
X-Received: by 2002:a05:6870:c08:b0:4a6:f705:25a with SMTP id 586e51a60fabf-4afdf497cfcmr9471729fac.21.1794871814468;
        Mon, 16 Nov 2026 15:30:14 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2288f59sm7859996fac.9.2026.11.16.15.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:30:13 -0800 (PST)
Message-ID: <94e8f3c9-5162-4717-8063-f5c2b4828456@linuxfoundation.org>
Date: Mon, 16 Nov 2026 16:30:10 -0700
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
Subject: Re: [PATCH v2] cpupower: fix use-after-free and stale limits in
 frequency-set
To: Lukas Beckmann <lbckmnn@mailbox.org>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 03:03, Lukas Beckmann wrote:
> do_new_policy() directly fills the unset fields of new_pol from the
> current CPU's policy. This is problematic because do_new_policy() is
> called with the same new_pol for multiple CPUs by do_one_cpu() in the
> slow path. This results in stale values in new_pol being applied
> (starting from the second CPU that should be changed), and even a
> use-after-free (for the governor string).
> 
> Fix this by building the target policy from new_pol and the current
> policy in do_new_policy() instead of filling the missing values into
> new_pol.
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
> ---
> Testing and minimal reproducer:
> 
> Running the command
> 
>      ./cpupower frequency-set --max 2500MHz --min 2500MHz
> 
> with ASAN reports the use-after-free before, but not after the patch.
> 
> Run the following commands:
> 
>      # set CPU 0 to a different maximum than CPU 1
>      echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>      echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> 
>      # Change min and governor (but not max) of CPU 0 and 1
>      ./cpupower -c 0,1 frequency-set --min 1GHz -g performance
> 
>      # See if max got changed
>      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
> 
> This shows that the stale maximum of CPU0 is used for CPU1 before the
> patch, but not after the patch.
> ---
> Changes in v2:
> - use a shorter changelog and testing section
> - build temp_pol from new_pol and cur_pol instead of copying new_pol
> - Link to v1: https://patch.msgid.link/20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org
> ---
>   tools/power/cpupower/utils/cpufreq-set.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index 06cd4b280132..674e3aabd31d 100644
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
> +	struct cpufreq_policy temp_pol;
>   	int ret;
>   
>   	if (!cur_pol) {
> @@ -151,16 +152,22 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
>   		return -EINVAL;
>   	}
>   
> -	if (!new_pol->min)
> -		new_pol->min = cur_pol->min;

Why can't you leave this logic as is and set temp_pol fieds,
  if (!new_pol->min)
	temp_pol = cur_pol->min;
  else
	temp_pol.min = new_pol->min;
> +	if (new_pol->min)
> +		temp_pol.min = new_pol->min;
> +	else
> +		temp_pol.min = cur_pol->min;
>   
> -	if (!new_pol->max)
> -		new_pol->max = cur_pol->max;
> +	if (new_pol->max)
> +		temp_pol.max = new_pol->max;
> +	else
> +		temp_pol.max = cur_pol->max;
>   
> -	if (!new_pol->governor)
> -		new_pol->governor = cur_pol->governor;
> +	if (new_pol->governor)
> +		temp_pol.governor = new_pol->governor;
> +	else
> +		temp_pol.governor = cur_pol->governor;

Same for all of the above. Make just the minimum changes
to fix the problem instead of changing the logic


>   
> -	ret = cpufreq_set_policy(cpu, new_pol);
> +	ret = cpufreq_set_policy(cpu, &temp_pol);
>   
>   	cpufreq_put_policy(cur_pol);
>   
> 
thanks,
-- Shuah
