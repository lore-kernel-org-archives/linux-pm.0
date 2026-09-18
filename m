Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D63655FF;
	Fri, 18 Sep 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693928; cv=none; b=HIDlfVOwKNqOp9pWiNTWZA4FqscwmsbyOUC3A3T/tFlCCWIJHtIzQw8+r8satNrb45wiCrzj//ZxhsLr2/LWwpqz1DXThr0lfyjitN76LXYNok77ANhLQv3s3a3+P2vtzTfhQRHfCRxGIMIXn2mP3fQhNudSggQBUd5y04dHgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693928; c=relaxed/simple;
	bh=491wnfZBRmqnSBkd6vdUZjFaCi24bk5o5ISzQwKWlHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdOVEFuX0YqOPadn3kWU1WyBhKQ00rmOZ3SBpDMRmt9TgIvDC2iqQEwbnZkofiZOUYpui7gklOSNCV/aox2PPi2LQWIb+gKA4h4ueEbjI69XnM84KXnFR4HmCTt1K4uc0m0xMaZogOht/74ZPIf3NTRUZGC0WVFM8fT8R5Kvx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ugfbKRrt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ugfbKRrt"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78FE8C1;
	Fri, 18 Sep 2026 03:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789693815;
	bh=491wnfZBRmqnSBkd6vdUZjFaCi24bk5o5ISzQwKWlHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugfbKRrtfPg+wwAkArXPyMpivsCqffzOXGTyBNeOXLyG7uiDWvWpq95jqh4RE/d9J
	 7qfL06IuZbt2ydi7xvaxyYjorDvRz11EbUehWQb/2paEeTAYPZChvApsENq5oNnO1L
	 u76X01YWmJ98gXUM9XIx79p1Rv+HprKQzYluPBQY=
Date: Fri, 18 Sep 2026 04:11:56 +0300
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
Subject: Re: [PATCH 02/10] clk: renesas: r8a78000: Add clock for FCPV and VSP
 for SCP FW SDKv4.36
Message-ID: <20260918011156.GB145152@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-2-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-2-4c72d4e086dd@ideasonboard.com>

On Thu, Sep 17, 2026 at 09:04:41PM +0900, Paul Elder wrote:
> Add clocks for the FCPV{B,I,D} and VSP{B,I}. They each have one clock
> from an option of two: a 1066MHz and a quarter-divided 266MHz. As we
> already have support for the 266MHz one, add just those for now.
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
>  drivers/clk/renesas/r8a78000-cpg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
> index b820d09e1a195068debe8a6eea7a01c534a97b23..17792ff6ab8ae2f7eb5c8f7e3d581b43177e195d 100644
> --- a/drivers/clk/renesas/r8a78000-cpg.c
> +++ b/drivers/clk/renesas/r8a78000-cpg.c
> @@ -326,6 +326,8 @@ static const struct clk_map_in r8a78000_cpg_fw_4_31_0[] = {
>  	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	FIXED_CLK(66M) },
>  	{ R8A78000_CPG_S0D4_PERE_MAIN,		FIXED_CLK(200M) },
>  	{ R8A78000_CPG_MSOCK_PERW_BUS,		1667 },
> +	{ R8A78000_CPG_SGD4_VIO_DP_TX,		FIXED_CLK(266M)},
> +	{ R8A78000_CPG_SGD4_VIO_DP_OTHER,	FIXED_CLK(266M)},

Same comment as for 01/10. I think the two patches can be squashed
together actually (unless Geert disagrees).

>  	{ -1 }
>  };
>  
> 

-- 
Regards,

Laurent Pinchart
