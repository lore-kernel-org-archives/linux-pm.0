From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 01/13] thermal: Make temperatures consistently unsigned
 long
Date: Mon, 6 Apr 2015 18:47:08 -0700
Message-ID: <20150407014707.GB4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
 <9hhzj6y217d.fsf@e105922-lin.cambridge.arm.com>
 <20150327190750.GZ9742@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36681 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbbDGBrA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 21:47:00 -0400
Content-Disposition: inline
In-Reply-To: <20150327190750.GZ9742@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 08:07:50PM +0100, Sascha Hauer wrote:
> On Fri, Mar 27, 2015 at 10:18:14AM +0000, Punit Agrawal wrote:
> > Hi Sascha,
> >=20
> > Sascha Hauer <s.hauer@pengutronix.de> writes:
> >=20
> > > The thermal framework uses int, long and unsigned long for temperatur=
es
> > > in millicelsius. The majority of functions uses unsigned long, so cha=
nge
> > > the remaining functions to use this type aswell.
> > >
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > I'd suggest changing to long instead. It would allow the use of the
> > thermal framework in environments where temperatures are below 0C -
> > quite easily reached in many parts of the world.
>=20
> I agree to use a signed type. I also found it not so nice that the thermal
> core does not support negative temperatures. I only chose unsigned long
> because the patch got smallest that way, but I already expected this
> answer ;)
> We could also use int instead of long. INT_MAX =B0mC is still enough for =
using
> a computer on the surface of the sun (Not for the center though)

Agreed, int is the preferred type.


>=20
> Sascha
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVIzcUAAoJEMLUO4d9pOJWgV8H/29YNF8sYriHa8/Cst4MOIUr
RBgDYvRvOAcfuxBudmpE8XmzEneCYTTnT1zu9BQOfuAIgu3gbAn39MDl9U6iO9JB
1t1qW9VZB8KBjQAYzByNDHvCtvGg2zt7VjPsuJDRlbq0sLy2e/DXCG+rGjkchysj
tyM7MWU291JF2uaiKob4RfWA3xzN/OWINWSGEws26nZFrYglFp5Aqi7XOst7NXs5
x0d9RGc2U90fzRPVS6WdD3sRAt1PJOD6MJh05Gjrxq/KOREovIpu8XMB3vZpPt6F
/ar7y1JIEi1fWm9Pn1Hdi+T5NfIy5mxefKzaUJbVL3hXSFAnjbEQATksRYwYv3M=
=6tEx
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
