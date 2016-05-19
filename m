From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Thu, 19 May 2016 17:44:07 +0200
Message-ID: <201605191744.07228@pali>
References: <573C9F45.5090109@ti.com> <20160519091719.GL29844@pali> <573DDDE6.7070408@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5839116.WSLPxctESh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38148 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994AbcESPoL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 11:44:11 -0400
Received: by mail-wm0-f52.google.com with SMTP id n129so42106739wmn.1
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 08:44:10 -0700 (PDT)
In-Reply-To: <573DDDE6.7070408@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

--nextPart5839116.WSLPxctESh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 19 May 2016 17:38:14 Andrew F. Davis wrote:
> P.S. The code is still a bit strange, I'll probably go grab one of
> the N900s from our test farm and make sure my future cleanups don't
> break this, but are we sure the *name* of a driver is an ABI?

It is not name of driver, but directory name of sysfs path where device=20
is exported...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5839116.WSLPxctESh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlc930cACgkQi/DJPQPkQ1JRKACdE4DuT8Gjz5zNfxWdXNyLcl7O
mZIAoKYysplxNPs7f+ByckRKQVEDyeSV
=c5Zv
-----END PGP SIGNATURE-----

--nextPart5839116.WSLPxctESh--
