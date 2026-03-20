Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8D40DFC6
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984833; cv=none; b=BBVl49ncURIZFzBpt91Jwu1xSaBqS8u7Zutxsj0fhVsv3ostRk3Kc2gsO4Q4LsLngXgidEfPgAbCiMyO7j0PTDIxa2isldsSQ02QgRCM+TCHwTefrqc1qhamlV88l0M7jRnFgnykNPcQWS5RhliIizDhyeJjSELjBi3Mit1NhXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984833; c=relaxed/simple;
	bh=p4jdjoNZvu9JK5AtQ3lU1aueRQj3/gDHUzJt/cbJm+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNRS9SPc1Nzcwo+e3vo1x7cRp3HfEAPGZBjOY/DTy+RJgsxRtE3zcHLNH66OcB7GyQCLXUBnAv+cxb8W6gLkAonD2uPj142KCFExkOjkdGIDTc1cKIZIFCCtkpV7C/RRGSIJuIrqj2hboO/yNyscyH8FU9cfShLYk34P5yR14o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LP5caZqJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LP5caZqJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aecefc7503so10414825ad.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 22:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773984831; x=1774589631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlPfj4bdTLV2Os6t+carSgE77ZFwl6/igW33LG2/Ts4=;
        b=LP5caZqJP7/wnROLWayOtVVz6IRgghEzspXSqvq2p0zq9C9F3IM0PeD6cV88xMerXC
         qEFBDqau8MzVSBxlfrC2chiK3Vb6j1BlYcMZAQxEStgEkw6Z7ZXEO77bg93kzNikh+mw
         1i3lrR/YeG/HiNat/qkmOgttPJmY/f0+bMwkMmTDIzLs1vLE3vR5eqMPbT7gmF/ZzP0J
         H3J4hSpIdVqWNYUerxTvb2w5ve23fU+30/jmRzsTO3iYLmJuhLPL7w9YuD1EZarKR19e
         ht+y9GBUDbX1MwosZg6M/iYUoazNUnhG/DNTJjOsmFG37xXD0A1MDS3pvJWMV8bS0hwx
         YRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773984831; x=1774589631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlPfj4bdTLV2Os6t+carSgE77ZFwl6/igW33LG2/Ts4=;
        b=q77sO3ZQmZVzE7Jw19IX3htCzKxocW2xXW05ZTYybi4MavCeGD1OSeUZV+wkp+LFXE
         cjq+y3CglwH18m+JWe6jBgAil+I29C4g4WtE9xuey+GqRC/1rrLQBamMGIAK2XuG8AyW
         BF62IDMG9AYoq5dgP/4ugSa5qTzgeGwRV8NtSXcinnZPhhUjlzKDSaYP1xW6wt+uN7gx
         QoqUmarVHAgew7ijP7Y+FIEBs+cgpD0CKgquHMPvso5rYJF46O5WW7XX0XGElpyI3VDM
         8UNKM/PBLTCBjptpz7ZXezQHbFeRrGVKBj6ZZ/md1af5y31Rg8f0+FjMVLlK2RRFKU+B
         Zk6g==
X-Gm-Message-State: AOJu0Yx5GN3JcyProNzuc10uax1HMS+Y4C4Z9sBietL4LwdAUsAnXMmz
	7tShZNQqx8Hzv1aW2olkUmx/POhmrloR6V5QB6jIl+uUHAzFrqomCHliOAZL3p0kzr813+ZYxGc
	9SRRM
X-Gm-Gg: ATEYQzyC1ZKE0fdNdbINlg2n1GJgYuZQycKKPn30Eu9J0ozlMN3wMKhbiK+H3xGOpMo
	BPUBw46Qp79jQPDyM5UOITHD7VVzE+g8OyruR2YHePeWrNPnQNvRH8KQwQs+4AzpFEreBQX6K6J
	Lt/CGoGM2lRsYGPUp7+KFAQhjLkSx10jSaLOLltdDJKxJhU00J7o84ZvAAJIeisyPE3y6JaMbSt
	oU8p8+cKF1Rv6BSKnoQ3fbtaiGCMnEb6jcXoL0vAFX0Pvlfg9n+R3VstOtLgI1ScTh5zsdMb3ZU
	Vj5O387bkrHK0sVNOHy1bbVCW7Pwv2GDSroS390NH247MDAmbw0SuK4WM5oOD2goZUDv6vfgXTq
	jerRD8jiDPRBnEWtF8dDH5jzErdd/h60VN3/JjabMLq/v/ySZbKWKEDM2M8bvaO6yKbK4/wcVST
	+aq9441k8t7AHMIX9yS3VAT8tH
X-Received: by 2002:a17:903:1aa4:b0:2b0:7225:d2c0 with SMTP id d9443c01a7336-2b08277cbedmr18459485ad.30.1773984831194;
        Thu, 19 Mar 2026 22:33:51 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352a17asm9904015ad.24.2026.03.19.22.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:33:50 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:03:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: tegra194: remove COMPILE_TEST
Message-ID: <mvnvzcjhhwsf7n43zlgsirsmogebkukw4n6biu4movti34i2rp@bui4ndqpgjp3>
References: <20260318191233.5851-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318191233.5851-1-rosenp@gmail.com>

On 18-03-26, 12:12, Rosen Penev wrote:
> The driver needs architecture specific headers to build. Problem gets
> exposed when TEGRA_BPMP gets COMPILE_TEST added to it.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4014bc9dd73a..47c9b031f1b3 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -248,7 +248,7 @@ config ARM_TEGRA186_CPUFREQ
>  
>  config ARM_TEGRA194_CPUFREQ
>  	tristate "Tegra194 CPUFreq support"
> -	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
> +	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
>  	depends on TEGRA_BPMP
>  	default ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
>  	help

Applied. Thanks.

-- 
viresh
