Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809023F431
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499237; cv=none; b=uKVsZSXYO4n/IbOLODOBpMXPgNXo67rCPaoTBWioIHFgThN6PvNg7FaZTAsVyZK25QVwSVChWxnYIhfA0kJjjl/RqOiENWKlcK3zmJSrOO21DU5iW34gx5cTf/8mZ6jFarZXylyXoQ0lDp+MJ/ya1/Wn75TP4dl0ocvxoFrLMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499237; c=relaxed/simple;
	bh=oduFAIUeGAEDQZ1phnxCBWnCFFGd1w7xegjQ3UpP6bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wcdwyq/3GS/HCgod5gI6GRjxuvWCLU0ezTm9WRPHjqV7c4zf5lVyFyIP7hEJXh21gyDNRPXoFs0zD32Wcoj40VIlFjsXIfArkICFJgk453iSRbfvZp3s6IqFx085es4DXdxwVt12dHd4qDWSQ+SP2vY4j+cWNB2sK3Nr+iMlfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fkr3ajWN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fkr3ajWN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1f074a12so29127765ad.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 21:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781499236; x=1782104036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldG7OKmPYAJSsAgvGSM91j+vuJuEOnf6Cy+DpvB+JCQ=;
        b=Fkr3ajWNePGGBsXQxChDFZUgy1MuHnaIHF5sl60c90ptewxzfoVyIHneI4Sdxpmnrr
         r8pyP79JtjQROAXZrbLcj0PPo4c+eQBnYyWGjZksFMU4QJviYcIvqqJ+0biNh9f43S1X
         rNgfiGiu9iw5XM1kfYTBFkalzp7IjrKyvL6waEWBxpcYzs0gZlcZNgNfWJJHZHMF2xQq
         maDNIdZ4CvmwSjUjRJh9C0165pWyBgpna5IQfjWvcjH3YQoppA58Fw9YglbYBChKZLA7
         GwVfg5jH+d0Ik7CC/CpmRZXORDUdLyUar3NcpzEDNVcF5Wtcirz2wT1C6xgdLGyH4o4F
         IP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781499236; x=1782104036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldG7OKmPYAJSsAgvGSM91j+vuJuEOnf6Cy+DpvB+JCQ=;
        b=khN0Ie1wLScXdlL02byiwHxoBBYY92PsqE2sTTPxol4JvSEIyc7MoonD071aq7GiAA
         qpZdPvEHFWKoB6CTPnxZua8+mJ987e4nQwxPPCoQd8ZV8OnllVXP3k65XYSuH/oVW8iC
         ZWtasAIifVCyxsH1PB5cCuX820Qh59c0EWHnVkhLeCC3nm3fTGLW1EEVCLeXijvN0FXr
         GyJ1ZN183KddTE81tHHFBzVUJ3EgryT8UFdLNnF9kW3Born1Zfyqc+zCwmFQmLn0DlCI
         bfD7ttJLiQxdtSa3qYDxMMu3z4tIRZV3uTnMj5i5oSLuRn7ZGduysiRtjNpAlYbjGmtx
         51/A==
X-Forwarded-Encrypted: i=1; AFNElJ+wTvDcEqHt9tQGRBWEfMe3VtNFlHh74zQAzng56YCU9XmgyliQKXihJdRTtuGWFs1e7Hby+eFe6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HQvDOP3TCa0N3YguoQbRgRTepIm7c2+U4HzpNOYAhCwZpUEM
	kphDaAiK/hDbjfR+x/NhrX5UP/Ei+bZyhplbnLpSI8OLuUbMiZt5e8yLe5WgCk/I47Q=
X-Gm-Gg: Acq92OHq2K/WueicnijKc1m1oQoIYDsB+lwzIJ9MrmqPUiBzd2qzdwX7T1l/NOFZmBZ
	dZCECI96a9+gA/8qBV3OJ9BggcEJT5Z0lgMoYMucPEmYoCNJ3OHOWC2UwppDD6MQhJbf0ud6vpC
	Lbc7ocoUeVMLxS6j2xUGCGiuaYjVtwSKjSkv4Hwp1TyiSOIpLXoN8PC/6vW4IUczh8FczjoWspA
	gDDFum4TuVBv4ounOf8Zf/YQL99VxUR2izkTkcmShYxeKoOBEYMUiHAdWf/mR+ObWRWVI/ImGjH
	hKT8upYKLaAvsBxsjr8T0otpyDu4oaVTLbHKIWKT71L/3vJfpv4hS68C94PnH64ZZrO9P9u21Gh
	z6w0va+2a6thZQu9gIomo2o9jfnI2vJ5YCoF6IoYrE25CeQh9pFVWBIUdIDpMWhAGcHUdH1MFNk
	i84j+540pk6ludTbrQlvTZ/K8=
X-Received: by 2002:a17:903:2cc:b0:2c1:1a22:7c43 with SMTP id d9443c01a7336-2c412360000mr139205545ad.24.1781499235045;
        Sun, 14 Jun 2026 21:53:55 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb4424sm86687015ad.31.2026.06.14.21.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:53:54 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:23:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jack Lee <skunkolee@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: Re: [PATCH] cpufreq: powernow-k6: replace symbolic permissions with
 octal
Message-ID: <6ouaf6u7cphc4mva73wvqeqrcndeo7sg625iv6fqs4hpiqcchd@ofbdcufipyzf>
References: <12116e07-040c-4536-958a-d55d04d163c8@oss.qualcomm.com>
 <20260613171559.43079-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613171559.43079-1-skunkolee@gmail.com>

On 13-06-26, 11:15, Jack Lee wrote:
> Symbolic permissions S_IRUGO are not preferred. Replace with octal
> permissions 0444 as recommended by checkpatch.
> 
> Signed-off-by: Jack Lee <skunkolee@gmail.com>
> ---
>  drivers/cpufreq/powernow-k6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
> index 99d2244e03b0..764907b04c04 100644
> --- a/drivers/cpufreq/powernow-k6.c
> +++ b/drivers/cpufreq/powernow-k6.c
> @@ -29,10 +29,10 @@ static unsigned int                     max_multiplier;
>  static unsigned int			param_busfreq = 0;
>  static unsigned int			param_max_multiplier = 0;
>  
> -module_param_named(max_multiplier, param_max_multiplier, uint, S_IRUGO);
> +module_param_named(max_multiplier, param_max_multiplier, uint, 0444);
>  MODULE_PARM_DESC(max_multiplier, "Maximum multiplier (allowed values: 20 30 35 40 45 50 55 60)");
>  
> -module_param_named(bus_frequency, param_busfreq, uint, S_IRUGO);
> +module_param_named(bus_frequency, param_busfreq, uint, 0444);
>  MODULE_PARM_DESC(bus_frequency, "Bus frequency in kHz");
>  
>  /* Clock ratio multiplied by 10 - see table 27 in AMD#23446 */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
