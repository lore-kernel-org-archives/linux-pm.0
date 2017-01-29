From: Sebastian Reichel <sre@kernel.org>
Subject: Re: syscon-poweroff: add a mask property
Date: Sun, 29 Jan 2017 19:50:12 +0100
Message-ID: <20170129185012.ltzc5ocw42dz7buq@earth>
References: <71309f45-0f6c-a7af-eb01-59400f0c93a1@mobi-wize.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sbgrd7k75vigoa5x"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751215AbdA2SuW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Jan 2017 13:50:22 -0500
Content-Disposition: inline
In-Reply-To: <71309f45-0f6c-a7af-eb01-59400f0c93a1@mobi-wize.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>


--sbgrd7k75vigoa5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 29, 2017 at 02:04:00PM +0200, Guy Shapiro wrote:
> The syscon-poweroff driver powers off the machine by writing a value to
> a register. Both the register and the value are configured via the
> device tree.
>=20
> I encountered a situation where I need to mask the written value - some
> values of the register must remain unchanged during the power-down.
> (This is required to turn on the i.mx6ul using the RTC. See [1] for more
> details.)
>=20
> Unfortunately, the property of the register value is currently named
> mask, so we can't just add a "mask" property.
>=20
> The solutions I could think of:
> 1) Add a new mask property and name it "mask_mask" or something like
> that.
> 2) Create a new "syscon-masked-poweroff" driver that will have value and
> mask properties.
>=20
> What do you think?

I suggest the we add a value property to the binding [0]
and use the following logic in the driver to keep
compatibility with the old binding:

if (!value) {
    /* support for old binding */
    val =3D mask;
    mask =3D 0xFFFFFFFF;
} else if (!mask) {
    /* support for just providing value */
    mask =3D 0xFFFFFFFF;
    val =3D value;
}

regmap_update_bits(map, offset, mask, val);

[0] Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt

-- Sebastian

--sbgrd7k75vigoa5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOOWEACgkQ2O7X88g7
+ppv6A/+MWubyajo5hYpQJnAvXv0GsJaY6KZFMbxOjDUxtaF3uwMRCXeBloNxEeT
iCUKdd/8IxsvgFAedzXC9aNiRe1FNkzrjZuVa3ALcx/sUZ+cetNGl5TKxfaiiUMk
wdb9inF7fRHo8HV+SLAow/qfrO46MCcuLj1MZ63b6WEUpkvwZj9f0oTwYfvWA8QZ
m/gzm6mLJnX9/+G221qo4ee4lNkvi8EHBAT9bOH7B1yVgbHTIT76+NNGMZQ7OFjT
ix4JutlwUle8ArGVqqDBJuWpRA6lWjGjfFbjEa7LFPBkz01aW+gOvIgcfJ2VDqWc
0Ta6SpN2fC/FmcqZvo1nzEwGdPxnATetgu14+eDTYwVAHzZPG8WmGNX9iF+Ak6kc
8uMR/txCkQPfkl8IDV2NJEdpSKdUS751myDOdEFga6kVGtTT0E66kDqtOPbHMrXt
8YjuexdndV8EwGR4PQDktSE53KUTF8yqDdTS9Bf/hNW+KTX7MwtfRGsj6ifwV4UK
I9hEvyeW4+cv5EFV5R0vLFq1HX5xx6mpOnBJc431ojJvpcH+RDG7ewYGQKOJR94g
4lSTVZTxt17STeoRcei6D/Bnc/J5ri+Y/yij/UztEyI8+6MxOyc+Kpcmqxgng1DC
nqwG0WhoOhSTjzCbEn/i2DDvF9MNJkbwhZpCSTvsqAaIQAVBarw=
=mBHd
-----END PGP SIGNATURE-----

--sbgrd7k75vigoa5x--
