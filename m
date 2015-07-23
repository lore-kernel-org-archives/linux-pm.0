From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/8] power: bq27x00_battery: Renaming for consistency
Date: Thu, 23 Jul 2015 22:15:35 +0200
Message-ID: <201507232215.35603@pali>
References: <1437601920-13045-1-git-send-email-afd@ti.com> <20150723161240.GF29125@pali> <55B11E4C.6000006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4898944.EvpSPCHOL9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34402 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbbGWUPj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 16:15:39 -0400
In-Reply-To: <55B11E4C.6000006@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Belisko <marek@goldelico.com>

--nextPart4898944.EvpSPCHOL9
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 23 July 2015 19:03:08 Andrew F. Davis wrote:
> >> -#ifdef CONFIG_BATTERY_BQ27X00_I2C
> >> -MODULE_ALIAS("i2c:bq27000-battery");
> >> +#ifdef CONFIG_BATTERY_BQ27XXX_I2C
> >> +MODULE_ALIAS("i2c:bq27xxx-battery");
> >>=20
> >>  #endif
> >=20
> > Why is this MODULE_ALIAS needed? Some lines upper there is
> >=20
> >  MODULE_DEVICE_TABLE(i2c, bq27xxx_id);
> >=20
> > which add proper i2c: module alias...
>=20
> Not sure, looks like it was added in commit
> 8ebb7e9c1a502cfc300618c19c3c6f06fc76d237 which claims that the
> "module won't get loaded automatically" without it, but I have not
> had this problem, so I'm not sure why it's there.
>=20

git grep bq27000-battery show me that only one driver uses that name:
drivers/w1/slaves/w1_bq27000.c

And more over, it is platform device, not i2c device. So that commit=20
8ebb7e9c1a502cfc300618c19c3c6f06fc76d237 is wrong! CCing Marek.

MODULE_ALIAS("platform:bq27000-battery") is really needed for=20
w1_bq27000.c but MODULE_ALIAS("i2c:bq27000-battery") should be removed.=20
It is not used by any board platform code or DT.

Marek, correct me if I'm wrong.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4898944.EvpSPCHOL9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWxS2cACgkQi/DJPQPkQ1LwIQCgpDoDJuTOb9KyJmkebj9oAazE
N+4AoKiBJWgE8OEyUFhnPYnecuyw+evq
=mWRw
-----END PGP SIGNATURE-----

--nextPart4898944.EvpSPCHOL9--
