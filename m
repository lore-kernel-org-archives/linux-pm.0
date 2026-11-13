Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568951;
	b=beFsDFqXeP58FIFC3wOx9iBfmPYxXekXkg+TcG9dj2NvdgBHMg905Br/55MIkgTxly4F
	 iRRBFTM9GF1stWe2z9lBtv4mzg8nZlcTo9WTDM5z//joy+XdYtCPdMef2EkntVOyQt1Nm
	 2N7b5Hyw+VMncK64Fs7nLNNru9uwnmTRhI13itxIvsM2A0Db45T6BtEmB7xgRtUFRQPJS
	 PWWFOnMlrR7gBUQr+MY52TkRzhOAdFBgMum/Nn0Og4O7L5aB0f2z4r5H1+HH8FRoDuIEu
	 yi/RDOEUWZ4Sx2mMma7vbf5vXJ2XybWjUW3rUYtvBsjawfQERpIwzpEI8MTctedE9tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568951;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yGlIyfBjIJAxL3beSaCSyFhTL6UntSgouor70UsS65I=;
	b=5PkGihqsQMXe9lJXNuob7j7u508T5F2eC/NpdIkLfq+xJG4Am0hRbD/L6vA9q6MMw7e+
	 IucH3QdDVYicWv9vqegQfZwkzcSiKBFgRKn52J/z6la0tOk+zYX5Y38Y/n72y3qqP3hS3
	 zyYBphv/WloZSskIMP+GgMWS8L+TAuLmUqmZkqOldhComKSWX96BfESdmr7YQzApWSC+w
	 S1ufvmClhCi68ofoixrv86GHLJfx9UCSCP2dHJeXMHirG4qnur9K4Z1yA0/CTC+lzaqvv
	 byigB4SVBU4UR6OG+77Zldon5tCLSdbdZIpWbRm4a2jzYhaoF4TrU/bVM7WA5ThIatQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpoiwbAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A887606A323;
	Fri, 13 Nov 2026 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpoiwbAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684701F000C4;
	Fri, 13 Nov 2026 11:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568951;
	bh=yGlIyfBjIJAxL3beSaCSyFhTL6UntSgouor70UsS65I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mpoiwbAbdQG4fU1wY/HFh9WYX1+1lLXSVrGTM3ZFqZ8dx+2vg1TOix4X4rkBKErnz
	 vTj1Tlih3sj4jKQqz+IPqsPvImGDnmhE99QX+GQPJc7QMzo8OaOMwPKHXQwzD5EMF0
	 NRFYswrERm1Sh/DPQyB90Ag2IZqwBvCZQAvxYD92qMDy29yrk7AUoqNM70UiUJxOdD
	 P8h1jAeoSeJOrx8yh4FJHKOCURawoPuMZJ3I78CsLVEjZfSbEJnMhXLZBvjvawRdSz
	 fm2Aml+5vSOvfxOTMMSWc9UXNYUb/rRoQ40jL2r1hvlxllLZCYTMjwfetqIvkPQMSp
	 aLHrZD5g1WUCQ==
Date: Fri, 13 Nov 2026 12:22:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marc Lainez <marc.lainez@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, phone-devel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: power: supply: add Qualcomm QGauge fuel
 gauge
Message-ID: <20261113-terrestrial-outgoing-camel-fad1a1@quoll>
References: <20261112170841.2189322-1-val@packett.cool>
 <20261112170841.2189322-2-val@packett.cool>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112170841.2189322-2-val@packett.cool>

On Thu, Nov 12, 2026 at 02:07:27PM -0300, Val Packett wrote:
> From: Marc Lainez <marc.lainez@gmail.com>
> 
> Document the QGauge fuel-gauge block handled by the qcom_qg driver, with
> compatibles for the PMI632 and PM6150 PMICs.
> 
> Signed-off-by: Marc Lainez <marc.lainez@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  .../bindings/power/supply/qcom,qg.yaml        | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,qg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,qg.yaml b/Documentation/devicetree/bindings/power/supply/qcom,qg.yaml
> new file mode 100644
> index 000000000000..79dd18d87879
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,qg.yaml

Filename should match one of the compatibles.

> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/qcom,qg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QGauge Fuel Gauge
> +
> +maintainers:
> +  - Val Packett <val@packett.cool>
> +
> +description:
> +  The QGauge (QG) block found in some Qualcomm PMICs (PM6150, PMI632)
> +  provides battery fuel gauging through hardware voltage and current
> +  FIFO sampling, open circuit voltage (OCV) measurement, and coulomb
> +  counting. The hardware has a multi-state FSM (S1-S7) that automatically
> +  transitions between active sampling and low-power sleep states.
> +
> +allOf:
> +  - $ref: /schemas/power/supply/power-supply.yaml#
> +  - $ref: /schemas/nvmem/nvmem-consumer.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm6150-qg
> +      - qcom,pmi632-qg
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Battery missing interrupt
> +      - description: Battery voltage low interrupt
> +      - description: Battery voltage empty interrupt
> +      - description: FIFO data update done interrupt
> +      - description: Good OCV measured interrupt
> +      - description: FSM state change interrupt
> +      - description: QG event interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: batt-missing
> +      - const: vbat-low
> +      - const: vbat-empty
> +      - const: fifo-done
> +      - const: good-ocv
> +      - const: fsm-state-chg
> +      - const: event
> +
> +  io-channels:
> +    items:
> +      - description: ADC channel for battery thermistor temperature
> +
> +  io-channel-names:
> +    items:
> +      - const: batt-therm
> +
> +  monitored-battery: true

drop

> +
> +  nvmem: true

Missing constraints


> +
> +  power-supplies: true

Drop

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - monitored-battery
> +
> +additionalProperties: false

unevaluatedProperties instead

> +
> +examples:

Best regards,
Krzysztof

