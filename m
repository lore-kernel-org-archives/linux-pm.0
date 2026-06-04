Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77788413D99
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572201; cv=pass; b=FUd0ku6paAEAYPovEQ2LxLBTjoZTgs459maNcrVkbw2hcIcqjflM2OMFIWsjP8ynW1ckuEOfvrarY8LsPoMgm/iXbkVi3CiR+0TOqD06ltE9JpdB1C4OBnNM5iZis3idk9oU/0yHIsYLnaN35TpSadsZjdp0FKgES8UFXGyd4OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572201; c=relaxed/simple;
	bh=G9nFh7v8j7acwr3OyC0fVYembfzlnZt3C5JR+74mpZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7B2rNmMVFAJC1Q9fZ/2LLP8WebTJ9l8zXsvDfERevcm1uU27WrsdqI90wWr5kjijFxkP8afm98yDTeB8/8vmbE65y34KPRQh5RPESp/SWspSwNeVuQ/mOPjgH9rzhWNsfgykRWn2IULedAa6BIgU+1whRbTq/Re4q1wDgGXRtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dvx6AsfG; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dvx6AsfG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so574114a12.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 04:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780572198; cv=none;
        d=google.com; s=arc-20240605;
        b=fLyzK2cOLqN7TW2T3V4KEobH7U7mwsIPfPTxgS7/gWU0OkiDCMndowx7nWFf4/WmEQ
         gAHxkPrZUDnF/18Yfq1RI7Sy4e52QOy4gLVJVHhvuiwpxgkrMkAurvSnWAjk/iL6JPBa
         5xNn4pk7v9A2ZcKwQZOSlMsaIh0l7/7Fcf2C7tbNfvT+Q+uXJHDDtgewNE+xHAK/KbDc
         zYHeOSCK3+kUtlmNu3NNJcjq1EM+xiY122y6IofxBXdENPNS8aMWNeFhTBH51Zlm/toa
         S5xpp2crs9vuaIKJZv3WH3oKdHUKwH7C38RBqIWmc6ZNOoC4f+eEow3tfB+cEjefIw5P
         xPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zSZAPul0pXkxx09T12pErJ7HwDU4RDxf16+6acHgaAM=;
        fh=5eJwXNBm8wEqoDxHLiNgsXMPfRaie/5oksME8sf7REA=;
        b=iHDTZW+lqWd8TYPBJMiaq+Cm3QYGwH+YaQbWO4df2PrTGMVDQNw/0CcXFYBabgSBpZ
         FgIDitaOp2QhjG2TcPCnhW0KECcim6oz2mrfENZEwGot9nMATSJGvN+QLKbuA209aUtQ
         MmxvenVTIfxGrwonutp4QHRKOsqdf424fZTgzcQ9iR4UQ8p7bt50d2A/OJ7nr51Ru8oc
         yoccOYIFreSLsV93xE0zujWxl/PhKOn1nt8baDIrvktrpt8x3/bFo6FTVUdy1msZXYnY
         X8q9JUO9iq4wBt8/W+VtwcojmV3a7X3SQp35H2ECpW+qeWIa6cqPyimEWGwX+J/icZX9
         jVMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780572198; x=1781176998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSZAPul0pXkxx09T12pErJ7HwDU4RDxf16+6acHgaAM=;
        b=Dvx6AsfGD02bweAo0ZEINt0kOaCQzPJ1S2+optCdZlXmIr23h/q3YrAsWtupnJ7l45
         c98RGB5NER11WyEenOQEJiqhh0Iy88ubfgMHy7ZCJvzG2v1t15JKlK6T9311q8noIq+t
         CIZFHD1fklBLj0B/CUVGk6CwALZ5FSxxbvzILufg+xELUDVYcg7x8Dzt4jUQgXPvImP0
         asnJzap0HrzweOPVSCBiRJoqC/iBCnwf872TLf/em3etyORjPOjuF6gZ+HpaBwCgLQoX
         tRYik6X8LflxAyu8m7Z91oJSEuFcJ5WhN2i2BEU/P/RNYSQjh2eEM0nx19hgLjtmepPp
         Xv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572198; x=1781176998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSZAPul0pXkxx09T12pErJ7HwDU4RDxf16+6acHgaAM=;
        b=FAB0B+j2rrw6EIcHdFImIKHni5UhWtFgCQtTMZbYqpDZhcEFGCe9gDoEa7NCZaHM0f
         SY3dz5M8cnymKMJUudzLutNpl7h3QfMGO1M+Fg9BVNpvYlVirdvjMfFFSwrnsHr8ZUle
         tiY5FaD1yPm3wXze2sdXnU7C8sQUJA5GarA7Gkll7WYz7l+DuQZ6mS9dOtsi//NUKwlo
         mBNnUu0PiV0zzAzX2bvJK1f4+DNOkPaRXiUlFPZb0x3SJD0qve06fqddrf+ffnOdNIlo
         dMGyBGGq1qcfqtdqG8YrgjnWOQewDAbV5cFv5E/YySSSGfKuJFkabcx6VA5T08KtRMUt
         4Unw==
