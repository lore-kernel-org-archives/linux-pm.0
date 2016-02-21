From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] power: bq27xxx_battery: Restore device name
Date: Sun, 21 Feb 2016 12:34:54 +0100
Message-ID: <201602211234.54709@pali>
References: <56B0A318.9060306@gmail.com> <1454417257-10992-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <201602061135.49665@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3768851.F70Xj4SJFx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201602061135.49665@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--nextPart3768851.F70Xj4SJFx
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 06 February 2016 11:35:49 Pali Roh=C3=A1r wrote:
> On Tuesday 02 February 2016 13:47:37 Ivaylo Dimitrov wrote:
> > Patch <703df6c097956d17a818e63961c82e8e9eef9fef> ("power:
> > bq27xxx_battery: Reorganize I2C into a module") has removed the
> > device name numbering from bq27xxx_battery_i2c_probe. Fix that by
> > restoring the code.
> >=20
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>=20
> Fixes: 703df6c097956d17a818e63961c82e8e9eef9fef
> Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Please apply this patch and backport to stable kernels with already
> has patch 703df6c097956d17a818e63961c82e8e9eef9fef.

I still do not see this patch in any tree... Please apply.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3768851.F70Xj4SJFx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlbJoN4ACgkQi/DJPQPkQ1IxrgCcCh/iN0m28aI5q7hIyiY7uFgo
ZOgAoMR8Dw7Hyc5VD2SZO0JNdaAtQQTI
=Ck09
-----END PGP SIGNATURE-----

--nextPart3768851.F70Xj4SJFx--
