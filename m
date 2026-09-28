Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764637E2E1;
	Mon, 28 Sep 2026 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573835; cv=none; b=GDH4vopCUUG34Ls35y+YjXXRZlK6RpZ5VC48rXVHztK+DHHLDoc/LIiuUEUiaNLLje40Hxje7w3eRduSkLPDcMz/eCcornDa6bDzJz6/NLyhWiPEksUNsZB+OpTU/68/b/siMlfDHfxqcN8erIA3Vaoi5rfsPtnL0G/7XuvJ0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573835; c=relaxed/simple;
	bh=8KUFjbAMBy4PelaOUS84OaEnF4yW4XEW7SEYfT2ELTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKwjpcxzcLwjB/PLjjz6+hqNFHJ1hTbcIICq1FjVjt1BNmxRgvWTLcDDrLMOBd8vuGvg0SXEiYMzFvnhXiBhw5TvPUpS6BuTBsfBuB23HuSPE+RCaXee6XXsRue3XgMbCt3oSnobhBG6DL9SYV1VJU/yOHFWqi94zJcDPdnsrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkjvhMfR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkjvhMfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257B91F000FF;
	Mon, 28 Sep 2026 05:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790573834;
	bh=8QhxpW00yraLjdsyXjafndt02JRMMBCzVdcuQl77r+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XkjvhMfRfahuE79Gj1oGilaIo+aVnkpFIqwL9/vgwvfn1KREvgOHru0lQB08u6ssL
	 WFOQHHkAFbjMIbqCu9FlJYQK8Totuh9O6tSg8Lnzq6ltw+hqHWxXvl3P8f+Ed5Vo9Y
	 8qFLKTzh7rqofkmB6cuDhGZnKMB6kOGEzmynhnbnqDr+m2fFTDc9hMVKbJNUOykU36
	 RlwPrMqYwV9hAdDxvrWIq3NwWEKxSxlo4MHk8lNAlqR3kSys2agzmaTzcur1XdTxDp
	 5AjlaSO5pELgXbE3CHhAGRNfDeUIfNQZGoqeC26gvVa9TPkZLfkDKI9T4UJxEGCRAO
	 RHeOh8oV+QTAQ==
Date: Mon, 28 Sep 2026 07:37:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 01/18] dt-bindings: power: Convert Ux500 PM domains to
 schema
Message-ID: <20260928-rainbow-adventurous-otter-3aa6a7@quoll>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-1-9352be6b86b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-1-9352be6b86b1@kernel.org>

On Mon, Sep 21, 2026 at 12:48:07AM +0200, Linus Walleij wrote:
> +description:
> +  The UX500 power domain controller gates power to one or more peripherals on
> +  the SoC. Domain specifiers use one cell containing one of the DOMAIN_*
> +  indexes defined in dt-bindings/arm/ux500_pm_domains.h.

Use rather full path, so include/dt-bindings/arm/ux500_pm_domains.h

> +
> +allOf:
> +  - $ref: power-domain.yaml#
> +
> +properties:
> +  compatible:
> +    const: stericsson,ux500-pm-domains
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#power-domain-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/arm/ux500_pm_domains.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pm_domains: power-controller {
> +        compatible = "stericsson,ux500-pm-domains";
> +        #power-domain-cells = <1>;
> +    };
> +
> +    mmc@80126000 {
> +        compatible = "arm,pl18x", "arm,primecell";
> +        reg = <0x80126000 0x1000>;
> +        interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&pm_domains DOMAIN_VAPE>;
> +    };

Please drop the consumer from the example (thus also arm-gic header).

With these:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

