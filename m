Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193567;
	b=nZwsg7CB47pZuUdPLtzKqbiyIZcijItzl88bab0QsoMY2D34LBwr7d8iNSZN9eHRm3sc
	 4KW5N6AKf+rFFYhst+IUeHESo/SLxdZH1V4Zhtw8dkEjrnXgXIWzeGvQl7ZFfSl3h3Aua
	 gX1c6Ep9nEkg5PXJ5PTmTKSO8usIqp/MGdRSL1m/bdVUe01bgGFxNoLj7e4N2x795qOWd
	 a9lHM7vpc8uYvOfaalxHPGjPglRsXzEJDboNv6R+cJPLJ1FIGpQs/ywb+y7Cx0j01XgcV
	 VJfdkzrFEqCtCJ/7ww2YuVqwII9YvvT3NMwRJj686+uf4js3D0EO4TIw4TdYAaLtifA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193567;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1DNWJoUMee7BA1rq4YqQoJ4KY2u4Hp/IvSZrKafhkbo=;
	b=3sbH67xGLtvERIcgn8mh8pX+hbCi2GLFt7cWB9CZyZniEmHQRr6G8pCdvk5aDSNW8/no
	 l+qqCzrBmGyUOeHLmEEeptVMZZ4J/c+BJRLyQSdO6q3YTXMEDvRM+o/hiPpvru7kGjgk+
	 rkAdnE2AL9KDY8IwmEAjqlyMpUU2ZChCbPpLlOj/Uh5xFKRICJ6hxrSjKHUpUAN2YRffU
	 Ipti03PGugd9JDXhMptRGgluTXNLOoV8SPMWP6dkm059zhkUFKv6iqp6GO7k/mHwdGPbL
	 pvRjAQPb/Rg2PRkVM57gY52lp0adAfzmgm9z1sCLbKZtwN86nLuKuQM9r8ADb2ju4yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X98DRQRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A42606A31D;
	Wed, 28 Oct 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X98DRQRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2A61F01828;
	Wed, 28 Oct 2026 13:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193566;
	bh=1DNWJoUMee7BA1rq4YqQoJ4KY2u4Hp/IvSZrKafhkbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X98DRQRYt12rCjBMCSan/AGJnXZjh+c58zBFO+Xmjyvgz4T/YVi/Xjd6k/bURiHzI
	 6JU9Rzb+vM81pwcK3xi6y+YxHoPRMrIZz11ZFH8upTMt+xqbrQkPej5aYiQxLSl5AA
	 +h1QoKiuDrFFNPwS1zAgh3q+OORuRn1U+yoypmyHbZZWrr283QvChliKfMSmLX2Bjp
	 j0O4K+XMo6624KZNjzJ27d9RyInrV+LyNgT0tGfQ4fSBWaxTxpK8vKx0vGi3TEBEUt
	 JsblxgLOMtled4atpXetUAc5QQuYMoAA5AMdNpQBzvFrzsBbwSejjX4xxuJkD4iGW6
	 nkklFGALogGXQ==
Date: Wed, 28 Oct 2026 14:19:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	devicetree@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, Mariano Marciello <mmarciello@google.com>, 
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 2/9] dt-bindings: soc: google: Add Google Tensor CPM
 binding
Message-ID: <20261028-rapid-daffodil-rat-0adc6a@quoll>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.2.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>
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
In-Reply-To: <20261026144346.2.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>

On Mon, Oct 26, 2026 at 02:43:40PM -0700, Brian Norris wrote:
>  .../bindings/soc/google/google,lga-cpm.yaml   |  74 +++++++
>  include/dt-bindings/clock/google,lga-cpm.h    | 191 ++++++++++++++++++
>  .../interrupt-controller/irq-cpm-google.h     |  16 ++
>  include/dt-bindings/power/google,lga-cpm.h    |  79 ++++++++
>  .../dt-bindings/reset/google,lga-cpm-reset.h  | 175 ++++++++++++++++
>  include/dt-bindings/soc/google,lga-lpcm.h     |  54 +++++
>  6 files changed, 589 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml
>  create mode 100644 include/dt-bindings/clock/google,lga-cpm.h
>  create mode 100644 include/dt-bindings/interrupt-controller/irq-cpm-google.h
>  create mode 100644 include/dt-bindings/power/google,lga-cpm.h
>  create mode 100644 include/dt-bindings/reset/google,lga-cpm-reset.h
>  create mode 100644 include/dt-bindings/soc/google,lga-lpcm.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml b/Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml
> new file mode 100644
> index 000000000000..546e6c7fff80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml

