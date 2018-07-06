From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: ltc2941-battery-gauge: Release
 device_node in ltc294x_i2c_probe()
Date: Fri, 6 Jul 2018 19:04:52 +0200
Message-ID: <20180706170452.xw3w56dgtj4j4tru@earth.universe>
References: <1524954955-22107-1-git-send-email-khoroshilov@ispras.ru>
 <20180501123908.z3kuokp2b6umnnda@earth.universe>
 <8fef316f-85d0-0bd4-4bbe-2d8330dfe2ec@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sgp437usmp7xmvlg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8fef316f-85d0-0bd4-4bbe-2d8330dfe2ec@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
List-Id: linux-pm@vger.kernel.org


--sgp437usmp7xmvlg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 08, 2018 at 10:16:31PM +0300, Alexey Khoroshilov wrote:
> On 01.05.2018 15:39, Sebastian Reichel wrote:
> > On Sun, Apr 29, 2018 at 01:35:55AM +0300, Alexey Khoroshilov wrote:
> >> There is of_node_get(client->dev.of_node) in ltc294x_i2c_probe(),
> >> but these is no of_node_put() somethere in the driver.
> >>
> >> The patch adds one on error and normal paths.
> >>
> >> Found by Linux Driver Verification project (linuxtesting.org).
> >>
> >> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> >=20
> > That is ugly. Let's replace of_property_read_u32(np, ...) with
> > device_property_read_u32(dev, ...) and get rid of np instead.
>=20
> Ok, I will prepare v2.
>=20
> What is the right way to replace
> info->supply_desc.name =3D np->name;
> ?
>=20
> If lifetime of 'client->dev.of_node' =3D 'np' cannot be less than lifetime
> of 'client->dev', should we use just
> info->supply_desc.name =3D client->dev.of_node->name;
> ?

It looks like I never responsed to this, sorry for the delay.
Your suggestion looks fine.

-- Sebastian

--sgp437usmp7xmvlg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/oTQACgkQ2O7X88g7
+pq9xw//V+h6sEIzoTlgvBqXNPwpDULp4u31CGbC5taCrRW3sSAUxrSf2Bwixr1i
9yhwEelcRrQkkZO3Z4gp8B3z2tEVVw8H6x8DmbI6k4ZGeZgBKiH6w92+PDsGoo3E
NlcTRN/MjX3Z6zkilIpOV9k+EMDDZdFHT4tS6PHxVh8KFFZ85qLBkpkoXi7rjEKf
xPJTd6yKdXGy4OkMtDFRONvqJHOA55+aMxzzLC5DBdEg1c2Vwpaa9K+cV4UZBRjb
3mrCJsdgmP+uzbbSrWRdq1aU1Lfb6gNiXJna1RIVeJG4MwQyw7jLLBU0mNzg6lMx
gKBk8ohWH+7AJnF3SoKJOIZJEeuZbo90Lx0IyHTsneh4F8oXYrkKXxj6ffwFm+BO
weMeCbYvQKBtoMzhJkm76VSvP40pdihCbcpqYoFJYlbXDAjMJ4pndrxod7wfpuwT
rYorDKS9OzWXvKjxrpFmczU9hyLW4oFr1xk4oPhhNFezGkpbWcmhqsXc4roaiAYe
MfBhqCjm0FrulJEtwHaaLVz0O41AFQjdHwezmfwubI576PIRArQ43UCjgl79dlE6
yAAg5I+U9Cug5c/yDTbwQ9a7dpty7KxEmTaMbV7+gstccofDTTKvtrOK41GquhbL
394dzVfTYjbe4zh03uVA8xkREjX2RVoOTDTRmOVJxxAnIlJF2rc=
=pGHf
-----END PGP SIGNATURE-----

--sgp437usmp7xmvlg--
