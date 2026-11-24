Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514163;
	b=PhYT4x48f056yifIh4K4+bygpfwXmEN719w6ZTU83uEDjftz7Qwa30zBioh1Elmpe1od
	 rkrB1cVxvhY0i1GNNWwXSeZWCuE4/SQc+Bh6Drdmd69Ov6+3mJkgotEg5vHQ+h8YNsHxf
	 3iJdhazsk9bQe7M0TvbBoMendjUDVYtcc0O42cKaZT6dHywW3djMYd8pRzz/AnR3UfwP9
	 eE1an/OczCsO1uLQg/fbifiAv2Lnw/vd3KN7zDje4uN2Mvk6Ak1k1u7Wyitc/C2p54QUW
	 j3pNL1eacTh9w+x5mxgKmiCa2JWQ6bvC9PheqDgyqa0MVPj/xBjyePRmw/AxIaeDb/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514163;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HBwwx22gdCBZcO+HQC+OiG/e+KY/HmCfnI4aK0bezx0=;
	b=LYdOBr/FJSe0QkzfLKey6kt15fLGy9ZZiRCte1i/LeqL+IAVR54quWeNel2oUmtJ2mh/
	 VbeM/FIxfUFErsVnvYd4XYXCmZcOFh1vBn/nxlaMlFs3A9pOrXHhzh41T5rXC9MW8QU+w
	 Ybap+qcG+YmzPiGJ816CuZK/nNoyjCtapzNpLD0OV+iL93XKTrJn8ZVF+45z0aBmbkwns
	 cef6MeBz752+9v0rsJ9LDoziEJ3eLAmmLmHM1fkqIHbKcQLsb/+78hsKuOvNhYlRiQ+V3
	 o7AKlWhW8FJF6YhcnWnLJHPxRaJ/nQ57feLNI+z+t81DreIoLMzb+SCnQu2GiSsW8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgKvT66T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C3606A32A;
	Tue, 24 Nov 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgKvT66T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A121F000EB;
	Tue, 24 Nov 2026 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795514162;
	bh=HBwwx22gdCBZcO+HQC+OiG/e+KY/HmCfnI4aK0bezx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HgKvT66TjCdo1tP68cBTobK77WEZOs0plGQEzS8YDlxCl0uR4GpJeTTms4vjEJFEQ
	 XFZ8XAhxZgOGNms6u9xuyZM1+WQ08J/xdo1Tz/4lIAeMmVdqSHwrtZZvNAQ9G5G0RQ
	 4t1hrQnSv90AYxS0fS5KvUlb79gdT9DrVSpg9F9U+8Lrl9Dmkj7qlu0Yqp9eaPM33A
	 3FvZljj58ni7EX2g3uu5n9L4k5aBGz4jov5y/cHJ3KdmqA4Mz3EhX0Gi5QBmObXkuu
	 dIMimcxNuwFX473yI69Bde9fMfX32vg2bv3rJyreFKWU1WtTe5tVLu4QWh1wR6Iqqq
	 QjidklHUqc3cw==
Message-ID: <a5f859c1-0779-4ae1-88f0-bfa12268e09c@kernel.org>
Date: Tue, 24 Nov 2026 10:55:57 +0100
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
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add qcom,pm4125-charger
 binding
To: Raj Aryan <raj.aryan@oss.qualcomm.com>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Casey Connolly <casey.connolly@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Rakesh Kota <rakesh.kota@oss.qualcomm.com>
References: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
 <20261124-smblite-charger-for-pm4125-v1-1-2132c9f0601f@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261124-smblite-charger-for-pm4125-v1-1-2132c9f0601f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/11/2026 10:15, Raj Aryan wrote:
> Add YAML devicetree binding for the Qualcomm SMBLite switch-mode

YAML devicetree binding, you hit combo... Drop YAML.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> battery charger found on the PM4125 PMIC.
> 
> SMBLite is a reduced-feature charger IP sharing a common SPMI
> interface with the SMB2 family (PMI8998, PM660) but using separate
> SPMI peripheral bases for CHGR, DCDC, USB, MISC and BATIF blocks.
> 
> The binding covers:

Do not explain what the patch is doing. We can read the diff. Please
read submitting patches or look at other commits to learn what is
supposed to be here.

> 
>   - compatible string: qcom,pm4125-charger
>   - reg property for the CHGR peripheral base address
>   - Four interrupts: usb-plugin, bat-ov, wdog-bark and
>     usbin-icl-change
>   - Two IIO channels: usbin_v (USB input voltage via ADC5_USB_IN_V_16)
>     and usbin_i (USB input current via ADC5_USB_IN_I)
>   - Optional JEITA soft and hard threshold configuration as raw
>     16-bit ADC comparator values written to BATIF ADC comparator
>     registers
>   - Optional monitored-battery phandle for battery parameters such
>     as float voltage and charge termination current

...

> +
> +maintainers:
> +  - Raj Aryan <raj.aryan@oss.qualcomm.com>
> +  - Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> +
> +description: |
> +  The Qualcomm SMBLite is a switch-mode battery charger IP found on
> +  the entry-level Qualcomm PM4125 PMIC. It exposes five separate
> +  SPMI peripheral bases for CHGR, DCDC, USB, MISC and BATIF blocks and
> +  supports USB input current limiting, JEITA temperature protection,
> +  battery overvoltage detection and a hardware watchdog.
> +
> +properties:
> +  compatible:
> +    const: qcom,pm4125-charger
> +
> +  reg:
> +    maxItems: 1
> +    description: Base address of the CHGR SPMI peripheral (e.g. 0x1000).

Drop description.

> +
> +  interrupts:
> +    maxItems: 4
> +
> +  interrupt-names:
> +    items:
> +      - const: usb-plugin
> +      - const: bat-ov
> +      - const: wdog-bark
> +      - const: usbin-icl-change
> +
> +  io-channels:
> +    minItems: 1
> +    maxItems: 2

Why is this flexible?

> +    description: |
> +      IIO ADC channels used by the charger. usbin_v is the USB input
> +      voltage channel (ADC5_USB_IN_V_16). usbin_i is the USB input
> +      current channel (ADC5_USB_IN_I).
> +
> +  io-channel-names:
> +    minItems: 1
> +    items:
> +      - const: usbin_v
> +      - const: usbin_i
> +
> +  monitored-battery: true
> +
> +  qcom,jeita-soft-thresholds:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      JEITA soft temperature thresholds (COOL, WARM) as raw 16-bit ADC
> +      comparator values written to the BATIF ADC comparator registers.
> +      Example: <0x5314 0x25e3> for COOL=15°C, WARM=45°C.
> +
> +  qcom,jeita-hard-thresholds:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      JEITA hard temperature thresholds (COLD, HOT) as raw 16-bit ADC
> +      comparator values written to the BATIF ADC comparator registers.
> +      Example: <0x58cd 0x20b8> for COLD=0°C, HOT=60°C.

Express temperatures with proper units.



Best regards,
Krzysztof
