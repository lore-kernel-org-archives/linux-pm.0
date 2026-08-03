Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F003515FB;
	Mon,  3 Aug 2026 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795755; cv=none; b=Hb+1sYo7HCxOP2AyYUJhXoTUV36ZlCVY+Y3/2UnS+URTzU+oRW6frAQsiFj5w8S9+fhpHA5MdCUZuRadG3ogutLpNjpNOAIz7DhsM9E0Tq1cnk1NfIMK00d6VHdlnPW5U5uBSPBOmFBXNzd7kNVyFMWdh2eP2cPcKO7sw0acCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795755; c=relaxed/simple;
	bh=CNSO+WBmvcqw+nvXWqefnKshU3yhwvZPb8pHXa21cmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHhv2KDtuZkBTQG9UKMw8pvDGcGCI/PkDzB+6L0B749KNqbjd/gC/B4vFFPRCsTv0gSWW2cg+AjB3ym/wPgSfZr/SsGLYHC/2aRVjoGwWRuksHcel5G2yJgeLcCb8J4U6cSOedl3+a1Q+0fsc7UekWQGYs178B9kdVy2lfCAglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3vNjADY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3vNjADY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D731F000E9;
	Mon,  3 Aug 2026 22:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795754;
	bh=QyFPn8q42V8UAdgnXK7tNQAdLlrB0mrtydrnFstRtOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C3vNjADY8AkCkgdef674Ux6vNUnGjEVwy+Q149SCSwvkxrkRdiKnrfXbr86VIonb2
	 7s1O5Lh0oX+ctP2/i9Mb07/AMW18YVoZNiooaka2Vcff5zzESjKEjPcKGNt4xZwi7X
	 Qv6+Xr51KWHv9LoToBUUA24iTxLCzOP5rnZRQ2Qrkg8FBEyf/XB+GbAMKXeksuNsNA
	 a3bAKhwKP+wXNaQ41RXiLI75lxPYpeGK1CIJ4NXvkLuo/902CrMvCd5rCFZ5PGdgWp
	 Jl3OatlG52N232U3kjz3fOZpvHgN1AqSBXWePQ83RtrWZJ4VEG8/n9nP/3qZsfbd56
	 3f3FacM2OdRMQ==
Date: Mon, 3 Aug 2026 17:22:31 -0500
From: Rob Herring <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
	simona.toaca@nxp.com
Subject: Re: [PATCH] dt-bindings: thermal: ti,omap-bandgap: Convert to DT
 schema
Message-ID: <20260803222231.GA728307-robh@kernel.org>
References: <20260731-ti-bandgap-v1-1-aeee6a658520@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ti-bandgap-v1-1-aeee6a658520@gmail.com>

On Fri, Jul 31, 2026 at 12:42:38AM +0530, Bhargav Joshi wrote:
> Convert Texas Instruments OMAP SCM bandgap from legacy text to DT schema
> 
> Add "ti,dra752-bandgap" to compatible which was missing in text binding
> but used and matched by same driver.
> 
> Document the "#thermal-sensor-cells" property, which was missing from
> the original text binding but is required in practice by all in-tree
> users via the common thermal-sensor.yaml binding.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../bindings/thermal/ti,omap-bandgap.yaml          | 227 +++++++++++++++++++++
>  .../devicetree/bindings/thermal/ti_soc_thermal.txt |  88 --------
>  2 files changed, 227 insertions(+), 88 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml b/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml
> new file mode 100644
> index 000000000000..5afd10a84f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml
> @@ -0,0 +1,227 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/ti,omap-bandgap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP SCM bandgap
> +
> +maintainers:
> +  - Eduardo Valentin <edubezval@gmail.com>
> +
> +description:
> +  In the System Control Module, OMAP supplies a voltage reference and a
> +  temperature sensor feature that are gathered in the band gap voltage and
> +  temperature sensor (VBGAPTS) module. The band gap provides current and
> +  voltage reference for its internal circuits and other analog IP blocks. The
> +  analog-to-digital converter (ADC) produces an output value that is
> +  proportional to the silicon temperature.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,omap34xx-bandgap
> +      - ti,omap36xx-bandgap
> +      - ti,omap4430-bandgap
> +      - ti,omap4460-bandgap
> +      - ti,omap4470-bandgap
> +      - ti,omap5430-bandgap
> +      - ti,dra752-bandgap
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 6
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpios:
> +    maxItems: 1
> +    description:
> +      used to inform which GPIO line the tshut signal is routed to. The
> +      informed GPIO will be treated as an IRQ;
> +
> +  "#thermal-sensor-cells":
> +    enum: [0, 1]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,omap34xx-bandgap
> +              - ti,omap36xx-bandgap
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 1
> +
> +        interrupts: false
> +
> +        gpios: false
> +
> +        "#thermal-sensor-cells":
> +          const: 0
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,omap4430-bandgap
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +
> +        interrupts: false
> +
> +        "#thermal-sensor-cells":
> +          const: 0
> +
> +      required:
> +        - gpios
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,omap4460-bandgap
> +              - ti,omap4470-bandgap
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 3
> +          maxItems: 3
> +
> +        interrupts:
> +          maxItems: 1

Drop. 1 is already the max.

> +
> +        "#thermal-sensor-cells":
> +          const: 0
> +
> +      required:
> +        - interrupts
> +        - gpios
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,omap5430-bandgap
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          maxItems: 4
> +
> +        interrupts:
> +          maxItems: 1

Drop. 1 is already the max.

> +
> +        gpios: false
> +
> +        "#thermal-sensor-cells":
> +          const: 1
> +
> +      required:
> +        - interrupts
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,dra752-bandgap
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 6
> +          maxItems: 6
> +
> +        interrupts:
> +          maxItems: 1

Drop. 1 is already the max.

> +
> +        gpios: false
> +
> +        "#thermal-sensor-cells":
> +          const: 1
> +
> +      required:
> +        - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bandgap@48002524 {
> +        compatible = "ti,omap34xx-bandgap";
> +        reg = <0x48002524 0x4>;
> +        #thermal-sensor-cells = <0>;
> +    };
> +
> +  - |
> +    bandgap@48002524 {
> +        compatible = "ti,omap36xx-bandgap";
> +        reg = <0x48002524 0x4>;
> +        #thermal-sensor-cells = <0>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    bandgap@4a002260 {
> +        compatible = "ti,omap4430-bandgap";
> +        reg = <0x4a002260 0x4>, <0x4a00232c 0x4>;
> +        gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>; /* tshut */
> +        #thermal-sensor-cells = <0>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bandgap@4a002260 {
> +        compatible = "ti,omap4460-bandgap";
> +        reg = <0x4a002260 0x4>, <0x4a00232c 0x4>, <0x4a002378 0x18>;
> +        interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
> +        gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>; /* tshut */
> +        #thermal-sensor-cells = <0>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bandgap@4a0021e0 {
> +        compatible = "ti,omap5430-bandgap";
> +        reg = <0x4a0021e0 0xc>, <0x4a00232c 0xc>,
> +              <0x4a002380 0x2c>, <0x4a0023c0 0x3c>;
> +        interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bandgap@4a0021e0 {
> +        compatible = "ti,dra752-bandgap";
> +        reg = <0x4a0021e0 0xc>, <0x4a00232c 0xc>,
> +              <0x4a002380 0x2c>, <0x4a0023c0 0x3c>,
> +              <0x4a002564 0x8>, <0x4a002574 0x50>;
> +        interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>; /* talert */
> +        #thermal-sensor-cells = <1>;
> +    };

1 or 2 examples is enough. Perhaps the 1st and last to have the simplest 
and most complex.
