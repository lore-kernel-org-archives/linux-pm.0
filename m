From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 0/3] power: supply: cros: add support for dedicated
 port and expose connected ports
Date: Sun, 16 Sep 2018 22:37:22 +0200
Message-ID: <20180916203722.szu7m2bztos5b6bk@earth.universe>
References: <20180810131349.3883-1-fparent@baylibre.com>
 <20180916111254.iapirc4utba4kkzj@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3qn6lr4o7bwrthb4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180916111254.iapirc4utba4kkzj@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Fabien Parent <fparent@baylibre.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gpain@baylibre.com
List-Id: linux-pm@vger.kernel.org


--3qn6lr4o7bwrthb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Sun, Sep 16, 2018 at 01:12:54PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Fri, Aug 10, 2018 at 03:13:46PM +0200, Fabien Parent wrote:
> > Dear all,
> >=20
> > This patch series adds support for an optional dedicated port
> > to the ChromeOS power supply driver and adds a new property that expose
> > when a power supply is connected. The series was tested on ChromeOS "Fi=
zz"
> > hardware.
> >=20
> > This patch series depends on the following patch serie which adds
> > the ChromeOS power supply driver:
> >  * https://lkml.org/lkml/2018/5/2/585 [PATCH v4 0/3] mfd/power: cros_ec=
: add
> >    support for USBPD charger driver
> >=20
> > The ChromeOS power supply driver also depends on the following patches =
to be
> > applied:
> >  * https://lkml.org/lkml/2018/4/23/602 ([PATCH v8 0/6] typec: tcpm: Add
> >    sink side support for PPS)
> >  * https://lkml.org/lkml/2018/4/18/229 ([RESEND PATCH v5 4/7] mfd:
> >    cros_ec_dev: Register cros-ec-rtc driver as a subdevice.)
> >=20
> > Best Regards,
> > Fabien
> >=20
> > V2:
> >   * Rebased to fixed apply issue with patch #2
> >=20
> > Fabien Parent (3):
> >   mfd: cros: add charger port count command definition
> >   power: supply: cros: add support for dedicated port
> >   power: supply: cros: add property to detect connected ports
>=20
> I prepared an immutable branch for patch 1+2 and merged it into
> power-supply-next. I will push out the branch and send a pull
> request for the immutable branch to Lee later (once I have Internet
> connection).

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git/ tags/psy-mfd-cros-immutable-for-v4.20-signed

for you to fetch changes up to 3af15cfacd1eef7f223802d49a88cae23c509183:

  power: supply: cros: add support for dedicated port (2018-09-16 12:55:25 =
+0200)

----------------------------------------------------------------
Immutable branch for mfd and power-supply for v4.20

Immutable branch between mfd and power-supply for driver
changes in CROS USBPD charger driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Fabien Parent (2):
      mfd: cros: add charger port count command definition
      power: supply: cros: add support for dedicated port

 drivers/power/supply/cros_usbpd-charger.c | 115 ++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
--------------
 include/linux/mfd/cros_ec_commands.h      |  10 ++++++++++
 2 files changed, 111 insertions(+), 14 deletions(-)

-- Sebastian

--3qn6lr4o7bwrthb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluevv8ACgkQ2O7X88g7
+poEBw//ddrOYa5nNbPvtjw90WJtN+p7mjKsE4VJHW3S8M1xOJr2h2dNksKNPXGC
6eqVBYr6HJVDS9xVcshl/+vDecB8Y5VsNgvVifxiT4nZgvymIO1DwzYswdebQtSD
mE8cwVIJN4eod8+asxRowTbYz6lATJ1YhcHw92VpsiTXnII0FtV7AW3TcukxocSN
AwakMYRLpSZMhUgv07OdXIgopO3S17IuNfGMEDTsoNQlwH0Qbrmidb6M+FqrBSjb
HZa4KHtza6g3YhV53EJthGeeXorMyArmssTSNQpDUjU15vq0tTOzx9/jYa4HUwu0
547rg/G/J+J5VgjH7r/Jf1934e+sPItEP2lnfofzun4Db5qAB3rUF22/ShmHERs3
Wyilp9WfuuZisAGu/LgnOZSCFtwrHvrvyy64+BJrf0ZO5iqYngLX7WM9ASTIjcTf
Zc1eeDzD7Ob7qdTPcD2YaiSaCMZCtEWB1bnHCCuDPoKo/OHw2BtgZjMnIjFYzZUD
ZIMmfiqudNfsCOTY5fp4q9vSqHvO6XsysF6+v5QfVBpkI6HQAOCYUCSXO+6EcQQz
Js/X3canqSBUA0ZYLtzpnm2ice0AgOmcLuWmmELf0qJblkBmhHAbXBIgPTtzzXNI
jTmS6bWe5ob6BiIqzeFp9ytj5fddWgcoPaHiSD0LpHAZFhLX1zw=
=amxo
-----END PGP SIGNATURE-----

--3qn6lr4o7bwrthb4--
