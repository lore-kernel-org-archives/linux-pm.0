From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] power: bq27xxx_battery: Restore device name
Date: Sat, 6 Feb 2016 11:35:49 +0100
Message-ID: <201602061135.49665@pali>
References: <56B0A318.9060306@gmail.com> <1454417257-10992-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3756145.XszZvKC3sU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34179 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcBFKfx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 6 Feb 2016 05:35:53 -0500
In-Reply-To: <1454417257-10992-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart3756145.XszZvKC3sU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 02 February 2016 13:47:37 Ivaylo Dimitrov wrote:
> Patch <703df6c097956d17a818e63961c82e8e9eef9fef> ("power:
> bq27xxx_battery: Reorganize I2C into a module") has removed the
> device name numbering from bq27xxx_battery_i2c_probe. Fix that by
> restoring the code.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

=46ixes: 703df6c097956d17a818e63961c82e8e9eef9fef
Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Please apply this patch and backport to stable kernels with already has=20
patch 703df6c097956d17a818e63961c82e8e9eef9fef.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3756145.XszZvKC3sU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAla1zIUACgkQi/DJPQPkQ1IKpACffa/ADbsu6Av07WTkNE+WgGNm
ffwAoJtOjfhn9kLasUWxodSC3f1moZcc
=BW2A
-----END PGP SIGNATURE-----

--nextPart3756145.XszZvKC3sU--
