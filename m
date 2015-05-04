From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Mon, 4 May 2015 22:34:55 +0200 (CEST)
Message-ID: <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com> <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com> <20150504123648.GU15510@sirena.org.uk>
Reply-To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150504123648.GU15510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Mark,

> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> hat am 4. Mai 2015 um 14:36 geschrieben:
>
>
> On Wed, Apr 29, 2015 at 10:32:26PM +0000, Stefan Wahren wrote:
>
> > +static struct regulator_ops mxs_dcdc_ops = {
> > + .is_enabled = regulator_is_enabled_regmap,
> > +};
>
> Why do we have an is_enabled() operation but no enable or disable
> operation? 

i'm sorry, i forgot the following point in the changelog:

- move dcdc handling from mxs_power to mxs-regulator

I hope the change is okay. I implemented only is_enabled() to have at least 1
operation.
But it's not really necessary.

> I'm also not 100% clear what code the DCDCs and LDOs are
> sharing here...

Actually only probing and the regulator info structure.

Best regards
Stefan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
