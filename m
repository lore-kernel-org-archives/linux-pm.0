From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH V2 3/6] power: mxs_power: add driver for mxs power
 subsystem
Date: Wed, 27 May 2015 15:51:50 +0200
Message-ID: <20150527135150.GA9205@earth>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com>
 <20150523174149.GA16004@earth>
 <55656E70.6030906@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44164 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbbE0NwP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 May 2015 09:52:15 -0400
Content-Disposition: inline
In-Reply-To: <55656E70.6030906@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, fabio.estevam@freescale.com, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, May 27, 2015 at 09:12:48AM +0200, Stefan Wahren wrote:
> Am 23.05.2015 um 19:41 schrieb Sebastian Reichel:
> > On Wed, Apr 29, 2015 at 10:32:24PM +0000, Stefan Wahren wrote:
> >> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> >> power subsystem. It's required to trigger the probing of the underlying
> >> drivers like on-chip regulators.
> > I'm not sure what you need the power supply class for. I see only
> > one property (ac connected), which is constant. Maybe just drop
> > the power supply stuff?
>=20
> those SoCs could be powered by 3 different sources:
> - 5V wall
> - USB
> - battery
>=20
> I choose the first one as a base, because it's the simplest one.
> Unfortunately i don't have the time to implement all of them.

=46rom what I can see the driver does not implement the 5V wall
charger handling. It simply assumes, that the 5V wall charger
is there.

While you can skip implementation of battery connection check
you should make sure, that AC is actually connected.

> The Freescale downstream kernel (based on 2.6.35) [1] has a driver to
> handle all MXS power sources. But i think a clean implementation from
> the scratch would be necessary for mainline.
>
> > This would leave an almost empty driver, which just sets a single
> > register at probe time and probes more drivers. That would probably
> > be more fitting for the MFD subsystem.
>=20
> I don't have any problems with fitting the driver to MFD.

You can keep in in drivers/power. From your code I assumed there
would simply be a fixed AC connection and nothing else.

> > -- Sebastian
>=20
> [1] -
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/=
power/mxs/linux.c?h=3Dimx_2.6.35_maintain

-- Sebastian

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZcvzAAoJENju1/PIO/qaFNgQAI49PzvxnSwG3aCOOWb5v1+i
d/AgI/2veo6+3NcGZAk12bA1AJ6ODB4S/GOv9ykDTJrQZ7DlQ1mDXz1bvUD0UzYo
P37IzPkJ6YEjC8a3//mTsAv1lPXXPoFgczu4pLn81Mmf0SKHLkp/BhmXbqv5+wtA
1WYz4GQwxcnoSjIcuPkqc85APaX94nwEeXyV7IYVr8+N2pRKJlYSj2s6pRlieDIm
Ohnfvk9VhIdarRG78sIV0sH4UcYERRNcqS4HFmUvguAXEB+sv3rN1P4RNU/qCjFT
dZyTiQuCiXCSN0rykzuRyLV0C2j2bmdnroVRafRUEb6+fKw/u/Af9ODBhJ3z2c25
Sn+h5T0siejqnRYVhFKepg9vSscdSCQITrpOiMwNmarFisQXZ4QYt6qYsw4vuBzQ
HTnMzlUr76ZcIauSlQ4KixzJQGZWteXfpf5tA4l9IzA6EIMv2SeprOdnoc57LB/o
GcWrrsFMGCk18vSbVZ03JWloQykHJ70iCxOkdDwE820kFDA+MCjhQNLLf8MvXoQv
sLQl6Tkih8CeCYEy1vsBeCc+ngzXYbaRWcnfJSFP/WC7kjEzh5mwtJCRmhma/meU
gkbpGXj3hHRcWTZCg8hbYW4ChpE8dohGmWab2pOzVJjk21o3/GpLWPAPsXg/sdqZ
WPLN6P3mUVi6nseip9G0
=IX4o
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
