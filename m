From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/3] regmap: Add 1-Wire bus support
Date: Thu, 8 Jun 2017 15:13:41 +0200
Message-ID: <20170608131341.izvoelvrg37ktrie@earth>
References: <20170602070629.8210-1-minimumlaw@rambler.ru>
 <20170602070629.8210-2-minimumlaw@rambler.ru>
 <20170608125350.6glgyrlydqmtshru@earth>
 <20170608125704.rq2mushzmvsjemmv@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ifdx4s4sool54nv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50197 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdFHNNt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 09:13:49 -0400
Content-Disposition: inline
In-Reply-To: <20170608125704.rq2mushzmvsjemmv@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--6ifdx4s4sool54nv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 08, 2017 at 01:57:04PM +0100, Mark Brown wrote:
> On Thu, Jun 08, 2017 at 02:53:50PM +0200, Sebastian Reichel wrote:
> > On Fri, Jun 02, 2017 at 10:06:27AM +0300, Alex A. Mihaylov wrote:
> > > Add basic support regmap (register map access) API for 1-Wire bus
>=20
> > > +#include <linux/module.h>
> > > +#include "../../w1/w1.h"
>=20
> > This conflicts with the following patch:
>=20
> > https://www.spinics.net/lists/kernel/msg2524566.html
>=20
> Not in -next yet?

I think Greg did not yet apply it. It already has been
Acked by w1 maintainer, though. This was just a heads
up for upcoming trouble :)

> > I guess Greg could pull your immutable branch and above
> > patch can be augumented to also update regmap-w1.
>=20
> Yes, or I can pull in a tag and apply an integration fix if needed.

Sure.

-- Sebastian

--6ifdx4s4sool54nv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5TX4ACgkQ2O7X88g7
+poSzg//T+ElHzYw4hMWFQAil44q0W56eMX/MPdNq6oJKVG4XrbHZO9ys4gvbOy7
DTzk9ZimAQgrN4n2NzhxHYAFPHrIKfKOnTtsRqNk9zlqf9w1cc1b5euvpRUSk+TO
dV452PXxjmLe4f3kCATI+aalU08dqVAWjlVKAsQPGydDAxhlQQMxWW9bjlqyjjla
Y7ldIkI1HAxyYAx/7IbE4mgI2EANIQE9z+/GFNnxGwn/f1Trmf/T51AgAWuCVQ6z
TYKVSJI17U+bSbpjpr9tnhhPzaiWnLPzB/6pArQsLv4nXtQs2YEfiKD2+Q5TSoEk
HvW2v5TTo/fbaCGMfm5b007F57AYozYy6CaxWmHISdNEBd9pBWK7LFhk8jdUXwJJ
+xXi9EI8yp4OTzBy0IMJswEb+zm1imhjhctVzspf2K13jSeUHW/ME3Lj/xPZk2em
mKoNWGZgT8/FPqP9tNcUg28UmvFy3LWL/n/trZI7FQXFGIFIDBKdociod4US9qHn
G1LsPHr6NjSJXT/Lq1A/ItfP746xX38uh0VuJA62iEnLxih8VpC8h+y6ntRkKZZO
2Mxzzh5GPA7GpGHV1GTzB6G2wlK5W8WmOdAk1Q2o6LtINuyMiXKTPIhtFPMmx5UH
H1BAvsrmEq4EZkkps3AYkwyEqpmax9Fg0p/v12g8o3KiMSTkJKM=
=xCLZ
-----END PGP SIGNATURE-----

--6ifdx4s4sool54nv--
