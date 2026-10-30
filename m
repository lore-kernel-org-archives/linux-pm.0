Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396556;
	b=Tdq14HnhVSOyr9LkJBrhh7UmE7R3gwWZRNCkfAFwURuCQ72g5i/BIdYvhI295NkX1VSL
	 NXhoeeuSeZNLmP7BcMrbl3RSIu3Rc9KGW2PdRLusWcu7ZLpeU1BE62+mL9FCTVQq9jjzh
	 zrkL3puu6sA77ZSSZexbs7ydyPFddqlYwCSVcT7S/afPcWULVFxJwc/PXnJugy3/bTvJm
	 Suvadio/RwAbOQOxeXM7tSfvFiC2yTTiEvjW1/Dv5QsFq5xq4TVEx18dgCPbyvHvD5T4D
	 6lISBr37JUefoXW0KZQ6ym8naVxfn+CUdmuGaQVtEqe7waXVnDIOsBeXhFPja6+q+fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396556;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=MKTjykgOrfu8wOjfiCiCsH0c4SWntncXs+RHHtQtSKQ=;
	b=OUuUHjRELoS+Q4KjlWQSIwkzL94uyW2l/7YtLTb4zrVhSmq7H7dHgidEGyl3f48uGng8
	 kMMt0C3BeYvZw/DyU2nxg7fnZDA7ZC9Hyn4XCYDe3JMi/kpwDBMQyTcD+GxYGtxMty3T/
	 Ju0h+sNTGVMQpBVMYo66/JoHFVvhvwVidkid5/s3P5KB3kVKdBIN5JamdgSAZsyUehm1v
	 Cmc+qyiuUz/MThR9xrQIRzOzdOos/DB9VARcObEVRswm/Yk223eDn3odotc/LG9K2nydd
	 jbwkkbcSrNoDai6q11p7GM8fWtYD419MFi7yX1lpoCuhX7A7bR4pcXX3khoZ2/bs7wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=N0Fv6Bbn;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EA606A31A;
	Fri, 30 Oct 2026 21:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 392EA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=N0Fv6Bbn
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A79F54B0;
	Fri, 30 Oct 2026 22:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793396419;
	bh=pSxZ+QaQ6ZAohSdLzR1ic1dMjgxEy0yHWUi6G16l+P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0Fv6BbnIchUv7KqlNQe175TG1jrN0eVa8331bV1qhssgBRq+mdtjEFYZ4e2TlUXO
	 Ie3D2izCAq/zhook2Zgf4P5l9y/mHSdDvqT0+EHC+JKIoQDgQJUXX/NA/UboKt4q9U
	 rvNzpcUn9P1wJpqrUNxvNafF93skzILwPIZ0ZmOw=
Date: Fri, 30 Oct 2026 23:42:32 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH DNI v3 06/15] arm64: renesas: r8a78000: Add FCPVD and
 VSPD nodes
Message-ID: <20261030214232.GD3178046@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-6-e052903a3832@ideasonboard.com>
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
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-6-e052903a3832@ideasonboard.com>

On Thu, Oct 15, 2026 at 04:51:46PM +0900, Paul Elder wrote:
> Add DT nodes for the FCPVD and VSPD IP cores in the R-Car X5H SoC.
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> ---
> Changes in v3:
> - Fix the mapping between VSPD and FCPVD nodes so that they all work

That was a good catch. I think the weird mapping comes from how the VSPD
instances are connected to VCON groups:

- VCON group 0 (VCON[0123], DPTX0): VSPDa0, VSPDa1, VSPDb0, VSPDb1
- VCON group 1 (VCON[4567], DPTX1): VSPDa2, VSPDa3, VSPDb2, VSPDb3
- VCON group 2 (VCON[89], DPTX2): VSPDa4, VSPDb4

> ---
>  arch/arm64/boot/dts/renesas/r8a78000.dtsi | 190 ++++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> index f90b869579d384e3fc13d0a13625b7cddaac2868..1fa4896739110de1e445bfcd631d4937bda40714 100644
> --- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> @@ -1000,6 +1000,196 @@ mdlc_aon: system-controller@c1338000 {
>  			bootph-all;
>  		};
>  
> +		fcpvd0: fcp@c5010000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5010000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;

Here (and below) too I would use SGD1.

