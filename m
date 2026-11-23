Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410811;
	b=li9MloUI2gd69w38kIDEuVYfWdx3gbC4DPeiC90aFEFQ2fP+GVRhxF0/NdMcd35YEHle
	 s9eV3O2VGOQzBz3BnuigruHdAAhD/HSI/MYinr0uLipHw7HuCo93+dkO1sLEWvSounxGB
	 9H0CxC8r0QbZyaMptdK5YmMz530zrK3HvSTj0U/KF1FBNMApQvQTmZqq58St7l0ENlziH
	 8d5rY9cWV37G4B+9I5wqnfyZLNNO/dn9ZH7fXNlJLtJSPot57rVNjVnI2V2rpiwSlRuJ/
	 b7LXPyzvjsyUxSmNyk/ac4qWbSrZmvMjfiuIwYV2MJSoHVyysX9fWCZ+MKps0+9F6Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FUqLDQXnSJ5sC0anYruumGCX75FgOtK3GjAUXxEI5pY=;
	b=g/AW8z8mqq54hTyudvekiGwnGun0oozskQKwzTjBru3I6UOhK9jC6x/ac1JdrC6l65in
	 hkoNa6O8hhjyrBUnVILtJ0t+VnJFa2pzV6c3HmuIn7tAEPDS284xG65uGEyk0YuhzLmcY
	 h2yfuv6lYUZNG9Y+mQh9nhVWmoq7qscREj6dd2ny8YbkfdvHXGgCV7hgeD6uC74hdM3op
	 mg+d/SiTIqaZQxv8onSoaxQ982ok9BHciTvX+Tz1/3sHTiSDCrtbEZ69tBAau8DMyMkdF
	 JqW6B8o/5HWvZD/DgzGV/yxREFxDUo7Dhlso89r5BsyeDVla1Bi2xOaVL/MOFq8LXbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mk5fTCH5;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDE606A31A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ADDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mk5fTCH5
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-380b40312e2so6987235eec.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 21:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795410810; x=1796015610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FUqLDQXnSJ5sC0anYruumGCX75FgOtK3GjAUXxEI5pY=;
        b=mk5fTCH5/Drpvpg5QA+hbvQxQGO+R7TnbSgiZZtAZn3UjKf0fRIzMRdHbfY+0Z/pzV
         SFj3Kw/05Z5T3zteL4dQ0VFVhrHeunfl4aFYOTdsYaW1cqezniBoJltXc9uqwjaIXYK/
         m4ulhxHyHhchDRpBwM3uN4iwkAKK18W91dyz8y6PGeWrEPSlTrFKd2zNVu2aVgL50tgl
         JCCC0mmEwDF/WQV5c93GXNHNMR4Ok5vIc0u4eEGtcXFFbiIqj1Cfteu7FWFUJ2zwXmFx
         YrCd3JG/Y4iMScDzrdibOKoC4naX9OAT/k/HiBpueuXtc583nX7bAAsjjuymNtTzQX2C
         hzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795410810; x=1796015610;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUqLDQXnSJ5sC0anYruumGCX75FgOtK3GjAUXxEI5pY=;
        b=E9tIhNhyUPXMrDPu+wjY6TELCr+PV0MNHTQsnNlIvd9LsTXG+DI9xHo6QfCtJeWa4y
         kHpf1OfF+Si8DBm3L0jJpUgJDcbVauz6SHswJNq7tVWBazysx60DQLHYd/o0s1wuHoWR
         1nVfSljqWTHv7LUWbxerkLhK3jUHCFGBVf5f7QjMSsmxv2yQvtxMdP+FDW8Azp9MKLn/
         dtJMNG5Cgy7Qww6WAPgP5MOps/x/bXVk5V9CO4OuMAFjgxscNTfyeykndzg3rvFugUIu
         IiIfbtTitmiXWElqGgeE318ZO6NZvSZmBdEtglknCgigScSTF5M/S3AYh0tDwyLIPble
         oSzg==
