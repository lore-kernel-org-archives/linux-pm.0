From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH v3] dt-bindings: power: supply: bq24735: reverse the
 polarity of ac-detect
Date: Tue, 24 Jan 2017 17:24:33 +0100
Message-ID: <1485275073.1087.10.camel@paulk.fr>
References: <1481804479-8711-1-git-send-email-peda@axentia.se>
         <5f5fe01a-7c7a-58f7-2171-5f6879392ea7@wwwdotorg.org>
         <c3e87e2b-5d0d-c1ff-8edf-f4a77de31c1e@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SOOvVsKFPpcG8l9bj3W2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c3e87e2b-5d0d-c1ff-8edf-f4a77de31c1e-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--=-SOOvVsKFPpcG8l9bj3W2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 15 d=C3=A9cembre 2016 =C3=A0 18:50 +0100, Peter Rosin a =C3=A9crit=
=C2=A0:
> The bindings are fine.
>=20
> The Tegra dts files are buggy, but the driver is also buggy, so those
> two bugs cancel each other. So, the option is to either introduce
> regressions by fixing the two bugs thus creating a flag day where
> the kernel and dt needs to match. Or, just document what is going on
> and change the bindings even if they are not wrong.

After reading the discussion, I would rather be in favor of fixing the driv=
er
and the tegra dts files, which are both wrong.

Keeping things as-is is very counter-intuitive: the GPIO on nyan boards is
active-low and should be described as such (think of other projects, like
U-Boot, reusing the dts). It's also very counter-intuitive to require that =
any
new board using that driver use active-low polarity in the GPIO declaration=
 when
the line is really active-high.

So yes, it means that older dtbs won't work with new kernels and vice-versa=
, but
as it was pointed out, this is a bug fix, not even a cosmetic change.

Is anyone strongly opposed to that solution? I'd really rather see the issu=
e
fixed that way instead of the current proposal (this patch).

I'd also be happy to implement and test that solution on nyans, as I've don=
e
other bq24735-related work for nyans recently.

--=20
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-SOOvVsKFPpcG8l9bj3W2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAliHf8EACgkQhP3B6o/u
lQyCDA//UBvAuI549m8idre3GKwAZPy/v69yUZ3QOblQvwl0SHJT2ZVXfyuepsqO
njqUHT8xk8bdKsYdFJiHc9o8tJXopcDOmU+dGT4W1/fq8nygJen1xksdiBCr5Qra
XXJSyGmjG0B+BweuL9EBiLUb24t4UapbLDqSMrXMVrWp5+63Y6Ojdy/9nIlHuhQa
9OsFVLa7lk4l4pnIB0ON1VjJn9Q+0JuBWWSZyLa9gte2Pw/46qzmg2DUJDXIuMjY
KULF+FLBtNBdMfGuGhIduDd/wALvQ46yref/w7e2kW6SESogYemH1H56KpgEJioc
rtKAdVtyaZ4+zV0jTISiB6vwLgcVtvxyK7/owe5zuKwHl8enFFFw6RYt5Ug9plRi
jS7s8yfkwfbNkuiuKmNtR1M4R4x9j6+JrWNjWywZeK0i/Y/UPzkkUfZFfOL0bsxa
5tZL6bVap8TBDNYXDzGRj57R2E6lUjqea1bWC3ZpVqXpjw9kx7PTxSyBNr7sFPPd
K4HE2yThnTjSNv4axwJzNqOkSae1L6RhQUZO5v6gGesLBpkeAa+kHgoo+xdEUkI5
2eCcDWvwyBLUQjjhqUaC2a5WdYBiU1BSR85KaE8deHhzguCp54j+gallSNLwgliz
TpAFWPFoJvFjw0TIbtoDdI4Mv//u4/KT3RFeDN9K2yg6dD1GxHU=
=qUTE
-----END PGP SIGNATURE-----

--=-SOOvVsKFPpcG8l9bj3W2--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
