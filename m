From: Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Date: Mon, 29 Oct 2018 14:07:57 +0100
Message-ID: <20181029130757.m5okrfvusjl5fu5m@qschulz>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-5-oskari@lemmela.net>
 <20181024135633.GA342@bogus>
 <20181028154011.04efdecf@archlinux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d247wavwh5lwf5wa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181028154011.04efdecf@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Rob Herring <robh@kernel.org>, Oskari Lemmela <oskari@lemmela.net>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--d247wavwh5lwf5wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Oct 28, 2018 at 03:40:11PM +0000, Jonathan Cameron wrote:
> On Wed, 24 Oct 2018 08:56:33 -0500
> Rob Herring <robh@kernel.org> wrote:
>=20
> > On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> > > The AXP803 ADC is compatible with AXP813 ADC, but add
> > > specific compatible for it.
> > >=20
> > > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >  =20
> >=20
> > Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> This doesn't seem to have any dependencies with the other patches
> so applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to ignore.  However I am a little curious to know
> why we would add the ID and then not use it (that I can see)?
>=20

Sometimes with Allwinner (and X-Powers), two IPs seem identical until we
discover something that is slightly different. When this happens, we
have to add a compatible to differentiate both. However, we would also
need to change the Device Tree to change the compatible. We would need
to handle the driver behaviour for both Device Trees.

So better anticipate a possible difference so that we don't have to do
some hacks in the driver to handle the device correctly.

As always, Chen-Yu or Maxime may know better so I'm just stating what I
seem to recall.

Quentin

--d247wavwh5lwf5wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvXBiwACgkQhLiadT7g
8aNGohAAqGgoY6iEBWbxr5CUbqS3mda6QQ8HkBcE9EqDT/JpjKiQmRay4qZyJ6pC
u54eWJFzyZOyOmzhVUhP9TTa6yt0+A/tmyOtEUwkH2rU4IPqmwrjJ4PAnk4aFLw5
EsPN25o9Zk60y9bhvclDkw1MHldvPJER6ejygP90zOcwqIc5DjrQfY4aPnImnRZ1
+Cs/zct/IVUScTCOMdqvOT5mff/8OkKRmbw6+Ukr/11RPIm2zly61i0XWoyXslkv
xZhhP+Fs7G3+Zs7cUmxkTNliyJ4wHkHD9p00fSB2DKWB0Xj+SeYziWvLZF/tVV1J
zhcfRy1yVI3gU5Uvf9kd5/ONHQt06yNVtSusEpmV19WKznoJqrn9IFLmXqJC2ayv
8mVHDSRP3ci0k4hVC3kpQF3SkVe/kYpxdzea7u+d+Lv6xg2j9QRqsJN/IL9sY0Ss
JFrQVxrhEolYScRpEoORWU7e5phhrGxK2W9wFO2iHVbH5M3vVZnWa3L4RZf5NiwR
Zadjk2idbdpn3FBMmOi3QKtT7xlsPHauv8vCr2BVEnQFIJMqvNt9Ny0t+ZDLfw5h
/JaVZs1pOcKwzvJvtch1wtbrCPTgzHJLEU2gO7bWWXolBnYx28PYKjgtRgl/RLvM
m0taZizWks/8EqaYlGFYpoUoBYTNnYRivcoJV602PQk1gmzcvYk=
=YFs6
-----END PGP SIGNATURE-----

--d247wavwh5lwf5wa--
