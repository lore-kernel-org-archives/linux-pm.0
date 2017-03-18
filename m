From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: add support for Raspberry Pi thermal
Date: Fri, 17 Mar 2017 17:09:04 -0700
Message-ID: <871stvjvj3.fsf@eliezer.anholt.net>
References: <20170318000132.9212-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170318000132.9212-1-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
>
> This commit documents binding for BCM2835 SoC thermal used in Raspberry
> Pi devices.

There's already a native (non-firmware) thermal driver just waiting for
the maintainer to merge it.

https://www.spinics.net/lists/arm-kernel/msg566217.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljMeqEACgkQtdYpNtH8
nui00xAAq7cw1fdsx1mOWNHairIen7q/6v9S0l42RtdVPpSKl4W3A0Re8qEak3H6
RXSq5FRMH8ODX4p0voBRUmHsPs95SSb+/HS1EfYwsDVo/bf0cWQPGGOr582GxFI/
im3gROviZopRs/EAkH5HQm/9ASXXdQQZjrBNn0V7qgFSJGzfQKrRbjT04NzyS9O/
zTHVSp5kM6bexCU2+Mmh1BHOhF1kevV/9yb8i7jznG5BSdx0614XCn8DviBnqfmr
vhbB2biUHiA3kgupcq130X2y3d2ftVVQ1H5ppx2n2XyLvjZ/grrnONM8VxEtMd1J
wKi6RvUSWAN9eldJaA1lizJiwFgXCfQE2thCSfvxIkWAM+Bs6dsYLJaMLAaV4ig2
MbF86AYvQGGKvNq2uUsLD0E7/9Sn2eJJAvav/OFWfsb9jqw3e7CHmSdIgVAYfKa8
eryaDwARFTE7Pz4CLBkmI5GaPaBKGVVVyp4/8NS5ymgzBFnh+juxi3e4GbwHyGfN
XiWWNkVurUAUTXCpNxfocbKP7HJ4AFsOOVqKn+IMjRLnDRS2ltMszh+4ngMeSPk0
n9eSrUqEF8cYPUOXXza6XMjRnoa2lqaXQB95PzAJPI6LaTGv9vSQe9kqRB9SlZ/m
jJak8TQ/PepvjPlcalp8mQfN9+JkjL+6LNT2l7rUDvbGsvVPiIg=
=5YYF
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
