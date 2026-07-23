Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8E364EA6;
	Thu, 23 Jul 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822472; cv=none; b=awdAQPfD2oLujF4KNKQLakDE69T2pujagDJrQivXhMfLIAY5MDBHY7nXFISjDWHDyEJK65AApyx/WknAmGZqLyzXCzo4pBxowfQuR7n/49w49BgRdOw3UydHRqHHOQx3FhCe6KQfmLxjn0nRxLpOPsGgj2BDbejkdaWxcp9ug3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822472; c=relaxed/simple;
	bh=ReKNhrUZlCyRH2rajfvrFCbPTTFv08qpZe5VCyK2fyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeAIDki/g8Q8wW2+qB5124vNKCLrX19/svaDa80zDlQgo9G6d64Xol/PFCNjdRY7ztINvbyZZAtkz2j/VaPi+8S+KLrt92pRQwum5265l74StqgXi/jBwA/NCCUtWNroSs05HlvuR6Elv3vNcw3gcp4CH9WxkdrOFpTHJm1SzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A21F000E9;
	Thu, 23 Jul 2026 16:01:04 +0000 (UTC)
Date: Thu, 23 Jul 2026 17:00:59 +0100
From: Lee Jones <lee@kernel.org>
To: rva333@protonmail.com
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mfd: mediatek: mt6397: add mt6323
 PMIC EFUSE
Message-ID: <20260723160059.GB3526803@google.com>
References: <20260713-mt6323-nvmem-v3-0-205c39267a24@protonmail.com>
 <20260713-mt6323-nvmem-v3-1-205c39267a24@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-mt6323-nvmem-v3-1-205c39267a24@protonmail.com>

On Mon, 13 Jul 2026, Roman Vivchar via B4 Relay wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> The MediaTek mt6323 PMIC includes an EFUSE used for storing calibration
> data.
> 
> Add the devicetree binding documentation for the MediaTek mt6323 EFUSE.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 3cbc0dc12c31..d2de227ae7a6 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -159,6 +159,23 @@ properties:
>      required:
>        - compatible
>  
> +  efuse:
> +    type: object
> +    unevaluatedProperties: false
> +    description:
> +      The efuse is responsible for storing calibration data, such as thermal
> +      sensor calibration.
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mt6323-efuse
> +
> +      nvmem-layout:
> +        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
> +
> +    required:
> +      - compatible
> +
>    leds:
>      type: object
>      additionalProperties: false
> @@ -307,6 +324,10 @@ examples:
>          interrupt-controller;
>          #interrupt-cells = <2>;
>  
> +        efuse {
> +          compatible = "mediatek,mt6323-efuse";

Nit: This tabbing looks off to me.

The example below uses 4-spaces, this uses 2.

> +        };
> +
>          leds {
>              compatible = "mediatek,mt6323-led";
>              #address-cells = <1>;
> 
> -- 
> 2.54.0
> 
> 

-- 
Lee Jones
