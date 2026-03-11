Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A938E100
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261746; cv=none; b=CZaLHZWQu20kaHC7BO2ozG0QqVDfHwjjkfMW5RM8M8RfHQU1UfFvoliX/Km/PLJnZPQ+AzNJPU7djN7ymwWeFSp7y+MDWgOjgeZPnfKpKUqYxENIx0sAcW75GxsdrLxc/uxZTNKLRDgmaCcTrBW8CYCHDazdr2y0bE0aYmb9vU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261746; c=relaxed/simple;
	bh=6C9KAVauOsonWe1aHGajOSvY4SwjJL9x2ZE22Eeu++Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I4op2yJdyZ+yVd+xBKBMpaKg4P+PqspCXvUOMTmswUxqMaS5Lpa5PrwIWj3kfx5FttfzA/wVCbYJ/Ky7Erfy6ohPSQXCfq9XFIHi4lPiQamwt4OmElZkEh26JMGm4ngRsNbaYm4roQHhIaAhyErGsVdXgHecPENigiYuvpBZ6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nv50xfeH; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nv50xfeH"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46704fbf62dso235643b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773261741; x=1773866541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0MWD9p+47ib0o1zU+8oNV/mN8dTy/RJSd6vSCsCQV8=;
        b=Nv50xfeH33Sp5HkR/D0YNVsoHxp13eVMcfTTwrorsHMk2+g+0Q7zILFm0OUUGm195A
         9cJmYNaZzPBfytcCaT99hHRXYg7gALW+oMUsthfxtCoLU+y6kp/8CcH+ksSFjVbA465P
         rrqiU1jXmigCX9Vioir0aMQEPDIhv7fubIeMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261741; x=1773866541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0MWD9p+47ib0o1zU+8oNV/mN8dTy/RJSd6vSCsCQV8=;
        b=wocnHhm4ItovXc+v7OP7LdZTJuTn4/YhWf4330s9cRXlrf2VPWkGfOlLJ5U2ppVyRo
         LbHiPGsqrNesp4Wc5+IXqtaM6I8fFgVIuFW4+W1BUhp5o6LSbiuhhIrwP93U0rMcOGgV
         zIZsZL7MP8iFfOgW8zz19QJvGW3eabdBPO3pXQVtwTMu9+YSYTasDtiDky4PYG2XjMP7
         F91GlzGj2DExX2FDzTnL5QWo1HRpsIfmhnUAGJvurLt+3DISI8AUfiLJoiCh0WgRuZ4d
         rPZ/1BZ7jFKxtq4lMfo7CWWwNuyPTL3CvfR5bbX2sva6XzAaCXe4kuDmAk9mEM520+oS
         QO9g==
X-Forwarded-Encrypted: i=1; AJvYcCXdc5GQcIqkYtyZxhpZ++U1iFVrva/PCCrUwhnBoH9KYAz3Q3h94yK1VvFs0wZe9W8B34UW+9HHYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nNHAm5PGaqtAEhYTJfpkMygtWGI4sfZCTRDZDA/GEDOOBwh5
	frAgXA3lBwcy/9sEX90e+oOf48wHRRc817zOZmt0Oxp1iZdwkRpRanfJx0zvx/r5czQ=
X-Gm-Gg: ATEYQzydxl88GWUGcSZVsYs5eAdi69glX1VsIO8axoj2Sd/AKzpE35+YDUpgQcfZAd3
	XQjiWkPiJerDgFPULZn1HmkDoVrbQf+DbbhJtNa0PS7NlD/oLwG86OkwuK2XaJfgbip8id31bKm
	NAGBX5iT9+pFAY2Nr4/BDOY0sw/423jt6XixErPgTI1VGkFKvgqpY1/V4oaHx7NTWwsM7gYmPHW
	IqL1t2QQf9+DNopimJPRXAoVyf7miOFzbimn1uVE1bpo3YfuA8Qw64hW/OFnDGiCM664iTEaa8i
	yP2M0ncNi9St5T4+FsJAahAvEWTTG4SrLmPZZzSujRbljOhNtJS53UeyFXMNaX3SckGuuEDt8DD
	BZZR1xlBdFV535rNyD2tHL9UB/MaDyvvPg6NPul5vVmSGHjIG8geMffwu9rHe5prpUPJdDm8voO
	R3T2isouFpum/1C9uSTXfD+z7HLqxDcthDwoK+hocPLdYvqA==
X-Received: by 2002:a05:6808:221f:b0:464:82c5:567c with SMTP id 5614622812f47-46733547fa1mr2584119b6e.41.1773261740731;
        Wed, 11 Mar 2026 13:42:20 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4673415d291sm1849093b6e.6.2026.03.11.13.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:42:19 -0700 (PDT)
Message-ID: <d7def94c-bead-4544-9208-97e6f0d07483@linuxfoundation.org>
Date: Wed, 11 Mar 2026 14:42:17 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cpupower-frequency-info.1: fix long option name
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <abHAdH-ggaxUugCy@desktop0a>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <abHAdH-ggaxUugCy@desktop0a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/26 13:20, Roberto Ricci wrote:
> The long version of the option is --performance, not --perf.

Okay - I need more than this than the cryptic change log
Include options running the command

> 
> Signed-off-by: Roberto Ricci <io@r-ricci.it>
> ---
>   tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
> index 47fdd7218748..1173d4f31e69 100644
> --- a/tools/power/cpupower/man/cpupower-frequency-info.1
> +++ b/tools/power/cpupower/man/cpupower-frequency-info.1
> @@ -53,7 +53,7 @@ human\-readable output for the \-f, \-w, \-s and \-y parameters.
>   \fB\-n\fR \fB\-\-no-rounding\fR
>   Output frequencies and latencies without rounding off values.
>   .TP
> -\fB\-c\fR \fB\-\-perf\fR
> +\fB\-c\fR \fB\-\-performance\fR
>   Get performances and frequencies capabilities of CPPC, by reading it from hardware (only available on the hardware with CPPC).
>   .TP
>   .SH "REMARKS"

thanks,
-- Shuah
