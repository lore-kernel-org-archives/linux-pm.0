Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFC33E35F
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008787; cv=none; b=TVw3+1UPXnpikHZqoypa4itqVVOq8SKHq4QW3VcviOpCjysV0/oNHxlkhzYiSv/tl9iGnxupinGG043CEbV97ZjgjgCrDHyiXd2qi2D7Gz7AkuLltph+TSs6mUgBLoHSmvIs9lxuMiVd2U+OdCJNpxTJVmZI9GjS7YAkeuyZMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008787; c=relaxed/simple;
	bh=jfa8ytdmrfomsd7Bc3kOVRi5zbSCzmo6zCu240qE/X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS8eKsqW5aV+1wbJyLGia1KhSuyQC45of/+v/dvTGyg4DJAJCoz8wEoQpyOQQwg24d0n0aM7rJUOLWi0dCA1Yqi4jtMhDZqRhY8fMIsfuFt1abqU7mP7iu8aBBQXkAmry6Mc1Sr6+YItyszaLdDIKe89/B/pVeOwU8Bd/JHKAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=au/s3p2w; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="au/s3p2w"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so6890736b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 22:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777008786; x=1777613586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnwOvgDndaP9V3Bbl38tHqOQaGjwNEX0O9pKgu8MbD4=;
        b=au/s3p2w9q0dZZ2w8SN8ZUhGGwQuXGP5fgVcT1i4o2Cc3stw6eJgAS6vDvqUpnnB01
         R2+a7xDLILqsKvo9P+8QfTO87ZcGubnEPCcY1WtLX1iTajPLEP1aJrHCcE7mj/szbp7d
         foKwr2xcs40jFijPHrupzJJyaR563vz7Biv9KpHb/oJcmtKNGnbPI33s4xA3JtfxbPgz
         eGfejNgxUqkBASMdwU3/9MEWnPk+j8FB5Nrfg+IgF7f4PUfI/WjDruLV9UMmaQaGK4FW
         hjiIl6fsrRsQ5eIPHJ0NqzjkwKiEOxPyie0WmTK9zOjSriP9fkvMtpyRtvMW5cEaHStp
         RJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777008786; x=1777613586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnwOvgDndaP9V3Bbl38tHqOQaGjwNEX0O9pKgu8MbD4=;
        b=LVYqmdARJ4bpXpUSDtRijBoyXWc9yk1FzXQQhacTK0WV2l7wMLOxuy9Ry2VALpB/6Z
         MwypZ5teGpkphqOI7BcFLZyiRDfvtsPweFjThp8Q6IE+aJiJL75W5p6OdLry+ASjlVkH
         Ed2fX3LQCX10vXRFybth6SjK3QnPhZ2iczHLVhIDd3DHNzl3iPJEg8Z6M5AswT6iUdGL
         aXx/WTs0HAbNnAwxfQODUk3hQG3z5Sg7PMR++iAKoPvmcwAg/Z2QtInLKWU+S5YinPpB
         C6GOGFw5AbUIUzeya+YuVX0jBF5/uxWzrfBU43hWMzupyGstWHb0dM/rl6tTbCfmw1hX
         d0UQ==
X-Forwarded-Encrypted: i=1; AFNElJ84iL+sVmH0IpFc2r9UMqmL0vOqsay2QHoHc4Z+dI1FfaFO2aPr2badSPsWieSYV37JWXqZRJHcSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0EWQVXG8nxHyekxQslhgRR4Fj/rJF3KQHoFZ1dr9lK5/T2Eab
	gobmpJ638Ixrf1p39pCb69p9up1ZsMhJL+GkFqJA/hzrHxd0mJgY3PseOsDgiMK+qxA=
X-Gm-Gg: AeBDievXq85797k/ULgBLE3xPsAvF4sMrHhS5YzEMOSk8sRhZd+ITlbWUQsXDsI2xXM
	4mE3dKB3trVxIv4QCwfM/wJ4FEfkNNGpgBX7t8hpfwL4VfHt9PN5jWUr5fi+nCaxX4Hbto+kV8T
	mCmSQkLa6kVt79oq6LJbej1oRPVEksgsq+DuwJ0ussYBxh921njfUNI4sZ770wuyimTrCqubPDr
	JaKSE1tyQxP7dwXuCpirGxErORRETVl99amq4lQuDPP1CMAYf4ON1v0xjXUKZURS8yH/pBgk1Rv
	AqJ2dbd0UX7+Sxdaj5PGSt1wbfuEo2WYbK2r6OPwVEmA0VdWDNq8Dl0a6Dvyxy5qMZsYRBtqkDV
	Zc8HxR280MR2ws2LmL0KVYZ8GtXAIC6NLM0im80mP1WkYliN2FgejjhQ5xLo5PnF1PHfWTyKlbO
	X7caohB+zyg8JGeYs11g2VcJ/AbD+cEeyzgw==
X-Received: by 2002:a05:6a00:2d01:b0:82f:91f:bf35 with SMTP id d2e1a72fcca58-82f8c7db32fmr31698639b3a.3.1777008785496;
        Thu, 23 Apr 2026 22:33:05 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9819e5sm23074570b3a.2.2026.04.23.22.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:33:04 -0700 (PDT)
Date: Fri, 24 Apr 2026 11:03:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom: Unify user-visible "Qualcomm" name
Message-ID: <nerfirktc63hj3uffhykrxccxud7s56rbahzo7t3ug3ar4pwpd@4gjmjnu26vpn>
References: <20260423173607.92564-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423173607.92564-2-krzysztof.kozlowski@oss.qualcomm.com>

On 23-04-26, 19:36, Krzysztof Kozlowski wrote:
> Various names for Qualcomm as a company are used in user-visible config
> options.  Switch to unified "Qualcomm" so it will be easier for users to
> identify the options when for example running menuconfig.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> I am doing this tree wide:
> https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 47c9b031f1b3..a441668f9e0c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -153,7 +153,7 @@ config ARM_QCOM_CPUFREQ_NVMEM
>  	  If in doubt, say N.
>  
>  config ARM_QCOM_CPUFREQ_HW
> -	tristate "QCOM CPUFreq HW driver"
> +	tristate "Qualcomm CPUFreq HW driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on COMMON_CLK
>  	help

Applied. Thanks.

-- 
viresh
