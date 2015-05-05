From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V2 4/6] DT: add binding for mxs on-chip regulators
Date: Tue, 5 May 2015 19:12:34 +0200 (CEST)
Message-ID: <1195324103.963873.1430845954289.JavaMail.open-xchange@oxbaltgw07.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com> <201505041551.26355.jbe@pengutronix.de> <1858103470.878923.1430770850541.JavaMail.open-xchange@oxbaltgw08.schlund.de> <201505051021.01939.jbe@pengutronix.de>
Reply-To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201505051021.01939.jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?=22J=C3=BCrgen_Borleis=22?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Juergen,

> J=C3=BCrgen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> hat am 5. Mai 2015 um 10:21 =
geschrieben:
>
>
> Hi Stefan,
>
> On Monday 04 May 2015 22:20:50 Stefan Wahren wrote:
> > [...]
> >=20
> > I think we have 3 options here:
> >
> > a) add the regulator daisy chain for the i.MX23 too
> > b) remove VDD1P5 from the i.MX28 diagram so it would fit for both a=
gain
> > c) remove the diagram complete
> >
> > I would prefer option b. What's your opinion?
>
> I prefer a) because once the details are known, we should keep them.

beside the point this could be to much diagrams for a binding documenta=
tion, i
don't have any objections about option a).

>
> Regards,
> Juergen

Regards
Stefan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
