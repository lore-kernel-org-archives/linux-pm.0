From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power_suply: isp1704_charger: Fix isp1704_write() definition
Date: Sat, 2 Jan 2016 16:48:05 +0100
Message-ID: <201601021648.06931@pali>
References: <1451646209-11618-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <201601011226.21552@pali> <568663EF.9070502@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart362944302.hndijH6itr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38867 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbcABPsK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2016 10:48:10 -0500
In-Reply-To: <568663EF.9070502@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machel <pavel@ucw.cz>

--nextPart362944302.hndijH6itr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 01 January 2016 12:33:03 Ivaylo Dimitrov wrote:
> Hi Pali,
>=20
> On  1.01.2016 13:26, Pali Roh=C3=A1r wrote:
> > On Friday 01 January 2016 12:03:29 Ivaylo Dimitrov wrote:
> >> All calls to isp1704_write() are using parameter sequence of
> >> isp1704_write(isp, reg, val) but the function is defined as
> >> isp1704_write(isp, val, reg). Fix isp1704_write function
> >> definition so that the driver to be functional.
> >>=20
> >> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> >=20
> > Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> >=20
> > This problem is there since inclusion of driver itself. No idea why
> > that driver could work... I remember that it detected correctly
> > type of charger.
> >=20
> > I will test this patch on real N900 HW in one or two weeks to check
> > how it behave after patching...
>=20
> Well, I  tested in on real HW, wall charger as well as USB were
> correctly detected. No idea what else needs to be tested, but I guess
> if you guide me, I can test whatever is needed.
>=20
> Ivo

I think nothing more is needed to test. But I want to see how driver=20
behave with and without this patch.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart362944302.hndijH6itr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaH8TYACgkQi/DJPQPkQ1LHXACfVN7DTtn7Kqs49uGRzuI+Qltq
/U4An2beKPIr/YFdD1l8b1BVQ3ZU8tS9
=jVjk
-----END PGP SIGNATURE-----

--nextPart362944302.hndijH6itr--
