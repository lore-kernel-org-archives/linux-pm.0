Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50D3BFE34
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544479; cv=none; b=GYqVVWQC93/aeDlOceKpjMcWQL99coKOpyupQsT/lGvJ09D9U1NXcOWZqaLcVzfsHzTdVQL9P44bnOAq3U2CWObfo1WNLifu63NvATVfhG3qd0gcZx5NhJAuFepUCehrrVgcdaKuSQFtlDySko14q1014Cnk6BwKbskZY6uERGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544479; c=relaxed/simple;
	bh=EjQj2LS0JNyUic2hcCxEF400RxvSSgR2RMKFB+bwmO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPzQ20pUIwzYLLxIUpHJ2eUZwnR8rBtInSLDeSCYegOLr9ocHmd/LVYdJ5MtGYG7JNpITjW1vqOyeQSskaQvhB+AHx/rPJA7MAhqv6TSd+JjWb09m+HHVFnzLHnD54fDZrow4REQVVwQ+q1M3U8grzsSph0HG0NMEP0AAskq3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VYoFjNaV; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VYoFjNaV"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-497e6956acfso1207124b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788544477; x=1789149277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sswBzQfsCyKYg2+YC2ZCiHjV592pYawy0eyNgxUcAfc=;
        b=VYoFjNaVBHsVGKsuPz378EzHq6+F9r9rtq2n+9NftMpFSIRDlbUl/pZyJyUU532zPH
         /AUeTM14qNkAunLuUghnRxYkevoeuQ8NithBW9ZbwDIUIEHrTrGYHygEASXwfNNuzYxy
         adkaCUTy3v9G6ebKCMKjzgQdu4vVo0ib9KXn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788544477; x=1789149277;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sswBzQfsCyKYg2+YC2ZCiHjV592pYawy0eyNgxUcAfc=;
        b=FeBBrrWB8sAxYzQr2j6xzuu30Zl56gk8dp3NnLwx6BJUAz0ZdLmyLxYi0XvcgQZPIO
         7zqH8zVbwROmtKHRNsWm2iH/IbhS0Skfc95zj0uAaappj38OLyxziuyfNJIszS5V0pDq
         rBIoJC7ETmdptkndrA53Q6VCWEJWNEYog6zaxh7OlzPl+LP8o2ccwNC+b3C8ROMnkmE4
         v1bFuHhuQ/or56WBbJGPwklF3cq6V+U3BkSnYTLQxeSrKOl+vlRm5wYDFUeyWRABfCZZ
         c1boVF//vqjRAQusR7mEStqgms/rFLeObKhZ1dF2IUblmRRBH11eV52SyQVNPWDOexuX
         zfag==
X-Gm-Message-State: AFuF++nQ3LSY4LWlXvNAVoUF2nl18hZtiEWTSoyT1o+K68WN/ly3m7Xx
	/76wQZpNQE+6CzvxduLoMS9Q+yWtx6Ibyn7LQQ+SIwGmtFmnN6EXTonHZSFndFOalOg=
X-Gm-Gg: AYBFou2EKtyZBTq/UWDcQbuyVdwmDfa9SXomS2E8UVEAht6BsQVYJKaZDa3Ys+zIuIR
	44ZDdmgfbEzzQRxL8FLLjOo/jAy7li2kWirocdjnobTUQdSKKwj85hOqpJK6ITrUi82OEmJTYMm
	3frMUjFwT/t+BKDdhOixpo4asC6LvIq0jq4X+7CDhy07e1TUYPPW34cukjGcrKhyCfu5oXv3atB
	q1ftgo1skavQ1KX9ROw09zkoZkBzPozI95W7qM4QwZ/HLVnsTAFlXhc+fcItM0Crd/7Uokg46AC
	6obI9kJSbUhxI0MhKoOQ8KiOlBj6uywtS+hyo1cxYQth4sNOWd6GKDQk4nIT/sn11nU6wkggcXi
	UhfY+tch1oJD34193Kg/Ee4MDT5HjxYLLTZ4OVCbbxLs3c2gwTtGP2uInDZfWeQcImfaVQIZ4RO
	S5ARXXaGJhRjVrjN5SPJmCkyMINJkhiCoHxFCOCKjFlI10EDH1TiD4BZ0NPo2jq/Lk+RKLXEt7K
	x6P4cm/YX8=
