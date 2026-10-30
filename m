Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396087;
	b=MUkOe0eaSBMjbLQwXU1gZjQhw2ssMU8oyoDYEVgsNROYhKeTjx/rpphh6i5KctrLoufE
	 pgYuaWCvRLSdWkWtsYJpSPaVQcgT4jsyZGBXjRTUMkFvb+x/lXHsehkYeHOlT5LX7CDgA
	 lYenwHIPNZoQX2hTR5pmf7wDv9X/meXKLqpPTweFiu9WZG8pSE7EjKJ5AarAp26d+fh8G
	 3IDHZeGqiUKx1xIRUeSx50sDkZecSw5y3NWKWj6kukQeoWvYgI9PdethPLqJTjAFQi8rI
	 88sv9FiYD5oKs6sxxuiXza7p/Uv4EH8K+l0Rn9EMvvXnM0YVHGQ2v28AHZQOeysYGmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396087;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=xq+NA1zj5BEONru8YUkjauomU7/b7gTd1VCdgXZzmfQ=;
	b=bxDzjoAlyb5lN4esEur32mE4as39i3MiBpqqu4DZ15Upo3oFVM28R6Z2ydAW78dN8H0D
	 lzUDQKJlWxzgEC4EnR+Odo3iS3kbMi7VR4e5iZIRzLm1m4dcq5GlPsWhzT1NYZu/LCRns
	 k9XabCe/1OkK82FocuoGeUv1fUK5ywFsFkjKiwSZbBZqobSWU9S6mzSLPM7AlpDLVVv/0
	 YEGPeywJTSBVXDOWZZISg997kAjZz590VbSm7fW4Ie4/Nq+/4bq9oetEmHtXfqEdttepM
	 r7ivVKTcRvRkFDZvBQ3aXjZzEZ1RUev3ViIBJJC31yGQ9C7Git8gfD/7VhSwF9PEkMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=fIT6yLRN;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38318606A31D;
	Fri, 30 Oct 2026 21:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38318606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=fIT6yLRN
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7AEFB4B0;
	Fri, 30 Oct 2026 22:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793395949;
	bh=UHYyaFSKiE4grvzN2qAkv8GWlcmzU//DzI8Ey+F66Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIT6yLRN/3r5O15kcnS1ioTAFqE53Z0NPFFyQ69NyzeI3KpRtrNqhqr0k/qrRoKQ3
	 ohPFaiNArumGdv+o7Aex7mbquTSqefGzqUVV7A+O4taoeD8+hrLiz4sGogCqM02Ogy
	 rYvIUk5Wdmu///mkEEecong4RxIKnC4aSjCHyBRw=
Date: Fri, 30 Oct 2026 23:34:42 +0200
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
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
	Phong Hoang <phong.hoang.wz@renesas.com>
Subject: Re: [PATCH v3 10/15] media: vsp1: Fix access to reserved registers
Message-ID: <20261030213442.GB3178046@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-10-e052903a3832@ideasonboard.com>
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
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-10-e052903a3832@ideasonboard.com>

On Thu, Oct 15, 2026 at 04:51:50PM +0900, Paul Elder wrote:
> From: Phong Hoang <phong.hoang.wz@renesas.com>
> 
> Some modules of VSP are not available in all instances,
> so fix access to reserved registers.
> 
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> Reviewed-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/renesas/vsp1/vsp1_drv.c | 34 ++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> index 6ec8c234ea29939e4aebdf56fc51ae1cc5c69156..819c5eda9171d8ef7c8fc88adc959019b6bed497 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> @@ -560,20 +560,34 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
>  	for (unsigned int i = 0; i < vsp1->info->uif_count; ++i)
>  		vsp1_write(vsp1, VI6_DPR_UIF_ROUTE(i), VI6_DPR_NODE_UNUSED);
>  
> -	vsp1_write(vsp1, VI6_DPR_SRU_ROUTE, VI6_DPR_NODE_UNUSED);
> -	vsp1_write(vsp1, VI6_DPR_LUT_ROUTE, VI6_DPR_NODE_UNUSED);
> -	vsp1_write(vsp1, VI6_DPR_CLU_ROUTE, VI6_DPR_NODE_UNUSED);
> -	vsp1_write(vsp1, VI6_DPR_HST_ROUTE, VI6_DPR_NODE_UNUSED);
> -	vsp1_write(vsp1, VI6_DPR_HSI_ROUTE, VI6_DPR_NODE_UNUSED);
> -	vsp1_write(vsp1, VI6_DPR_BRU_ROUTE, VI6_DPR_NODE_UNUSED);
> +	if (vsp1_feature(vsp1, VSP1_HAS_SRU))
> +		vsp1_write(vsp1, VI6_DPR_SRU_ROUTE, VI6_DPR_NODE_UNUSED);
> +
> +	if (vsp1_feature(vsp1, VSP1_HAS_LUT))
> +		vsp1_write(vsp1, VI6_DPR_LUT_ROUTE, VI6_DPR_NODE_UNUSED);
> +
> +	if (vsp1_feature(vsp1, VSP1_HAS_CLU))
> +		vsp1_write(vsp1, VI6_DPR_CLU_ROUTE, VI6_DPR_NODE_UNUSED);
> +
> +	if (vsp1_feature(vsp1, VSP1_HAS_HSIT))
> +		vsp1_write(vsp1, VI6_DPR_HST_ROUTE, VI6_DPR_NODE_UNUSED);
> +
> +	if (vsp1_feature(vsp1, VSP1_HAS_HSIT))
> +		vsp1_write(vsp1, VI6_DPR_HSI_ROUTE, VI6_DPR_NODE_UNUSED);
> +
> +	if (vsp1_feature(vsp1, VSP1_HAS_BRU))
> +		vsp1_write(vsp1, VI6_DPR_BRU_ROUTE, VI6_DPR_NODE_UNUSED);
>  
>  	if (vsp1_feature(vsp1, VSP1_HAS_BRS))
>  		vsp1_write(vsp1, VI6_DPR_ILV_BRS_ROUTE, VI6_DPR_NODE_UNUSED);
>  
> -	vsp1_write(vsp1, VI6_DPR_HGO_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
> -		   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));
> -	vsp1_write(vsp1, VI6_DPR_HGT_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
> -		   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));
> +	if (vsp1_feature(vsp1, VSP1_HAS_HGO))
> +		vsp1_write(vsp1, VI6_DPR_HGO_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
> +			   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));
> +
> +	if (vsp1_feature(vsp1, VSP1_HAS_HGT))
> +		vsp1_write(vsp1, VI6_DPR_HGT_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
> +			   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));

I'm fairly sure the hardware would work fine without those checks, but I
understand there's a desire to pass certifications. As this isn't in a
hot patch,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  
>  	vsp1_dlm_setup(vsp1);
>  

-- 
Regards,

Laurent Pinchart
