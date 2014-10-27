From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 02/10] dt-bindings: Document the standard property
 "system-power-controller"
Date: Mon, 27 Oct 2014 17:26:36 +0000
Message-ID: <20141027172636.GZ18557@sirena.org.uk>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-2-git-send-email-romain.perier@gmail.com>
 <20141027163918.GB14253@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YPOU9eFKIy6Wf5kE"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141027163918.GB14253@saruman>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--YPOU9eFKIy6Wf5kE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 27, 2014 at 11:39:18AM -0500, Felipe Balbi wrote:
> On Mon, Oct 27, 2014 at 04:26:47PM +0000, Romain Perier wrote:

> > +act8846: act8846@5 {
> > +	 compatible = "active-semi,act8846";
> > +	 status = "okay";
> > +	 system-power-controller;
> > +}

> there is no mention here that system-power-controller superseeds
> poweroff-source and deprecates that.

Given that poweroff-source hasn't made it into a released kernel yet we
can probably just kill it off completely can't we?

--YPOU9eFKIy6Wf5kE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUToBLAAoJECTWi3JdVIfQ5DYH/RI8OXmYY0W2YOW2mndiN6ux
eH0/FrQVFLEGTn4UP9EWVSBYIPVpoKFAzWmUfWqW31J0LgzsSyy2k9CRq6sD6MXS
PlqwsgVN8rNn1GBvp18w9PFJM2lDtpIPYWQLttWAJlCDmc5KXdGSuBn1p4Rutnzy
i71n4qKADI3IkDy/k6fnkyJXyTvwct61NBsfQiKImUpstqy0j4oP4qKT+c/8Mh5z
RpsWbuN+3YC/uOm11rTjGcmBGcG564BfOOueiJN+HnkE9PKB9opi/t40rQXy0s0O
FBf3dVZEkH3bqmuy0rj+b4ETBLX2SgOp/KIEZAKgh5gVploewmAGBE3yMZt9FSs=
=Gk4X
-----END PGP SIGNATURE-----

--YPOU9eFKIy6Wf5kE--
