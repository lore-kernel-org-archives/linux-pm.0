From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] sbs-battery: make writes to ManufacturerAccess optional
Date: Mon, 19 Sep 2016 21:02:45 +0200
Message-ID: <20160919190242.wx2enmdqblbcvzqm@earth>
References: <1473387000-13646-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lvkuyfiotrgym74z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbcISTCy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 15:02:54 -0400
Content-Disposition: inline
In-Reply-To: <1473387000-13646-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>


--lvkuyfiotrgym74z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 08, 2016 at 07:10:00PM -0700, Guenter Roeck wrote:
> According to the Smart Battery Data Specification, the use
> of ManufacturerAcess (register 0x0) is implementation-defined.
> It appears that some batteries use writes to this register
> in order to implement certain functionality, but others may
> simply NAK all writes to it. As a result, write failures to
> ManufacturerAccess should not be used as an indicator of
> battery presence, nor as a failure to enter sleep mode.
>=20
> The failed write access was seen with SANYO AP13J3K.
>=20
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks, queued.

-- Sebastian

--lvkuyfiotrgym74z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4DZSAAoJENju1/PIO/qaE5AP/Rw5y8aJJByuZLIi4x2oeATq
ljQ311ckvq49IxlqF4wrIZRJJnCUYMnYRegWnyFNwPaFVgYQiorphQyTanP6JNzt
EmBJSsQw9HX/KrL9XXwgvV56VO/ldRdyxNsYRH4+y/37HBrObRIyBIhgwm5Mtu44
BG7Xndy+WY7J9IUPWT5XWbWsOu72sZLj3iX8486WCArmoNYOC/Xwqxsobz02Wb0R
QzY8h8+xhRYjyORp5bZ3a4Q+Sj4vC4QuZHQlKJh7tDcfKJtq6pZ1K9sNXjITuJ/S
DyLIP2B8OVFu7uVGiAnZy/YwBjKftq9E6yDqgovRwvvzi5Yo5Po5TFTmmS8fU+ja
Wz9K4/+Yoe3a5AEruQ3w2/S+LIr7Wfc4j+VcBERHb9NhkwhYTuxUmvkW55rhQpAO
DOeGda1UGIO2EZGKpoudG05rFfk80ZbBUWNQTPa6eO1H856oiTAxpPsLSno4FN13
/cmvuD3F3vPaFbPfpvmMxo5h9HFS5qXc7NZtmXb1rqFr8zM54eJ7KVDCfzHxdVoX
gGnWrZS6Id93macqAGzSk6gtZjWXuj2ZPOEVuX5zd6cO0M3qzmRwZgaik9ox/aPP
rrAoZo02RGNiCnMyGcUiDOx4cJt3utmVWIxuwSB4jEIXZsvMs/0ivWF7WepP2sci
v5qMqUsXmIU6tewzmgiJ
=0ATD
-----END PGP SIGNATURE-----

--lvkuyfiotrgym74z--
