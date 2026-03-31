Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10313C345A
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943713; cv=none; b=Aa7swnqoRHY5Qxn0G5LQcv1fEXAtCq+p8wIoc283qGuzdTojlnlIYtVCDkNpak3tdfjgkA4Qjmq3dl53y60IYxxayy14OJbex4S+mpW8LE8faXp74iw2O7lhCWSVxVQzaCAPwpgV1WmASZsyJNiuU8syWdgIBoNSoY7dh7VkoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943713; c=relaxed/simple;
	bh=OXqkr2sJvOPPNRiK9t6YT2Ivw2Ja+LmvNj2SMRQ+DYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaohBG/b0j6vPYKeRL+gZuf8ufeAvZq2ABK7QZGUNDjHh5/UBoWPu33lQF559tM8919/YAl3B0yTpT/9qUF62R/ejlMvN2cI0q8ldyf77zkSyX9Rmgry26bPYcRvxddY70Zq0IkDLtdaZk8TD/xFCHaSjILCcem5qN9w2xs/Xio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FMNLAsxQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMNLAsxQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so2668135b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774943711; x=1775548511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYwWMcVK3ge9r4O622lFZ/KcLdtwufulzBb/T8/Dyxw=;
        b=FMNLAsxQFUMt4zApuBevcc2Wrn2OEe13RUfZLp5nmSgriI+Bh2CS2MbTIu9dScDVjT
         luNaTeP1oZ3JRg9LTC25CuyoeG2hk4iuv5gt4dur9fqaKoNNEruKVH66pJwa8ijHzNiY
         UtASyPeFxJLY/Hlx91zZSom4XTu/5d3Pg+u8g5by6R4gSuSOmQToLwrBkMb+UNh5I6ZW
         Mj90+JJV6EU1EOGwO6indybUl6v2F8wRMu2rQqv1eMTlah7W/idFXWqOKYg2W3MMpVfn
         45nMUuYCgn3T7Mi4y4ahwJMnyMK30DGkpO9LNopIo0xQw173o5eHqr6SUSZbiL97h5Zv
         B6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943711; x=1775548511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYwWMcVK3ge9r4O622lFZ/KcLdtwufulzBb/T8/Dyxw=;
        b=HbYPpcc4v9KuYE+eYD7UOocCgqQkAgm1qwH0LYcpWuLO8L5dU4jtLMkaLbcz2fjEMp
         WyOv8gd9OoiEMCGY3J30q/slsCcYj8vAfIrZr+UBbx1N+/fRqluypNm8+iop/3sFjr6t
         h8LOksbmtQrpAI0/xZft4K6QN4ZX5TfiQVzK9NtQ0c8VlmTlWpiJrS2SULaLGALl3FJQ
         JA/MauZe7rQ5T6vW06ElgLgYpwyGBfjMyloYAVHwqefbQVSWqN/gfm+SNRM1oJxqupn9
         RxyDm9fyEm2UYOt364dnG0P+sFoUxCm7isN3qweQa/3FFme74nSDzK3awtnohr89yFWi
         qCXA==
X-Forwarded-Encrypted: i=1; AJvYcCXKZZVHPIPPi/rF63qxYGHZC5kKmOCCKZUiPZi8/X7hfCLMue7m1A8GqG/bYf9BqPjQcqwE5gL6ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RQoxRmDQjgMuEw1Hys3hRTzi9joN/MiBdXzM0jKw3EXS/g4M
	5SU6vGMY1tcRya7QpHCpfqYrM8F1K9yhrE78EYvZ343iFYRoWWiueBT3wzQAg5Ju5xM=
X-Gm-Gg: ATEYQzwTHApjIQLhgA1lcwRuT8xHTKUnS9IEm/RA/FfDaXGyNRqI6Pr6THmg88N0SqY
	MtZllFV/zPBtdf1AAsqLMA1uPCixp0FXjkc2xQbgh/FRqejESjTzrh/KOnZH6bghEbTbA0D6mPG
	BCUY1bC4p7uhjZmFydODzETipzY1FHjMEW0cqZYdIoL/NtH6wJpxagor1qgR3bLzEH0SfeHjf5e
	xwb0/NwKsmSwLWt20oXxPIsyz9YHhdBvkDjaztm/GLDvT4JJCG4dtiyqOo8fYif9F4ftSM1IBEJ
	CRUQMyMzXVSMmpYfV3zhV7VmUwDS49+TxDloJd4b4vLSuyHeo7cRks4CgPCce4vO6R6kkGheWIZ
	KG4cB1Ebs3FrKH/G/jft0ePClA2ucGFs5rJl6BND+HvVZjPIFmnYnjm1Q13ua0VB+nv20FF7Ynr
	mu4OtK1gTDW/o7D4jfp5O6Srpc
X-Received: by 2002:a05:6a00:18a0:b0:81e:d18a:489d with SMTP id d2e1a72fcca58-82c9608f877mr15015380b3a.42.1774943711227;
        Tue, 31 Mar 2026 00:55:11 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d3a8esm9975447b3a.39.2026.03.31.00.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:55:10 -0700 (PDT)
Date: Tue, 31 Mar 2026 13:25:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cleanup dead code in Kconfig
Message-ID: <4qxfqgj7jbjywmkzblf762oamxvb2s6m5b2w3ftq2i72abhmcl@cgtgslih7ric>
References: <20260331074242.39986-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331074242.39986-1-julianbraha@gmail.com>

On 31-03-26, 08:42, Julian Braha wrote:
> There is already an 'if CPU_FREQ' condition wrapping these config
> options, making the 'depends on' statement for each a duplicate
> dependency (dead code).
> 
> I propose leaving the outer 'if CPU_FREQ...endif' and
> removing the individual 'depends on' statement from each option.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/cpufreq/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 78702a08364f..db83f3365698 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -163,7 +163,6 @@ config CPU_FREQ_GOV_ONDEMAND
>  
>  config CPU_FREQ_GOV_CONSERVATIVE
>  	tristate "'conservative' cpufreq governor"
> -	depends on CPU_FREQ
>  	select CPU_FREQ_GOV_COMMON
>  	help
>  	  'conservative' - this driver is rather similar to the 'ondemand'
> @@ -188,7 +187,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  
>  config CPU_FREQ_GOV_SCHEDUTIL
>  	bool "'schedutil' cpufreq policy governor"
> -	depends on CPU_FREQ && SMP
> +	depends on SMP
>  	select CPU_FREQ_GOV_ATTR_SET
>  	select IRQ_WORK
>  	help
> @@ -365,6 +364,6 @@ config ACPI_CPPC_CPUFREQ_FIE
>  
>  	  If in doubt, say N.
>  
> -endif
> +endif # CPU_FREQ
>  
>  endmenu

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
