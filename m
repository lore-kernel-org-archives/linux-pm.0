From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [RFC v1 3/6] power: supply: bq27xxx: Enable data memory update for certain chips
Date: Sun, 9 Jul 2017 11:07:44 +0200
Message-ID: <201707091107.44653@pali>
References: <20170709021700.14354-1-liam@networkimprov.net> <20170709021700.14354-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart27779330.D5AsuxS47D";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34204 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdGIJHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jul 2017 05:07:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so17720163wrc.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Jul 2017 02:07:48 -0700 (PDT)
In-Reply-To: <20170709021700.14354-4-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

--nextPart27779330.D5AsuxS47D
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 09 July 2017 04:16:57 Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Support data memory update on BQ27500, 545, 425, 421, 441, 621.
> With exception of BQ27425, these are only enabled #ifdef DEBUG,
> as they are not tested.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 164

Why under #ifdef DEBUG? Seems that this is misusing DEBUG which is used=20
for other things.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart27779330.D5AsuxS47D
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAllh8mAACgkQi/DJPQPkQ1I85gCgqWBMvzchGnHqqZ98sDgbOyUe
M0wAn328cf9RY477Ovq/mscMSO8qnVce
=4/d6
-----END PGP SIGNATURE-----

--nextPart27779330.D5AsuxS47D--
