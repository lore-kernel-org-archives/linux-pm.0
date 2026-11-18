Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013134;
	b=FJYHRc+pDzi11p9PBLm55lDxSVIwD8PmA2nlWsO4B+/XEVRUkihdOcRleuAZPYaluHaU
	 jH3atHOnmGnM2OGnVPzDkR3ulpFf0iUGL+5C7OxG8865x+H5zf+CPlfpNuFaFCSmtt4ef
	 x9S7X/Imdrf52ivPxhd+lTwJytqirp0cnpw05lXz0mwn1yDay9uRhKn5Bijum0co1bwAj
	 HKqWGlMgPuDo4pUKi9+VlGFWtawkAf2I/eqGT7Xxzw9ABB9QV5j9xy3UxuNyqWM9piqqH
	 WhXJ953yLj4RzTo1428rUJjLpsdcngySwHzTAXRtUBhWLGiO5IY5PhqPHb11NSYR8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dW8jz8AGPYPy5zw3TfeSNEgxlfsTPgtxmP0tja/c/ok=;
	b=kRMJ8yZnSQHaq0Tqyx98P9V/Kpa0NUZsFUp/D+KRwL+nFH2zNPehWSGUdvGrWd+ir8Sh
	 qEHdgKqBgakjjK2QKjzJ+L6CmYHK9jPSfFIFOUTHmWIaIaFq/ArsPrU8IFcYHjqNAUQ0H
	 VkGpZLGVrYtffCF6Z8UAzAarXzayN2jB/87fV66r+G3ohb3OnH41wKOselN1tmqKE3bE4
	 v3psaL6nB+vYgOlAGPZHjs2Ap1+ciZaUgCBnl4qHPO01hON7fLBwmQQ5AXuMAH8du6MpT
	 uyn7PK0ug1Hb4yrsJZMhfCimyL1c/wiDYzN95x59BaKLeBljUPCSA64Xm6dmzY9ad/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="h/V3GnQq";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F510606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 14:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F510606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h/V3GnQq
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so11354835e9.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795013132; x=1795617932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dW8jz8AGPYPy5zw3TfeSNEgxlfsTPgtxmP0tja/c/ok=;
        b=h/V3GnQqzDYq2+Ocl+djVXBVuyWbqmvHG+OGYyfMN89qcxr7EWLd11cyani+5hjlv1
         WLNecqE7293/zllCuLdsKFoIFMM8fcNJhcpMs9c+7mypY5kOnCv1FIDJ+YaUg1Xmxldp
         xTrQX5ZC55Zklzxax1U7EhQWJSm+Yroo0mTyRZqMN29tezP9MUxPsKYS4KpzSHzOm8yX
         6pn/YAWEWzVXbVG2bLDqsqQxO8aZammeB8kymZOGTipwM1P7qrkPXfJBGBeXaJ7kSOL4
         upQU6siI/bA+SESuz/5YB89xWVFNdnooK7OWh86cdfYljPk/Pxoe1NRaJDHI9bGm3I5u
         JPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795013132; x=1795617932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dW8jz8AGPYPy5zw3TfeSNEgxlfsTPgtxmP0tja/c/ok=;
        b=PTVc/r2L/3QbAYXGx9iMC3r7l4N7zf1MJkogGuvBjGXqXfVMr+O/CUZL/r9YrcF142
         h7p63b/cK1n8fM2WwlHp8RIWyLhDOPQ/DHPJrtY/RXaDKLucEWumE3h437RkgRnAxOUh
         /ehEAUXwCVHhCjwejoya89eWQoOJV8cf/DAZBE7fJvrmiByBnmm52MhB7GR7cULB1sG1
         ghBt9VY6gVX2LIerqpjqw5GZ+BwpKbqQd7qwSzaqbW8FvgIeaLKemW2IaUH5/EHcPBAR
         Fqed3GLNGXUEudQFkTp8PwdQrOxbWU5AZRFHFBJq/hUqoTPkQ5gebQv05Pw/EiZtXHJq
         D12w==
X-Forwarded-Encrypted: i=1; AL+hErF+cf5BQNrO4fZqUMpuas1ki99wG4f9EJbaWDnCC/dpjVm3Ia69NGLpl8QSoypIG7I0jGBqYlqMsw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+rcXGe4F1qibRPeHEt5VmysApN5tLpYbPpuknohrfZJHK96YeI
	BIphPhXq1okNnCZe9uVcE3jR+Ox90wO9JewJkoRD9eQe08/fWln+GjPWRMtGDls5+xQ=