X-Received: by 2002:a05:6808:5387:b0:4ab:224d:6dd6 with SMTP id 5614622812f47-4b7deda428bmr6794706b6e.15.1788544476511;
        Fri, 04 Sep 2026 10:54:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1ff95sm2596901b6e.6.2026.09.04.10.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 10:54:33 -0700 (PDT)
Message-ID: <aa803d8d-25af-48eb-bc6d-2476fc795c80@linuxfoundation.org>
Date: Fri, 4 Sep 2026 11:54:31 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpupower: monitor: Show how a counter value is
 exported
To: Hemanth Selam <hemanth.selam@gmail.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260818095538.1196953-1-hemanth.selam@gmail.com>
 <20260818095538.1196953-2-hemanth.selam@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260818095538.1196953-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/26 03:55, Hemanth Selam wrote:
> "cpupower monitor -l" lists the name, the processor hierarchy level and
> a description of every counter, but not how its value is exported. Some
> counters are a percentage of the time spent in a state, others are
> absolute values with their own unit, for example the Mperf "Freq"
> counter reports MHz and the RAPL zones report micro Joule. Both cannot
> be told apart from the listing.
> 
> Show the value type behind the hierarchy level and document it:
> 
>    [%]   The counter is a percentage of the time spent in the state.
>    [abs] The counter is an absolute value, its unit depends on the
>          counter, MHz for "Freq" or micro Joule for a RAPL zone.
> 
> Before:
> 
>    $ cpupower monitor -l
>    Monitor "Mperf" (3 states) - Might overflow after 922000000 s
>    C0	[T] -> Processor Core not idle
>    Cx	[T] -> Processor Core in an idle state
>    Freq	[T] -> Average Frequency (including boost) in MHz
> 
> After:
> 
>    $ cpupower monitor -l
>    Monitor "Mperf" (3 states) - Might overflow after 922000000 s
>    C0	[T] [%] -> Processor Core not idle
>    Cx	[T] [%] -> Processor Core in an idle state
>    Freq	[T] [abs] -> Average Frequency (including boost) in MHz
> 
> The time granularity part of the ToDo needs a new cstate_t member every
> monitor has to fill in, keep it noted.


> 
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>   tools/power/cpupower/man/cpupower-monitor.1   |  8 +++++++
>   .../utils/idle_monitor/cpupower-monitor.c     | 22 ++++++++++++++++---
>   2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
> index 89af019f8dc4..c8008919627c 100644
> --- a/tools/power/cpupower/man/cpupower-monitor.1
> +++ b/tools/power/cpupower/man/cpupower-monitor.1
> @@ -51,6 +51,14 @@ coverage in square brackets:
>   .IP \(bu
>   [M] \-> Machine/Platform wide counter
>   .RE
> +.IP \(bu
> +How the counter is exported, in square brackets behind the hierarchy level:
> +.RS 4
> +.IP \(bu
> +[%] \-> Percentage of the time spent in the state
> +.IP \(bu
> +[abs] \-> Absolute value, the unit depends on the counter
> +.RE
>   .RE
>   .RE
>   .PP
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index e8b3841d5c0f..376a1e30653a 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -269,6 +269,20 @@ static void parse_monitor_param(char *param)
>   	avail_monitors = hits;
>   }
>   
> +/*
> + * A monitor exports a counter either as a percentage of the time spent
> + * in the state or as an absolute value. Tell both apart, so that the
> + * numbers a measurement run prints can be interpreted.
> + */
> +static const char *value_abbr(const cstate_t *state)
> +{
> +	if (state->get_count_percent)
> +		return "%";
> +	if (state->get_count)
> +		return "abs";
> +	return "?";
> +}

Way too much complexity to do this.

> +
>   void list_monitors(void)
>   {
>   	unsigned int mon;
> @@ -284,10 +298,12 @@ void list_monitors(void)
>   		for (state = 0; state < monitors[mon]->hw_states_num; state++) {
>   			s = monitors[mon]->hw_states[state];
>   			/*
> -			 * ToDo show more state capabilities:
> -			 * percent, time (granlarity)
> +			 * ToDo show the time granularity of a counter, this
> +			 * needs a new cstate_t member every monitor has to
> +			 * fill in.
>   			 */
> -			printf("%s\t[%c] -> %s\n", s.name, range_abbr[s.range],
> +			printf("%s\t[%c] [%s] -> %s\n", s.name,
> +			       range_abbr[s.range], value_abbr(&s),

Find a simpler way to do this instead of adding a new routine.
Hint: you can check it right here.

>   			       gettext(s.desc));
>   		}
>   	}

thanks,
-- Shuah
