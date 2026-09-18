Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EC4DA9BE;
	Fri, 18 Sep 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729886; cv=none; b=uhgbh8gSZJw1r4MZKsI7rUnWA8nk09st1nBQ/aYO97rQVSHNZMLPXp37imwGhOJBnejNijQnNWpzMxbDN9hbvnz6FQvUviaLM06vp2Mba82eYdQzFnLQ0+wLTSLckq8wSUOOSdAMyR2jvkvJ0NFLxnlyqtDTSsRl92oATxoblGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729886; c=relaxed/simple;
	bh=Yqmtu8M6h+BczEI0nt80sCS0j7rs6+dg+w7G6hRCWxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkW2HNEdSa8beCWTRbJ0UDBqSKTrdA21WzOkhPgOS8M25m6xQ6N5jCsEqZtOIgbM8aelg5Yg+wHU6MlbnyVAit9rdxQTvvTfF9hzdy6khRkaHdH3JZCuD2xwB9GiUnP5fWlm7eSl12vFiG01AFA7olSYxuwXiTPJx6if4gS/KVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bAQP8VJe; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bAQP8VJe"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2CBD84FF8;
	Fri, 18 Sep 2026 13:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789729778;
	bh=Yqmtu8M6h+BczEI0nt80sCS0j7rs6+dg+w7G6hRCWxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAQP8VJe9J4RgCmYFfZbtrtA5FJuLckeuKuODWAqDFwQ9t3jVcevdRNNAND2mkNmk
	 Rz5Bd8Nd0vkepfidLjwZYmMPJ01B7gKBv3WvLZJ2KlZey0PozUVQ1qyIk3oVltIEga
	 AHrMR4lIgTrnPORwvkTIcRNoKsOfUDUP571X9pqg=
Date: Fri, 18 Sep 2026 14:11:19 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Paul Elder <paul.elder+renesas@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"magnus.damm" <magnus.damm@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: [PATCH 07/10] media: rcar-fcp: Handle resets
Message-ID: <20260918111119.GF59058@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-7-4c72d4e086dd@ideasonboard.com>
 <TY3PR01MB113464309AC8B77BA471A31DC86872@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113464309AC8B77BA471A31DC86872@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On Fri, Sep 18, 2026 at 11:03:25AM +0000, Biju Das wrote:
> On 17 September 2026 13:05, Paul Elder wrote:
> > 
> > [You don't often get email from paul.elder+renesas@ideasonboard.com. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]

Don't worry, we plan to work on VCON support for X5H, you will get more
e-mails from Paul :-)

> > On some versions of the FCP, such as the one on the X5H, reset
> > control is required to operate the FCP.
> > 
> > Add support for handling resets optionally, to continue supporting
> > versions that do not require it.
> > 
> > Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> > ---
> >  drivers/media/platform/renesas/rcar-fcp.c | 34 +++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
> > index d99b3ff976e80f275af19e5dc02c6e1de98c38a3..15bcbbda3b853f71780aae876f6440b33addf193 100644
> > --- a/drivers/media/platform/renesas/rcar-fcp.c
> > +++ b/drivers/media/platform/renesas/rcar-fcp.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/property.h>
> > +#include <linux/reset.h>
> >  #include <linux/slab.h>
> > 
> >  #include <media/rcar-fcp.h>
> > @@ -63,6 +64,8 @@
> >  #define RCAR_FCP_REG_BA_REF_Y2                 0x0118
> >  #define RCAR_FCP_REG_BA_REF_C                  0x011c
> > 
> > +struct reset_control;
> > +
> >  enum rcar_fcp_type {
> >         RCAR_FCPF,
> >         RCAR_FCPV,
> > @@ -73,6 +76,7 @@ struct rcar_fcp_device {
> >         struct device *dev;
> >         void __iomem *base;
> >         enum rcar_fcp_type type;
> > +       struct reset_control *rstc;
> 
> You could drop this global variable. Please
> See below.
> 
> >  };
> > 
> >  static LIST_HEAD(fcp_devices);
> > @@ -262,12 +266,19 @@ static int rcar_fcp_probe(struct platform_device *pdev)
> >         fcp->dev = &pdev->dev;
> >         fcp->type = (enum rcar_fcp_type)device_get_match_data(&pdev->dev);
> > 
> > +       platform_set_drvdata(pdev, fcp);
> 
> This can be moved after the user.
> > +
> >         fcp->base = devm_platform_ioremap_resource(pdev, 0);
> >         if (IS_ERR(fcp->base))
> >                 return PTR_ERR(fcp->base);
> > 
> >         dma_set_max_seg_size(fcp->dev, UINT_MAX);
> > 
> > +       fcp->rstc = devm_reset_control_get_optional(&pdev->dev, NULL);
> 
> rstc = devm_reset_control_get_optional(&pdev->dev, NULL);
> 
> > +       if (IS_ERR(fcp->rstc))
> > +               return dev_err_probe(&pdev->dev, PTR_ERR(fcp->rstc),
> > +                                    "failed to get reset control\n");
> 
> 
>        platform_set_drvdata(pdev, rstc);

I'd rather keep the rcar_fcp_device structure. When we'll add
compression support to the FCP driver, we will need to access registers
and other fields of rcar_fcp_device.

> > +
> >         pm_runtime_enable(&pdev->dev);
> >         ret = pm_runtime_resume_and_get(&pdev->dev);
> >         if (ret < 0)
> > @@ -283,8 +294,6 @@ static int rcar_fcp_probe(struct platform_device *pdev)
> >         list_add_tail(&fcp->list, &fcp_devices);
> >         mutex_unlock(&fcp_lock);
> > 
> > -       platform_set_drvdata(pdev, fcp);
> > -
> >         return 0;
> > 
> >  error_pm_put:
> > @@ -305,11 +314,32 @@ static void rcar_fcp_remove(struct platform_device *pdev)
> >         pm_runtime_disable(&pdev->dev);
> >  }
> > 
> > +static int fcp_pm_runtime_suspend(struct device *dev) {
> > +       struct rcar_fcp_device *fcp = dev_get_drvdata(dev);
> 
> struct reset_control *rstc = dev_get_drvdata(dev);
> 
> > +
> > +       reset_control_assert(fcp->rstc);
> > +       return 0;
> 
> > +}
> > +
> > +static int fcp_pm_runtime_resume(struct device *dev) {
> > +       struct rcar_fcp_device *fcp = dev_get_drvdata(dev);
> > +
> > +       reset_control_deassert(fcp->rstc);
> 
> Assert the reset in case of failure.
> 
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops fcp_pm_ops = {
> > +       RUNTIME_PM_OPS(fcp_pm_runtime_suspend, fcp_pm_runtime_resume,
> > +NULL) };
> > +
> >  static struct platform_driver rcar_fcp_platform_driver = {
> >         .probe          = rcar_fcp_probe,
> >         .remove         = rcar_fcp_remove,
> >         .driver         = {
> >                 .name   = "rcar-fcp",
> > +               .pm = pm_ptr(&fcp_pm_ops),
> >                 .of_match_table = rcar_fcp_of_match,
> >                 .suppress_bind_attrs = true,
> >         },

-- 
Regards,

Laurent Pinchart
