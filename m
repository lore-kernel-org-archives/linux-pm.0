Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E992348C5D;
	Fri, 18 Sep 2026 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694525; cv=none; b=QYQBhbzPUU3rG/P/6ozATBukkHzVBIJWeq6sH5Rh194+Ry7N5M7GHz4kZcJWzUeSg6W8els07T2CL7vEmgeermUzF4WdrxGuVNkZR+iRC/F9bj/xn4DXiq4DUrblrn+ikDdJs7c6qg5gQaxLaEHUZ5PaxHvyJvpCWoXPUkz5dJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694525; c=relaxed/simple;
	bh=NprK1WE9s3afYX1CixzE73TQnctfnNwedCGApWOmWMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2582nnR0ySl3E+D+RTLTK4mDuC99O+NiZIvXj9QrJLNDDLAysAFp7cN15FbktoJD4VwJiUUxnGfeFxJksqZJQC1+toxTfaw5zQ0qHkqEQEeoZb0DD09uhWv//BFoqcvu0Y1Pa3mDFjQG85Frg9SCuVL3UqczgZdOpK+VSY36/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wEdblEIK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wEdblEIK"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17B2F22B;
	Fri, 18 Sep 2026 03:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789694412;
	bh=NprK1WE9s3afYX1CixzE73TQnctfnNwedCGApWOmWMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wEdblEIKiyuK2mnqAv4nJMPuvyp2wZf+lFda6iKz6tSiS2G+Ql2LdV3P+3S587Pc/
	 mjgQhunI9jjO6YYOSUBCExS4sALF+WhMbyltG4SltqE5Gq/yRgnPyFZUgWCJwGG98n
	 hzvOpBDLfHRbQCfR2ZQmLpV+0TesSw5YxPNB2j4M=
Date: Fri, 18 Sep 2026 04:21:53 +0300
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
Subject: Re: [PATCH 05/10] arm64: renesas: r8a78000: Add VSP[BI] nodes
Message-ID: <20260918012153.GE145152@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-5-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-5-4c72d4e086dd@ideasonboard.com>

On Thu, Sep 17, 2026 at 09:04:44PM +0900, Paul Elder wrote:
> Add DT nodes for the VSPB and VSPI IP cores in the R-Car X5H Soc.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
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

Same comment as for 04/10.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

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