> +			power-domains = <&mdlc_vio 0x07 0x7e>;
> +			resets = <&mdlc_vio 0x7e>;
> +		};
> +
> +		fcpvd1: fcp@c5011000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5011000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x7f>;
> +			resets = <&mdlc_vio 0x7f>;
> +		};
> +
> +		fcpvd2: fcp@c5012000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5012000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x80>;
> +			resets = <&mdlc_vio 0x80>;
> +		};
> +
> +		fcpvd3: fcp@c5013000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5013000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x81>;
> +			resets = <&mdlc_vio 0x81>;
> +		};
> +
> +		fcpvd4: fcp@c5014000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5014000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x82>;
> +			resets = <&mdlc_vio 0x82>;
> +		};
> +
> +		fcpvd5: fcp@c5015000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5015000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x83>;
> +			resets = <&mdlc_vio 0x83>;
> +		};
> +
> +		fcpvd6: fcp@c5016000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5016000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x84>;
> +			resets = <&mdlc_vio 0x84>;
> +		};
> +
> +		fcpvd7: fcp@c5017000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5017000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x85>;
> +			resets = <&mdlc_vio 0x85>;
> +		};
> +
> +		fcpvd8: fcp@c5018000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5018000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x86>;
> +			resets = <&mdlc_vio 0x86>;
> +		};
> +
> +		fcpvd9: fcp@c5019000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5019000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x87>;
> +			resets = <&mdlc_vio 0x87>;
> +		};
> +
> +		vspd0: vsp@c4800000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4800000 0 0x8000>;
> +			interrupts = <GIC_SPI 623 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x70>;
> +			resets = <&mdlc_vio 0x70>;
> +
> +			renesas,fcp = <&fcpvd0>;
> +		};
> +
> +		vspd1: vsp@c4808000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4808000 0 0x8000>;
> +			interrupts = <GIC_SPI 624 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x71>;
> +			resets = <&mdlc_vio 0x71>;
> +
> +			renesas,fcp = <&fcpvd1>;
> +		};
> +
> +		vspd2: vsp@c4810000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4810000 0 0x8000>;
> +			interrupts = <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x72>;
> +			resets = <&mdlc_vio 0x72>;
> +
> +			renesas,fcp = <&fcpvd4>;
> +		};
> +
> +		vspd3: vsp@c4818000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4818000 0 0x8000>;
> +			interrupts = <GIC_SPI 626 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x73>;
> +			resets = <&mdlc_vio 0x73>;
> +
> +			renesas,fcp = <&fcpvd5>;
> +		};
> +
> +		vspd4: vsp@c4820000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4820000 0 0x8000>;
> +			interrupts = <GIC_SPI 627 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x74>;
> +			resets = <&mdlc_vio 0x74>;
> +
> +			renesas,fcp = <&fcpvd8>;
> +		};
> +
> +		vspdb0: vsp@c4828000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4828000 0 0x8000>;
> +			interrupts = <GIC_SPI 628 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x75>;
> +			resets = <&mdlc_vio 0x75>;
> +
> +			renesas,fcp = <&fcpvd2>;
> +		};
> +
> +		vspdb1: vsp@c4830000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4830000 0 0x8000>;
> +			interrupts = <GIC_SPI 629 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x76>;
> +			resets = <&mdlc_vio 0x76>;
> +
> +			renesas,fcp = <&fcpvd3>;
> +		};
> +
> +		vspdb2: vsp@c4838000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4838000 0 0x8000>;
> +			interrupts = <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x77>;
> +			resets = <&mdlc_vio 0x77>;
> +
> +			renesas,fcp = <&fcpvd6>;
> +		};
> +
> +		vspdb3: vsp@c4840000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4840000 0 0x8000>;
> +			interrupts = <GIC_SPI 631 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x78>;
> +			resets = <&mdlc_vio 0x78>;
> +
> +			renesas,fcp = <&fcpvd7>;
> +		};
> +
> +		vspdb4: vsp@c4848000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc4848000 0 0x8000>;
> +			interrupts = <GIC_SPI 632 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x79>;
> +			resets = <&mdlc_vio 0x79>;
> +
> +			renesas,fcp = <&fcpvd9>;
> +		};
> +
>  		fcpvi0: fcp@c5030000 {
>  			compatible = "renesas,fcpv";
>  			reg = <0 0xc5030000 0 0x1000>;
> 

-- 
Regards,

Laurent Pinchart
