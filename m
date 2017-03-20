From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq24190_charger: mark PM functions as
 __maybe_unused
Date: Mon, 20 Mar 2017 22:39:37 +0100
Message-ID: <20170320213937.ssk5ztffifna5sfp@earth>
References: <20170320131424.271241-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nggept5cdypatvf5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755123AbdCTVjo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 17:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20170320131424.271241-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Liam Breck <liam@networkimprov.net>, Mark Greer <mgreer@animalcreek.com>, Colin Ian King <colin.king@canonical.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--nggept5cdypatvf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 02:14:15PM +0100, Arnd Bergmann wrote:
> Without CONFIG_PM, we get a harmless warning:
>=20
> drivers/power/supply/bq24190_charger.c:1514:12: error: 'bq24190_runtime_r=
esume' defined but not used [-Werror=3Dunused-function]
> drivers/power/supply/bq24190_charger.c:1501:12: error: 'bq24190_runtime_s=
uspend' defined but not used [-Werror=3Dunused-function]
>=20
> To avoid the warning, we can mark all four PM functions as __maybe_unused,
> which also lets us remove the incorrect #ifdef.
>=20
> Fixes: 3d8090cba638 ("power: bq24190_charger: Check the interrupt status =
on resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, queued.

-- Sebastian

--nggept5cdypatvf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljQTBkACgkQ2O7X88g7
+pqb4g/+KH9tqz3ExsvCQ1nQ2rey/WquY+sbFnNQZVxQY7xt/9DwaDdIFZ8kxsO/
LqbX1+jGSFQVeCcnk+eBtWAerL9BePLh8tY9xMUi15ti3TRAVHBvY1+ofBDsWmu8
URdx1Ek3oL4RLxaCXaenOWE8d0B1MD/xJcr81xg88wlJF9mkST5rixfj/m84kLE4
DhCeeIqllaujczVVr8dQC5fH5n8eXooLOJVYagZDHMy2MFzWJmplvXy/5tApPnc9
exfsBXC07HlcV/oWJB38gfHUUYDQv7Gdl893z5YDEqQMarLsepJRf0DIXm7cP2le
Jy7EtKswDso2qyn8hsCgB1BHuw29Ff8Sbby3cLpMmBipS384lgw7N7p2OjrADt0f
CvMRUZt1hPlJnxQpsSj4RP9dDcNvpdcvU3CDd0KO/vJ/1SFreo1EIi2zof6hdPAT
qWu/uwRVQEz03MkRQRP8idgP3kkQhH92Jy/mWRuEhZTSUbxlD/Hw4ijHjjJCLjNX
6prdWLl0iUEJbA1TENcjBCeRFTXXeSW/JGDiSCob7Qm+kEx6osf+HMTZL2x2XnRH
iOaBlePS4SBi4+2LoahdB+1ylI9IPoHIIQ4wqhTQezt/ypbUUf5x+n/ZaPyvk8To
qz+N8PQbz8zcDzpfV7VAGCKhflNQX3PnENARDn/zxql0WqrVQ5E=
=+6e8
-----END PGP SIGNATURE-----

--nggept5cdypatvf5--
