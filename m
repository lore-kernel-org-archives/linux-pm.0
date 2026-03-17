Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51438E5FB
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737520; cv=none; b=Nwr2XVOS2WlNGcCHGJF1FMrPPNXM+/I1CsGkKNnO7HnDP8rFI/7p4BCKUJUdAdyriF3FQU4sv1B8Lmnn7khvG5TE+QQ3c5TyPuB73eERGGz0LqbJ7UnewDjRNJLVkNFPU2H6qNnmm8Wo2hZMy3jxXp5Dtpy5xLkVS7O0dpQjVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737520; c=relaxed/simple;
	bh=p8pVTyPl47a537YPvdFqH/ssrxTbysfNXijEbIICXdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT8AwY8ab7MWn1eCmU8t3/MQ62jPpq2uAs5DPz+t653E8zw1wRQcmUvuKzMXFxesyoynTMnIG3lLct8xYY00EfnRrL+b3kmqw8zEHXrZ0hZPT6HrQwSRD3+Dmvg9epSPqIKq4aknfibq/8woua+vbalDfI8oSYxcsAsbGOkQT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l91ggJsY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l91ggJsY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82987437624so364580b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773737519; x=1774342319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rab1Vx6P07OVr4XGKcMH30oU9Egb7S8XIvL2tnMJznM=;
        b=l91ggJsYtSm00fcAO5YEN4SX1keC3xNi7qFXCHfaCFcdlCyHLIfJeXiw24zBUKyfd9
         7KZvB2K5B5O+kIunW2DvKCuJMBRpJRx9Kcbvd54zlgClPzQKlAes56Wh04edsiYlMelq
         g0d/zIa0nsWFekU793DOJ6iNa/IDraRhrHB1g46VJWXLewbHzvQsryVBQDIXHiYJHKwG
         712Mded4uZtBxPLm7rswJMXFtY7G5lOW5RgLSTDI3EMN8KGQxhiJfbGWw1KMLzLzuZhj
         O9n7+t9HD52Z/hI9gnw7O2kcEwqcH1v4HrMeAMlPZX3nL2E5hPQ4AzMRo4souo2Rf4qU
         a6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773737519; x=1774342319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rab1Vx6P07OVr4XGKcMH30oU9Egb7S8XIvL2tnMJznM=;
        b=g8PO2x/NBT/zMAo88uNpzyRqBGnE+cZdB42E/371wS5fxpjqbDPS0vjismuUZz5CCJ
         pFjISldXrALOAuklVn4XEw6soJ24A0vwMCgO5WamZotf4PQo3Vro0RkVFVr9T6onxW8r
         U5AV/TdSDHpOcl3yqzIagmyFy7pcTzMg9SIcIsxh25VdSCGUrhzpVsA+QvSmhZFOf/B3
         LOAwrBBFk38MXO7T4wdF5njdEklmwmp6eSw/y6/qNMYo9jSPJvm/B/F1lAkgntv86gK6
         TfpdoVq4Ha2OKwXUm8D1b5tKCU3kwieF97kASK3X7sB3SerdI7EQz/m7S186AZ1ognc+
         +pIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnt3FBv7qkAV0wcEHZJiNtdaG/ZWqCD1SihNQ+2c6mXrHwfOiWAiUfTqwk5kdcMdoztUNmybFCwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YytglZRijKnF6+018mTQH8+YZhvVYp2KVZqV2KAfMohseT3ESXF
	8pLVFsi5eI7H2EmI76PAgFmM9q90YPF7RSEscfmqgse5vsisC4l0aRShzkLjOU7pC0ckybYPikH
	2DzI1
X-Gm-Gg: ATEYQzxYAYtyVvXYnOkOV/ErS18DGrS4zfNxe4rjP62dDOr5UQ5YfYGoxKcBTuDZ8iG
	I5FhScFvyjbKkolX2bSCsLwalC+nX6T2WZI+sYRDxp+bbAApAvSr0c3yjuTu06o0w1nbzxUIL59
	+dlwPm6VuCV9vRdrLzpveQ1n5Gm3QT+rKdBeEUtPehfUpJ1dQkI0andvNY34pBM8KuVW+3JOOXW
	x2Hj8IbQlxs64T4rnAue2fWfP3NYY/ZgXLAkO94PEJBlXn8ZAGBkbdAmIwuUDv5TIxkb5ORAdfX
	4I2VWHfQEFNgBorkwVMZEaqPh7JKqsihLCF3sR77iIKTV1kgERpfJet61tj8i29lmG8rhVot3aP
	9x5OPqQkd0+0EsaPw2QIb1sXnO+AHfZecnbCNO3mm6h+XZmZg88Iumxc2qCNodbG0xd6fpuQHYn
	pM91BrsCD1WtDiwEKX8Abj7peN
X-Received: by 2002:a05:6a00:1398:b0:822:69b2:7ed0 with SMTP id d2e1a72fcca58-82a56014846mr2547142b3a.6.1773737519091;
        Tue, 17 Mar 2026 01:51:59 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm15903645b3a.39.2026.03.17.01.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 01:51:58 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:21:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, umang.chheda@oss.qualcomm.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Add QCS8300 to cpufreq-dt-platdev blocklist
Message-ID: <apsp4wx7pluiwfc46unxpwaylubwk7ltn4oc62dtqrgvggumb5@5aobovyqmlgl>
References: <20260316103752.289324-1-faruque.ansari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316103752.289324-1-faruque.ansari@oss.qualcomm.com>

On 16-03-26, 16:07, Faruque Ansari wrote:
> The Qualcomm QCS8300 platform uses the qcom-cpufreq-hw
> driver, so add it to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 25fd3b191b7e..ff1204c666b1 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -159,6 +159,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,qcm2290", },
>  	{ .compatible = "qcom,qcm6490", },
>  	{ .compatible = "qcom,qcs404", },
> +	{ .compatible = "qcom,qcs8300", },
>  	{ .compatible = "qcom,qdu1000", },
>  	{ .compatible = "qcom,sa8155p" },
>  	{ .compatible = "qcom,sa8540p" },

Applied. Thanks.

-- 
viresh
