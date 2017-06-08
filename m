From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] regmap: Add 1-Wire bus support
Date: Thu, 8 Jun 2017 13:57:04 +0100
Message-ID: <20170608125704.rq2mushzmvsjemmv@sirena.org.uk>
References: <20170602070629.8210-1-minimumlaw@rambler.ru>
 <20170602070629.8210-2-minimumlaw@rambler.ru>
 <20170608125350.6glgyrlydqmtshru@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h4hmmz5l2z34dhif"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55904 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdFHM5W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 08:57:22 -0400
Content-Disposition: inline
In-Reply-To: <20170608125350.6glgyrlydqmtshru@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--h4hmmz5l2z34dhif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2017 at 02:53:50PM +0200, Sebastian Reichel wrote:
> On Fri, Jun 02, 2017 at 10:06:27AM +0300, Alex A. Mihaylov wrote:
> > Add basic support regmap (register map access) API for 1-Wire bus

> > +#include <linux/module.h>
> > +#include "../../w1/w1.h"

> This conflicts with the following patch:

> https://www.spinics.net/lists/kernel/msg2524566.html

Not in -next yet?

> I guess Greg could pull your immutable branch and above
> patch can be augumented to also update regmap-w1.

Yes, or I can pull in a tag and apply an integration fix if needed.

--h4hmmz5l2z34dhif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk5SZ8ACgkQJNaLcl1U
h9DNRwf/cimqGqkRq8gnZO1Bez2mZCKIpEZMIP9bklYw8F59o1sJVmNvUTZm/+aN
/39IO4LCjKYaNFPKepXHIvTlFqn7KDjk/k48bmLSy9QqDBSS6bWNbZdcI06lPtBp
SaO4JIcKG8N0h4ZRqzGmpYpzw6OyECzwqF2mgbuCGNJ0fdpzWbew+/odpFaWn/0v
v/lbkETQP4go+ZPBEyvmRLAljb1m7iCb1S8/BR7iNmZ1CChDxakPugJfUtkFoPgd
os/Ct+MrUSEpuHng6COeruj+kN8K+jNzit2K+vepCp+GCHO2+/Q6DjSwLMKKOUgQ
wyDmMhbjvYpi9+NixmROUHHu0vZW9w==
=xI08
-----END PGP SIGNATURE-----

--h4hmmz5l2z34dhif--
