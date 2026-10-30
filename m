Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397748;
	b=qUTnfan9jXksTY8ffScSDX3ODso3eyefQskxec3w3vlL79RBkI9k/UZ5MUOsqox/sbqk
	 N0TAdegQ8sgxzJhpa8iHekqIVphFDeJgzJwf59rIixMIkVnIyMxzFUoeol5UTvGU3LRH1
	 MBqgS2HnzWNw5V9GwCpaaHCNqkZyQ4oHfSKd/5DLRXUP3YcrG3G1/NvPYgPxpSRth3cP+
	 4XGzTVQKW75WFxSuw1MhUck5ZS/VWJndf6kQJzwQVp8z7kCbxNVjYqT1AMOg1PCFOKpjk
	 GHVC0z9yKz8ci93EBF0KyTzHx5nKCRLXRE+EqvVG9wdqWn+SkFjdBh+vE988XIyMrvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397748;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CmhrV7WOQ1Ivtyn6HVKc1TJGgGsBZCFCnlJmc49PvXY=;
	b=SZaShb2fgBdkB4/eGp0wkmrnE7GlHJkeS4ax1d0JdGNCz3Puxn9N8WifxmX2GpqxUBiI
	 qOb5eSND7dAzesg5CCmNQDlmklJu2v+Go0O4KMw+Oe4ImD2fbdWlgjSYWbE/EsmnDDJxr
	 OgwbtEPagynLiXwchcQef+pSlRTui7yw3/QVXHDDieSQ6bGxvcWyzzyySntE9RhBb/RC9
	 NzNFyfmOS3HER3ygcw9tlY91+9jlfhZZrRdsB/GGC6SPOgTxRhSiEdvtMAj+/EnwaGE8J
	 pPV991yZaKHNj+YGWhHzUYWUXgs8H5RvPwKWhtkhHpV/WnaOqG0sJAmW8NPM4R5KaKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=F4vu3pTg;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D45606A31A;
	Fri, 30 Oct 2026 22:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69D45606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=F4vu3pTg
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3734434;
	Fri, 30 Oct 2026 23:00:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793397611;
	bh=cvfJwegAtBirKmtRHDJkgsq/4UihRm1DZ/iQ7q6bsbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4vu3pTgWKfsuxJCQVJfZ1qDARXYRmiVyZ/wgzrrW2MeUH/vk8csX1M4uu5P3ZfOF
	 svwjhU1p83QwoFSEtuVBkv/vFjj59uTDXITrhYExydBNuBQPqMi2POsMGjO4bD3IdJ
	 uLDhJKrZb+GOnfwqBAyESKn3W+Ag3/Fb/2m2Cdzc=
Date: Sat, 31 Oct 2026 00:02:24 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Elder <paul.elder+renesas@ideasonboard.com>,
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
Subject: Re: [PATCH DNI v3 15/15] media: rcar-fcp: Check device revision at
 probe time
Message-ID: <20261030220224.GG3178046@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-15-e052903a3832@ideasonboard.com>
 <CAMuHMdXLC7Zw9x6=iz2WMeuPr=rhqKMVPpRdVqFcHJxmAYC79w@mail.gmail.com>
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
In-Reply-To: <CAMuHMdXLC7Zw9x6=iz2WMeuPr=rhqKMVPpRdVqFcHJxmAYC79w@mail.gmail.com>

On Tue, Oct 20, 2026 at 02:20:43PM +0200, Geert Uytterhoeven wrote:
> On Thu, 15 Oct 2026 at 09:53, Paul Elder wrote:
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > Verify that the device revision register reports a valid value,
> > otherwise reject the device.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/media/platform/renesas/rcar-fcp.c
> > +++ b/drivers/media/platform/renesas/rcar-fcp.c
> 
> > +
> > +static const struct of_device_id rcar_fcp_of_match[] = {
> > +       { .compatible = "renesas,fcpf", .data = (void *)RCAR_FCPF },
> > +       { .compatible = "renesas,fcpv", .data = (void *)RCAR_FCPV },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, rcar_fcp_of_match);
> 
> I don't see a good reason for moving this around?

I think it's a leftover from the original version of the patch, which
was using of_match_device(). It's not needed any more now that the code
below uses device_get_match_data()/

> > +
> >  static int rcar_fcp_probe(struct platform_device *pdev)
> >  {
> >         struct rcar_fcp_device *fcp;
> > +       int ret;
> >
> >         fcp = devm_kzalloc(&pdev->dev, sizeof(*fcp), GFP_KERNEL);
> >         if (fcp == NULL)
> >                 return -ENOMEM;
> >
> >         fcp->dev = &pdev->dev;
> > +       fcp->type = (enum rcar_fcp_type)device_get_match_data(&pdev->dev);
> 
> s/rcar_fcp_type/uintptr_t/, although this no longer seems to trigger
> a conversion between pointer and integer of different sizes warning?
> 
> >
> >         platform_set_drvdata(pdev, fcp);
> >
> 
> > @@ -215,13 +332,6 @@ static const struct dev_pm_ops fcp_pm_ops = {
> >         RUNTIME_PM_OPS(fcp_pm_runtime_suspend, fcp_pm_runtime_resume, NULL)
> >  };
> >
> > -static const struct of_device_id rcar_fcp_of_match[] = {
> > -       { .compatible = "renesas,fcpf" },
> > -       { .compatible = "renesas,fcpv" },
> > -       { },
> > -};
> > -MODULE_DEVICE_TABLE(of, rcar_fcp_of_match);
> > -
> >  static struct platform_driver rcar_fcp_platform_driver = {
> >         .probe          = rcar_fcp_probe,
> >         .remove         = rcar_fcp_remove,
> >

-- 
Regards,

Laurent Pinchart
