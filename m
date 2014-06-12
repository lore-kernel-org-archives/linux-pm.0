From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/24] drivercore: Bind/unbind power domain on
 probe/remove
Date: Thu, 12 Jun 2014 17:39:01 +0100
Message-ID: <20140612163901.GZ5099@sirena.org.uk>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
 <20140610212731.GA11191@kroah.com>
 <53977BC1.5000301@gmail.com>
 <2753039.YD6R0RpJkS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SRdXq8ahTMo0Vx5K"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38613 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbaFLQjn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jun 2014 12:39:43 -0400
Content-Disposition: inline
In-Reply-To: <2753039.YD6R0RpJkS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Tomasz Figa <t.figa@samsung.com>


--SRdXq8ahTMo0Vx5K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2014 at 02:18:44AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 10, 2014 11:42:25 PM Tomasz Figa wrote:

> > OK, so proposed solution is to put this in:

> > - platform_drv_probe(),
> > - spi_drv_probe(),
> > - i2c_device_probe(),
> > - amba_probe(),

> Yes.  Specifically, those are bus types that don't do their own power
> management.

This sounds tedious.  Can we not instead introduce some generic helpers
which all such buses call/use and then implement the hooks in there
(along with anything else that they should all do)?  There must be other
things that all these buses are having to cut'n'paste.

--SRdXq8ahTMo0Vx5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmdeiAAoJELSic+t+oim9BYoP/i2AxFYw/w0cyeNTHxfhc5iZ
Hi3pvcI/kIuQ2b+R7Szw03fQ15N7pPM9tIszuMeV8fKSFJ6yrcmdjtJmXohEAB8L
spkBkmn9FC5xlY6OydN7b0lAJ6V3ZWNiz+1kiGTlX0wAPpYfHH4RWMZlAgudO/am
4MvVFExW1LIo8ZDdv+EbNr/U3tUJqXxTBEl0Am0YVl2RL2kd+rPkT00qVB3YzAH6
az63n28b3auNIA4Vzb1qwu8fEIJVTOQW/1g+en14YZNHJvkGqlu3lvQoBeF6/e++
KD8VrmRRklDJ2CEzgC5pgSt+gmS1JVDjKDHUxskmt75/mPNL5rzxCFvflQLwn/vR
LvLh+SEplQnv7CUGHhRhwzrHr77XV8VITly2Oy1bsXeJBKfufw6GG+HoXjPgNsh5
q2Jge50Rya1IVYt9et7G2GmpqH/sTncW8fm910pbZceu3iw8KrLV/mbxUPgDuNAb
cr9jWtmuG57/0LbB5apBLhicmMB87L8PC0J879x1vMl75CLgDwvsk81eVOlJ7qpS
X1FbOEY/D+UOGtHTy8vFdfbtAdf7foJCWBiBQtd1VljQZEogvFMhTo/8ya+hWrDS
b4OsuOGUM8QGI9KETEDs2IIyg22agm/Mb758pQeu2o3kUiKZqbFLP1GGSUS2LGOl
COycolbMJ8yHmfnkrkgi
=B81T
-----END PGP SIGNATURE-----

--SRdXq8ahTMo0Vx5K--
