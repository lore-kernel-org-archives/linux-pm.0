From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: twl4030_charger: remove incorrect __exit
 markups
Date: Wed, 15 Mar 2017 22:12:32 +0100
Message-ID: <20170315211232.fslnl6qwhftzcvbp@earth>
References: <20170301234453.GA13831@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="que2yga7vhr7hbfg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750819AbdCOVOT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 17:14:19 -0400
Content-Disposition: inline
In-Reply-To: <20170301234453.GA13831@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--que2yga7vhr7hbfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Wed, Mar 01, 2017 at 03:44:53PM -0800, Dmitry Torokhov wrote:
> Even if bus is not hot-pluggable, the devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, merged.

-- Sebastian

--que2yga7vhr7hbfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJrkAACgkQ2O7X88g7
+pqvHw/8ClmjY4kOcWgopftQah1ggwxUkhGzcdkCW9LHZBJfNT9jTq+evY9QbFjK
UL+YyCZs6X/bxWficENGlsjdNYgEvaiN4+Otsbyivac0JBoltonZAJdV5dHq9E6k
nx/5PPsqeEM6xRZtPVdEOBdgevkqEseS9ZuHztaDVAe1Xie5/0v5OQJMpTzIBYpr
E4oU+Kc6e2GplugMgzHiJdvnd8HmTEf6koPl2rBJaAArMhhTuT+cG1L+gW5++ttC
JB3mhmW0IisTdU0IbmWzVx7yMnRwiTDJoV02Fa61+NhE0xjwAl9KnNF2xR7h7l9B
ovZmKYkeHIA46X1YDDBmdQfSCNMnVgc+l3yTzy5qZrodOWbUiWuscLd4ANTNRqnT
T8VO9hcsaVY0aJy4cWo8+H7a+kgsuUEOkVGIZzTIN9aat6kO1FIGNmxdbGll+en/
m7ajmxg+ZyP1Vs0lDWQzh4NMrHHdl1AHu6CX36RPt2izikWQfKmtR+m0cX4O0WNp
4jD+BhwkNjTccqysi4yBuMgHiAyRfoOHbr6eavHv2H9mKyFSwjOrMynMzFAYjXqb
Pq0QHpQDQFYaP/2FpCm/di6+OOPwQALDetMEUgydR9Agd8rvLc5Bmw142sGYmnqF
ZMZKFrLr2gxUbWrTVsSI6JHepI72BwtPrT8bGqIU/+ZKnJaZjPU=
=Z7ra
-----END PGP SIGNATURE-----

--que2yga7vhr7hbfg--
