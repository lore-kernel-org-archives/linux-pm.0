Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEDC358381;
	Mon, 28 Sep 2026 06:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575526; cv=none; b=CV9M4/a4Rb+8n2GlOrbm83cEp6Cl8zJhz8LN08YTkYFT6k7rN1eMIo3OLTFHAA6VgMjUrg/E3T7wGWhWJuU4LOWzwlars9y/J8A37Iqed7MGiPMmnWv64X5jUaJczgIEozZcfropkEd5D6NWRwB9ks9liTogGsMQOIZIEy8cits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575526; c=relaxed/simple;
	bh=SRIVWSNq3KWGvgesxCgQZHeMYaQNq8qGyM04vvRBSBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD2DkbcDDJtxvYpub1jue6gKp2RNsemrlTNHA9WP+mq+NpQ1qtfW4PqqrXHg9QiTln7r97oURqo/M42jCMp5NOlGrUtCFHoLu8IUo4g1X+ldIJ7vzbq/NCeGsxRj89UmXOsuNP7nxu+L5C7SfBwyXVPf/ynmBg+J8eYGvl94QNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0nMX7JI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0nMX7JI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F169C1F000FF;
	Mon, 28 Sep 2026 06:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575524;
	bh=jV0YdUb90luw2wkc1DzhQGAKsyzFWyg8sRvBE0GqwaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E0nMX7JIFIn6vJn4WFiHlMfoAwaOes2EeJJNCsygq7dFzsxkjrJIAetWDfD3m1z5n
	 aTRxxUb9+UD5aN/A3ICOGmo8YKEo3iI7IMsIPsx3BKmdi9Pu4CtZl5Z3b1s7FtXX7k
	 Y6NutCUUNv3yBniSJN2KEIfRLCmP4wQ8sl2dTJApnjDZp0+E9x4QZRUIFD/NtoBDEV
	 o3sjsOlL2yDn1lzMsN4PNmJWuhohvpH2PcKPKFG50xS2N/x0CuMr8LB2qmRsm3nlO+
	 E4kssRDuAoaPwpjvrWTP1L+Pd6xMropQEeCKSGP3dR8GfTQkC95APYalqsVfu1e+RW
	 mXkONZKVH0Gbw==
Date: Mon, 28 Sep 2026 08:05:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: adc: renesas,rzg2l-adc:
 Document RZ/G3L ADC for TSU
Message-ID: <20260928-controversial-foamy-tanuki-7fef04@quoll>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
 <20260922042707.116378-6-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922042707.116378-6-biju.das.jz@bp.renesas.com>

On Tue, Sep 22, 2026 at 05:26:57AM +0100, Biju Das wrote:
> Add the renesas,r9a08g046-adc1 compatible string for the ADC1
> instance on RZ/G3L, which is dedicated to the on-chip TSU (thermal

Is there ADC2 instance?

> sensor unit). Unlike the other ADC instances, this one only exposes
> a single channel (channel@8), so restrict the allowed channel nodes
> accordingly.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Dropped required property '#io-channel-cells'.
> v1->v2:
>  * No Change.
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml     | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> index 40341d541726..f08f5439d127 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> @@ -25,7 +25,9 @@ properties:
>                - renesas,r9a07g054-adc   # RZ/V2L
>            - const: renesas,rzg2l-adc
>        - items:
> -          - const: renesas,r9a08g045-adc  # RZ/G3S
> +          - enum:
> +              - renesas,r9a08g045-adc   # RZ/G3S
> +              - renesas,r9a08g046-adc1  # RZ/G3L ADC for TSU
>  
>    reg:
>      maxItems: 1
> @@ -121,6 +123,19 @@ allOf:
>              reg:
>                maximum: 7
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g046-adc1
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$": false
> +        "^channel@[8]$":

Why number 8? Does datasheet actually calls it that way?

> +          properties:
> +            reg:
> +              const: 8

Best regards,
Krzysztof

