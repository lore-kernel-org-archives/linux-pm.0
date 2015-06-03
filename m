From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] sbs-battery: add option to always register battery
Date: Thu, 4 Jun 2015 00:50:41 +0200
Message-ID: <20150603225041.GA15243@earth>
References: <1433250883-32245-1-git-send-email-frans.klaver@xsens.com>
 <20150603135750.GB18181@earth>
 <20150603141035.GO9880@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60821 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbbFCWvK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Jun 2015 18:51:10 -0400
Content-Disposition: inline
In-Reply-To: <20150603141035.GO9880@ci00147.xsens-tech.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 03, 2015 at 04:10:35PM +0200, Frans Klaver wrote:
> > While I still think, that the HW design is bad,
>=20
> I'm still interested in learning how we could improve the HW design in
> your opinion. Would you say we should be using a non-removable battery?

No I would say the battery should be able to identifiy itself. So if
the device is not connected, there is no battery device and when you
connect it the battery is registered. This could be done for example
using Device Tree overlays. iirc something like that is planned for
beagle bone capes.

> > I'm basically fine
> > with this change based upon your comments. I think it's better to
> > make this into a module parameter, though, since that moves the
> > decision about this feature from compilation time to module load
> > time. This will make it possible to use a generic kernel on your
> > device. Maybe something like this could be used:
> >=20
> > module_param(force_load, bool, 0444);
> > MODULE_PARM_DESC(force_load,
> > 		 "Attempts to load the driver even if the "
> > 		 "battery is not connected");
>=20
> That makes sense. We can work with that.

-- Sebastian

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVb4S+AAoJENju1/PIO/qaRakP/2QPJVDvdCuag3wUzLvliSfM
CidayvdSCXCRPMEUYJIPII1VioRUQYLjwvCA76IiIxEHXq9U2kyMdDfqh2TOzcWr
TOS+Yul2td78yViJAuMmec68Rsy9u4veoRfCeuL9JBeP9yDHBoq9Hj4wF9IMPL94
TUOm1MKts96ou67FNAPH9P+71RH6vCqziw69kKYNbyM2MwlavPoCOWyFCyVcLI8E
pSwE5T+hWeiJVwX1RDPNSYgdxs7syUGfOynZeWl7s56z/ZbTrtbKZPerk5ipknaH
c3I5zhvOYK8stBOgi1Vg7kmu6B+J5NBpDatjSPCX6dKi8Pi2zMVsFc/BNUyTsR6V
oVC8m9h7NoBwFUAqkTGNwq8q8WH00OO6Skog+ItanvdD6tin6UR50amA7e3SY+8T
uO1SJuRuVOYaG08k9p6EkwyJBwUpSEIJxwuBVK7gZiKxSZkYax3iJOXGHc+LW8+X
NMLG52ZypzEgxBsDTmZAyS543r4FXNU0pHaNhdivxtnwN+Ott9zYNbKYPIwcCClA
wJx+F/tQiy5vQhkg0hGUpq5NmaD6VVLbp6/hccXjodo2r6sjAW1CSafpbCu76z1F
1qKqXtAgKsL+KMBBcd40YufSzODHV9xTz4QreARyr97Mle/Y0oEQZnaVQIAy3pKE
hc+XnDmFyGLBLHRnkkan
=feIm
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
