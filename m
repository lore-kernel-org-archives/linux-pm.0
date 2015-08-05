From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: power_allocator: do not use devm* interfaces
Date: Wed, 5 Aug 2015 11:44:06 -0700
Message-ID: <20150805184405.GB4161@localhost.localdomain>
References: <20150804163340.GA33245@dtor-ws>
 <20150805082910.GB2688@e104805>
 <20150805165020.GB3603@dtor-ws>
 <20150805172902.GE2688@e104805>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33551 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbHESoL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 14:44:11 -0400
Content-Disposition: inline
In-Reply-To: <20150805172902.GE2688@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Lukasz Majewski <l.majewski@samsung.com>, Peter Feuerer <peter@piie.net>, Sascha Hauer <s.hauer@pengutronix.de>, Punit Agrawal <Punit.Agrawal@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 06:29:03PM +0100, Javi Merino wrote:
> On Wed, Aug 05, 2015 at 05:50:20PM +0100, Dmitry Torokhov wrote:
> > On Wed, Aug 05, 2015 at 09:29:11AM +0100, Javi Merino wrote:
> > > On Tue, Aug 04, 2015 at 05:33:40PM +0100, Dmitry Torokhov wrote:
> > > > The code in question is called outside of standard driver
> > > > probe()/remove() callbacks and thus will not benefit from use of de=
vm*
> > > > infrastructure.
> > > >=20
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >=20
> > > We added the devm* calls because Eduardo asked for them in the review.
> > > I don't have a strong opinion regarding this, I'll leave the decision
> > > to Eduardo.
> >=20
> > I tried to look for his reasons, if any, but even in earliest posted
> > versions use devm* for allocating memory
>=20
> http://thread.gmane.org/gmane.linux.power-management.general/45000/focus=
=3D45265
> http://thread.gmane.org/gmane.linux.power-management.general/46064/focus=
=3D1722858
>=20
> He didn't give reasons and I didn't ask for them.  He insisted on it so I=
 just added
> it across the board.

Yeah, that's my bad.

I believe I had in mind getting the thermal core in a better shape by
having proper driver/device matching. But still, looking at the code
now, I must agree with Dmitry. As of now, it does not make sense.


BR,

Eduardo

>=20
> Cheers,
> Javi

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVwllxAAoJEMLUO4d9pOJWZisH/3npDTIrLOnUfyM7MLoWB0MA
vwXt6JJ2KjOQYOWeiWmjYXRxB1dViVJmr9ZOJNTaU5npa4/bnwow5gSmnk6YxmRv
w5TT8oyuZOVpgWWnoqEm+G+YljRm82MoPA3fxCERnHhs7JZTAyIXJyAimkGJWQFy
t1ymxqDIc2MxV8tF11ssX+DxOsin5T+WTJMXU230vnTAnG4HI3f3PyMa0dn/pZBX
luNg8BWe/wdyX5npqCuOCEBW1/UTg2Pw7vkgb2rMXzst5+9evwmPjPjVQ3tWP8lC
S/sWtM2S9S/bqAzvSJlx0BB/zwiqlWe98Uvx3A0W/Uo4vJR9TGyRSqtT8vCVyC8=
=AdLz
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
