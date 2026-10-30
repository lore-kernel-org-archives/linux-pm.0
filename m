Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396296;
	b=H29LjLuv9zf2aTeJ/nt/NBryw1u19vw/wlqezBYj/wvDWBdhDEoH2Vm9qPJzNgor2Wiq
	 K/Em6m07g4OzljZAQIfIXAIUo9yNlKWsivneAjZdSzqtuxbMKRe19Eb6i+JFyMkAnQzQU
	 esEGVR++bIXtLPcZ1iTJlVh6YDoFcmWha2JfMJpCoTVrb90zJlE8irEUvfTwIUjawhvRT
	 mCdIatYLqMTXSIIUXG+8jKb4eIo+LcRXTcXEOhneDRoNGECWh6fOnfTajh3ai5UuLCATJ
	 9rvvS2QPw2QAm9uywyOooJ8rWrd+GnpZAmLVpAF8Eintj5QOfWh+KXhBJL9rcMhGkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396296;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hPwxOiEv9fBE8aIWPVa1/bgdvb4W/YMWcaiy5lCsNN4=;
	b=COXxGm/3Akqf8/2v3M47JkPY6xixziXmsSCZ5W57DciZOsACkhr8LEjRfWpNR+CufpLF
	 20YdLsdgrRAi7U55kQKy0PXN6g6zvOwEy/CfBHwPEd2e3nL1nNvchRKDUdH6oKug0+OpT
	 nSWy4xSDWc3fHwlK7EW7g3+FBC7DRZjyIPJIW6UE5TX1rubY8KR5KDWfGNAEWYJne+PGE
	 3P2K9I6nT3q8r31LuHQjQLiJv01r6Bk7d7/ZKSH7Xp1TERKO8+acybIe3MoZDOCdVqp41
	 FMQOuNWBWlCGWaICAqThyAfwbv4KWhHXYb9GK6dofltK32zgIvGjDOuFqeWwZ9Sw/AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b="Q6f/BoxD";
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCED606A325;
	Fri, 30 Oct 2026 21:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCED606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Q6f/BoxD
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3638B4B0;
	Fri, 30 Oct 2026 22:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793396150;
	bh=mhvqEixdDbdzdKOTvnXWf9scL4yTOZMFHRlK1GjWEZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6f/BoxDuUcNEpgNKmjpwv32hVuO7+97TwlOliyS1O/NIMXvvAQ8L6jJHeSv03vnS
	 xeq1/GzIVeX91waAx0db4Lc2QSu82iVn41eCtBV7gl01Ljz9mX9KDyngeAdXc7+rPk
	 tqPPPFGL+DGl2ZQwVoILu/+gSyPzypQSBUyQAesk=
Date: Fri, 30 Oct 2026 23:38:03 +0200
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
Subject: Re: [PATCH DNI v3 05/15] arm64: renesas: r8a78000: Add VSP[BI] nodes
Message-ID: <20261030213803.GC3178046@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-5-e052903a3832@ideasonboard.com>
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
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-5-e052903a3832@ideasonboard.com>

Hi Paul,

On Thu, Oct 15, 2026 at 04:51:45PM +0900, Paul Elder wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Add DT nodes for the VSPB and VSPI IP cores in the R-Car X5H SoC.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a78000.dtsi | 99 +++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> index 2f8886f8b6545026397fd83969882f8c62afa9d3..f90b869579d384e3fc13d0a13625b7cddaac2868 100644
> --- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> @@ -1072,6 +1072,105 @@ fcpvb4: fcp@c503c000 {
>  			resets = <&mdlc_vio 0x106>;
>  		};
>  
> +		vspi0: vsp@c5080000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc5080000 0 0x8000>;
> +			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;

For the reason explained in 04/15, I would use
R8A78000_CPG_SGD1_VIO_DP_OTHER here and below.

> +			power-domains = <&mdlc_vio 0x07 0xfe>;
> +			resets = <&mdlc_vio 0xfe>;
> +
> +			renesas,fcp = <&fcpvi0>;
> +		};
> +
> +		vspi1: vsp@c5088000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc5088000 0 0x8000>;
> +			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
> +			power-domains = <&mdlc_vio 0x07 0xff>;
> +			resets = <&mdlc_vio 0xff>;
> +
> +			renesas,fcp = <&fcpvi1>;
> +		};
> +
> +		vspi2: vsp@c5090000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc5090000 0 0x8000>;
> +			interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
> +			power-domains = <&mdlc_vio 0x07 0x100>;
> +			resets = <&mdlc_vio 0x100>;
> +
> +			renesas,fcp = <&fcpvi2>;
> +		};
> +
> +		vspi3: vsp@c5098000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc5098000 0 0x8000>;
> +			interrupts = <GIC_SPI 646 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
> +			power-domains = <&mdlc_vio 0x07 0x101>;
> +			resets = <&mdlc_vio 0x101>;
> +
> +			renesas,fcp = <&fcpvi3>;
> +		};
> +
> +		vspb0: vsp@c50c0000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc50c0000 0 0x8000>;
> +			interrupts = <GIC_SPI 618 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
> +			power-domains = <&mdlc_vio 0x07 0xf9>;
> +			resets = <&mdlc_vio 0xf9>;
> +
> +			renesas,fcp = <&fcpvb0>;
> +		};
> +
> +		vspb1: vsp@c50c8000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc50c8000 0 0x8000>;
> +			interrupts = <GIC_SPI 619 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
> +			power-domains = <&mdlc_vio 0x07 0xfa>;
> +			resets = <&mdlc_vio 0xfa>;
> +
> +			renesas,fcp = <&fcpvb1>;
> +		};
> +
> +		vspb2: vsp@c50d0000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc50d0000 0 0x8000>;
> +			interrupts = <GIC_SPI 620 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
> +			power-domains = <&mdlc_vio 0x07 0xfb>;
> +			resets = <&mdlc_vio 0xfb>;
> +
> +			renesas,fcp = <&fcpvb2>;
> +		};
> +
> +		vspb3: vsp@c50d8000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc50d8000 0 0x8000>;
> +			interrupts = <GIC_SPI 621 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
> +			power-domains = <&mdlc_vio 0x07 0xfc>;
> +			resets = <&mdlc_vio 0xfc>;
> +
> +			renesas,fcp = <&fcpvb3>;
> +		};
> +
> +		vspb4: vsp@c50e0000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xc50e0000 0 0x8000>;
> +			interrupts = <GIC_SPI 622 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
> +			power-domains = <&mdlc_vio 0x07 0xfd>;
> +			resets = <&mdlc_vio 0xfd>;
> +
> +			renesas,fcp = <&fcpvb4>;
> +		};
> +
>  		mdlc_cmnn: system-controller@ca410000 {
>  			compatible = "renesas,r8a78000-mdlc";
>  			reg = <0 0xca410000 0 0x1000>;

-- 
Regards,

Laurent Pinchart
