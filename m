From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Thu, 19 May 2016 18:06:50 +0200
Message-ID: <201605191806.50809@pali>
References: <573C9F45.5090109@ti.com> <201605191751.28412@pali> <573DE26E.2040403@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1946392.GON8ngfT0A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33322 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbcESQGx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 12:06:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so22229314wme.0
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 09:06:53 -0700 (PDT)
In-Reply-To: <573DE26E.2040403@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

--nextPart1946392.GON8ngfT0A
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 19 May 2016 17:57:34 Andrew F. Davis wrote:
> On 05/19/2016 10:51 AM, Pali Roh=C3=A1r wrote:
> > On Thursday 19 May 2016 17:48:29 Andrew F. Davis wrote:
> >> On 05/19/2016 10:44 AM, Pali Roh=C3=A1r wrote:
> >>> On Thursday 19 May 2016 17:38:14 Andrew F. Davis wrote:
> >>>> P.S. The code is still a bit strange, I'll probably go grab one
> >>>> of the N900s from our test farm and make sure my future
> >>>> cleanups don't break this, but are we sure the *name* of a
> >>>> driver is an ABI?
> >>>=20
> >>> It is not name of driver, but directory name of sysfs path where
> >>> device is exported...
> >>=20
> >> Which is named after the drivers name, so the same question
> >> remains.
> >>=20
> >> :/
> >=20
> > No, it is not driver name, but device name. That is different.
>=20
> My bad, that's what I meant, device names should be dynamic, right?
> Relying on them being static in software would then be buggy (like
> relying on eth0 being the right NIC everytime)?
>=20
> I'm not familiar with the N900 software, but IDR can give out
> different numbers and may not always give the first battery #0 (it
> does now but is that a guarantee in IDR?) and if not then what is
> the userspace response to this changing?

In case N900 would have more bq27xxx batteries, then yes. But N900 has=20
exactly *one* bq27200 battery, so there is no IDR problem.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1946392.GON8ngfT0A
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlc95JoACgkQi/DJPQPkQ1L1RgCghFhU8Pu9bZFemhvoqukXDHX4
MAYAoMPZQB8ik4CLXgZvE103KAogrSgI
=4rUR
-----END PGP SIGNATURE-----

--nextPart1946392.GON8ngfT0A--
