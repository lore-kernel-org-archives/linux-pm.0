From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power_suply: isp1704_charger: Fix isp1704_write() definition
Date: Fri, 1 Jan 2016 12:26:21 +0100
Message-ID: <201601011226.21552@pali>
References: <1451646209-11618-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart31564437.YFpZN71oln";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33808 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbcAAL0Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2016 06:26:25 -0500
In-Reply-To: <1451646209-11618-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart31564437.YFpZN71oln
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 01 January 2016 12:03:29 Ivaylo Dimitrov wrote:
> All calls to isp1704_write() are using parameter sequence of
> isp1704_write(isp, reg, val) but the function is defined as
> isp1704_write(isp, val, reg). Fix isp1704_write function definition
> so that the driver to be functional.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

This problem is there since inclusion of driver itself. No idea why that=20
driver could work... I remember that it detected correctly type of=20
charger.

I will test this patch on real N900 HW in one or two weeks to check how=20
it behave after patching...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart31564437.YFpZN71oln
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaGYl0ACgkQi/DJPQPkQ1K3pACgkG1q0ghvR91eaOcAZeXwouZH
v1wAnRKF/8hSl+xLGmdd1zPCVvx2YHHH
=7JD+
-----END PGP SIGNATURE-----

--nextPart31564437.YFpZN71oln--
