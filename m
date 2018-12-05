From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 13/14] power: supply: axp20x: add missing include bitops.h
Date: Wed, 5 Dec 2018 18:43:17 +0100
Message-ID: <20181205174317.wm5wuxrhy2tbkjih@earth.universe>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <9547ef8e8e6fe9f933264119bd186bdd83974999.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6r73kfzavaa5p2y4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9547ef8e8e6fe9f933264119bd186bdd83974999.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


--6r73kfzavaa5p2y4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 26, 2018 at 05:27:54PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> The axp20x_usb_power driver uses BIT() operations but lacks the include
> for it. Include the bitops.h header file.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 42001df..f52fe77 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -10,6 +10,7 @@
>   * option) any later version.
>   */
> =20
> +#include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> --=20
> git-series 0.9.1

Thanks, queued to power-supply-next.

-- Sebastian

--6r73kfzavaa5p2y4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIDjIACgkQ2O7X88g7
+ppZFg//W2oPevm8Wr3ZHLF2wdiahU1to0KiH0CWpU1x3nQILUUq9PDsX3y98tng
1DINy6cuzj+ikTkuQz7fvqfVDIx5vphKA/8M+XmhkjtnC0qm7ExnUUGY2+7ZQJ8c
UT+M04fk7/OnV797OzZbuXlC7pixYXLfSAR312RZBuh2h5pO8jUOpaCofhkm5yuh
eQaB84w4FWLfTg9jTkfoA0IrOVYPSYH3mV/q+dew9IWEXh3lQhgagR7KAmr2tzLv
kHxCvOAdUYksAJvCZJ2cibhoD1Fn+N8HuyjipXAgracM70cjfUq0OZb++3yDUbeD
9oJMOW42aheaChUQvHsnRtEeUJLlEvD9OZLmqF2Fxc1g3gitStnTqFO9q0m4/S/3
60xxKoq3wIOpSLa/neMmyvstWjd/704O5fpQFqufitWxb4XNwuxx1wGIv5ch/XT8
HjsG9HYFQhG/Rx1v6t5uBL3aUXw3cY+zdl6hnyKxuRL4SMRR0pGoaQvMdv+Jm7GA
r1QPmY3+9/SGUa3xBq4WoglvrSLFKNlQ8hEuwRSeXOrhW72WLPIUbd69jAgexhDh
M1ZFjg7DiI4UPD4rfQNqKLkZ40xlCaf0ely4uC8aHpQLLznE0MQDCEMiad26Xw3P
YqLcoUybwdQNlVTs5W4vjIzxtkOVWk2V5LcCnXUMN3cuze43/N0=
=tgm4
-----END PGP SIGNATURE-----

--6r73kfzavaa5p2y4--
