From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 03/22] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
Date: Thu, 5 Jan 2017 17:51:42 +0100
Message-ID: <20170105165141.yamr24tn5pcleyfa@lukather>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-4-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8988884107367946325=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-4-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net, knaack.h@gmx.de, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, jic23@kernel.org, icenowy@aosc.xyz
List-Id: linux-pm@vger.kernel.org


--===============8988884107367946325==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ubympmcbdleq2fod"
Content-Disposition: inline


--ubympmcbdleq2fod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 05:37:03PM +0100, Quentin Schulz wrote:
> +	switch (axp20x_id) {
> +	case AXP209_ID:
> +		indio_dev->info =3D &axp20x_adc_iio_info;
> +		indio_dev->num_channels =3D ARRAY_SIZE(axp20x_adc_channels);
> +		indio_dev->channels =3D axp20x_adc_channels;
> +
> +		/* Enable the ADCs on IP */
> +		regmap_write(info->regmap, AXP20X_ADC_EN1, AXP20X_ADC_EN1_MASK);
> +
> +		/* Enable GPIO0/1 and internal temperature ADCs */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> +				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> +
> +		/* Configure ADCs rate */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> +				   AXP20X_ADC_RATE_MASK, AXP20X_ADC_RATE_50HZ);
> +		break;
> +
> +	case AXP221_ID:
> +		indio_dev->info =3D &axp22x_adc_iio_info;
> +		indio_dev->num_channels =3D ARRAY_SIZE(axp22x_adc_channels);
> +		indio_dev->channels =3D axp22x_adc_channels;
> +
> +		/* Enable the ADCs on IP */
> +		regmap_write(info->regmap, AXP20X_ADC_EN1, AXP22X_ADC_EN1_MASK);
> +
> +		/* Configure ADCs rate */
> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> +				   AXP20X_ADC_RATE_MASK, AXP22X_ADC_RATE_200HZ);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}

I'm not a big fan of those IDs. It always ends up with a ever
increasing list of cases without any consolidation.

In this case, the only thing you need is a list of pointers and values
that can definitely be stored in a structure.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ubympmcbdleq2fod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYbnmdAAoJEBx+YmzsjxAgJ4kP/37Es0ZWIlM6Wh58mgOZYT6X
6CDKZ+/1efFLTVgyjd+XpAty2H4VL4bu7NJ/x4kLobQop/R5f78yqoywXz6/jnyH
qotuDSo/RVuPM0c01dXcr1p/TiBpa+ZWQ5u9Q15ux4jnVt0majNzQUE+zPArcICC
B85bo9HavOPUK+oAcyZiTUwjyMqUlfAlm2Lfr97nrZacgG96mgRNEMOt9E8AbnaZ
mjBGFpy84lx0N6sg29ZpzFnXmutkoCcMBQR+A7OhY0nF5zjqeDOw/URhI3y4e3tK
6H5tRkjWhvszUzhmRdrUMdCzrG5ipJWCI2mZBVRYBynDK+2K19NKhe1ovOUhZ20p
oj8qxuphtQANI8ppskH/a0ynONrvpYTboErgZ/AqjdkP3c+3WBb9VnrHE1iV7tyY
bBLpiBVEjvYAQlnQTCnVDp1kBfIypg3DDKH4H0OQx0OIpjSe6JdwBGeBJn750K8v
NBQwYQAiGXX/+6xMdKz7Y25fBKQg40jRAlnXyM22ZAbz+6ZXsSHejFgssfRruCUp
Mj2kllAAoW6xl+OTcykEeTt2A1evNIZxWO7bbL55FlXBMK32a4PL2kQXdv687Dot
oiIagvfbqdBwTgM8SquJ4xHXVV/Ln8FkWT8Zt0FWbWPrPGIr1KIl7XGiQr2TG8Zn
GJrHs1j5gJReCJh6mg+v
=YjoP
-----END PGP SIGNATURE-----

--ubympmcbdleq2fod--


--===============8988884107367946325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8988884107367946325==--
