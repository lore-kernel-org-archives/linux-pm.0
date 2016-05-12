From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: bcm2835: add thermal node to device-tree of bcm283x
Date: Thu, 12 May 2016 16:24:34 -0700
Message-ID: <87posqamh9.fsf@eliezer.anholt.net>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org> <1463063738-11506-4-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463063738-11506-4-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Add the node for the thermal sensor of the bcm2835-soc
> to the device tree.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.d=
tsi
> index 9db9d97..525f1f2 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -159,6 +159,12 @@
>  			status =3D "disabled";
>  		};
>=20=20
> +		thermal: thermal@0x7e212000 {
> +			compatible =3D "brcm,bcm2835-thermal";
> +			reg =3D <0x7e212000 0x8>;
> +			clocks =3D <&clocks BCM2835_CLOCK_TSENS>;
> +		};
> +

You could drop the "thermal: " here since nothing refers to it.  Either
way,

Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXNRCyAAoJELXWKTbR/J7o4VIQAIqZ9eE6PPyqUZjeV26/z6tl
D25K4de5K81Jv1sd9QCY/ElIvWGJUeIyuUnZ125jGGaIwdrUi4K0ejeZ7CM54ZB6
KWHp22a4udLJ0N5lD0JVR1B5p5mYpFCENxET2PUZBQWU8IMtNzX00l8ZO2ewleL2
snXMfPbh4pIXEKXaA7G1MVy3wlEtYeJmczhTCyToDMlwQQt92eKiMGxSjSfsbww0
VITLhChfXNA2T4ZolCi4zlhRDNCSsvICFx90D7h8riX18721i7XVOOMjDzI9MKWF
48EZDiGf8/DMcOfDtCk3yyfcrxVVT96mGSvu9V3liIiVNq0Xa/9DHeErwyOPi8vI
LvGldBnxOSi8jUByxrkLntWDFXvvgAyHHD72bdg7hw/A59X4sJCTy2F/kTzeRre5
tTEE6mepfwIAmq8YODM4JnLTr1wzcCsdRp4075Ys7HmOC70tmYYtt0Sk9ZpXGDjG
Sryb0IyuijoVyolB5hq+y6c12kcTRt4kmBif5N6zIgXzbFBFUZmfZD1TT854fU9k
lpCrgmD1oaMA4uDH2HW66qoQV6ZvxF4LAicA7OemI6W1RitGuRpdnqpdnyMvafM0
0xkrjHojfRw9XAIH45YdYN+T+AtWnSI4IaCTt38vP15PTqpWyK28M9etbODGogTs
3HL1TC4LESVdJMqF91Lv
=DwAg
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