Place it in power/ rather.

> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/google/google,lga-cpm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Central Power Manager (CPM)
> +
> +maintainers:
> +  - Brian Norris <briannorris@chromium.org>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Central Power Manager (CPM) is an on-chip power management subsystem
> +  found on Google Tensor SoCs. It has a variety of responsibilities, from DVFS
> +  and power management to resets, PMIC control, and even RTC management. The
> +  Application Processor communicates with CPM over a set of mailbox channels.
> +
> +properties:
> +  compatible:
> +    const: google,lga-cpm
> +
> +  mboxes:
> +    items:
> +      - description: TX mailbox channel for sending requests to CPM
> +      - description: RX mailbox channel for receiving responses from CPM
> +
> +  '#power-domain-cells':
> +    const: 1
> +    description: See <dt-bindings/power/google,lga-cpm.h> for power domain IDs.
> +
> +  '#reset-cells':
> +    const: 2
> +    description:
> +      Each reset is specified by an LPCM ID (cell 1) and a reset ID (cell 2).
> +      See <dt-bindings/soc/google,lga-lpcm.h> for LPCM IDs and
> +      <dt-bindings/reset/google,lga-cpm-reset.h> for reset IDs.
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +    description:
> +      Interrupt identifiers are assigned by CPM firmware. See
> +      <dt-bindings/interrupt-controller/irq-cpm-google.h> for interrupt IDs.
> +
> +  '#clock-cells':
> +    const: 2
> +    description:
> +      Each clock is specified by an LPCM ID (cell 1) and a clock ID (cell
> +      2). See <dt-bindings/soc/google,lga-lpcm.h> for LPCM IDs and
> +      <dt-bindings/clock/google,lga-cpm.h> for clock IDs.
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - '#clock-cells'
> +  - '#power-domain-cells'
> +  - '#reset-cells'
> +  - '#interrupt-cells'
> +  - interrupt-controller

Keep same order of properties here and in properties list, something
resembling alphabetical sorting without leading '#'.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cpm: cpm {

Drop unused label.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).
Most likely: power-controller if has power domains. power-management
otherwise.


