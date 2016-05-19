From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Thu, 19 May 2016 17:51:28 +0200
Message-ID: <201605191751.28412@pali>
References: <573C9F45.5090109@ti.com> <201605191744.07228@pali> <573DE04D.9050101@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2166560.S94FGVzUhf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37683 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbcESPvc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 11:51:32 -0400
Received: by mail-wm0-f45.google.com with SMTP id a17so132855748wme.0
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 08:51:31 -0700 (PDT)
In-Reply-To: <573DE04D.9050101@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

--nextPart2166560.S94FGVzUhf
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 19 May 2016 17:48:29 Andrew F. Davis wrote:
> On 05/19/2016 10:44 AM, Pali Roh=C3=A1r wrote:
> > On Thursday 19 May 2016 17:38:14 Andrew F. Davis wrote:
> >> P.S. The code is still a bit strange, I'll probably go grab one of
> >> the N900s from our test farm and make sure my future cleanups
> >> don't break this, but are we sure the *name* of a driver is an
> >> ABI?
> >=20
> > It is not name of driver, but directory name of sysfs path where
> > device is exported...
>=20
> Which is named after the drivers name, so the same question remains.
> :/

No, it is not driver name, but device name. That is different.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2166560.S94FGVzUhf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlc94QAACgkQi/DJPQPkQ1KiKgCcD3Bl8njQCOASpaRiH/vp/eTy
z+YAn1ymJ51y8Vwz4kXb+rR121yhK/zX
=Upcw
-----END PGP SIGNATURE-----

--nextPart2166560.S94FGVzUhf--
