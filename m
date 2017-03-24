From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
Date: Fri, 24 Mar 2017 12:52:12 +0000
Message-ID: <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xw5b3dbne2bvd47"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--2xw5b3dbne2bvd47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 06:53:06PM +0200, Leonard Crestez wrote:

> Enabling bypass mode makes a regulator passthrough the supply voltage
> directly. It is possible that the supply voltage is set high enough that
> it violates machine constraints so let's check for that.
>=20
> The supply voltage might be higher because of min_dropout_uV or maybe
> there is just an unrelated consumer who requested a higher voltage.

I would expect that if bypass is enabled then the constraints on the
parent regulator would be set appropriately to support this, I wouldn't
expect that we'd try to apply the operating constraints of the regulator
to the supply.  Usually bypass is used for low power retention modes
with different settings to those used in normal operation that wouldn't
be desired in normal operation, if we were going to have constraints for
this I'd expect a separate set used during bypass.

--2xw5b3dbne2bvd47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljVFnsACgkQJNaLcl1U
h9DeZwf/dU2bLpbeGSjhPK9LjpacPW1+ydcLXWbZdlB2SjSVqAqJMO9F9rOKiuUj
/9efOpcJwJZ97fmVy1wU3VgX0/lpUqCVoj0BnNtKeBpHjFYZDrXVvsw3Bn2An4aX
AO34GBhFg8gFK/LXKNin4iEgaUOv4aC/Wzv0Y4FYc55Oc1uqs/uibM+6v+eKYbHq
31kJMdhenABpGyZIYpj/QJl3qUiO5zvQ98dDAPBvIPmRGUvwSCgk24MJn92D1ye4
Jks94c6ePWgpj8s0v39jU4yw/N6VeKkJd2k7UQdnl4dJtAovoB/Fo6QOdpEwvY72
z0CGlVcpBPi8Q5rEChOg/I39A2niRQ==
=DVC4
-----END PGP SIGNATURE-----

--2xw5b3dbne2bvd47--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
