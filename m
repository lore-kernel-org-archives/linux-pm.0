Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4703C9EF8;
	Thu, 24 Sep 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260727; cv=none; b=WMCL5edMWT0th6AcJzzoBbBb7kpXzMbGPkmlFOa0swn1/M672Lr9axQLjm7NLjTG4S6QNRDyB3I1uwMEPThclz3dM7I4pOAp57MRshSmwoFsyuOz72nDJSWadjK55Mt/xrJTZaxo6yU4hq709LQ+/k5sxO9zHBQl45E1rHac81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260727; c=relaxed/simple;
	bh=B7L+GN8EOMrfe62BtJNrbN4w2aX8t7lKA7UWYMth/QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IszkbdzTesjd2KEMstrBSbcxEhWnJwhCOLiP73uAAYjRR2qRhjTfWXfSmRflsdK8n29y19mUo+3onGM1CDan/zyEw55lsbu0M0aD4uMy6J4/m9EzaAN1ZiV78c0Af8/vDo2AGuYfpGpeSMdF55A7v8PKOvYfrxs8VQADh1/gXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lKHwjV9m; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lKHwjV9m"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DAB7BD0;
	Thu, 24 Sep 2026 16:36:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790260615;
	bh=B7L+GN8EOMrfe62BtJNrbN4w2aX8t7lKA7UWYMth/QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKHwjV9m5LTQ5EiY6WzBz9pgzaoNw7/t8Xf9M28MaUx21IG6tm32irCHIx7EPyMAQ
	 7KcZGhKt/DjeAiOzwUkDXZkjgmgtFRu7OytINlmNQSpeLbWeqJvtXOTKTQqmFNK9vX
	 QuPwtAHeu8EsoqTEQxXVmz8q9kAhA2ssnDnPiXbU=
Date: Thu, 24 Sep 2026 17:38:41 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder@ideasonboard.com>
Cc: Paul Elder <paul.elder+renesas@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Message-ID: <20260924143841.GE135998@killaraus.ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
 <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-8-dbe9236bfd22@ideasonboard.com>
 <20260919175851.GI1124359@killaraus.ideasonboard.com>
 <179024137074.2882041.17628313046085880585@neptunite.rasen.tech>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179024137074.2882041.17628313046085880585@neptunite.rasen.tech>

On Thu, Sep 24, 2026 at 06:16:10PM +0900, Paul Elder wrote:
> Quoting Laurent Pinchart (2026-09-20 02:58:51)
> > On Sat, Sep 19, 2026 at 02:07:05AM +0900, Paul Elder wrote:
> > > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > The R-Car X5H uses 0x09 as the SoC ID in the version register. Document
> > > is with a macro, as done for other R-Car SoCs.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> > > ---
> > > Changes in v2:
> > > - Fix the version register number: s/0x04/0x09/
> > 
> > Thanks for the fix.
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > But I think we can squash this with patch 09/11.
> > 
> > > ---
> > >  drivers/media/platform/renesas/vsp1/vsp1_regs.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> > > index 4c0315656e9f81a9656b58fb6f0233f8a22ac0e1..8abf39bac6c2f333696ebf55de87586d2df3bed0 100644
> > > --- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> > > +++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> > > @@ -816,6 +816,7 @@
> > >  #define VI6_IP_VERSION_SOC_E3                (0x04 << 0)
> > >  #define VI6_IP_VERSION_SOC_V3U               (0x05 << 0)
> > >  #define VI6_IP_VERSION_SOC_V4H               (0x06 << 0)
> > > +#define VI6_IP_VERSION_SOC_X5H               (0x09 << 0)
> 
> Do we need to add an X5H1 (0x09) and X5H2 (0x07)? Or whatever 0x07 is because
> that's what the bsp is referencing for X5H. I've personally observed 0x09 for X5H1.

I'd add 0x09 for now, and 0x07 later when we'll be able to test X5H2.

> > >  /* RZ/G2L SoCs have no version register, So use 0x80 for SoC Identification */
> > >  #define VI6_IP_VERSION_SOC_RZG2L     (0x80 << 0)
> > >  

-- 
Regards,

Laurent Pinchart
