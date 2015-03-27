From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 01/13] thermal: Make temperatures consistently unsigned
 long
Date: Fri, 27 Mar 2015 20:07:50 +0100
Message-ID: <20150327190750.GZ9742@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
 <9hhzj6y217d.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40563 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbC0TH6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2015 15:07:58 -0400
Content-Disposition: inline
In-Reply-To: <9hhzj6y217d.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 27, 2015 at 10:18:14AM +0000, Punit Agrawal wrote:
> Hi Sascha,
>=20
> Sascha Hauer <s.hauer@pengutronix.de> writes:
>=20
> > The thermal framework uses int, long and unsigned long for temperat=
ures
> > in millicelsius. The majority of functions uses unsigned long, so c=
hange
> > the remaining functions to use this type aswell.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> I'd suggest changing to long instead. It would allow the use of the
> thermal framework in environments where temperatures are below 0C -
> quite easily reached in many parts of the world.

I agree to use a signed type. I also found it not so nice that the ther=
mal
core does not support negative temperatures. I only chose unsigned long
because the patch got smallest that way, but I already expected this
answer ;)
We could also use int instead of long. INT_MAX =B0mC is still enough fo=
r using
a computer on the surface of the sun (Not for the center though)

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
