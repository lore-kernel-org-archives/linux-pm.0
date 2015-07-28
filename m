From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 1/6] power: bq27x00_battery: Remove unneeded i2c MODULE_ALIAS
Date: Tue, 28 Jul 2015 22:00:41 +0200
Message-ID: <201507282200.41564@pali>
References: <1438112353-19704-1-git-send-email-afd@ti.com> <1438112353-19704-2-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3903500.HvjBdTcuLd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38808 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbbG1UAp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 16:00:45 -0400
In-Reply-To: <1438112353-19704-2-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart3903500.HvjBdTcuLd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 28 July 2015 21:39:08 Andrew F. Davis wrote:
> The MODULE_DEVICE_TABLE macro automatically adds all needed
> i2c MODULE_ALIASes so remove the extra MODULE_ALIAS.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3903500.HvjBdTcuLd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW332kACgkQi/DJPQPkQ1IRygCgn/Z0m8dG4vmEYhxBZqYderAO
AbAAn0U/A42H33xoMg8sKQrHikh9ND5s
=lsXh
-----END PGP SIGNATURE-----

--nextPart3903500.HvjBdTcuLd--
