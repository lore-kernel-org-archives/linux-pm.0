Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E8385D7B;
	Fri, 18 Sep 2026 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694344; cv=none; b=q5rZMrzk1jaPWFV4TqQJ1k08cAKV3uQ3Vges0HdtZ+U+EBl3v1TImdZ4bP6SjVLnOAfNOhwRiPILqVegp77bScwyT/hM0bkeHK8/88px+mXjppdivcLCeWe5nUCqEv7kroz3yrVAbGWCbOm8G/UHaFTqs6nwKLNPM01Irur9VwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694344; c=relaxed/simple;
	bh=RcHFCQPEVl0IEXlJbKVntpsjEHvtrMd2sMbK/m9AEnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4kiG9/aUZ672yAu2n1MrDpOlSQD0wH+wRvKWQ/stfdOljIdW0izXG4IOELPFAfmI+rDEayi7F8ukcNgzBv2OP5ofaDuJsgyoR33fu5OXd0soVbiovriOH8Pndo4xuq3eXGv27acUE5Jx8CwSl4yQMqeZrgJOA3EI91Vwarl/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IZJ30dH/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IZJ30dH/"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4D27222B;
	Fri, 18 Sep 2026 03:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789694237;
	bh=RcHFCQPEVl0IEXlJbKVntpsjEHvtrMd2sMbK/m9AEnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZJ30dH/OeuJwYTfoB4syzi4AnTHtRWFJvNnZ+asRX+QNsu/7CYmyHlWoFWwDsn7G
	 cvYECCs91L8tjVBXfZ2tdA49VScG+LxtD3nf+GtRCEU0kVmENfIPc4fprThKUjRCuz
	 D6KtoWrS4iyBIHa8r3czls7lcUIt82XU2Jtl/+7Q=
Date: Fri, 18 Sep 2026 04:18:58 +0300
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
Subject: Re: [PATCH 04/10] arm64: renesas: r8a78000: Add FCPV[BI] nodes
Message-ID: <20260918011858.GD145152@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-4-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-4-4c72d4e086dd@ideasonboard.com>

On Thu, Sep 17, 2026 at 09:04:43PM +0900, Paul Elder wrote:
> Add DT nodes for the FCPVB and FCPVI IP cores in the R-Car X5H Soc.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a78000.dtsi | 72 +++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> index 9a07753b221541ed49a975e0c95f2f5d1fdc6ac2..2f8886f8b6545026397fd83969882f8c62afa9d3 100644
> --- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> @@ -1000,6 +1000,78 @@ mdlc_aon: system-controller@c1338000 {
>  			bootph-all;
>  		};
>  
> +		fcpvi0: fcp@c5030000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5030000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;

Hmmm... Merging this in mainline requires patch 01/10, but we can't
upstream it yet in its current form. Geert, does that mean we can't
upstream DT integration yet at all ?

The patch otherwise looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +			power-domains = <&mdlc_vio 0x07 0x107>;
> +			resets = <&mdlc_vio 0x107>;
> +		};
> +
> +		fcpvi1: fcp@c5031000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5031000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x108>;
> +			resets = <&mdlc_vio 0x108>;
> +		};
> +
> +		fcpvi2: fcp@c5032000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5032000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x109>;
> +			resets = <&mdlc_vio 0x109>;
> +		};
> +
> +		fcpvi3: fcp@c5033000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5033000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x10a>;
> +			resets = <&mdlc_vio 0x10a>;
> +		};
> +
> +		fcpvb0: fcp@c5038000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5038000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x102>;
> +			resets = <&mdlc_vio 0x102>;
> +		};
> +
> +		fcpvb1: fcp@c5039000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc5039000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x103>;
> +			resets = <&mdlc_vio 0x103>;
> +		};
> +
> +		fcpvb2: fcp@c503a000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc503a000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x104>;
> +			resets = <&mdlc_vio 0x104>;
> +		};
> +
> +		fcpvb3: fcp@c503b000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc503b000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x105>;
> +			resets = <&mdlc_vio 0x105>;
> +		};
> +
> +		fcpvb4: fcp@c503c000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xc503c000 0 0x1000>;
> +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> +			power-domains = <&mdlc_vio 0x07 0x106>;
> +			resets = <&mdlc_vio 0x106>;
> +		};
> +
>  		mdlc_cmnn: system-controller@ca410000 {
>  			compatible = "renesas,r8a78000-mdlc";
>  			reg = <0 0xca410000 0 0x1000>;

-- 
Regards,

Laurent Pinchart
