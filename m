Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913604;
	b=lqNjLFggAlnvPV3Q4JH5Q/x0veGEPTDT5bEklwAcssY24h9Cp+6+ckIrulOO/FQpTb9y
	 uAwebIfNiuu6taU7YZYWat6m0HC4owqmoI4ZKF4S8vx0DGhfaCrALqOvRoNZWqpgRHE2/
	 bHpuY4EN1WBZXtcbWiF+wdFUGZ1Nn90OjGeFEz1u7YGYApw+9YhCBRU7Iaxma51jfn6m6
	 cAfNHcWgWTPPz9RsyyvyWd8rmfu8vjNCXoLztEDbbgcBL+JOtLpqqn4OSeX7/Qr0MDFUl
	 fWrGUzl/LHPuqlTiotdnt6taOZMUsl21YfGNdbLFwv8YQGDAbrTjBTRrebOkiD/koCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=n4s7yJbpQX8syBD03XjGhRC32jwUYZoWTRv+UwUgeKs=;
	b=WQqnAPCeWBJcRNzn4jesFGTei7HJXMfon3nF5/gXkVKA+Xe4Xj1cXeZ37gNxBqhnk4L/
	 LTkHvnTbCEuibiJ4KVLXN7sKK5b8LXSoYjEr625Wvb8oOOfAUDVA5s17J9LTwA2AVhA30
	 ZPo5rpl/VIklXccFkTGPmCvDbMn7Y0GtEH7+G3YGaqZlMaaaJgfEIjA+88UzpzooBxvrh
	 zj3lxstTnTPskTY0D8GCDPTkovEtWAuZe6oeztIAi4kckl2zRrUWRJemvDm1GrKRwy2Jo
	 sRBlOQ3kPaK0l8ioT7R+R27yHtpiJnX683pQFTI4NRx5jKKK2SKMBURJgeN9JOed2Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fZGLg0sl;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F7606A323
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 11:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5F7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fZGLg0sl
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a3c08d6928so6265918c88.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794913602; x=1795518402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4s7yJbpQX8syBD03XjGhRC32jwUYZoWTRv+UwUgeKs=;
        b=fZGLg0slbOqiT/LgH+j+6JL3838bVPAZoUKYPPR5vYSOWvED3b6bDzIquyykaT1Qt9
         qzL9aHijplMBTNi2OHnkxnadG0EjX178DfCzHuh/SK+NOn3HKTIeU9nfMJh/6Y4EPHni
         TCC7eKQIZ4lalbs6xnkiO5YYdzm6e5vCLLy9LwPHc6oWTnrfY0lGrv4FB/xLEEQciJQy
         3VO/z4yzqoulFpi7H02jGqebsvBXp60V0EBEVyl4i8b+CazGVgBJOCihUwOVTgqszfsZ
         rim7Jdpe748KgiWtnsG5GLdr7ao869tjNHgOGaKyf10CGcBr0uMr8KgYWvV+mUYWI/4v
         IQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913602; x=1795518402;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4s7yJbpQX8syBD03XjGhRC32jwUYZoWTRv+UwUgeKs=;
        b=xBKP5yOu+0DFt7wBgqLV2UwZmKtgruvJUT7mXL7bZz+y0TJXLTpGSP0mVAstUEWjQP
         Sv+vQb6CNr3qSi2bg4OtT+Fg2FrHVL+JwW7SLpspDuwggGchWR4Jj7PtIshce8RpmBjr
         lUtxYzKgtO+5WqgoJiaMj6HMbyOGOAnNQmf/XPZ3paX8EiydMPxw0BqP3WWozxIMzHPp
         A9+EeyurWkYyBWX71R4lHPRRh5W2f2O4IWiVDyeOSoB2rwC+riFYdAxi6v7u107w/CJR
         mfnOJ+ZfD3/MqoyWF8QVkhDxM74SjfasFfxhAHgAFoVbxL7pWWRnstM4YmLz+oDNyw7w
         IE5w==
