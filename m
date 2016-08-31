From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 08/11] power: act8945a_charger: Add max current
 property
Date: Wed, 31 Aug 2016 16:58:02 +0200
Message-ID: <20160831145802.hmbnddaaif6y522t@earth>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-9-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3aswb4shmajpbku"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472109599-21915-9-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--y3aswb4shmajpbku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2016 at 03:19:56PM +0800, Wenyou Yang wrote:
> Add the power supply's current max property,
> POWER_SUPPLY_PROP_CURRENT_MAX.

[...]
 =20
> -	chglev_pin =3D of_get_named_gpio_flags(np,
> -				"active-semi,chglev-gpios", 0, &flags);
> -
> -	if (gpio_is_valid(chglev_pin)) {
> -		gpio_set_value(chglev_pin,
> -			       ((flags =3D=3D OF_GPIO_ACTIVE_LOW) ? 0 : 1));
> +	charger->chglev_gpio =3D devm_gpiod_get(dev,
> +					      "active-semi,chglev", GPIOD_IN);
> +	if (PTR_ERR(charger->chglev_gpio) =3D=3D -EPROBE_DEFER) {
> +		dev_info(dev, "probe retry requested for gpio \"chglev\"\n");
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(charger->chglev_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"chglev\"\n");
> +		charger->chglev_gpio =3D NULL;

Please also use devm_gpiod_get_optional() here (see previous patch).

-- Sebastian

--y3aswb4shmajpbku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxvB6AAoJENju1/PIO/qaAEYQAIeKE6G8O7vUTIlrmcYtoW5k
VQs0ALkuS8Gl/Kyj/57ByTA5OiDIC3HeqKNIY+o2IGdx47H+yO9cZnlGQNdp1sd4
djk3bliSyN5ftllTorkQs9IOrtO4mPnoxcDfqV50IkapnTrGl5n0WYvLXygMhknC
H5JufHcwYE4JjDgI3gIstuB4bdaYJz6jQNB8hfsb5HEH0kfDJ7Mp4p2n4OGH6YHM
syFpvzaruBEHj8Ecd9puEkpcn+qXMJj2DiDkztBozyZwzCV/8bBl8b4oP7cE4PFj
tyjb/tqjdH+aVes39CY4crj6/r6HP80G4ZOwQcPiokQGscpA9TmKT6de4aygvr44
o7CLNvPX0q9kBvt6jzXGGHzsaA0bcLJYvPYUleDkn4mlPfS32exqBDEh+wlUSLjN
VsXYfC1RInlFq+w4Y+VYkms+FO6Ox7GuoFK/qSeBvkICnaMtkltMui7D6z/yrM9y
Fdrdw72QyqYKO9GdpxKMPmt7Ns9pK35RAe5yjnJwsqdjqzWTZP/5+6mnvcqFgsuP
CNggL2+9pWYmAz0bQ4aUbUG3z1dTPGWTD2whnbZjU3buBLHQoL13DJikbPuBaw2C
ntFAiZhm7lsoPJIEwfFqMFVpnFLVlatqrL3ebBlGF0lfYsBfi3+7kmCQT8EgjHav
AuqNvkUnf+Vctkov7SLe
=8Qj8
-----END PGP SIGNATURE-----

--y3aswb4shmajpbku--
