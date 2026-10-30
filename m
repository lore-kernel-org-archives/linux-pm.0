Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394750;
	b=guYrVkWZMEGoIrj2heoP9x/0XMo/RjbO+eu77oll6kWUOkutIGVisTbIEM763K/W6B+O
	 lBoThC7ieoaiyuFTJDN1mKV1al0lTJAs0SQk/vwkE19x+kaXBONTvH/GSGuiaVpw5d+bj
	 vJWzXsr9AXElrKKonft35tqirl5MR9C21r/CxWDx6XykPAsBqbook/ObtP1EDA3SK3Xnk
	 GiREjm22VQ8Z/no7Hce3u950yrvxmIwFj6P0xMUZuiT63dLw549tALvo8yTwfNTKNp7z0
	 cXZT4Zg0mnZNja7sfvNcMkkACMZvMJRW7u9LrPnUZH6iL/i19fswMkZAU83uQQ+N2Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394750;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IEONd4jOnVyWQkHj1MJzqvWpoLIH0hBXrfM3VziQ+qI=;
	b=JG18oeuyDmB4Mip1pcrJVm3hq3awonTqudCAr9GicMVJUEvN5DcCcePERq3aEKODJJeO
	 jjkjrdB02/pdqETt7205b+pkVzv0pvpJIIDHqybBxadATmRU8I0U1LwfaITufCEnV/59G
	 QrpucDulpWuYpru8WRltHRGLBhKJcsLXAqnlt8yJtmV6e2WcJjCV4M0WcSjc7YqZO2mht
	 G8APyp3Dsdi6JZqU6u60l62rXX8Uy3cfm1JIDpTfmbz0vN2cTNYzAxefWkHJRYdifmmwu
	 Wld4xN/8zqxEfQBpXp98K8VjRIVfGKxQr8/GjW17soJnxwmZ5gM3uLRkC8zTT/bNUMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=kGW4GTWR;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB2606A31A;
	Fri, 30 Oct 2026 21:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83BB2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=kGW4GTWR
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F9934B0;
	Fri, 30 Oct 2026 22:10:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793394612;
	bh=4ZcjkwBtXwpWd5YLcsKxjAoYlftpO+e2haPr8crGBDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGW4GTWRX2wvyUs92Hm7D+e4Tmn49DaB8rEiCWEcvqpEQpE0bEDtJ4DU6aI38BGd3
	 5FIowGc4/rt0hw2S12LMGXi2zmZYHe+Ixd9Y7KqKi25i2OHSYWfzjkl/p+BQ0a8tKu
	 D3QARqLMcbePtpSInZsbQzaq3bUHKuVgToZVyrRc=
Date: Fri, 30 Oct 2026 23:12:25 +0200
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
Subject: Re: [PATCH DNI v3 04/15] arm64: renesas: r8a78000: Add FCPV[BI] nodes
Message-ID: <20261030211225.GA3144851@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-4-e052903a3832@ideasonboard.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-4-e052903a3832@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Thu, Oct 15, 2026 at 04:51:44PM +0900, Paul Elder wrote:
> Add DT nodes for the FCPVB and FCPVI IP cores in the R-Car X5H SoC.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I need to reconsider this...

> Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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

... as this may not be the correct clock.

The user manual lists the following SGD clocks for the media-related IP
cores:

- CSI[0123]:		SGD1_VIO_CSI[0123]φ, SGD2_VIO_CSI[0123]φ,
			SGD4_VIO_CSI[0123]φ, SGD16_VIO_CSI[0123]φ

- VIN[012]:		SGD1_VIO_CSI0φ, SGD4_VIO_CSI0φ
- VIN[345]:		SGD1_VIO_CSI1φ, SGD4_VIO_CSI1φ
- VIN[678]:		SGD1_VIO_CSI2φ, SGD4_VIO_CSI2φ
- VIN{9,10,11}:		SGD1_VIO_CSI3φ, SGD4_VIO_CSI3φ

- ISP CS[0123]:		SGD1_VIO_CSI[0123]φ, SGD2_VIO_CSI[0123]φ
- ISP Core[0123]:	SGD1_VIO_ISP[0123]φ, SGD2_VIO_ISP[0123]φ

