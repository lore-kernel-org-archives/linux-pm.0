Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB447ECED
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989142; cv=none; b=I3fto8sKs6Qj8WrXf7Ml2xHEmzGBRkhUNkmaeUz8spHWZmRRCX5M0DuOEM9BMfdcRnF6DvmdE3kpytX3LJmeerKeA4KeIh6UbBcd6qc1bF6SC1kCRe8On99+W4fg/7dhie8mPeV6YqaFoTZvm8amvpugARlCwgc5WUaby20Mh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989142; c=relaxed/simple;
	bh=6WUyA/qRgZjRqG7xyPEggP/5P7ASanStlVdGCtJyGlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/Wn95sIUUbzArPEOPFOtE2KQHM8TWwyzo9dtgt5YA101CGBto0bl5CIHCmd+LPH+pot9C2rGsL316VsYno3wSYLmlvMcz2d+fT7EwN8ICTQfL1oyh9aY6s3ghavGI3PQBjst5qqBTJG1QX0scBEZj194Qs+dHOyzgVbqRz1rvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh4fgJSL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh4fgJSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DE6C2BCC9
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777989142;
	bh=6WUyA/qRgZjRqG7xyPEggP/5P7ASanStlVdGCtJyGlk=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Mh4fgJSL/M9UVKE2p3qiUr85OTWLf+7fGrk5/gmvziXiJS1/BdZI75bGGx46Zw+Vh
	 PKPYK28Dl3uz8jmmUval4JwgkcbUFpNOTMpWEXSqte7B40/S8bycBwBkvIncxIEdxT
	 Zyb7gDv9nwMIS976bz5EDFXkS7vnPYUusg24/SHk7/0Cl6ffTOosF/scP3X+cYufZ9
	 vm+ubSeF8g/anZeUu6Duin2gdr9+ePv8lbBEw1Bbt5rSdEw7TMv2e7V9H9tMXfTzDE
	 JjmQIZUgBtZsw+WCszAniTifd9E0Z9VAvuyIOIp5sPtkGcV06qiJUZP+He/lXe5zA+
	 FHUtsYpeJfQ+w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38be5e86918so64571621fa.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 06:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Oy4GC9ABBfT0xNzEN9KtOlwarql8BaMWG7cwYv6gZlVbJMaNoJT4Bn73hQxu7m2kheOYwGQyEvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8UsJQLVcchOE2ZB+6+U3SnffPIcGAnQEiJMULqbzUvKAoxDnK
	PKdFQMS4yax7GfxXsPt4wHlsRK9iTeuHEE7BWv6wyDK0WISv4L08lLaxv2fWdDZ3RHoAxjyjA44
	7Ok6UrJ3yb6UmN2cvcHVcBi7xgrLjx4Y=
X-Received: by 2002:a2e:bc0d:0:b0:385:9b50:91a8 with SMTP id
 38308e7fff4ca-3937856d91emr70254841fa.15.1777989140911; Tue, 05 May 2026
 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504050245.646078-1-iuncuim@gmail.com> <20260504050245.646078-2-iuncuim@gmail.com>
In-Reply-To: <20260504050245.646078-2-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 5 May 2026 21:52:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v67fmm82JGhRnNyFfDCwVX4XJkO1fY=jxu_1Ham9mO-bRQ@mail.gmail.com>
X-Gm-Features: AVHnY4LeTOBFKJ13FSl9wZl-RNp_nx4OHYevq6vt_0g-2EC1v07ZOx7WmI5wb_o
Message-ID: <CAGb2v67fmm82JGhRnNyFfDCwVX4XJkO1fY=jxu_1Ham9mO-bRQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Just some nitpicks.

On Mon, May 4, 2026 at 1:03=E2=80=AFPM Mikhail Kalashnikov <iuncuim@gmail.c=
om> wrote:
>
> Add dt-bindings description of the thermal sensors in the A523 processor.

Add an empty line to separate the "what" from the context.

> The controllers require activation of the additional frequency of the
> associated gpadc controller, so a mod clock property required.
>
> The calibration data is split into two cells that are in different areas
> of nvmem. Both controllers require access to both memory cell, so a new
> property nvmem-cells has been added. To maintain backward compatibility,
> the name of the old cell remains the same and the new nvmem-cell-names is
> called calibration-second-part

Missing a period here. Also might be better to explicitly say that the
calibration data for both controllers are scattered in these two cells
at different offsets, hence the need for different compatible strings.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 54 +++++++++++++++++--
>  1 file changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a8=
3t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83=
t-ths.yaml
> index 3e61689f6..6020413c3 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.=
yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.=
yaml
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
> +      - description: Additional cell in case of separate calibration dat=
a
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
> +        nvmem-cells:
> +          minItems: 2
> +        nvmem-cell-names:
> +          minItems: 2
> +    else:
> +      properties:
> +        nvmem-cells:
> +          maxItems: 1
> +        nvmem-cell-names:
> +          items:
> +            - const: calibration
> +
>  required:
>    - compatible
>    - reg
> @@ -176,4 +207,21 @@ examples:
>          #thermal-sensor-cells =3D <1>;
>      };
>
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/sun55i-a523-ccu.h>
> +    #include <dt-bindings/reset/sun55i-a523-ccu.h>
> +
> +    thermal-sensor@2009400 {
> +      compatible =3D "allwinner,sun55i-a523-ths1";
> +      reg =3D <0x02009400 0x400>;
> +      interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
> +      clock-names =3D "bus", "mod";
> +      resets =3D <&ccu RST_BUS_THS>;
> +      nvmem-cells =3D <&ths_calibration0>, <&ths_calibration1>;
> +      nvmem-cell-names =3D "calibration",
> +             "calibration-second-part";
> +      #thermal-sensor-cells =3D <1>;
> +    };
>  ...
> --
> 2.54.0
>
