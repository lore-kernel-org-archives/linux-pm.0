Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DC29827E;
	Tue, 28 Apr 2026 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362423; cv=none; b=dG/8/v+Zaqs1Ku4X/5sum0Z1RIOd6GP2JXQ9ru+7B1hFqn70mAH9cYnREYbDqeBFD5pyW2HsNWsD+gpReBJpVaecEmMV6/kkrll+yrgr/GyEOfM9Tx9HwxtjnVcyL21Ks2VGuLjI52UKyggMz6fzcdCZN6COaGZ+xf8/chL/lCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362423; c=relaxed/simple;
	bh=LjvQWxO8MdqD3grX5Gi28h5ntU4nyt5GvckNuDrXREU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVaNax8SmtDJl1Cm2WXZdjcN/jee93R2yZ5+7ebCkXZzMfuQhsRVbj9FYP7ljPidjGrDclyV7whV17B6mRH9EaY79MucQ4Q7EQAUvQLfEBAUQCy6dbt13mHaQLCoIKbFh65gmfYu86U1auBxX27H9n5kVoPFVQfIjO2/81WZ4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGyzS1vZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGyzS1vZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5419C2BCAF;
	Tue, 28 Apr 2026 07:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777362423;
	bh=LjvQWxO8MdqD3grX5Gi28h5ntU4nyt5GvckNuDrXREU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGyzS1vZsNCTz0eymCL2UyLf5YdAlcj+ArMyHL9o+qmE5VwKCXwnXdPD+oTzzMSfy
	 o/QYaAc0xx+Bgx9s2NZf6vuu2yQN84Z/02GkbsBiV1NHTm8YaGpD8VesJrziCKQV5W
	 nf+JrOYfdF3OjTkwRGGsU/6g+QlbYQ+eKXODcGv/3zitNDvDIDgJ0VVTZaerETeeoL
	 PVpZ9nNoJURMOJxNIlCU7cBoCkQlPr/C4v7pCyGAUrtr8GHY+CI0orURgIR69Br+pM
	 u8A25UTFSSbToxCtkCqVQcK0CJFi2II2elj4yXNCGQ0rRF22AZI/y5bHolqj3igpMl
	 ikqYt2ZWlVMgw==
Date: Tue, 28 Apr 2026 09:47:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org, 
	simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org, 
	maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com, neil.armstrong@linaro.org, 
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: sgm41542: document
 sgm41542
Message-ID: <20260428-bulky-nebulous-reindeer-ed45ed@quoll>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427170914.5062-2-macroalpha82@gmail.com>

On Mon, Apr 27, 2026 at 12:09:09PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Document the SG Micro sgm41542 battery charger/boost converter.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> new file mode 100644
> index 000000000000..3e5041e5b551
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml

Filename must match compatible.

> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SGM41542 Battery Charger
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The SGMicro SGM41542 is a single cell battery charger/boost controller.
> +
> +maintainers:
> +  - Chris Morgan <macromorgan@hotmail.com>
> +  - Xu Shengfei <xsf@rock-chips.com>
> +
> +properties:
> +  compatible:
> +    const: sgmicro,sgm41542
> +
> +  input-current-limit-microamp:

Missing vendor prefix.

> +    description:
> +      Optional value to clamp the maximum input current limit to for
> +      the device. If omitted, the default value for the hardware will
> +      be used (2400000).
> +    minimum: 100000
> +    maximum: 3800000
> +
> +  input-voltage-limit-microvolt:
> +    description:
> +      Optional value to clamp the maximum input voltage limit to for
> +      the device. If omitted, the default value for the hardware will
> +      be used (4500000).
> +    minimum: 3900000
> +    maximum: 12000000
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  monitored-battery:

You miss definition of this property. I guess this is power supply, so
reference proper schema for power supplies. Look at other bindings to
for some example code.

> +    description: |
> +        A phandle to a monitored battery node. Values for the following
> +        are used by the driver and if not present will result in default
> +        values being applied:
> +        constant-charge-current-max-microamp
> +        constant-charge-voltage-max-microvolt
> +        charge-term-current-microamp
> +        precharge-current-microamp
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:

No need for regulators node, just define here otg-vbus directly. But
honestly, your example is incomplete or you defined something implied by
the compatible. If you have a fixed 5V regulator, what is the point of
defining it in the DT?

> +    type: object
> +    properties:
> +      otg-vbus:
> +        type: object
> +        description: OTG boost regulator
> +        $ref: /schemas/regulator/regulator.yaml
> +        unevaluatedProperties: false
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    battery: battery {
> +      compatible = "simple-battery";
> +      constant-charge-current-max-microamp = <10000000>;
> +      constant-charge-voltage-max-microvolt = <4350000>;
> +      precharge-current-microamp = <180000>;
> +      charge-term-current-microamp = <300000>;
> +    };
> +    #include <dt-bindings/gpio/gpio.h>

Drop this one

> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      charger@3b {
> +        compatible = "sgmicro,sgm41542";
> +        reg = <0x3b>;
> +        input-current-limit-microamp = <3000000>;
> +        input-voltage-limit-microvolt = <4500000>;
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> +        monitored-battery = <&battery>;
> +
> +        regulators {
> +          otg-vbus {
> +            regulator-max-microvolt = <5000000>;
> +            regulator-min-microvolt = <5000000>;
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.43.0
> 