X-Forwarded-Encrypted: i=1; AL+hErGiR2zkjPDzzUYs05/dBnjtvntV8EYx3MOxsuhAy1/d+ZH5Qmqi4vrQUcDo3hHByOftFhnYtStmbg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OsF7kfu5NNY2YURXWFpkm1ncd3cPTJ3WFmvIvrJ1/WQfZO7n6
	RF5+hUAoB+oSJG0TzGk2Kb35CLnVwZ+VOXkJ4d5BExJ7ShYPw5LxhBLLVN6JkX9l9Xo=
X-Gm-Gg: AYBFou2FYPPENLVf5IULpNDsgKdV2/5O1SuL8nSzC47QnFOQgmQdahRU7KbjbAsZlg7
	vFXwHPd9uszbPSW5XQ3Qpx0CZfnYWbuauHHHuH49eundYurjxU7ObVWp0Jf9jWr6AfC9W58NSbF
	5QDdUndXogfPCjTTpB3miCCOhpmoEJvQcFPFD+FzwDwTNTS8zE2brP+7ZEDOLyeInJuogRwQhDO
	Eoe/Vtjl1/ursAOuxvLeaJ+0fVZlOnlTSKGKrCisYcjpcR+g8lvB3SaC8uqFPRtOzqahNO/6a5R
	Ha3CO59pqTF8UUHdSK9LptZksGC8OJ+5FHJSkfmLUrjhKLHtO1FWkxLNUfQQDDsJzyQT4KulLoy
	tmh4ZZBjiEES6YnLzRwjQUqhdCnBiG8ejUcK4sCaLVRuax2EalYCJxrE6gEkIWRqnPsRTEZnz8r
	W/CvEpG35YSJ7uh8Plju+dDXhGR8NnLvJLllg0RtZRcFpgP3FPeHNXwXVm5ZnkQim/2XqxCDxfD
	bns1OnuQjBjKAFifd/cSniql2jV81T9QwdSj9Dp5aKScmhbYbwDiegAdXRGZwEEgColQD1MfiSk
	EzWVdHPYaEBWOeeBXpnzZeO1Qzy7YA==
X-Received: by 2002:a05:701b:4188:10b0:154:fa0b:6df1 with SMTP id a92af1059eb24-1b5030fb7f2mr12989338c88.37.1794913602124;
        Tue, 17 Nov 2026 03:06:42 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm39194951c88.2.2026.11.17.03.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:06:41 -0800 (PST)
Date: Tue, 17 Nov 2026 16:36:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Milan P =?utf-8?B?LiBTdGFuacSH?= <mps@arvanta.net>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Shuwei Wu <shuwei.wu@mailbox.org>,
	Aurelien Jarno <aurelien@aurel32.net>, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: Set the initial OPP to apply its voltage
 constraints
Message-ID: <avw1Pos5Je8piwvU@vireshk-B250M-D3H>
References: <20261111130430.10359-1-ncopa@alpinelinux.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111130430.10359-1-ncopa@alpinelinux.org>

On 11-11-26, 14:04, Natanael Copa wrote:
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index eb15650f99bf..2646dda10aac 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -153,6 +153,30 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>  	.suspend = cpufreq_generic_suspend,
>  };
>  
> +/*
> + * Set the OPP for the current clock rate, so that its voltage constraints
> + * apply before any policy can change frequency. Otherwise another policy
> + * sharing the supply could lower the voltage below what this one needs.
> + */

I think the problem is valid and must be solved somewhere.

> +static void dt_cpufreq_set_initial_opp(struct device *cpu_dev)
> +{
> +	struct clk *clk = clk_get(cpu_dev, NULL);
> +	unsigned long rate;
> +	int ret;
> +
> +	if (IS_ERR(clk))
> +		return;
> +
> +	rate = clk_get_rate(clk);
> +	clk_put(clk);
> +	if (!rate)
> +		return;
> +
> +	ret = dev_pm_opp_set_rate(cpu_dev, rate);

I think this works accidentally for now as OPP core could have
rejected a switch to the same OPP in this case too.

- We should add a new flag to `struct cpufreq_dt_platform_data` to run
  this code only for the affected platforms and not everyone.

- Perhaps we need a new OPP API, which configures the hardware,
  forcefully, to the current OPP.

-- 
viresh
