From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power_suply: isp1704_charger: Fix isp1704_write() definition
Date: Sat, 9 Jan 2016 23:42:30 +0100
Message-ID: <201601092342.30608@pali>
References: <1451646209-11618-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <201601011226.21552@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2799918.nU0oy9oeiC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38396 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756381AbcAIWmd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Jan 2016 17:42:33 -0500
In-Reply-To: <201601011226.21552@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, sre@kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

--nextPart2799918.nU0oy9oeiC
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 01 January 2016 12:26:21 Pali Roh=C3=A1r wrote:
> On Friday 01 January 2016 12:03:29 Ivaylo Dimitrov wrote:
> > All calls to isp1704_write() are using parameter sequence of
> > isp1704_write(isp, reg, val) but the function is defined as
> > isp1704_write(isp, val, reg). Fix isp1704_write function definition
> > so that the driver to be functional.
> >=20
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>=20
> Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> This problem is there since inclusion of driver itself. No idea why
> that driver could work... I remember that it detected correctly type
> of charger.
>=20
> I will test this patch on real N900 HW in one or two weeks to check
> how it behave after patching...

Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Please send this patch to all stable kernels.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2799918.nU0oy9oeiC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaRjNYACgkQi/DJPQPkQ1KUGgCffivennTm0S6AbmP50eC3+6r1
9p4An01nthi6DXIlMDDG2VkDKVn78lmC
=jeu/
-----END PGP SIGNATURE-----

--nextPart2799918.nU0oy9oeiC--
