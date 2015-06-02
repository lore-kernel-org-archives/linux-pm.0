From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] sbs-battery: add option to always register battery
Date: Tue, 2 Jun 2015 21:50:37 +0200
Message-ID: <20150602195036.GD13930@earth>
References: <1433250883-32245-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55410 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbbFBTvG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jun 2015 15:51:06 -0400
Content-Disposition: inline
In-Reply-To: <1433250883-32245-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 02, 2015 at 03:14:43PM +0200, Frans Klaver wrote:
> Commit a22b41a31e53 ("sbs-battery: Probe should try talking to the
> device") introduced a step in probing the SBS battery, that tries to
> talk to the device before actually registering it, saying:
>=20
>     this driver doesn't actually try talking to the device at probe
>     time, so if it's incorrectly configured in the device tree or
>     platform data (or if the battery has been removed from the system),
>     then probe will succeed and every access will sit there and time
>     out. The end result is a possibly laggy system that thinks it has a
>     battery but can never read status, which isn't very useful.
>=20
> Which is of course reasonable. However, it is also very well possible
> for a device to boot up on wall-power and be connected to a battery
> later on. The current advice in this situation is to probe the device
> from userspace if you expect the battery to come on at some point in the
> future. The downside of this approach is that userspace needs to be
> aware of the backend of its powersupply, which is inconvenient and going
> against the point of hardware abstraction.
>
> In some of these cases you do want to register a battery, even if none
> are attached at the moment. To facilitate this, add a configuration
> option to try to talk to the device, defaulting to y, thus keeping the
> current behavior. If unset, the battery will always be registered
> without checking the sanity of the connection.

=46rom my POV registering a power supply driver for an unconnected
chip is wrong.  It implies to the system, that there actually is
a battery connected.

Also how do you know, that a sbs based battery is connected at some
point and not some other battery (e.g. a bq27x00 based)? How does
the system know, that the battery becomes available?

Note, that userspace interaction does not mean missing hardware
abstraction. It means missing support for automatic device
identification. The same is true for serial connected bluetooth
devices.

-- Sebastian

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVbgkJAAoJENju1/PIO/qaC84P/3WuVre0assYwPGtvkYrwLGA
Cqc5wE3WoyVLK5s/GyP+3uyDrKUa7VjVy05a8O8n78y5g3SE6FlLlZwvAup1DlEy
BCVnUR4DOSy/pKkeWcsLjnEDYjCAeoBSTXPOByWHVkjFmoQx0+IIZtWdx246lEHJ
AxcTyWa0yrpxZHa50UDQzbJKdO2Xq4zdJF3CaGe9HT6iQaWFJgSQT5BhjB1y0d+2
FwxKpcxelaUufsrffch8Irf/goTl46h8Lld7Ub5X5OpPxGrvdwOLM48BRN7vuTFN
FQ4UpPheZCRONeMuPxiRgdhZJ5Ce0R9web3V2f6qt1O9ePtBO7k+nqO9oeJVtLEk
SBmvC1sPIoDRgpR4MAbluyYBKINkPpUSRwXxdDJHrjT56GveVtC1KrFJemXGeag7
a1R3dexJlgYweohCxkaZwQ3eDC3tZOrA/T5QyD4leQ5BgqK4Cn6Uh8ksIfLlfK3r
VwYwqVGdNHr1vI6t1aT9wuMaXK6E04A14/hgwpgyn/sTv9N9FleXTJUS8noRlXQD
qukhebDf3OMX7sVbYGfNl+QaOCnWXY24ZU+zxh/AzZChSS0oG8MEY1UKsPRzSewS
No/1hBzE5zdDRU+Q7ItmKv6C3Gdj482+jAC37miYqPzQqh6GXAUKqnYr0Mcz6wIt
iGsoJk92kPbY53N9gjDc
=u+/q
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
