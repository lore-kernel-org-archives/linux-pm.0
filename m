Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883928;
	b=dM/B9MAyewfVfvDWIYygQC3b/N91Tjv5w7rwLKcU6a/3EEks9VkxHrQXamPETFmFbuXK
	 JyVrGARDY3yyn+R5buYP/acogBc72xt2fHzi7UHTyc/8pNrV0gFPv/x0nrDTji1jF4n/4
	 SDpH1zLs7OydsPyG+rnELBOt6BKEwchcjYxjnqsP0mxjdW0hoe1PXscgX2dks6gmCrUTl
	 9BE5aJfeNz/utwIoIAq4ymPoP0vOEd2yBRkMs8PWYGHiFNpBjhx6HRX9KhrNxtVT2ZtfA
	 zcmr1FncrMro6bRCSM1O7FPEuI9S1112OkmP4vCAnKWbB/idLkcTPLU3FB1mSyZ6oRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883928;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ME3C+3I1moR9zuX6vPDKVLw16xDyzhIK7WbtwWzTCfE=;
	b=K/Rxx1vdijiHPEqY/WWTKaHNNe5BCV4XMNE1uuYNVJ8kyaVhXW06d5ErUwqoivUUMKHd
	 GvWKRKBIqABV472sExWlW7b959N1G1u0ZYp+GS6WMF0Q1VIWb7gK10CN6sUF+VDRoLVMQ
	 e4lMB270gOZQdij2BoggBBophbhOkRa/jVJJ8toBHFEruBidRnoRmXFFrh0flaZsSiNZ7
	 dLArs7Fcn+sjksb145mLaW9BUi3RzC2bW5flzhHBHlFPbthYy3mtuU9Q8wSJMb6HBz8jT
	 d2v7hrkxs/m9L2BVesRS2H7+TlVF2hA2+qUyReNk+awzFKiwsoIGFa/MkSMEpcSML5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD02606D830;
	Thu,  5 Nov 2026 13:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002811F000C1;
	Thu,  5 Nov 2026 13:05:23 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: laurent.pinchart@ideasonboard.com
Cc: bmasney+clk@redhat.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	geert+renesas@glider.be,
	jbrunet+clk@baylibre.com,
	kieran.bingham+renesas@ideasonboard.com,
	krzk+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	paul.elder+renesas@ideasonboard.com,
	robh@kernel.org,
	sboyd@kernel.org,
	ulfh@kernel.org
Subject: Re: [PATCH DNI v3 04/15] arm64: renesas: r8a78000: Add FCPV[BI] nodes
Date: Thu,  5 Nov 2026 14:05:21 +0100
Message-ID: <20261105130521.85109-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030211225.GA3144851@killaraus.ideasonboard.com>
References: <20261030211225.GA3144851@killaraus.ideasonboard.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi Laurent,

