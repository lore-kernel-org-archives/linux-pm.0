Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C23D1CAF
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508953; cv=none; b=Ea7+2j77qt/VywfylwHOKxT132mqxflCe+cucasmgjZw+Y5xmbDsESY8fZOq70tbVXd5dkDxPT9cXxoR6VoOnzudwBiDCrJY2eUHndav0BrxfWn44VirfejGxESn4sSdkn9VGYVFKY9mMIoVMTh3Du1OGIyMSq3E1tNhKPv4VVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508953; c=relaxed/simple;
	bh=IWGp/NWkgG/a5CvbWg4n6hVzBMccA2mG1yRRLqy2pl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZE556c/GbO5Vcszq05Le3/lopM0Ueak+Omx+1X1qx+fVwXs/CPsw9fq9GYefWTJUyZIG43RRalHSnnh5+OFGQFe2Q2BqoPstb8J7sLb+1CasBe69SMrUO/asQCb9Tgpycmg87YfPxmCmOAuZLcDCrVKE3ncW6VRgi5bD+dq/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAPZWyM2; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAPZWyM2"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb6573bd52so731049a34.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788508951; x=1789113751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LxXdH2O4yqJZkq6Caw3eDtnAXG7jVWIM1Lm/pGgl0f4=;
        b=YAPZWyM2Ovy2duq5ZRJ7oCvZzUMRIk0DgNiA4QA0RZ4yeSvoc1XsFHs4JtN4Kg/paB
         OeVBE/SDd+6jeImYNCnzP+RrpSufqQavCpFl/fvkMgc1nQoPJV+3+bY+YoLOuQVSRAnu
         r/lw10l7Gx+/KLMomN6fAwLGF7H6ycgXrLWohQONPx4eu7inVPUbiUZB0Pf9vRyLSPy5
         vvZP2LFiYff4uLo/ttCsfwP/2EFzIm8WLCkfYlq95y9A7/Wh/FTV3U/DcwKSPQ2IzJ0L
         /jI7XIn8QUTXE6p84j687ta3j+ftK7nXR7qxgrR/eWoHFSv9IxpT+Z9T0/7i8+26aUt1
         sVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508951; x=1789113751;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxXdH2O4yqJZkq6Caw3eDtnAXG7jVWIM1Lm/pGgl0f4=;
        b=tNqA5pZZuKwcv1cmgROVAfDUmnvPHTwmNcq/Yu4i78YYldvctuJbMS1RzytadbWUUP
         4guaX3vssb+uLlp6UF5RKsljt+yvJbJ4AzNuN68NXaTXyJOjel5M6LrPyFKUT/M6V9fW
         h4OT0/RCveWPQXA9iCeZXprCzop8jKfdLssaN2bIWYIwLa47S7QjVRJQPvcFc5hJqkO3
         4Rm7mkUXv9zDwILK89OCH6e70bNRIGBIs+avTsV9qyQ3UPdGtLA3xu2L2FsFXvsv1SWH
         FUnP898IXfRg6SR8cDYM9qZDsKnziAunLNqjCx9UVT6fukee4cw1kMUhmAKnQiwunBG4
         INCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxoQacEQ/d5zIVb2I08xzvCM04GLtylBg9i+Ix1FcHXmIvDfDCTS1ugRGrOGnXsuWlZyTE3TW5RQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kl3LHL+9/pASrlvYOR/CDRIardSLX23sSyXRpY/ZYH7O+cF5nY
	A3rr0aqg7NB+4ilZ5hAUEAr63Qap3gev+9RU1O0QECT0y6D73/4vNoFCC6najbMxMZnbD86vb2E
	xuuBT4BI=
X-Gm-Gg: AYBFou16L+Mpoa3Yn4InN0DHIvvl6eMlmqQ9aA7V4cFixYPkTpNLCegv4aFqIz+cBkJ
	zuwGiRFJLrwxnPBM5DWRmiGUyCGYVR+rW7Vh0+i27Ie7QYijWk+B4YRnFRoD/uc+Lr0oLN9eSjO
	cGW+9ReJx8cfObNmkE9z7Io7LMrKsu+NimLijBUoBr/gth511zY1QmmsLF8zPNbXZiv3hUzAN07
	2LchU6lBJOMId1EmGjn366fayzAgFH20vLudb81wYGqp9YIIUrClbRdlRS1HcudPsikNsBB/Bpo
	wb32zps/yFhPxahEVOQ2/MXtZ8bUb21E+X2EWHXNjR0d+XH8zgY44sV1cEePw3zU3F0u8cvfw8m
	qxzGU5r6IAY88Q1HlIouZ45lFeY3UdqlY2e03sevyFy2ikkM1JkJkTa9wSX64BFKp8Vx2RlXety
	JiB090NHncl3d+8lW+g9a40+K5RaIg7zBgL56L2oRvtHfz3rIUcmH4YU4kkeICzRxEQ3K+9LVl1
	z0=
X-Received: by 2002:a4a:e915:0:b0:6b7:46fa:16a5 with SMTP id 006d021491bc7-6b746fa1ae8mr1522269eaf.58.1788508950532;
        Fri, 04 Sep 2026 01:02:30 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm5356732eec.7.2026.09.04.01.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:02:29 -0700 (PDT)
Date: Fri, 4 Sep 2026 13:32:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: rcpufreq_dt: add module alias
Message-ID: <app7EnFj9RMsdJcO@vireshk-B250M-D3H>
References: <20260904075635.14840-1-rmxpzlb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904075635.14840-1-rmxpzlb@gmail.com>

On 04-09-26, 15:56, Frank Zhang wrote:
> Add the missing `platform:cpufreq-dt` module alias so that the driver
> can be automatically loaded when the platform device is registered.
> 
> Fixes: 06149d8f2216 ("cpufreq: Add Rust-based cpufreq-dt driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 10106fa13095..32a508d82f68 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -219,4 +219,5 @@ fn probe<'bound>(
>      authors: ["Viresh Kumar <viresh.kumar@linaro.org>"],
>      description: "Generic CPUFreq DT driver",
>      license: "GPL v2",
> +    alias: ["platform:cpufreq-dt"],
>  }

Applied. Thanks.

-- 
viresh