X-Forwarded-Encrypted: i=1; AL+hErEyt2SyJdFzibJWGU+l363f5KkUupUrg6yvMD0Xxiz7pIcvzoVs0MvRwQBlXER0c290Ch9DCV1Taw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9hlPYj1/1R1fW5lGidG83OGDrJdtuz1x5z6MRgv5LFwCMT9YKk
	pSCn4vQ5ER0iDMd97IeuR2kmSyN5B1+iyvYyK2wjTHfWEPKrhaXQTtXf5GMuqK4orK77cYtTuRb
	VeKSy
X-Gm-Gg: AZFdTZeH/+RJS/+B6nPX9Nb0SIItco1MVa+mLgRSGF7B/OMFsJWpk87TLOhgGaZ3M2m
	yNNW4nuXvTMRnFiQ9yiuSc8rt3K0cd6OF7J21S7Sec6KUcObAEuS9sewki99Y1/7TUJ6gsMoaGV
	QuOyxrJl4dlslHkvSxXQRG4cB8jZZAc+K4rwFkZYrpwF630s9qpRuoxD9MHaSYzmbpPEqs5uYFW
	8p7nlZSd/Gg8Pm+aGQE1Yls9LmeVU4eBIq/vS796CCLXM1wBZNCf5kYbgdQ/GYZZU3YXQUuczn0
	MykwZxTAuHziDkqsKv3xBWBHZn6WmZujSdE0pqPiqs/H37axoJKnn6ZXVa06eX8ZydUdmui/VIP
	0e/7syu61naHFUSceECo1kFOYBlFeYPg9DEkA6799dHGGYrKpiUEyen7G/oMvSZ8JGR+SDF/tUR
	HHSgbKBFSrd/GX5wxcN6Z5PwfcxbJjnK42WU1b9hOtxgFtPltZvHabgsiz1eWgkYfLO/KY1gYSe
	7NJJuIwUrz8UyOpQ7m8xr+VYYYNRxoI32kD6TaPsceFDBO51KfE1FhroCdRGMSMF2wilBFLGmSK
	SXUab6Xg4TamGnKDCETAhF8gXEpd+w==
X-Received: by 2002:a05:7301:4710:b0:378:314:4042 with SMTP id 5a478bee46e88-385702587c5mr10487392eec.14.1795410782709;
        Sun, 22 Nov 2026 21:13:02 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm28221624eec.13.2026.11.22.21.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:13:01 -0800 (PST)
Date: Mon, 23 Nov 2026 10:42:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: michael.reeves077@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: cpufreq: apple,cluster-cpufreq: Add
 M3 family compatibles
Message-ID: <awPLW-zURwW1dqZX@vireshk-B250M-D3H>
References: <20261122-m3-cpufreq-opp-v2-0-3c19963f55ee@gmail.com>
 <20261122-m3-cpufreq-opp-v2-1-3c19963f55ee@gmail.com>
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
In-Reply-To: <20261122-m3-cpufreq-opp-v2-1-3c19963f55ee@gmail.com>

On 22-11-26, 00:18, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
> 
> Add compatible strings for the Apple M3 family cluster cpufreq
> controllers:
> 
> - apple,t8122-cluster-cpufreq (M3)
> - apple,t6030-cluster-cpufreq (M3 Pro)
> - apple,t6031-cluster-cpufreq (M3 Max / M3 Ultra)
> 
> All three are compatible with the M2 (T8112) cluster cpufreq controller
> and fall back to "apple,t8112-cluster-cpufreq".
> 
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> index b51913a81791..516216cb6ad6 100644
> --- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> @@ -36,7 +36,11 @@ properties:
>            - const: apple,s5l8960x-cluster-cpufreq
>        - const: apple,s5l8960x-cluster-cpufreq
>        - items:
> -          - const: apple,t6020-cluster-cpufreq
> +          - enum:
> +              - apple,t6020-cluster-cpufreq
> +              - apple,t6030-cluster-cpufreq
> +              - apple,t6031-cluster-cpufreq
> +              - apple,t8122-cluster-cpufreq
>            - const: apple,t8112-cluster-cpufreq
>  
>    reg:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
