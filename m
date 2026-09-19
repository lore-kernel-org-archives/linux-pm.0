Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55CBA3D;
	Sat, 19 Sep 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840737; cv=none; b=mKNC748otwVTXUqI9Rz10gsivv2jsISn+gwlzWEUTvXbQZ8WHi0J2q73ydtk1indomhl73iVTsM+9i/a/RzrR1ggGLrRhNHNI/hcggRJg5HCqgkvFeGw3KD/pbmliZCcPwP3vpcrnbRsfG5RywR2FXk5vp0RZJU1uI3P2kW/ars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840737; c=relaxed/simple;
	bh=ojbN8jYKugn8rnd9PnnsxJsi+SUjUc1tUk1+gBuo4vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo1F8sFEIcmj1bNywq8Pmp4xF7un6iZAPo++4gTyEzgFCqa1Ufz3pf0Uro2lmjdCG4tQyEQ9yg+Z7RLVruuolgKCloraf0dStddA37yxcPfqd4GjjijBb1A6uXTotI4zxeXb24OTiP2JmGFgUPHsoyAvT1PDBcfayo+cXnTAl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sKJgL6fw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sKJgL6fw"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F79615BF;
	Sat, 19 Sep 2026 19:57:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789840629;
	bh=ojbN8jYKugn8rnd9PnnsxJsi+SUjUc1tUk1+gBuo4vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKJgL6fwSAIJ/UmUSyjil/zQ+pxlG1VwlFT4y34A8XD6+ismvrgYOYsAwnVDYQWnU
	 B2d8oFYRx71Ed8dyvuBu1oD65RWJ+zJFXoyzVPecv905QyVPi621SoNCI5o8NqCBEe
	 E56EH/0mDlqJr2Afi85rPU56q8PzXefkzXK7Hn8k=
Date: Sat, 19 Sep 2026 20:58:51 +0300
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
Subject: Re: [PATCH v2 08/11] media: vsp1: Document X5H SoC ID
Message-ID: <20260919175851.GI1124359@killaraus.ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
 <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-8-dbe9236bfd22@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-8-dbe9236bfd22@ideasonboard.com>

On Sat, Sep 19, 2026 at 02:07:05AM +0900, Paul Elder wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> The R-Car X5H uses 0x09 as the SoC ID in the version register. Document
> is with a macro, as done for other R-Car SoCs.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
> Changes in v2:
> - Fix the version register number: s/0x04/0x09/

Thanks for the fix.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

But I think we can squash this with patch 09/11.

> ---
>  drivers/media/platform/renesas/vsp1/vsp1_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> index 4c0315656e9f81a9656b58fb6f0233f8a22ac0e1..8abf39bac6c2f333696ebf55de87586d2df3bed0 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> @@ -816,6 +816,7 @@
>  #define VI6_IP_VERSION_SOC_E3		(0x04 << 0)
>  #define VI6_IP_VERSION_SOC_V3U		(0x05 << 0)
>  #define VI6_IP_VERSION_SOC_V4H		(0x06 << 0)
> +#define VI6_IP_VERSION_SOC_X5H		(0x09 << 0)
>  /* RZ/G2L SoCs have no version register, So use 0x80 for SoC Identification */
>  #define VI6_IP_VERSION_SOC_RZG2L	(0x80 << 0)
>  

-- 
Regards,

Laurent Pinchart
