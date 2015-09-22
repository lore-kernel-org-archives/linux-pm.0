From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 0/5] power/reset: at91: cleanups and slow clock
Date: Tue, 22 Sep 2015 17:13:35 +0200
Message-ID: <20150922151335.GA2533@earth>
References: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43764 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbbIVPNj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 11:13:39 -0400
Content-Disposition: inline
In-Reply-To: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 11, 2015 at 11:12:45AM +0200, Alexandre Belloni wrote:
> As discussed this series is now removing non DT initialization, allowing to
> compile the drivers as modules and finally adding slow clock support to the
> drivers.
>
> [...]
>
>   power/reset: at91-reset: remove useless at91_reset_platform_probe()
>   power/reset: at91-reset: allow compiling as a module
>   power/reset: at91-reset: get and use slow clock
>   power/reset: at91-poweroff: allow compiling as a module
>   power/reset: at91-poweroff: get and use slow clock

Thanks, queued for 4.4. You may want to add another patch adding

MODULE_DEVICE_TABLE(of, xxx_of_match);

-- Sebastian

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAXAbAAoJENju1/PIO/qanJYP/j6srEDRzqhbNIcre4gjvZu6
X961nnwA9FdP8fdztlzA6XpAi6AtUVz3qjBrvbbzjJcvdP/dRpKMy5T2sAlXy6Rs
ZwiGErO0CbfyNai7A/4UWbGEIIw3lt3p0mJLQpTzaAkZtNmLMbEXGAcZpB3h6NXj
WVf9gewJY+F+SmPX+unhEMEzKJz3yuABmnwZ6b1zytqzIbulVLWiktoVytWwkbRj
kXxS56blFTiRTjTWvXN4p1xza/dmBDveW/6gXsrRQCxsU2AtwuApJ8qMZ4Wt2Q+W
ZIbcQgwbnY4c13ZCPKmYaJrVRj2lpsnwMyq/FViTZZPBDed2cqqnwCEjUErN6SYL
yHM/YEXudOqQsiAtqn3Ix9gxFIhhUfzPEq1xxBj4/KClaL4Cepgj9528MxEqZj1Z
Upbc7KQ6jXCavAmajPqXnxesGWiSA/yfmZogbVoA9C1aBHd1763P9dcVBAIMz9es
SFJhtWkY45cHJTZVtRZEQQhyzwh6OITu6clgnYAoBNV49u7wCR6+vQV49EfxzQFQ
C7elrz3H+/IhsjcCL68Ns56JCZKmPkuWOZoXRXOhZuoYseQzYc+PX1swM8pNg7BT
OdFW8ZhCTMXU8xSIIbOeJrvudMUcYzAeGbQ9fwGFm8YIgzLiXgOHthGWqYncvmMd
4VTLCZdrPWeeJyhqb/TV
=d+8E
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
