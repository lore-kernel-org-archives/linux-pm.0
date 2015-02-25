From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Mess in the /sysfs: class/power_supply/bq2415x
Date: Wed, 25 Feb 2015 22:44:42 +0100
Message-ID: <20150225214441.GK13695@earth>
References: <20150131213919.GA16133@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150131213919.GA16133@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-pm@vger.kernel.org


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sat, Jan 31, 2015 at 10:39:19PM +0100, Pavel Machek wrote:
> So we have multiple values in one sysfs file:
>=20
> root@n900:/sys/class/power_supply# cat bq24150a-0/registers
> 0x00=3D0x50
> 0x01=3D0xc8
> 0x02=3D0x8e
> 0x03=3D0x4b
> 0x04=3D0x99
>=20
> (should this go to debugfs somewhere?)

I guess this should be dropped in favour of debugfs. A standardized
debugfs node will be exported automatically if the driver is
converted to regmap.

> Unobvious and undocumented entries:
>=20
> root@n900:/sys/class/power_supply# cat bq24150a-0/boost_status
> 0
> pavel@duo:/data/l/linux-n900$ grep -ri boost_status Documentation/
> pavel@duo:/data/l/linux-n900$ grep -ri termination_current Documentation/
> pavel@duo:/data/l/linux-n900$ grep -ri current_now Documentation/
> pavel@duo:/data/l/linux-n900$ grep -ri time_to_empty_avg Documentation/
> pavel@duo:/data/l/linux-n900$

Anton seems to have missed making Pali to write a Documentation
patch. Pali: Can you do so, please?

> And different units in different parts of tree:
>=20
> (these are mA)
>=20
> root@n900:/sys/class/power_supply# cat bq24150a-0/current_limit
> 1800
> root@n900:/sys/class/power_supply# cat bq24150a-0/termination_current
> 100
>=20
> (and this is in uA)
>=20
> root@n900:/sys/class/power_supply# cat bq27200-0/current_now
> 12138
>=20
> (I believe uA is right, so it is bq24150a that should be fixed....?)

> Ok, of course questions are: do we need to do something with it? If
> so, what?

For consistency it should be uA, but I guess this would introduce a
regression for Maemo people. Pali?

-- Sebastian

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7kJGAAoJENju1/PIO/qaci0P/io/qwYvkJeheKr9GvB5ihdv
T7I0wN+Eb2/nwJD7HAL832+OQV/YgE1nVzwcSxs6giKqAjwDfnwPf7D50zJzPH7x
t855eNgoqqPxUqlwmORVMAnzFWKPjjmCbSRxbp3OEQEtj05h5XobBNn/uIhEQVWe
6ND8fR7yQShg0/M0XN5vDKUul0PY9NaMdeTzGwDw19y3+OA3wC5z2NLTOkSkjRFb
nzboXiXVeJzotmeRsFjDQbKu8BmMef1j46sU0VA648PtXlHtE/TbPmHvTn00Ygz2
q+E/EjoKEG7Fkd8CQ8nbzm9pYDYlrBl0FQ8JHJuGaYoT6Of9gFP+agarNdnQ6fUQ
y2jKwFwuXTiC0MfUFPuLdXQBqdC5fnGjTdz0vCchJVnUnU7Um5KTb9LVEEE6IWbN
cQYWzmbVOj+J2AwUxH+Eso0/+NdXdLcyEy69GXlfxzY6/omXBmDgPP7oCGes2cW+
b1+RjGyKknjlQPCg63TmxKTq5P3GaXlbBmxRK5hu8dokWwD+FKjz9Ps1WK1saDzl
FmuYcLSPbZ0Tax3CqFlokTy5KrdsH2GBdpbaR9Yy61YVLbrny1MXxmhjjv8X6kEx
b3UeHGLwUnv99xF9Z8tE1qtWtws7jFjw4GT7D118WC/poId/so3C+SEkbVtBnBhv
bG9lsUv7B/ZUgWxaCmV4
=22Nq
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
