From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
Date: Wed, 27 May 2015 22:58:01 +0200 (CEST)
Message-ID: <1973961885.66028.1432760281554.JavaMail.open-xchange@oxbsltgw06.schlund.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com> <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com> <20150504123648.GU15510@sirena.org.uk> <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de> <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de> <20150507185216.GP22845@sirena.org.uk> <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de> <20150507193236.GS22845@sirena.org.uk> <1290103954.26573.1432642616013.JavaMail.open-xchange@oxbsltgw08.schlund.de> <20150527173321.GH21577@sirena.org.uk>
Reply-To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150527173321.GH21577-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> hat am 27. Mai 2015 um 19:33 geschrieben:
>
>
> On Tue, May 26, 2015 at 02:16:55PM +0200, Stefan Wahren wrote:
> > > Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> hat am 7. Mai 2015 um 21:32 geschrieben:
>
> > > > > > In the bootloader code enabling the DC-DC is critical. There is a
> > > > > > known
> > > > > > issue
> > > > > > which falsely triggers the brownout detection.
>
> > > > > Why would the driver not provide these operations?
>
> > > > I didn't implement this operation because the suggested workaround for
> > > > the
> > > > hardware issue isn't very nice
> > > > (disable brownout detection during enabling DC-DC). I was afraid of the
> > > > implementation.
>
> > > That doesn't sound too complicated?
>
> > Okay, i think i managed the brownout handling.
> >
> > Unfortunately i'm stuck at the next step. The DC-DC (3 way output) can
> > supply 3
> > LDOs vddd, vdda, vddio. In case of a DC-DC state change the 3 regulators
> > needs
> > to be reconfigured before.
>
> > I tought of REGULATOR_EVENT_PRE_DISABLE and REGULATOR_EVENT_PRE_ENABLE
> > events,
> > but i'm not sure that's the right way to achieve a synchronization between
> > DC-DC
> > and consuming LDOs.
>
> OK, that's possibly sounding a bit complicated. Is it just a case of
> writing some value, doing a reconfiguration and rewriting the original
> value or is it something more?

In case of a single driver instance instead of 4 ones (vddd, vddio, vdda,
dc-dc), things would be much easier.

Here are the steps for disabling DC-DC:

1. configure vddio to work without DC-DC
2. configure vdda to work without DC-DC
3. configure vddd to work without DC-DC
4. backup DC-DC settings
5. disable brownout detection
6. disable DC-DC
7. restore DC-DC settings

My problem is that step 1 to 3 must be done step by step through the other
regulator instances.

> If it's much more complicated than that
> then I think putting a comment in the driver explaining what the issue
> is would be the right step, that would address the issue with the driver
> looking strange.

Enabling or disabling DC-DC is only needed internally by the power subsystem
(e.g. in case of handoff AC to battery), because the DC-DC only supplys the
regulator daisy. From my understanding hardware components could use only the
regulator outputs. In the end a state change is necessary, but it shouldn't be a
public.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
