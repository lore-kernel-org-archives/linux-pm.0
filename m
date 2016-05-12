From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/4] dt: bindings: add thermal device driver for bcm2835
Date: Thu, 12 May 2016 16:03:23 -0700
Message-ID: <87wpmyangk.fsf@eliezer.anholt.net>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org> <1463063738-11506-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463063738-11506-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
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
> Add documentation for bcm2835 SOC thermal sensor.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  .../devicetree/bindings/thermal/bcm2835-thermal.txt      | 16 ++++++++++=
++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/bcm2835-the=
rmal.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/bcm2835-thermal.tx=
t b/Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt
> new file mode 100644
> index 0000000..607519a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt

There's a naming convention for the BCM DT bindings these days where you
basically name it after the compatible string, so this file should be
moved to "brcm,bcm2835-thermal.txt" (yes, even though it's inconsistent
with the rest of the files in the directory).

> @@ -0,0 +1,16 @@
> +Binding for Thermal Sensor driver for BCM2835 SoCs.
> +
> +Required parameters:
> +-------------------
> +
> +compatible : 	should be: "brcm,bcm2835-thermal"

Optional: change to 'should be: "brcm,bcm2835-thermal" or
"brcm,bcm2837-thermal"' (see next review for explanation).

I would also drop the space before the colons on the parameters, but as
long as the filename is changed this patch is:

Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

> +reg :		Address range of the thermal registers.
> +clocks : 	Phandle of the clock used by the thermal sensor.
> +
> +Example:
> +
> +thermal: thermal@0x7e212000 {
> +	compatible =3D "brcm,bcm2835-thermal";
> +	reg =3D <0x7e212000 0x8>;
> +	clocks =3D <&clocks BCM2835_CLOCK_TSENS>;
> +};
> --=20
> 2.1.4

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXNQu8AAoJELXWKTbR/J7o+PIP/ivtXhcqV1pSA5/MZzzD5kDu
2o5ZglQeUaR7Nfrf13fncAw6PXWq0cnXdYYwZQKKXeI+sBvvJUuPQ8G6y0zYvb+y
uxhDIuZl0tYWVli7/2ziaLlRghq4OFKVYdzE5fXAaecvfgGISIYtHbXEktzmWhsK
gNUdqWZgKfbHb1h6Pbk0T5jpc/93PCQ1pXonQ32LRcZfX2CWL9V/1pp8OS5P1Uj/
zB7b0Tth3FooGZ532JXtkQT3DHlC7FVSKBRrylGc4WDLnbacmBhxUzHZNUKMxH3s
0cUZiaGDfJBnFaWg+TxjJltsJXrMNGLLRbevW0JViwulwUnpzWVAfffTdKHdyBks
9fCgaGoHavS0W3Lhwvuy4o9oRlc5uSMd9zYyg845NqKQV0cAr8DZ5aihRoLaVXSj
kWgU5quwd4HuYctjDQUMPya1Oy/+JEwDcZPdDNNKRIFitAU7PzFDB8lpgw/L9JiJ
134jFcVOss61G/+cvEbq9aMMdq64vQnsgnYdtv/QqpnWAJL5Bj5MhtZNNIWVotwk
biQam1D2glnk1HCCZiWxU9m0V83R9oRoy5TiIvv65cUATdaY0YzWTvix/1kGiJjc
pcf4DbjXlHjy2an0FtQWp/CeQVLb7P8yYO+3pyAxI4wBAbnFEec0Oyj1eLJtdRRM
D5gf1g8s0xHXwOJVgK/W
=INxJ
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