> +        compatible = "google,lga-cpm";
> +        mboxes = <&cpm_ap_ns_req_mba>, <&cpm_ap_ns_resp_mba>;
> +        #clock-cells = <2>;
> +        #power-domain-cells = <1>;
> +        #reset-cells = <2>;
> +        #interrupt-cells = <1>;
> +        interrupt-controller;
> +    };
> diff --git a/include/dt-bindings/clock/google,lga-cpm.h b/include/dt-bindings/clock/google,lga-cpm.h
> new file mode 100644
> index 000000000000..6d5a5567226d
> --- /dev/null
> +++ b/include/dt-bindings/clock/google,lga-cpm.h
> @@ -0,0 +1,191 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H
> +#define __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H
> +
> +/*
> + * LPCM clock ID's of each SSWRPs
> + */
> +
> +#define LSIOS_GPIO_CLK			0
> +#define LSIOS_MCLK0_CLK			1
> +#define LSIOS_PWM_CLK			2
> +#define LSIOS_PWM_CFG_CLK		3
> +#define LSIOS_CLI0_CFG_CLK		4
> +#define LSIOS_CLI1_CFG_CLK		5
> +#define LSIOS_CLI2_CFG_CLK		6
> +#define LSIOS_CLI3_CFG_CLK		7
> +#define LSIOS_CLI4_CFG_CLK		8
> +#define LSIOS_CLI5_CFG_CLK		9
> +#define LSIOS_CLI6_CFG_CLK		10
> +#define LSIOS_CLI0_SPI_CLK		11
> +#define LSIOS_CLI1_SPI_CLK		12
> +#define LSIOS_CLI2_SPI_CLK		13
> +#define LSIOS_CLI3_SPI_CLK		14
> +#define LSIOS_CLI4_SPI_CLK		15
> +#define LSIOS_CLI5_SPI_CLK		16
> +#define LSIOS_CLI6_SPI_CLK		17
> +#define LSIOS_CLI0_I2C_CLK		18
> +#define LSIOS_CLI1_I2C_CLK		19
> +#define LSIOS_CLI2_I2C_CLK		20
> +#define LSIOS_CLI3_I2C_CLK		21
> +#define LSIOS_CLI4_I2C_CLK		22
> +#define LSIOS_CLI5_I2C_CLK		23
> +#define LSIOS_CLI6_I2C_CLK		24
> +#define LSIOS_CLI0_UART_CLK		25
> +#define LSIOS_CLI1_UART_CLK		26
> +#define LSIOS_CLI2_UART_CLK		27
> +#define LSIOS_CLI3_UART_CLK		28
> +#define LSIOS_CLI4_UART_CLK		29
> +#define LSIOS_CLI5_UART_CLK		30
> +#define LSIOS_CLI6_UART_CLK		31
> +#define LSIOS_CLI0_I3C_CLK		32
> +#define LSIOS_CLI1_I3C_CLK		33
> +#define LSIOS_CLI2_I3C_CLK		34
> +#define LSIOS_CLI3_I3C_CLK		35
> +#define LSIOS_CLI4_I3C_CLK		36
> +#define LSIOS_CLI5_I3C_CLK		37
> +#define LSIOS_CLI6_I3C_CLK		38
> +#define LSIOS_MCLK1_CLK			39
> +#define LSIOS_MCLK2_CLK			40
> +#define LSIOS_MCLK3_CLK			41
> +#define LSIOS_MCLK4_CLK			42
> +#define LSIOS_MCLK5_CLK			43
> +#define LSIOS_MCLK6_CLK			44
> +#define LSIOS_MCLK7_CLK			45
> +
> +#define LSION_GPIO_CLK			0
> +#define LSION_CLI_INT0_I2C_CLK		1
> +#define LSION_CLI_INT0_I3C_CLK		2
> +#define LSION_CLI_INT0_UART_CLK		3
> +#define LSION_CLI_INT0_SPI_CLK		4
> +#define LSION_CLI_INT0_CFG_CLK		5
> +#define LSION_CLI_INT1_I2C_CLK		6
> +#define LSION_CLI_INT1_I3C_CLK		7
> +#define LSION_CLI_INT1_UART_CLK		8
> +#define LSION_CLI_INT1_SPI_CLK		9
> +#define LSION_CLI_INT1_CFG_CLK		10
> +#define LSION_CLI_INT2_I2C_CLK		11
> +#define LSION_CLI_INT2_I3C_CLK		12
> +#define LSION_CLI_INT2_UART_CLK		13
> +#define LSION_CLI_INT2_SPI_CLK		14
> +#define LSION_CLI_INT2_CFG_CLK		15
> +#define LSION_CLI_INT3_I2C_CLK		16
> +#define LSION_CLI_INT3_I3C_CLK		17
> +#define LSION_CLI_INT3_UART_CLK		18
> +#define LSION_CLI_INT3_SPI_CLK		19
> +#define LSION_CLI_INT3_CFG_CLK		20
> +#define LSION_CLI_INT4_I2C_CLK		21
> +#define LSION_CLI_INT4_I3C_CLK		22
> +#define LSION_CLI_INT4_UART_CLK		23
> +#define LSION_CLI_INT4_SPI_CLK		24
> +#define LSION_CLI_INT4_CFG_CLK		25
> +#define LSION_CLI15_CFG_CLK		26
> +#define LSION_CLI16_CFG_CLK		27
> +#define LSION_CLI15_I2C_CLK		28
> +#define LSION_CLI16_I2C_CLK		29
> +#define LSION_CLI15_SPI_CLK		30
> +#define LSION_CLI16_SPI_CLK		31
> +#define LSION_CLI15_UART_CLK		32
> +#define LSION_CLI16_UART_CLK		33
> +#define LSION_CLI15_I3C_CLK		34
> +#define LSION_CLI16_I3C_CLK		35
> +
> +#define LSIOE_GPIO_CLK			0
> +#define LSIOE_CLI7_CFG_CLK		1
> +#define LSIOE_CLI8_CFG_CLK		2
> +#define LSIOE_CLI9_CFG_CLK		3
> +#define LSIOE_CLI10_CFG_CLK		4
> +#define LSIOE_CLI11_CFG_CLK		5
> +#define LSIOE_CLI12_CFG_CLK		6
> +#define LSIOE_CLI13_CFG_CLK		7
> +#define LSIOE_CLI14_CFG_CLK		8
> +#define LSIOE_CLI7_SPI_CLK		9
> +#define LSIOE_CLI8_SPI_CLK		10
> +#define LSIOE_CLI9_SPI_CLK		11
> +#define LSIOE_CLI10_SPI_CLK		12
> +#define LSIOE_CLI11_SPI_CLK		13
> +#define LSIOE_CLI12_SPI_CLK		14
> +#define LSIOE_CLI13_SPI_CLK		15
> +#define LSIOE_CLI14_SPI_CLK		16
> +#define LSIOE_CLI7_I2C_CLK		17
> +#define LSIOE_CLI8_I2C_CLK		18
> +#define LSIOE_CLI9_I2C_CLK		19
> +#define LSIOE_CLI10_I2C_CLK		20
> +#define LSIOE_CLI11_I2C_CLK		21
> +#define LSIOE_CLI12_I2C_CLK		22
> +#define LSIOE_CLI13_I2C_CLK		23
> +#define LSIOE_CLI14_I2C_CLK		24
> +#define LSIOE_CLI7_UART_CLK		25
> +#define LSIOE_CLI8_UART_CLK		26
> +#define LSIOE_CLI9_UART_CLK		27
> +#define LSIOE_CLI10_UART_CLK		28
> +#define LSIOE_CLI11_UART_CLK		29
> +#define LSIOE_CLI12_UART_CLK		30
> +#define LSIOE_CLI13_UART_CLK		31
> +#define LSIOE_CLI14_UART_CLK		32
> +#define LSIOE_SPMI_CLK			33
> +#define LSIOE_CLI7_I3C_CLK		34
> +#define LSIOE_CLI8_I3C_CLK		35
> +#define LSIOE_CLI9_I3C_CLK		36
> +#define LSIOE_CLI10_I3C_CLK		37
> +#define LSIOE_CLI11_I3C_CLK		38
> +#define LSIOE_CLI12_I3C_CLK		39
> +#define LSIOE_CLI13_I3C_CLK		40
> +#define LSIOE_CLI14_I3C_CLK		41
> +
> +#define HSIOS_MPHY_REF_OSC_CLK		0
> +#define HSIOS_MPHY_REF_TCX0_CLK		1
> +#define HSIOS_GPIO_REF_OSC_CLK		2
> +#define HSIOS_GPIO_REF_TCX0_CLK		3
> +#define HSIOS_HCLK_CLK			4
> +#define HSIOS_SYS_CLK			5
> +#define HSIOS_T_CLK			6
> +#define HSIOS_LP_T_CLK			7
> +#define HSIOS_MPHY_CFG_CLK		8
> +#define HSIOS_UFS_CFG_CLK		9
> +#define HSIOS_PHY_FW_CLK		10
> +#define HSIOS_PCIE_REF_CLK		11
> +#define HSIOS_UFS_RESET_CLK		12
> +#define HSIOS_UFS_LP_RESET_CLK		13
> +#define HSIOS_UFS_ARESET_CLK		14
> +#define HSIOS_UFS_PHY_RESET_CLK		15
> +#define HSIOS_AUX_CLK			16
> +
> +#define HSION_USB_CLK			0
> +#define HSION_DP0_CLK			1
> +#define HSION_DP1_CLK			2
> +#define HSION_PHY_FW_CLK		3
> +#define HSION_PCIE_REF_CLK		4
> +#define HSION_U2PHY_REF_CLK		5
> +#define HSION_USBDP_SUSPEND_CLK		6
> +#define HSION_USBC_NON_STICKY_CLK	7
> +#define HSION_USBC_STICKY_CLK		8
> +#define HSION_USB_DRD_BUS_CLK		9
> +#define HSION_CSR_CLK			10
> +#define HSION_USB_TOP_CSR_CLK		11
> +#define HSION_DP_PCLK_CLK		12
> +#define HSION_DP_CFG_CLK		13
> +#define HSION_U2PHY_APB_CLK		14
> +#define HSION_DP_VCC_CLK		15
> +#define HSION_U3PHY_REF_CLK		16
> +#define HSION_USB2_PHY_RESET_CLK	17
> +#define HSION_USB3DP_PHY_RESET_CLK	18
> +#define HSION_EBU_CLK			19
> +
> +#define DPU_DP0_PIX_CLK			0
> +#define DPU_DP1_PIX_CLK			1
> +#define DPU_DSI0_PIX_CLK		2
> +#define DPU_DSI1_PIX_CLK		3
> +#define DPU_DSI1_PHY_CLK		4
> +#define DPU_FE0_CLK			5
> +#define DPU_FE1_CLK			6
> +#define DPU_BE_CLK			7
> +#define DPU_AON_CLK			8
> +
> +#define GPCM_DPU_PLL_DP_CLK		0
> +#define GPCM_HSION_PLL_DP_CLK		1
> +
> +#define CPU_SSWRP_TSS_CLK		1
> +
> +#endif /* __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H */
> diff --git a/include/dt-bindings/interrupt-controller/irq-cpm-google.h b/include/dt-bindings/interrupt-controller/irq-cpm-google.h
> new file mode 100644
> index 000000000000..26d83bfe39af
> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/irq-cpm-google.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides constants for CPM IRQ.
> + *
> + * Copyright 2025-2026 Google LLC
> + *
> + */
> +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H
> +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H
> +
> +#define CPM_IRQ_RTC_ALARM_NO			0

