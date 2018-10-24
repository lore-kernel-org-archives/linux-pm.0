From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/3] PM: Renesas: Remove dummy runtime PM callbacks
Date: Wed, 24 Oct 2018 15:22:00 +0100
Message-ID: <20181024142200.GA5637@kunai>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 04:51:31PM +0300, Jarkko Nikula wrote:
> I noticed these independent Renesas drivers have needless dummy runtime
> PM callbacks. I don't have the HW so only build tested.
>=20
> Patches can be applied independently to their own subsystems. I wanted to
> send them together if some of them gets Tested-by or sees a regression.

At least the I2C driver part of this was on my todo list as well (just a
bit lower :/). I wanted to find out why they have been there in the
first place. Do you know if such callbacks were needed "back in the
days"?

Adding Magnus to recipients...

>=20
> Jarkko Nikula (3):
>   i2c: sh_mobile: Remove dummy runtime PM callbacks
>   net: ethernet: Remove dummy runtime PM callbacks from Renesas drivers
>   usb: renesas_usbhs: Remove dummy runtime PM callbacks
>=20
>  drivers/i2c/busses/i2c-sh_mobile.c       | 18 ------------------
>  drivers/net/ethernet/renesas/ravb_main.c | 13 -------------
>  drivers/net/ethernet/renesas/sh_eth.c    | 13 -------------
>  drivers/usb/renesas_usbhs/common.c       | 14 --------------
>  4 files changed, 58 deletions(-)
>=20
> --=20
> 2.19.1
>=20

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvQgAQACgkQFA3kzBSg
KbZ1+Q//YX0k/nI/3Cs6uu3E0BXdOQUKn502WYwXrs9SGPTdie+6Ps0SPVHPmCuQ
GKknAMm/8ChvHq+pV0N2f6ouyZd/fEFFcopwDZecXyZCREuPGbivsKqtTnTzbPOt
QMDWvvpF2Rzg1tM+svsSUQdchptlRHGQwP6zF6+/tr0mdrbaRSyQ01Wyk6S/Xtk5
G3BIhflMT1yHYmWz2L4HZ0JjqthXv0cNYOHNrV83a20PGsQd1zqXs2LLJDz4WpxH
00zffS4O+86fm8kj6F8TddIVNJzEEeXx39ctyKiyCLxlRODc8wCd4aI/JU+1SKXR
zgOBJnEzFbZVFX6auRtVUxrJ8+8q9AVP5bcCg1teaDf1PEUQUmfkGXPn2PI92jwt
zH5y6mMA5bJXUj/gWGXr6SNCkB0geZOe4xNsAEpDo/GKVtBQIBYF1k7NYPz32OYJ
qFD3Eds+QOdz/YNo+z0+Jat1yWXEd+HsME8WrmqbdRXe5B/4L2d01zISbBHnxjC0
aGrRd+TnBg7DXlDmAo8v7cNugMKNxauVUD1IsyJ/yfl/rpjoVxOP82qsqTluQ+6W
Lu7Z7KPln2Y3Rv5AnQXeP3pO59Lll81Eaq6mAItcrjX7QPn0WH8LVUdIyz3ssKs6
1v+LsYSdpyVvMvH4yKPqfUDnMAMjx8Q/as/K/0Y5A8isjHN6GrE=
=3659
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
