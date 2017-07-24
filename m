From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH 07/10] cpufreq: dt: Add support for some new Allwinner SoCs
Date: Mon, 24 Jul 2017 13:46:15 +0200
Message-ID: <2436327.OLdY8skjMP@aspire.rjw.lan>
References: <20170723102749.17323-1-icenowy@aosc.io> <20170723102749.17323-8-icenowy@aosc.io> <20170724085349.GT352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170724085349.GT352@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 24, 2017 02:23:49 PM Viresh Kumar wrote:
> On 23-07-17, 18:27, Icenowy Zheng wrote:
> > Some new Allwinner SoCs get supported in the kernel after the
> > compatibles are added to cpufreq-dt-platdev driver.
> > 
> > Add their compatible strings in the cpufreq-dt-platdev driver.
> > 
> > Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> > Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 2eb40d46d357..c3851453e84a 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -24,7 +24,11 @@ static const struct of_device_id machines[] __initconst = {
> >  	{ .compatible = "allwinner,sun8i-a23", },
> >  	{ .compatible = "allwinner,sun8i-a33", },
> >  	{ .compatible = "allwinner,sun8i-a83t", },
> > +	{ .compatible = "allwinner,sun8i-h2-plus", },
> >  	{ .compatible = "allwinner,sun8i-h3", },
> > +	{ .compatible = "allwinner,sun8i-v3s", },
> > +	{ .compatible = "allwinner,sun50i-a64", },
> > +	{ .compatible = "allwinner,sun50i-h5", },
> >  
> >  	{ .compatible = "apm,xgene-shadowcat", },
> >  
> > @@ -43,6 +47,8 @@ static const struct of_device_id machines[] __initconst = {
> >  	{ .compatible = "marvell,pxa250", },
> >  	{ .compatible = "marvell,pxa270", },
> >  
> > +	{ .compatible = "nextthing,gr8", },
> > +
> >  	{ .compatible = "samsung,exynos3250", },
> >  	{ .compatible = "samsung,exynos4210", },
> >  	{ .compatible = "samsung,exynos4212", },
> 
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> 

OK

I'm assuming this will go in via arm-soc along with the rest of the series.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