On Fri, 30 Oct 2026 at 23:12:25 +0200, Laurent Pinchart wrote:
> On Thu, Oct 15, 2026 at 04:51:44PM +0900, Paul Elder wrote:
> > Add DT nodes for the FCPVB and FCPVI IP cores in the R-Car X5H SoC.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> I need to reconsider this...
> 
> > Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a78000.dtsi | 72 +++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> > index 9a07753b221541ed49a975e0c95f2f5d1fdc6ac2..2f8886f8b6545026397fd83969882f8c62afa9d3 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> > @@ -1000,6 +1000,78 @@ mdlc_aon: system-controller@c1338000 {
> >  			bootph-all;
> >  		};
> >  
> > +		fcpvi0: fcp@c5030000 {
> > +			compatible = "renesas,fcpv";
> > +			reg = <0 0xc5030000 0 0x1000>;
> > +			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
> 
> ... as this may not be the correct clock.
> 
> The user manual lists the following SGD clocks for the media-related IP
> cores:
> 
> - CSI[0123]:		SGD1_VIO_CSI[0123]φ, SGD2_VIO_CSI[0123]φ,
> 			SGD4_VIO_CSI[0123]φ, SGD16_VIO_CSI[0123]φ
> 
> - VIN[012]:		SGD1_VIO_CSI0φ, SGD4_VIO_CSI0φ
> - VIN[345]:		SGD1_VIO_CSI1φ, SGD4_VIO_CSI1φ
> - VIN[678]:		SGD1_VIO_CSI2φ, SGD4_VIO_CSI2φ
> - VIN{9,10,11}:		SGD1_VIO_CSI3φ, SGD4_VIO_CSI3φ
> 
> - ISP CS[0123]:		SGD1_VIO_CSI[0123]φ, SGD2_VIO_CSI[0123]φ
> - ISP Core[0123]:	SGD1_VIO_ISP[0123]φ, SGD2_VIO_ISP[0123]φ
> 
> - FCPV[BI][0-9]:	SGD1_VIO_DP_TXφ, SGD4_VIO_DP_TXφ
> - FCPVD[ab][0-9]:	SGD1_VIO_DP_TXφ, SGD4_VIO_DP_TXφ
> - FCPVX[0123]:		SGD1_VIO_ISP[0123]φ, SGD4_VIO_ISP[0123]φ
> 
> - VSP[BI][0-9]:		SGD1_VIO_DP_OTHERφ, SGD4_VIO_DP_OTHERφ
> - VSPD[ab][0-9]:	SGD1_VIO_DP_TXφ, SGD4_VIO_DP_TXφ
> - VSPX[0123]:		SGD1_VIO_ISP[0123]φ, SGD4_VIO_ISP[0123]φ
> 
> - VCON[0123]:		SGD1_VIO_DP_OTHER0φ, SGD4_VIO_DP_OTHER0φ
> - VCON[4567]:		SGD1_VIO_DP_OTHER1φ, SGD4_VIO_DP_OTHER2φ
> - VCON[89]:		SGD1_VIO_DP_OTHER2φ, SGD4_VIO_DP_OTHER2φ
> 
> - DPTX[012]:		SGD2_VIO_DP_TXφ, SGD16_VIO_DP_TXφ
> 
> Those IP cores are connected in four types of pipelines:
> 
> - FCPV[BI] -> VSP[BI]
> - FCPVD -> VSPD -> VCON -> DPTX
> - FCPVX -> VSPX -> ISP Core
> - CSI -> VIN -> ISP CS
> 
> It would be quite logical for all IP cores in the same pipeline to use
> the same clock. This would be
> 
> - FCPV[BI] -> VSP[BI]:			SGD*_VIO_DP_OTHERφ
> - FCPVD -> VSPD -> VCON -> DPTX:	SGD*_VIO_DP_TXφ
> - FCPVX -> VSPX -> ISP Core:		SGD*_VIO_ISP[0123]φ
> - CSI -> VIN -> ISP CS:			SGD*_VIO_CSI[0123]φ
> 
> This mostly matches the clocks listed in the user manual, except for
> 
> - FCPV[BI] that is listed as using SGD*_VIO_DP_TXφ
> - VCON that is listed as using SGD*_VIO_DP_OTHER[012]φ
> 
> Now, note how in the clock diagram document the VIO "ISP" and "CSI"
> hierarchies both show 4 groups of SGD clocks (respectively named
> SGD*_VIO_ISP0 and SGD*_VIO_CSI0 in the first group), the VIO "DP"
> hierarchies show 3 groups of SGD clocks (named SGD*_VIO_DP0 in the first
> group) and the VIO "DP_OTHER" hierarchy shows a single group of SGD
> clocks (named SGD*_VIO_DP_OTHER).
> 
> This makes me believe that, wherever the user manual lists
> SGD*_VIO_DP_TXφ, it actually means SGD*_VIO_DP[012]φ. Similarly, where
> the user manual lists SGD*_VIO_DP_OTHER[012]φ for VCON, I believe it
> should be SGD*_VIO_DP[012]φ, both because there is a single
> SGD*_VIO_DP_OTHERφ, and because the rest of the VCON pipelines (FCPVD,
> VSPD and DPTX) all use SGD*_VIO_DP[012]φ.

The clock diagram has 3 VIO_DP[012] hierarchies and a single
VIO_DP_OTHER, while the clock list has 3 VIO_DP_OTHER[012] hierarchies
and a single VIO_DP_TX.
The clock diagram has VIO_MAIN (system bus) clocks, while the clock list
has VIO_OTHER and VIO_BUS clocks.

> For full consistency, I also suppose that the FCPV[BI][0-9] instances
> match the corresponding VSP[BI][0-9] and use the SGD*_VIO_DP_OTHERφ
> clocks, not the listed SGD*_VIO_DP_TXφ clocks.
> 
> This being said, in practice this probably makes no difference, as all
> those clocks derive from the same SGD1_VIO_MAIN clock and none of them
> are programmable or gateable.

Probably, but it would be good to have that confirmed.

> If the above explanation makes sense to you (and to Geert), we can ask
> Renesas to check if the issue I suspect are errors in the documentation.

Agreed.

Current SCMI firmware does not have the CSI3 group.  It does have
VIO_IM[012], which was replaced by DP_OTHER{012] according to the
"Differences" sheet in the clock list.

I guess we really need to know if e.g. all these SGD* clocks are the
same, and if they can be gated individually.  Same for the various DIV6
clocks, as there is only a single register to control them (which
probably controls the parent/singleton in reality).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
