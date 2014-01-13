From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 06/10] ARM: s3c64xx: pm: Add device tree based power
 domain instantiation
Date: Mon, 13 Jan 2014 12:17:26 +0000
Message-ID: <20140113121726.GQ29039@sirena.org.uk>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-7-git-send-email-tomasz.figa@gmail.com>
 <20140112192910.GW29039@sirena.org.uk>
 <52D2EE32.5060709@gmail.com>
 <20140113110935.GB29039@sirena.org.uk>
 <52D3D880.2090300@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yhCE4sTDB5mqd9YJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53503 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaAMMRz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2014 07:17:55 -0500
Content-Disposition: inline
In-Reply-To: <52D3D880.2090300@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Pavel Machek <pavel@ucw.cz>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-kernel@lists.infradead.org


--yhCE4sTDB5mqd9YJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2014 at 01:13:52PM +0100, Tomasz Figa wrote:

> Power domain control registers are part of the system controller
> block, which uses the "samsung,s3c64*-clock" compatible string. I
> know this is a bit unfortunate, but all registers of this IP block
> are mapped at the same page and some clock registers are at the
> other end of this area than others, so there is even no good way to
> split them into separate mappings.

I see - probably would've been neater to give it a different name but
too late now.

--yhCE4sTDB5mqd9YJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS09lSAAoJELSic+t+oim9nr4QAIqE+SCkUgeeuBvkgWcgDS1V
6OPmEeFFFLTkEnq3GtbuKQL42A19y/sJgQSuIkE1kmQjXn2+Jzi/lu4SrYdhw7nR
/kj0AKnJMQvuQVJJtGeCO81jd+6jHtPgmftkHEC0Xk1QyyeVljw1TmvXp+Y4TC4r
TktOjbnK4Ag9rG+8u2/GemiQ2SF3mLsAzYQLJ3Z03MPYbDDTlKB5Iwkzck3HjXym
mt4F+gZdGJ3Z3rTE+mzcfO+CjwQCYAHdTXZIpGD8lge94B7GtLK19Mx9puPCUOPQ
zKAJ+TVRY7D2B0u28Gqr2s4D8xAWcEMn1J4oTs+dPWPJ3RD5YtYTiOuKaFNqEf00
PY183uVXUIZAGyCmTi1HpZlBhj6YUoNKL9EEU6RBWWzJfzjn7ZhGoVga0+WULnAy
2xf0xGxFfon3nO934qEeTp1CWz+2Mw/XBi7udnJcuwhxa31hYn2FH0yjgR1tBj5W
ipd+FesT43k4slks4dk0sgYv750dPv22HOWySFfR+hP9fEdIbP0muRPMX92QFRgb
IcktYp3lK052i8bWa02amXY9z++v6kF0uP7uZ9IGG0kqyrcVCCrPGWUdpoe+HiyE
//1u2pjVT5UfdByXYt3r9yCT7KzUDM1XtaGjVVOU0vU5cTic6FZqZU1+jW89L4WN
TCPHv1kytVqOVtZ0XHOh
=1KKe
-----END PGP SIGNATURE-----

--yhCE4sTDB5mqd9YJ--
