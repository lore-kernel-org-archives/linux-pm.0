From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] iio: misc: add support for GPIO power switches
Date: Thu, 29 Dec 2016 17:29:20 +0100
Message-ID: <20161229162919.j2ej2cyeuoqnxykf@earth>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-3-git-send-email-bgolaszewski@baylibre.com>
 <CACRpkdZ7JrNfCKPuuCmkZd_7+NV0QLUN8ZMukFA0TcqS9SYXcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lb4vfyzhy2tybpcz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZ7JrNfCKPuuCmkZd_7+NV0QLUN8ZMukFA0TcqS9SYXcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Lia
List-Id: linux-pm@vger.kernel.org


--lb4vfyzhy2tybpcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linux,

On Wed, Dec 28, 2016 at 01:50:17PM +0100, Linus Walleij wrote:
> On Sun, Dec 11, 2016 at 11:21 PM, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>=20
> > Some power-measuring ADCs work together with power load switches which
> > allow to power-cycle measured devices.
> >
> > An example use case would be measuring the power consumption of a
> > development board during boot using a power monitor such as TI INA226
> > and power-cycling the board remotely using a TPS229* power switch.
> >
> > Add an iio driver for simple GPIO power switches and expose a sysfs
> > attribute allowing to toggle their state.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> I don't get this, isn't this doing the same as
> drivers/power/reset/gpio-poweroff.c
> ?
>=20
> With the only difference that the latter uses the standard syscall
> from pm_power_off to reboot the system instead of some random
> sysfs file.

As far as I understand it, the TPS229 is used by Barzosz to poweroff
a remote system. The gpio-poweroff driver is used to poweroff the
local system.

-- Sebastian

--lb4vfyzhy2tybpcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhlOd8ACgkQ2O7X88g7
+poLnA/+PczlGKFDmT/RhKMoBhYGAKqa02N/XFLAqeAHHijUHnkynyQuJCy4Z+du
zN83tRGzpGNGNivQrQ7+50ClROqR6Qg/IJUueK/ma8kR3UM8xzW7hylyfxo978Iu
sjquC1lgS2J7FCBUoP3x+W7XC/ScGwit6ANpso/43BaSAghSNKs7ypI0bQvOzURS
eKgiFBXkVU1NIUbcXI91hZB/gBsrCI6DGj48eW1+WKrFze+NwW6VenuXs3OrqruU
mtiZmlxBtlhjIczwhxTN/TyGbRIXaKewj2fs45uDOM15SMVmA7sd9H/kzfkO3vLt
w7YDNkbnKuKS4ptB9dVeOsFHruTJKWJloQmxhyAX8RQq/MU39xTxxpJVJpyZXxVj
+GP9c+T++OVhKJHkL3JZ03EcFpFlZshNS9KzpUqAokZ6YTZ0sKJs9YfMxrXEz694
xTifMSKbhELgCevzFldXGDoknJa8JmJuZ3LxxpJq/caLDxa9KjIG2V5ykVw6me4E
8nvRZnLVSgYFCgC1wJblnkgFa40XGSWMieuaz1ucb2+CynIQtbwD0j6XgVTeUdQM
qN93281DJT0dmQ0n/dtDcZcGu32qhXx9WSPmZJpptuV9cusMZsUklUaP3nKhNVYO
YVaV7x3ohxPYmiarJfVRCA+kXnXUSHnMD6jCRoqmGSB7TRNaq6c=
=eV4Y
-----END PGP SIGNATURE-----

--lb4vfyzhy2tybpcz--
