From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [RFC 8/8] ARM: dts: imx6qdl-sabresd: Enable fsl,ldo-bypass
Date: Wed, 29 Mar 2017 16:32:23 +0300
Message-ID: <1490794343.5481.33.camel@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
         <8f4dca5609781f0362009dfa7f6d5c0990b5ea6d.1490199005.git.leonard.crestez@nxp.com>
         <1490202830.29056.8.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490202830.29056.8.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-03-22 at 18:13 +0100, Lucas Stach wrote:
> Am Mittwoch, den 22.03.2017, 18:53 +0200 schrieb Leonard Crestez:

> > This enables LDO bypass by default on the imx6qdl-sabresd boards. New
> > dts files with -ldo suffix are added for users who want to run with LDOs
> > enabled on these boards anyway.

> Given that using LDO bypass affects the device lifetime negatively (see
> AN4724), I think the default should still be to use LDO enabled mode and
> have new DTs for people that desire to shorten the lifetime of the SoC
> for a minimal drop in power consumption.

This was based on what the Freescale BSP does, I don't particularly
object to upstream having a different default. It would be nice for
testing if this ldo-bypass path was enabled by default for some boards
but it's not a very good reason.

I will switch the default.

-- 
Regards,
Leonard
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
