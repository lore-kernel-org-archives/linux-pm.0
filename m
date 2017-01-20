From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 0/7] BQ24190 charger fixes
Date: Fri, 20 Jan 2017 12:51:14 +0100
Message-ID: <20170120115114.hz7b3pqpvtcoqkry@earth>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170118172654.19416-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="miie5eewsytmm56w"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdATL7X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Jan 2017 06:59:23 -0500
Content-Disposition: inline
In-Reply-To: <20170118172654.19416-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Tony Lindgren <tony@atomide.com>


--miie5eewsytmm56w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 18, 2017 at 09:26:47AM -0800, Liam Breck wrote:
> Hi Sebastian, thanks for your patience :-)
>=20
> These are misc bq24190_charger fixes, tested on a custom OMAP3 board.
>=20
> Changes in v4
>=20
> #4 factors out whitespace change in "Install irq_handler_thread() at end =
of probe()"
>=20
> Note: The other whitespace issue Mark raised is related to the purpose of=
 that patch "Don't read=20
> fault register outside irq_handle_thread()"

I queued the patches fixing the subject to contain "supply: ".
Apart from that I dropped Liam's Acked-By from the whitespace
patch, as he never Acked those changes and dropped the Fixes
line from the same patch.

-- Sebastian

--miie5eewsytmm56w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliB+a8ACgkQ2O7X88g7
+pqp1A/+ObmLbq2s9HMmtAy2CkfMKdohSN+7Ho1FgSfTKuzJk6YZ4LAuXiEuff6f
jdrkeYbOZtOYCqh1l2al89b/IoYLXEf3lYvtAKx33fFWQHuUX3fdQyi09cyKFvKI
3dShQIGgLWJKYgI7IDrOGNjq4OORQk35fIumba1JjhQ8+QmY72uA8BEeBvna+qov
ECXa2fSLyMT/2qATFEear/2HPLtVKY4gLycvk/GQjmr4KRulU/5zEMBXi0yvC844
yFOcJg0tc89MR4oa+53veFlI5xCdZLDeAdfbnJ1RTW4F/XuTLmOxaFKCkYG/dCCY
d6zclYXJ/Q4gF4Au7cF39AxpsjNOHhhD8abK/3djclqIze45HMHHpmM0lWdwKIPs
LO2/TlNMN7Px1K2v+lhgQWBSSeEq5iUEMYN6YbJgeNKXRONiMWtBnfxraJdsBoZj
RAC0oG5akRGOXVmCXvYh0FSWPjYUqLEs2U3ywuhkGARfAVS8af9FwmuBo20s7z0+
HhLffJ7n6aGC9JidZ/a7UvznrqZs3TRdkPA5nh5v4ykFB+kmZVmlvC3B28oxqKIY
copBPbHLRPil9eAmCnY/+rh36xLSOBniykxeo13fGVwFEq385fjgEU3av+yY3WaP
PZVqsVLZOgUwOg64+Y1fKQiI9IhLmc+MnRlCaE2YGfyqLgw1mCg=
=9I56
-----END PGP SIGNATURE-----

--miie5eewsytmm56w--