X-Gm-Gg: AYBFou2AWqW7I3xCcOfCiwkJbC+qc7BVhFoUJzjvwwNk8wFHhaRXvHCNOvHz9hTW/HK
	QPgCA3SnSailTvUWte78o+u9NaZ4gL6IpmubeszTrMQI+D7XH5DaCs333j34cK7a1aMaZgIpHv0
	YdfMOqH739PjQ60dWIB5sLPCrMqOyF37Vr4fa8OO+ts5z7Q+21NCg7tCbY02ssebtDdT5Ryc5rJ
	nNMoCYRiqDg56PoWunB0EOmisIE87AjNTJr5Q30XvcDgmp7hY558XhSL/0cBw3ey6sThQN/UeFs
	cVpcJMMGhNgJQUXO3ZdoFlsBknI3s3U+OmHeennN3z44SiXehf7RZtAraFeRuo+oc8Ry2YhbCdK
	N5d9evhg56nTxbT7NG/dgGJi62DL2Zl0Ugx8hi/6J2j6Ew+xU4kWO2MPg0RBgBlY7IEiGBF+FDy
	NbBkZX+yZtLqjz2QG0HQvYgnkWZcT1EhtuhnTWIX5rWwdDgyIz0hEHSkFYx/wS9HMg9QabAFMN7
	b5wTGuxwrB+6onh27L7BKIre2jhcO3NjxBOJOTHPdgWVDE7ATnnfGHRtZcF/UPQYfz8yjcibz8j
	AS97oQf3MonuV4xMrJp8Bxk7UzY1phcAlqU8dU0=
X-Received: by 2002:a05:600c:8b51:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4bb7da3a65fmr52309385e9.25.1795013132472;
        Wed, 18 Nov 2026 06:45:32 -0800 (PST)
Received: from [192.168.0.252] ([82.76.204.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6560962adsm5382230f8f.41.2026.11.18.06.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:45:32 -0800 (PST)
Message-ID: <ee73f5ce-906f-4411-9449-d17c3abfa11d@linaro.org>
Date: Wed, 18 Nov 2026 16:45:30 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: gs101-tmu: add Exynos850
 compatible
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Juan Yescas <jyescas@google.com>
Cc: Mateusz Majewski <m.majewski2@samsung.com>,
 Thomas Turner <tturner@lineageos.org>,
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
 <20261118-acpm-tmu-e850-support-v2-1-19848c0d97e5@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20261118-acpm-tmu-e850-support-v2-1-19848c0d97e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 3:51 PM, Alexey Klimov wrote:
> Document the `samsung,exynos850-tmu-top` compatible string for the
> Exynos850 SoC.
> 
> Unlike the GS101, where the ACPM firmware handles most of the TMU
> initialization and threshold configuration, the Exynos850 firmware
> implements a significantly smaller subset of TMU IPC commands.
> Consequently, the Application Processor requires broader direct
> MMIO access to initialize the thermal unit, configure thresholds,
> clear interrupts and collect calibration data.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  .../bindings/thermal/google,gs101-tmu-top.yaml     | 26 +++++++++++++++-------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> index 75560ebca48d..bea208cd4619 100644
> --- a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> +++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> @@ -15,17 +15,27 @@ description:
>    both direct register-level access and firmware-mediated management
>    via the ACPM (Alive Clock and Power Manager) firmware.
>  
> -  On these platforms, the hardware is managed in a hybrid fashion. The
> -  Application Processor (AP) maintains direct memory-mapped access
> -  exclusively to the interrupt pending registers to identify thermal
> -  events. All other functional aspects - including sensor
> -  initialization, threshold configuration, and temperature acquisition
> -  - are handled by the ACPM firmware. The AP coordinates these
> -  operations through the ACPM IPC protocol.
> +  On these platforms, the hardware is managed in a hybrid fashion, though
> +  the distribution of responsibilities between the Application Processor
> +  (AP) and the ACPM firmware varies by SoC.
> +
> +  On the GS101, the AP maintains direct memory-mapped access exclusively
> +  to the interrupt pending registers to identify thermal events. All other
> +  functional aspects - including sensor initialization, threshold
> +  configuration, and temperature acquisition - are handled by the ACPM
> +  firmware. The AP coordinates these operations through the ACPM IPC protocol.
> +
> +  On the Exynos850, the ACPM firmware implements a smaller subset of TMU IPC
> +  commands (mainly temperature querying, basic TMU initialization, and power
> +  state management). Consequently, the AP is responsible for register-level
> +  access to initialize the thermal unit, configure thresholds and handle
> +  interrupts via MMIO.
>  
>  properties:
>    compatible:
> -    const: google,gs101-tmu-top
> +    enum:
> +      - google,gs101-tmu-top
> +      - samsung,exynos850-tmu-top
>  
>    reg:
>      maxItems: 1
> 

