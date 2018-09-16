From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 0/3] power: supply: cros: add support for dedicated
 port and expose connected ports
Date: Sun, 16 Sep 2018 13:12:54 +0200
Message-ID: <20180916111254.iapirc4utba4kkzj@earth.universe>
References: <20180810131349.3883-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fioddoivingr7mgd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180810131349.3883-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gpain@baylibre.com
List-Id: linux-pm@vger.kernel.org


--fioddoivingr7mgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 10, 2018 at 03:13:46PM +0200, Fabien Parent wrote:
> Dear all,
>=20
> This patch series adds support for an optional dedicated port
> to the ChromeOS power supply driver and adds a new property that expose
> when a power supply is connected. The series was tested on ChromeOS "Fizz"
> hardware.
>=20
> This patch series depends on the following patch serie which adds
> the ChromeOS power supply driver:
>  * https://lkml.org/lkml/2018/5/2/585 [PATCH v4 0/3] mfd/power: cros_ec: =
add
>    support for USBPD charger driver
>=20
> The ChromeOS power supply driver also depends on the following patches to=
 be
> applied:
>  * https://lkml.org/lkml/2018/4/23/602 ([PATCH v8 0/6] typec: tcpm: Add
>    sink side support for PPS)
>  * https://lkml.org/lkml/2018/4/18/229 ([RESEND PATCH v5 4/7] mfd:
>    cros_ec_dev: Register cros-ec-rtc driver as a subdevice.)
>=20
> Best Regards,
> Fabien
>=20
> V2:
>   * Rebased to fixed apply issue with patch #2
>=20
> Fabien Parent (3):
>   mfd: cros: add charger port count command definition
>   power: supply: cros: add support for dedicated port
>   power: supply: cros: add property to detect connected ports

I prepared an immutable branch for patch 1+2 and merged it into
power-supply-next. I will push out the branch and send a pull
request for the immutable branch to Lee later (once I have Internet
connection).

-- Sebastian

>  drivers/power/supply/cros_usbpd-charger.c | 126 +++++++++++++++++++---
>  include/linux/mfd/cros_ec_commands.h      |  10 ++
>  2 files changed, 122 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.18.0
>=20

--fioddoivingr7mgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueOrUACgkQ2O7X88g7
+pqP0Q/+K/+lqnuTAU6NxzMJkFPBFSQ5k+dcnixaqnYrAjuwwcejGO8soyGo4tpl
LF1OIeeQKXxdTJhSIBFGQhrPgDIzKRX8u3z1/rmYgrjxFtZwGusWvtvdF4xbTrgL
ZpQP1Y5MREKv7hKig20Nsw+g9IkJGaHk0qZpyHLPpIi0YcKYRQNnumk+Vns3g7Wn
ilc6wNW+fODI/jJQD4Md8UIKyqOP3Rk9Q92KUmfGNb86ip8cvGUj62LIG+ZoveLP
/vwesoWKCtq+M2O0ykxt/dCNZGwYcVmLevoRE6SWWN8h8XUZiSUn42lXuY+QrVyq
gAizheqniYwo1YErTmKGa2coeB2hxbBrA3EbzYKEGqFW5CvWBgTU0kAfqFn0FKWy
qzCDB/f9JFUJViYTWDbgT3KhDHaMZVMxeZhjujoLZ31fVFYsWbQ2QvREnMcGZSbZ
/HzbeUDXmRKmrBHrGq1wsNFsnjYzwEXDEBEfgufARM6hklvjw4BliKirPwk+CWUw
o99AxruxoIo+2rhwC9YWiXEQl2391L+sMEI2rVfkYewrVrwmwC2wuvDJvzyuaxC6
KLuSn8XHa1Lm3GK28Ws/JT3kVerXTwKZb4iW+3KOgX0ZcEM+Y6AFPkAm8ujpslJC
x2whjMvSi084CvxZfi+wN09nf+JSvxMiwhgZSkQ1tjsrUkvhxnI=
=E2Uj
-----END PGP SIGNATURE-----

--fioddoivingr7mgd--
