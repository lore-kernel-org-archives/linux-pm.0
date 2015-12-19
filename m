From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: s3c2410: remove superfluous runtime PM calls
Date: Sat, 19 Dec 2015 22:57:52 +0100
Message-ID: <20151219215752.GA1247@tetsubishi>
References: <20151219105030.GA2571@katana>
 <Pine.LNX.4.44L0.1512191202150.27155-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1512191202150.27155-100000@netrider.rowland.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Asking linux-pm for help here: If we want to support RuntimePM for I2C
> > clients, do we need to enable RuntimePM on the logical I2C adapter
> > device (the bus master) which is already marked using
> > pm_runtime_no_callbacks?
>=20
> In theory you don't need to.  But there are some advantages if you do:=20
> You get automatic runtime PM time accounting for the adapter device=20
> (how much time active and how much suspended), and suspend events will=20
> propagate from the I2C clients all the way up to the adapter's parent.

That's exactly what I want. Thank you very much!


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWddLfAAoJEBQN5MwUoCm2VgcQAJx+dNIU++AH6GiME8BXZhhH
PVDBMg9DzdEytODZlQORBFhANkjrvFnl1OHSi9TEPqZvV6yb3ZKdbvF5n/YYxYtP
QPl3g3kn6VxaEftmvJje/r9NqPBZ7ihlHKu/zEbjVb89euyLVmgRgAM59n4j1mRy
hiDLs4KTmPriklfg10R7ib00fEZA52+E038GVpgSinCM/ldStyHN0rTxSXeWdUmj
LmDA6mlsgoZUNBXmYp8BAqY885azOqeMn3my3eYcYR/gHIUiPIEngEYGpD61IIYV
gKG/NcGLKFrzpMSVglgrr6wvWboCkbawEckrdWOTC3zdmM4syfdLcp6Inzt/vcnR
7ResqVYylja3YwOCeZ6HZUCC/wnmfGHCYaN3ATFICMumdsWeqst4OHiZ4R3hAxEg
U31l9bubq1WsdRyLe5yilQGzLGXKYTMajQd3zrKHpNTLgW4T+zZx/xwqGdr+AR9p
AHttqZ3SXeuBwFhNtE1iOLpwZ4xy9j4VM5eko4CqxEMb+5cssru1zJuK09L0ipMh
pgoXJIqdc0SiBlP8TM+wDFch+Fu0ks8BCSUQoZmdM/qWWk4bj23qr+k0sM7DVX2B
aCZbOpJaZHivfZDxdqwt/zgNV34pK9mz4H3TCfCXZJqYweyCG21Q0juwW8U/xlrv
YN95JWfomQncT+Grq2D9
=ZnPK
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