X-Forwarded-Encrypted: i=1; AFNElJ/WqvCRiRQBA/OGGuVpM0UQFyxvQNJ+pTsvPdkvOaHrXvL+rBuPyvDcDAByDqkuPCsxLQF9gf4shw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLB3D71x7dQ4wUbppm5hshHS3wTnnHefpmuX1KNX56ZqNlIlFf
	dystVlooTcZnstbBYCARF9v3SN0itDFY0paYWNNP5W7sM8PQc4QSTPeO+R0DdKb2j7vjXrrMNIr
	KmFqq3HOQxQaoMT7gsWcde2qN95sSIUQgj7SQIy1Z7A==
X-Gm-Gg: Acq92OHjP1iuuW0YF+jkY4baN0/jyP7Fw5/+SmH4KzATM0kcjRQP9m4vg8ZvXSuWRJ7
	bC79qTD99HTFxkR5H9voTYv/9f3G+Ld1GxVQvDRWiVURewZLAjDu/M5eYYPH8JvIAwss21jPV1i
	W7JGzEjlJN+69Ebe81dhtzw3bznmeuWI7RM3T/7+tnygc8QkoBGOv7N37nCAHODuqt+vocSNTkd
	h3Jny0haEu6dvWrRG3E7PD/p12uHJ8OfLVNDjrAbcwKxubsSZ3oWVwf6fLW3oO3oHAOcPEYdK6W
	2kbFBUHkisIZn9OQWcioihAwY0JUB2y/AaWbZ+3TrM5SMY/w
X-Received: by 2002:a05:6402:3215:b0:68b:539c:d269 with SMTP id
 4fb4d7f45d1cf-68e710ebc51mr4043117a12.12.1780572197841; Thu, 04 Jun 2026
 04:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org> <20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 4 Jun 2026 12:23:06 +0100
X-Gm-Features: AVHnY4Ia0mw8gm7Hj0ZlJv6TfIxLHonorNGMBp2ITPuIwQPM__6LAPjP3GLorns
Message-ID: <CADrjBPqhrnMv0xoMK+K=rMmd9jKAHYqFkn6y7EKoqm=i9o656A@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] dt-bindings: thermal: Add Google GS101 TMU
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.
>
> The GS101 TMU utilizes a hybrid control model shared between the
> Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
> firmware. This hybrid ACPM TMU architecture is also present on other
> Samsung Exynos SoCs (e.g., AutoV920, Exynos850).
>
> While the TMU is a standard memory-mapped IP block, on this platform
> the AP's direct register access is restricted to the interrupt pending
> (INTPEND) registers for event identification. High-level functional
> tasks, such as sensor initialization, threshold programming, and
> temperature reads, are delegated to the ACPM firmware.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  .../bindings/thermal/google,gs101-tmu-top.yaml     | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> new file mode 100644
> index 000000000000..75560ebca48d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos ACPM Thermal Management Unit (TMU)
> +
> +maintainers:
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
> +
> +description:
> +  The Samsung Exynos ACPM TMU is a thermal sensor block found on Exynos
> +  based platforms (such as Google GS101 and Exynos850). It supports
> +  both direct register-level access and firmware-mediated management
> +  via the ACPM (Alive Clock and Power Manager) firmware.
> +
> +  On these platforms, the hardware is managed in a hybrid fashion. The
> +  Application Processor (AP) maintains direct memory-mapped access
> +  exclusively to the interrupt pending registers to identify thermal
> +  events. All other functional aspects - including sensor
> +  initialization, threshold configuration, and temperature acquisition
> +  - are handled by the ACPM firmware. The AP coordinates these
> +  operations through the ACPM IPC protocol.
> +
> +properties:
> +  compatible:
> +    const: google,gs101-tmu-top
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: APB peripheral clock (PCLK) for TMU register access.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  samsung,acpm-ipc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the ACPM IPC node.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - "#thermal-sensor-cells"
> +  - samsung,acpm-ipc
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/google,gs101.h>
> +
> +    thermal-sensor@100a0000 {
> +        compatible = "google,gs101-tmu-top";
> +        reg = <0x100a0000 0x800>;
> +        clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
> +        interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
> +        #thermal-sensor-cells = <1>;
> +        samsung,acpm-ipc = <&acpm_ipc>;
> +    };
>
> --
> 2.54.0.1013.g208068f2d8-goog
>
