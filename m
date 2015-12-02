From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFD] PM_GENERIC_DOMAINS && !PM
Date: Wed, 2 Dec 2015 16:40:50 +0100
Message-ID: <20151202154050.GB624@ulmo>
References: <565C7C86.7030801@nvidia.com>
 <565DBEE6.5030704@nvidia.com>
 <20151201161809.GA20561@ulmo>
 <1995321.JkVMSghsar@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1995321.JkVMSghsar-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 02:35:20AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 01, 2015 05:18:09 PM Thierry Reding wrote:
> >=20
>=20
> [cut]
>=20
> >=20
> > That all sounds very complicated for little gain. Disabling PM doesn't
> > make much sense these days, so I'd personally be fine to unconditonally
> > enable PM on Tegra. I'm not sure what the correct way would be. Since
> > the PM symbol is user-visible, selecting it doesn't sound like a very
> > good solution, though a quick grep shows that some architectures do
> > this.
> >=20
> > Rafael, do you know what the canonical way is to make !PM invalid for a
> > platform?
>=20
> Well, good question.
>=20
> I can't really suggest anything cleaner than selecting it from the top-le=
vel
> Kconfig at the moment.

Alright, sounds like something we should do.

Thanks,
Thierry

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWXxECAAoJEN0jrNd/PrOh9tYP/ApXGqg14KqNoVv0+9e5vWvQ
Z71/iAnq03eQBGl0fc656YjYCkXet+PaTpQcfd0f0/L0i26IrhkqQ5mgENvDEdpz
cmTcyz/mV9XMh+BcArEsq+xpzMV+8PJYHJh8D1buh4jXH2a5gfffvu9iEUoq+Wlv
I90XXcyPWnuuz9azzO17KN1OVWKHofZmPDmUBcyBjoGKzcBARra8sR8MzTHLRHAv
740Lo10sqzk6XnnyJ22JaRIcM6VKl8qyj9VX1jR4lKd9Im1nceKSJrugNbzdaINf
a8oRPqLVSZ6ncb26y7TGD2m/lMO1bfTG+m0DyNgnE1pDWWzjBPxGkH5gk3BdVH7m
to90iNB15XTeQ5W+7hxN0w5raqBimn5fkK854kjM3PU1vLONqhah3huk7MUp7EAL
MzGCVTJnttjeBDrb1SAfJsjUExB9H1EojZHAZFJqdDXv3+OJyfB2lylrN4NmDtrv
vEI4wx1taAQ+OAwamugqcgWz4X6n42IhG5UuXktkZdtuJM1XKEWXkkNXGT8daW1U
rFM65L0Xrgsq2P/UypzbdH0PNSnBb6Ay0APNhAlfcM8HlK/8WfKwqN09XGsZcR44
jBFtJyB9+2c4UtLk/eZBNvuPOifHLbIFPYjHd3IJWkCfaOKPxc415XIxYP89ZLDN
87NyxK40jKhiU6zKfbmV
=V/fY
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