- FCPV[BI][0-9]:	SGD1_VIO_DP_TXφ, SGD4_VIO_DP_TXφ
- FCPVD[ab][0-9]:	SGD1_VIO_DP_TXφ, SGD4_VIO_DP_TXφ
- FCPVX[0123]:		SGD1_VIO_ISP[0123]φ, SGD4_VIO_ISP[0123]φ

- VSP[BI][0-9]:		SGD1_VIO_DP_OTHERφ, SGD4_VIO_DP_OTHERφ
- VSPD[ab][0-9]:	SGD1_VIO_DP_TXφ, SGD4_VIO_DP_TXφ
- VSPX[0123]:		SGD1_VIO_ISP[0123]φ, SGD4_VIO_ISP[0123]φ

- VCON[0123]:		SGD1_VIO_DP_OTHER0φ, SGD4_VIO_DP_OTHER0φ
- VCON[4567]:		SGD1_VIO_DP_OTHER1φ, SGD4_VIO_DP_OTHER2φ
- VCON[89]:		SGD1_VIO_DP_OTHER2φ, SGD4_VIO_DP_OTHER2φ

- DPTX[012]:		SGD2_VIO_DP_TXφ, SGD16_VIO_DP_TXφ

Those IP cores are connected in four types of pipelines:

- FCPV[BI] -> VSP[BI]
- FCPVD -> VSPD -> VCON -> DPTX
- FCPVX -> VSPX -> ISP Core
- CSI -> VIN -> ISP CS

It would be quite logical for all IP cores in the same pipeline to use
the same clock. This would be

- FCPV[BI] -> VSP[BI]:			SGD*_VIO_DP_OTHERφ
- FCPVD -> VSPD -> VCON -> DPTX:	SGD*_VIO_DP_TXφ
- FCPVX -> VSPX -> ISP Core:		SGD*_VIO_ISP[0123]φ
- CSI -> VIN -> ISP CS:			SGD*_VIO_CSI[0123]φ

This mostly matches the clocks listed in the user manual, except for

- FCPV[BI] that is listed as using SGD*_VIO_DP_TXφ
- VCON that is listed as using SGD*_VIO_DP_OTHER[012]φ

Now, note how in the clock diagram document the VIO "ISP" and "CSI"
hierarchies both show 4 groups of SGD clocks (respectively named
SGD*_VIO_ISP0 and SGD*_VIO_CSI0 in the first group), the VIO "DP"
hierarchies show 3 groups of SGD clocks (named SGD*_VIO_DP0 in the first
group) and the VIO "DP_OTHER" hierarchy shows a single group of SGD
clocks (named SGD*_VIO_DP_OTHER).

This makes me believe that, wherever the user manual lists
SGD*_VIO_DP_TXφ, it actually means SGD*_VIO_DP[012]φ. Similarly, where
the user manual lists SGD*_VIO_DP_OTHER[012]φ for VCON, I believe it
should be SGD*_VIO_DP[012]φ, both because there is a single
SGD*_VIO_DP_OTHERφ, and because the rest of the VCON pipelines (FCPVD,
VSPD and DPTX) all use SGD*_VIO_DP[012]φ.

For full consistency, I also suppose that the FCPV[BI][0-9] instances
match the corresponding VSP[BI][0-9] and use the SGD*_VIO_DP_OTHERφ
clocks, not the listed SGD*_VIO_DP_TXφ clocks.

This being said, in practice this probably makes no difference, as all
those clocks derive from the same SGD1_VIO_MAIN clock and none of them
are programmable or gateable.

If the above explanation makes sense to you (and to Geert), we can ask
Renesas to check if the issue I suspect are errors in the documentation.

Finally, while neither the FCP nor the VSP chapters indicate what the
SGD1 and SGD4 clocks are used for, the VCON chapter lists SGD1 as the
"VSPD I/F clock" and SGD4 as the "APB I/F clock", and the ISPCS chapter
lists SGD1 as the "Processing clock of ISP CS" and SGD2 as the "APB I/F
clock". The APB clocks are used for register access, while the "I/F
clock" or "processing clocks" are used for the data flow. If the FCP
driver (or the VSP driver) had a need to know any clock frequency, it
would be the data clock. I would therefore use SGD1 instead of SGD4 here
(same for the VSP).

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