Keep naming consistent. Clocks has _CLK suffix, so this should not use
prefix.


> +#define CPM_IRQ_AOC_MIN				7

Anyway, ABI constants should be indexed from 0 and incremented by 1.

> +#define CPM_IRQ_AOC_MAX				156
> +#define CPM_IRQ_AP_GDMC_WAKE			157
> +
> +#endif  /* _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H */
> diff --git a/include/dt-bindings/power/google,lga-cpm.h b/include/dt-bindings/power/google,lga-cpm.h
> new file mode 100644
> index 000000000000..4b35c59df2cc
> --- /dev/null
> +++ b/include/dt-bindings/power/google,lga-cpm.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H
> +#define __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H
> +
> +/* AOC */
> +#define LGA_PD_SSWRP_AOC		0

And here LGA prefix... this feels random.

> +#define LGA_PD_AOC_CORE			1
> +
> +/* AURORA */
> +#define LGA_PD_SSWRP_AURORA		2
> +
> +/* CODEC_3P */
> +#define LGA_PD_SSWRP_CODEC_3P		3
> +
> +/* DPU */
> +#define LGA_PD_DPU_DP			4
> +#define LGA_PD_SSWRP_DPU		5
> +#define LGA_PD_DPU_FE0			6
> +#define LGA_PD_DPU_FE1			7
> +#define LGA_PD_DPU_DSI0			8
> +#define LGA_PD_DPU_DSI1			9
> +
> +/* EH */
> +#define LGA_PD_SSWRP_EH			10
> +
> +/* G2D */
> +#define LGA_PD_SSWRP_G2D		11
> +#define LGA_PD_G2D_CORE			12
> +
> +/* GPDMA */
> +#define LGA_PD_SSWRP_GPDMA		13
> +
> +/* GPU */
> +#define LGA_PD_SSWRP_GPU		14
> +
> +/* GSW */
> +#define LGA_PD_SSWRP_GSW		15
> +
> +/* HSIO_N */
> +#define LGA_PD_SSWRP_HSIO_N		16
> +#define LGA_PD_HSIO_N_USB		17
> +#define LGA_PD_HSIO_N_USB_PSW		18
> +#define LGA_PD_HSIO_N_PCIE		19
> +#define LGA_PD_HSIO_N_DP		20
> +#define LGA_PD_HSIO_N_EBU		21
> +#define LGA_PD_HSIO_N_EBU_CORE		22
> +
> +/* HSIO_S */
> +#define LGA_PD_SSWRP_HSIO_S		23
> +#define LGA_PD_HSIO_S_UFS_PREP		24
> +#define LGA_PD_HSIO_S_UFS		25
> +#define LGA_PD_HSIO_S_PCIE		26
> +#define LGA_PD_HSIO_S_SD		27
> +
> +/* ISPBE */
> +#define LGA_PD_SSWRP_ISPBE		28
> +
> +/* ISPFE */
> +#define LGA_PD_SSWRP_ISPFE		29
> +#define LGA_PD_ISPFE_PIPE		30
> +#define LGA_PD_ISPFE_CSIS		31
> +
> +/* LSIO_E */
> +#define LGA_PD_SSWRP_LSIO_E		32
> +#define LGA_PD_LSIO_E_CLI_GPIO		33
> +
> +/* LSIO_N */
> +#define LGA_PD_SSWRP_LSIO_N		34
> +#define LGA_PD_LSIO_N_CLI_GPIO		35
> +
> +/* LSIO_S */
> +#define LGA_PD_SSWRP_LSIO_S		36
> +#define LGA_PD_LSIO_S_CLI_GPIO		37
> +
> +/* TPU */
> +#define LGA_PD_SSWRP_TPU		38
> +
> +#endif /* __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H */
> diff --git a/include/dt-bindings/reset/google,lga-cpm-reset.h b/include/dt-bindings/reset/google,lga-cpm-reset.h
> new file mode 100644
> index 000000000000..d147296dbffc
> --- /dev/null
> +++ b/include/dt-bindings/reset/google,lga-cpm-reset.h

