From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
Date: Mon, 3 Jul 2017 19:14:27 +0200
Message-ID: <20170703171427.qtpodt7watymphac@earth>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
 <20170703133602.ejcdu35ku3i63cj2@earth>
 <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q423twwc3cpjnt2c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--q423twwc3cpjnt2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 03, 2017 at 07:37:59PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 3, 2017 at 4:36 PM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > On Sat, Jul 01, 2017 at 09:28:10PM +0200, Julia Lawall wrote:
>=20
> >  * drivers/gpio/gpio-pca953x.c (line 190-192)
>=20
> It has double conversion there:
> 1. LE CPU: Read as LE and converted to LE (no-op), so, just u16
> 2. BE CPU: Read as BE and converted to LE, makes it __le16
>=20
> Looks like the conversion is not needed, only get_unaligned() is necessar=
y.
>
> P.S. What about lines 244-245 there? I think they are no-op.
> Interesting that those two parts were added in quite different
> commits.

val[0] =3D (u16)ret & 0xFF;
val[1] =3D (u16)ret >> 8;

looks like cpu_to_be16()?

-- Sebastian

--q423twwc3cpjnt2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllae3AACgkQ2O7X88g7
+po8OA//d9JWbNuF91GTv7k5o+dDCtUU7lICKhKm3wepov1DCRG4zUU57J/xPuI0
AxhTJQaF34E+2hs5+6WW+FC1IB/WA+nGpOS5dd+mKgno79AhMG0k424qbLQeNSfk
HploHIYSYmq7ndaLdRzeUDpC4kJ4+5eDxa3jVcC5d88Wc9mtX6UghzRsGEiw18EY
dOYbfYOZl3ANIAOFH6sP9p4g0j6BmX5bayOTP0hcPVoEZitYvoSaJMJczEwEgymK
rOpNpQFoXrbv5M/V9me2Qx8IOQ/uLYmgsJZbd3lotk3NsJvhuK2FkYAodNF4XC2R
ifkDovn2e4FzWLtbfSXrTdg5t6kWL6VCGGwW+V6sFl1hT6cHfIijsU1CGW3MTT4A
Njq8xRm0aOenaivh4DgPAtceE4ddsc7DJHGPKiqOYmiPhcxKckWSZbWuJD4n4Al4
crkYvIzsmX82F9S7xXfmW4Nt9mGiFiNnIFYfSrz8kbrA9Oj3/SUv0x/DqHULYAzf
8mfc5JWnEoVbIBQZ0m0EEu4zBbjMXE1Mk1CyiXWacb0J1OMpMpiwnmis/6lvPshL
ZnnDYVTjthwlukiOm3tVIXzZFCdlhkPpjFwFiP68OEYquJImWgl6ezaG3Rg85MM/
TwxqRJJrfXtGAnX0i3PgDLi/LQtCXK3FFEQBqtw/+7010a6jc+o=
=JFid
-----END PGP SIGNATURE-----

--q423twwc3cpjnt2c--
