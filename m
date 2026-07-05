Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701031E98E3;
	Sun,  5 Jul 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783243474; cv=none; b=G5QdBLaACE3E797W9bno+HXSBDAd2R30OQMIh6PJ3OJh+zgE2zymB1pQWIcC7ceDM1GmAZ8gP5v50teDGikDz6WCuxFKlkl6HyHgTELvLzZwea9qDhfVSX8sgMco5243gIDGAIwlV7VOvmZQs2Zr0HPBUUAlC1TIOXVfKN1lFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783243474; c=relaxed/simple;
	bh=cjIEasT95Xxy+NaTWGz2dtvC/Hav7olZad4yJO0pqLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3MKVJFjp6SCNjZRvJZ07s1yw0VjfE3LgJSeP1zFLn7qylGt1pWdlXRVs1PZIKDPM6414pnFGbEs52pu9m7HEEQ0+Vsjq4/n1+9oYcMHPdkur9SjarSpV25R1TdU2ahyxWCqkB5bKsOS7y+89vDyjNXTmXKY3ZwVa6EjMnpA3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCKw8uE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCKw8uE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDFD1F000E9;
	Sun,  5 Jul 2026 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783243473;
	bh=kEQyb/LC51AZrqltCLED85HWv0m0zHup+ymLpFMfzG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BCKw8uE8aeaPxfe9eF1fQSsTL861gYyhSbiXpG5pH4bY2YJJkieCmsPNwUO+z6grC
	 bIRKnNU/FaubAQkUEjecAVRT11Y/yuTTb2ZQ/axaesBbKuOSMWGwbqr7yVeCz+3GPS
	 ReIdTYJY1vWWQ/NI3Mi9Suq94/M9F5EpjR+4KKXN16wz85f68flyWEGv/5ccclJLxT
	 iCy7yZJW2Tb4B9kDknwVidSyEDAf42RK0BB3g70RKMwVGOsBqX+4fpvFEeGFmNIgg1
	 9rddmR/jjV1f+k/e+f7yNnFayGe+ryD5DbWFlOdClc5vhaXw3Di3iHiXX5oWXYu9U7
	 rY0LMCb36PrLA==
Date: Sun, 5 Jul 2026 11:24:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers
Message-ID: <20260705-agate-partridge-of-biology-1a44ae@quoll>
References: <20260704171411.1413349-1-iuncuim@gmail.com>
 <20260704171411.1413349-2-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260704171411.1413349-2-iuncuim@gmail.com>

On Sun, Jul 05, 2026 at 01:14:07AM +0800, Mikhail Kalashnikov wrote:
> Add dt-bindings description of the thermal sensors in the A523 processor.
> 
> The controllers require activation of the additional frequency of the
> associated gpadc controller, so a mod clock property required.
> 
> The calibration data for both thermal controllers (THS0, THS1) is split
> across two nvmem cells at different offsets, requiring the two cells
> to be read and merged. To maintain backward compatibility, the name of
> the old cell remains "calibration" and the new cell is named
> "calibration-second-part".
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 54 +++++++++++++++++--
>  1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index 3e61689f6..6f5b2f3b9 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -24,6 +24,8 @@ properties:
>        - allwinner,sun50i-h5-ths
>        - allwinner,sun50i-h6-ths
>        - allwinner,sun50i-h616-ths
> +      - allwinner,sun55i-a523-ths0
> +      - allwinner,sun55i-a523-ths1
>  
>    clocks:
>      minItems: 1
> @@ -47,11 +49,16 @@ properties:
>      maxItems: 1
>  
>    nvmem-cells:
> -    maxItems: 1
> -    description: Calibration data for thermal sensors
> +    minItems: 1
> +    items:
> +      - description: Calibration data for thermal sensors
> +      - description: Additional cell in case of separate calibration data
>  
>    nvmem-cell-names:
> -    const: calibration
> +    minItems: 1
> +    items:
> +      - const: calibration
> +      - const: calibration-second-part
>  
>    allwinner,sram:
>      maxItems: 1
> @@ -107,6 +114,7 @@ allOf:
>              enum:
>                - allwinner,sun8i-h3-ths
>                - allwinner,sun20i-d1-ths
> +              - allwinner,sun55i-a523-ths0
>  
>      then:
>        properties:
> @@ -132,6 +140,29 @@ allOf:
>          - clock-names
>          - resets
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun55i-a523-ths0
> +              - allwinner,sun55i-a523-ths1
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2

Missing clock-names

Look at other variants here, how they did it.

> +        nvmem-cells:
> +          minItems: 2
> +        nvmem-cell-names:
> +          minItems: 2
> +    else:
> +      properties:
> +        nvmem-cells:
> +          maxItems: 1
> +        nvmem-cell-names:

maxItems instead

> +          items:
> +            - const: calibration
> +
>  required:
>    - compatible
>    - reg
> @@ -176,4 +207,21 @@ examples:
>          #thermal-sensor-cells = <1>;
>      };
>  
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/sun55i-a523-ccu.h>
> +    #include <dt-bindings/reset/sun55i-a523-ccu.h>
> +
> +    thermal-sensor@2009400 {

You already have three examples, it is enough. Drop. Actually two would be
enough already...

Best regards,
Krzysztof

