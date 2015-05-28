From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH V2 3/6] power: mxs_power: add driver for mxs power
 subsystem
Date: Thu, 28 May 2015 19:38:29 +0200
Message-ID: <20150528173828.GA31619@earth>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com>
 <20150523174149.GA16004@earth>
 <55656E70.6030906@i2se.com>
 <20150527135150.GA9205@earth>
 <5565F1F9.2010801@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47115 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbbE1Riz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 May 2015 13:38:55 -0400
Content-Disposition: inline
In-Reply-To: <5565F1F9.2010801@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, fabio.estevam@freescale.com, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 27, 2015 at 06:34:01PM +0200, Stefan Wahren wrote:
> the driver consists of multiple files in the mxs sub directory.
> I linked to the main file to reduce search effort. The battery
> handling incl. charging should be implemented in ddi_power_battery.c
>
> From my understanding it's not possible to determine where the 5V
> exactly come from (either 5V wall plug or USB). The driver simply uses
> the USB PHY state.

Yes, but your driver does not even check, that there is 5V. It even
reports AC online if neither USB nor wall charger is connected.

> > While you can skip implementation of battery connection check
> > you should make sure, that AC is actually connected.
>=20
> Do you refer to the right state of property
> POWER_SUPPLY_PROP_ONLINE or driver probing?

I'm referring to the right state.

-- Sebastian

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ1KRAAoJENju1/PIO/qaX04P/2eHvKn8Q5X5ti4pgPGBvmHO
1FBWZCw54covEDNk9QU1bL7z4odzGJCMzDcGuc34DlP9soBO4aNnUJkDOx3jG488
Nxq3kJXelWaGvyPsmkc8f2EqyCzGmqNFHDyU4LyKGIUBYlM+dDaMxs6VvDnp4PbK
e9KriOTpfqptBJbt2BpAE9J/jUvA1yZ/RudsSI9lElmu8A7eBLpX62fCJ10vZbMm
rxhkZxmghFLYEmnfPcJSoedxIOZe/dwLJZLTmqvTEfsWW5jpUNcWCcgZPQ5IYJcK
U6M56GjUF/ehPAZMHfjn7oxGglrdwhl3VQdhDnMb6vvuzME2a0vVh+Jnsm/EVL4t
zpyE77+VCX0/BS3Pmeb/AddOqJnMMzw5hN/HnW4zupjk26SS1tWA76lBjkhhz4DO
57dXpoHE7KDPOp4FbhSBrypKTOrtRD8sRZw+G7wbvAWFpx9Nola57dirMus3qZYm
EZD7cabMZShY78zuDWjGDVIIlfJAufEpcS8uUS95MLA8kAgRHY5nVIvPA5oR4Xau
9+8XZKX9ePFSzfhLoNW2uUL8KRw4ZBq806zfjimSArL/GrtfSh7eg4RdmKy9fkJ9
bwqtSrqwr1wb1yv72agiqR4EgbUYMXBIx4QLeyvzOZ+2GuLK2uBeOhm4elMi4EEA
FJ5KsrDqzZHSnHmefoWU
=Krnb
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
