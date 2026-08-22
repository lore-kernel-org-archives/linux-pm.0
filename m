Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5333A9E1;
	Sat, 22 Aug 2026 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787384343; cv=none; b=bkirich2ja13iSm10tCC9U01tcMF83WuhLRO4o5boIYhVExIkL9nG5LLZk2yJfoNsnWfZZKetj+8B3mDkyng8HQWNzctXtZfZJ69QeTH4ENqYSCXMi3zGpHEnJKHL1T9VBoQPKpijZc4LKoK6x7WU5FsfR3pO3ueqVpw4kdwGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787384343; c=relaxed/simple;
	bh=20a6T6gfT4W5qmnR0IrhYYQg42UJNxpelFM+vKlIzts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6h9zTHKxz9GkPK8xzBMBI0EQLehqjfVRlwfd0g4T3mool/8M/ffEZY9tz1NbVnuEhTqhUhNxxSfm6oOGPKNZ9D7bEQd2l+oyKfTpNjxRo4+GOJMzYb0yPONaKyvdYLiE8UmcQbOPGb4S86T3NVw8WsIJFq3dAPf0t7Iz7wmaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1glk2k4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1glk2k4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A530C1F000E9;
	Sat, 22 Aug 2026 07:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787384341;
	bh=yxr1RTUyhpEzexigkTUOYj2YkjiALBk7cwuLfHLoWhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=b1glk2k40qB8dX5lLhDAvudDvtFkuzSyLzo1JY5Q8j0hSsZJ3NJ2LML6TlRZ5GswT
	 7Ekgb/1vALB6v3GCqYm4j6jQk3xUYf9F1ru/ECBWGYj24rF2szfwIvvh9ev7wUZjb9
	 CslsXIxNbyT5Oopd28Tfpy46F4KWB3qThbkelu9NZE5f0dbPaaXos3RLypkCxgFJOf
	 hK031J0UNOUjGRzBOftKd1DgmvSvekyVRkObuLtwrbDNRHJUh2QOQHxcMcdvKKNnhO
	 GGb6r7Ew0Wjw9raX13M8l4WMm+xAdU/Y2JbxwTsQpWSUk/E/l1eswlVQ/7bExIHYhm
	 bIEnRjhLtaSXg==
Message-ID: <bb0972e8-852f-48b5-82c3-325962e0f743@kernel.org>
Date: Sat, 22 Aug 2026 09:38:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] arm64: dts: renesas: Add initial SoC DTSI for
 RZ/G2M v3.0
To: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-9-ayman.chaudhry.kc@renesas.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260821150408.73829-9-ayman.chaudhry.kc@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2026 17:03, Ayman Chaudhry wrote:
> Add initial Device Tree Source Include (DTSI) file for the Renesas
> RZ/G2M v3.0 (a.k.a. R8A774A3) SoC with basic support.
> 
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a774a3.dtsi | 302 ++++++++++++++++++++++
>  1 file changed, 302 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3.dtsi
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a774a3.dtsi b/arch/arm64/boot/dts/renesas/r8a774a3.dtsi
> new file mode 100644
> index 000000000000..f60a31612b39
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a774a3.dtsi
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the r8a774a3 SoC
> + *
> + * Copyright (C) 2026 Renesas Electronics Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/r8a774a3-cpg-mssr.h>
> +#include <dt-bindings/power/r8a774a3-sysc.h>
> +
> +/ {
> +	compatible = "renesas,r8a774a3";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&gic>;
> +
> +	cluster0_opp: opp-table-0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +		};
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +		};
> +		opp-1500000000 {
> +			opp-hz = /bits/ 64 <1500000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +			opp-suspend;
> +		};
> +	};
> +
> +	cluster1_opp: opp-table-1 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +		};
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +		};
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&a57_0>;
> +				};
> +				core1 {
> +					cpu = <&a57_1>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&a53_0>;
> +				};
> +				core1 {
> +					cpu = <&a53_1>;
> +				};
> +				core2 {
> +					cpu = <&a53_2>;
> +				};
> +				core3 {
> +					cpu = <&a53_3>;
> +				};
> +			};
> +		};
> +
> +		a57_0: cpu@0 {
> +			compatible = "arm,cortex-a57";
> +			reg = <0x0>;
> +			device_type = "cpu";
> +			power-domains = <&sysc R8A774A3_PD_CA57_CPU0>;
> +			next-level-cache = <&L2_CA57>;
> +			enable-method = "psci";
> +			dynamic-power-coefficient = <854>;
> +			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		a57_1: cpu@1 {
> +			compatible = "arm,cortex-a57";
> +			reg = <0x1>;
> +			device_type = "cpu";
> +			power-domains = <&sysc R8A774A3_PD_CA57_CPU1>;
> +			next-level-cache = <&L2_CA57>;
> +			enable-method = "psci";
> +			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		a53_0: cpu@100 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			device_type = "cpu";
> +			power-domains = <&sysc R8A774A3_PD_CA53_CPU0>;
> +			next-level-cache = <&L2_CA53>;
> +			enable-method = "psci";
> +			dynamic-power-coefficient = <277>;
> +			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z2>;
> +			operating-points-v2 = <&cluster1_opp>;
> +			capacity-dmips-mhz = <560>;
> +		};
> +
> +		a53_1: cpu@101 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x101>;
> +			device_type = "cpu";
> +			power-domains = <&sysc R8A774A3_PD_CA53_CPU1>;
> +			next-level-cache = <&L2_CA53>;
> +			enable-method = "psci";
> +			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z2>;
> +			operating-points-v2 = <&cluster1_opp>;
> +			capacity-dmips-mhz = <560>;
> +		};
> +
> +		a53_2: cpu@102 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x102>;
> +			device_type = "cpu";
> +			power-domains = <&sysc R8A774A3_PD_CA53_CPU2>;
> +			next-level-cache = <&L2_CA53>;
> +			enable-method = "psci";
> +			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z2>;
> +			operating-points-v2 = <&cluster1_opp>;
> +			capacity-dmips-mhz = <560>;
> +		};
> +
> +		a53_3: cpu@103 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x103>;
> +			device_type = "cpu";
> +			power-domains = <&sysc R8A774A3_PD_CA53_CPU3>;
> +			next-level-cache = <&L2_CA53>;
> +			enable-method = "psci";
> +			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z2>;
> +			operating-points-v2 = <&cluster1_opp>;
> +			capacity-dmips-mhz = <560>;
> +		};
> +
> +		L2_CA57: cache-controller-0 {
> +			compatible = "cache";
> +			power-domains = <&sysc R8A774A3_PD_CA57_SCU>;
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		L2_CA53: cache-controller-1 {
> +			compatible = "cache";
> +			power-domains = <&sysc R8A774A3_PD_CA53_SCU>;
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +	};
> +
> +	extal_clk: extal {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board */
> +		clock-frequency = <0>;
> +		bootph-all;
> +	};
> +
> +	extalr_clk: extalr {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board */
> +		clock-frequency = <0>;
> +		bootph-all;
> +	};
> +
> +	pmu_a53 {

Please, do not send us downstream code. It looks awfully like one. It's
long time fixed in all upstream platforms. Also, this causes now warnings.

Best regards,
Krzysztof