Filename: google,lga-cpm.h

Keep things consistent. All the future contributors will duplicate every
issue you make here and then claim in discussion "but I saw existing
code like that".



> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef __DT_BINDINGS_RESET_GOOGLE_LGA_CPM_RESET_H
> +#define __DT_BINDINGS_RESET_GOOGLE_LGA_CPM_RESET_H
> +
> +/* HSION */
> +#define HSION_PCIE_PERST_RST			0
> +#define HSION_PCIE_APP_HOLD_PHY_RST		1
> +#define HSION_PCIE_INIT_RST			2
> +#define HSION_PCIE_PWR_UP_RST			3
> +#define HSION_USB_DP_CFG_RST			4
> +#define HSION_DP_PCLK_RST			5
> +#define HSION_USB_TOP_CSR_RST			6
> +#define HSION_PIXEL_CK0_RST			7
> +#define HSION_PIXEL_CK1_RST			8
> +#define HSION_U2PHY_APB_RST			9
> +#define HSION_USBC_NON_STICKY_RST		10
> +#define HSION_USBC_STICKY_RST			11
> +#define HSION_USB_DRD_BUS_RST			12
> +#define HSION_USB2_PHY_RESET			13
> +#define HSION_USB3DP_PHY_RESET			14
> +#define HSION_EBU_RST				15
> +
> +/* HSIOS */
> +#define HSIOS_PCIE_PERST_RST			0
> +#define HSIOS_PCIE_APP_HOLD_PHY_RST		1
> +#define HSIOS_PCIE_PWR_UP_RST			2
> +#define HSIOS_UFS_PHY_RST			3
> +#define HSIOS_PCIE_INIT_RST			4
> +
> +/* LSIOS */
> +#define LSIOS_CLI0_I2C_IC_CFG_RST		0
> +#define LSIOS_CLI0_I3C_IC_CFG_RST		1
> +#define LSIOS_CLI0_UART_IC_CFG_RST		2
> +#define LSIOS_CLI0_SPI_IC_CFG_RST		3
> +#define LSIOS_CLI1_I2C_IC_CFG_RST		4
> +#define LSIOS_CLI1_I3C_IC_CFG_RST		5
> +#define LSIOS_CLI1_UART_IC_CFG_RST		6
> +#define LSIOS_CLI1_SPI_IC_CFG_RST		7
> +#define LSIOS_CLI2_I2C_IC_CFG_RST		8
> +#define LSIOS_CLI2_I3C_IC_CFG_RST		9
> +#define LSIOS_CLI2_UART_IC_CFG_RST		10
> +#define LSIOS_CLI2_SPI_IC_CFG_RST		11
> +#define LSIOS_CLI3_I2C_IC_CFG_RST		12
> +#define LSIOS_CLI3_I3C_IC_CFG_RST		13
> +#define LSIOS_CLI3_UART_IC_CFG_RST		14
> +#define LSIOS_CLI3_SPI_IC_CFG_RST		15
> +#define LSIOS_CLI4_I2C_IC_CFG_RST		16
> +#define LSIOS_CLI4_I3C_IC_CFG_RST		17
> +#define LSIOS_CLI4_UART_IC_CFG_RST		18
> +#define LSIOS_CLI4_SPI_IC_CFG_RST		19
> +#define LSIOS_CLI5_I2C_IC_CFG_RST		20
> +#define LSIOS_CLI5_I3C_IC_CFG_RST		21
> +#define LSIOS_CLI5_UART_IC_CFG_RST		22
> +#define LSIOS_CLI5_SPI_IC_CFG_RST		23
> +#define LSIOS_CLI6_I2C_IC_CFG_RST		24
> +#define LSIOS_CLI6_I3C_IC_CFG_RST		25
> +#define LSIOS_CLI6_UART_IC_CFG_RST		26
> +#define LSIOS_CLI6_SPI_IC_CFG_RST		27
> +#define LSIOS_CLI0_SPI_IC_RST			28
> +#define LSIOS_CLI1_SPI_IC_RST			29
> +#define LSIOS_CLI2_SPI_IC_RST			30
> +#define LSIOS_CLI3_SPI_IC_RST			31
> +#define LSIOS_CLI4_SPI_IC_RST			32
> +#define LSIOS_CLI5_SPI_IC_RST			33
> +#define LSIOS_CLI6_SPI_IC_RST			34
> +#define LSIOS_CLI0_SPI_CFG_RST			35
> +#define LSIOS_CLI1_SPI_CFG_RST			36
> +#define LSIOS_CLI2_SPI_CFG_RST			37
> +#define LSIOS_CLI3_SPI_CFG_RST			38
> +#define LSIOS_CLI4_SPI_CFG_RST			39
> +#define LSIOS_CLI5_SPI_CFG_RST			40
> +#define LSIOS_CLI6_SPI_CFG_RST			41
> +#define LSIOS_PWM_IC_RST			42
> +#define LSIOS_PWM_CFG_RST			43
> +#define LSIOS_GPIO_IC_RST			44
> +
> +/* LSION */
> +#define LSION_CLI15_I2C_IC_CFG_RST		0
> +#define LSION_CLI15_I3C_IC_CFG_RST		1
> +#define LSION_CLI15_UART_IC_CFG_RST		2
> +#define LSION_CLI15_SPI_IC_CFG_RST		3
> +#define LSION_CLI16_I2C_IC_CFG_RST		4
> +#define LSION_CLI16_I3C_IC_CFG_RST		5
> +#define LSION_CLI16_UART_IC_CFG_RST		6
> +#define LSION_CLI16_SPI_IC_CFG_RST		7
> +#define LSION_CLI17_INT0_I2C_IC_CFG_RST		8
> +#define LSION_CLI17_INT0_I3C_IC_CFG_RST		9
> +#define LSION_CLI17_INT0_UART_IC_CFG_RST	10
> +#define LSION_CLI17_INT0_SPI_IC_CFG_RST		11
> +#define LSION_CLI18_INT1_I2C_IC_CFG_RST		12
> +#define LSION_CLI18_INT1_I3C_IC_CFG_RST		13
> +#define LSION_CLI18_INT1_UART_IC_CFG_RST	14
> +#define LSION_CLI18_INT1_SPI_IC_CFG_RST		15
> +#define LSION_CLI19_INT2_I2C_IC_CFG_RST		16
> +#define LSION_CLI19_INT2_I3C_IC_CFG_RST		17
> +#define LSION_CLI19_INT2_UART_IC_CFG_RST	18
> +#define LSION_CLI19_INT2_SPI_IC_CFG_RST		19
> +#define LSION_CLI20_INT3_I2C_IC_CFG_RST		20
> +#define LSION_CLI20_INT3_I3C_IC_CFG_RST		21
> +#define LSION_CLI20_INT3_UART_IC_CFG_RST	22
> +#define LSION_CLI20_INT3_SPI_IC_CFG_RST		23
> +#define LSION_CLI21_INT4_I2C_IC_CFG_RST		24
> +#define LSION_CLI21_INT4_I3C_IC_CFG_RST		25
> +#define LSION_CLI21_INT4_UART_IC_CFG_RST	26
> +#define LSION_CLI21_INT4_SPI_IC_CFG_RST		27
> +#define LSION_CLI15_SPI_IC_RST			28
> +#define LSION_CLI16_SPI_IC_RST			29
> +#define LSION_CLI17_INT0_SPI_IC_RST		30
> +#define LSION_CLI18_INT1_SPI_IC_RST		31
> +#define LSION_CLI19_INT2_SPI_IC_RST		32
> +#define LSION_CLI20_INT3_SPI_IC_RST		33
> +#define LSION_CLI21_INT4_SPI_IC_RST		34
> +#define LSION_CLI15_SPI_CFG_RST			35
> +#define LSION_CLI16_SPI_CFG_RST			36
> +#define LSION_CLI17_INT0_SPI_CFG_RST		37
> +#define LSION_CLI18_INT1_SPI_CFG_RST		38
> +#define LSION_CLI19_INT2_SPI_CFG_RST		39
> +#define LSION_CLI20_INT3_SPI_CFG_RST		40
> +#define LSION_CLI21_INT4_SPI_CFG_RST		41
> +#define LSION_GPIO_IC_RST			42
> +
> +/* LSIOE */
> +#define LSIOE_CLI7_I2C_IC_CFG_RST		0
> +#define LSIOE_CLI7_I3C_IC_CFG_RST		1
> +#define LSIOE_CLI7_UART_IC_CFG_RST		2
> +#define LSIOE_CLI7_SPI_IC_CFG_RST		3
> +#define LSIOE_CLI8_I2C_IC_CFG_RST		4
> +#define LSIOE_CLI8_I3C_IC_CFG_RST		5
> +#define LSIOE_CLI8_UART_IC_CFG_RST		6
> +#define LSIOE_CLI8_SPI_IC_CFG_RST		7
> +#define LSIOE_CLI9_I2C_IC_CFG_RST		8
> +#define LSIOE_CLI9_I3C_IC_CFG_RST		9
> +#define LSIOE_CLI9_UART_IC_CFG_RST		10
> +#define LSIOE_CLI9_SPI_IC_CFG_RST		11
> +#define LSIOE_CLI10_I2C_IC_CFG_RST		12
> +#define LSIOE_CLI10_I3C_IC_CFG_RST		13
> +#define LSIOE_CLI10_UART_IC_CFG_RST		14
> +#define LSIOE_CLI10_SPI_IC_CFG_RST		15
> +#define LSIOE_CLI11_I2C_IC_CFG_RST		16
> +#define LSIOE_CLI11_I3C_IC_CFG_RST		17
> +#define LSIOE_CLI11_UART_IC_CFG_RST		18
> +#define LSIOE_CLI11_SPI_IC_CFG_RST		19
> +#define LSIOE_CLI12_I2C_IC_CFG_RST		20
> +#define LSIOE_CLI12_I3C_IC_CFG_RST		21
> +#define LSIOE_CLI12_UART_IC_CFG_RST		22
> +#define LSIOE_CLI12_SPI_IC_CFG_RST		23
> +#define LSIOE_CLI13_I2C_IC_CFG_RST		24
> +#define LSIOE_CLI13_I3C_IC_CFG_RST		25
> +#define LSIOE_CLI13_UART_IC_CFG_RST		26
> +#define LSIOE_CLI13_SPI_IC_CFG_RST		27
> +#define LSIOE_CLI14_I2C_IC_CFG_RST		28
> +#define LSIOE_CLI14_I3C_IC_CFG_RST		29
> +#define LSIOE_CLI14_UART_IC_CFG_RST		30
> +#define LSIOE_CLI14_SPI_IC_CFG_RST		31
> +#define LSIOE_CLI7_SPI_IC_RST			32
> +#define LSIOE_CLI8_SPI_IC_RST			33
> +#define LSIOE_CLI9_SPI_IC_RST			34
> +#define LSIOE_CLI10_SPI_IC_RST			35
> +#define LSIOE_CLI11_SPI_IC_RST			36
> +#define LSIOE_CLI12_SPI_IC_RST			37
> +#define LSIOE_CLI13_SPI_IC_RST			38
> +#define LSIOE_CLI14_SPI_IC_RST			39
> +#define LSIOE_CLI7_SPI_CFG_RST			40
> +#define LSIOE_CLI8_SPI_CFG_RST			41
> +#define LSIOE_CLI9_SPI_CFG_RST			42
> +#define LSIOE_CLI10_SPI_CFG_RST			43
> +#define LSIOE_CLI11_SPI_CFG_RST			44
> +#define LSIOE_CLI12_SPI_CFG_RST			45
> +#define LSIOE_CLI13_SPI_CFG_RST			46
> +#define LSIOE_CLI14_SPI_CFG_RST			47
> +#define LSIOE_GPIO_IC_RST			48
> +#define LSIOE_SPMI_RST				49
> +
> +#endif /* __DT_BINDINGS_RESET_GOOGLE_LGA_CPM_RESET_H */
> diff --git a/include/dt-bindings/soc/google,lga-lpcm.h b/include/dt-bindings/soc/google,lga-lpcm.h
> new file mode 100644
> index 000000000000..d1944afff2b9
> --- /dev/null
> +++ b/include/dt-bindings/soc/google,lga-lpcm.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H
> +#define __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H
> +
> +/*
> + * LPCM IDs of each SSWRP.
> + */
> +#define LGA_LPCM_CPM			0

What are all these?

Best regards,
Krzysztof

