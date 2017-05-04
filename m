From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: bq27xxx: make bq27xxx_battery_settings
 static
Date: Thu, 4 May 2017 17:24:03 +0200
Message-ID: <20170504152403.4ukwib7dvjmk7g5u@earth>
References: <20170503104554.23019-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jd7db2dbo3ne7azg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37173 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdEDPYI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 11:24:08 -0400
Content-Disposition: inline
In-Reply-To: <20170503104554.23019-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Liam Breck <kernel@networkimprov.net>, "Andrew F . Davis" <afd@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org


--jd7db2dbo3ne7azg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 03, 2017 at 11:45:54AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The function bq27xxx_battery_settings can be made static as it
> does not need to be in global scope.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, I dropped Liam's patches instead.

-- Sebastian

--jd7db2dbo3ne7azg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkLR5MACgkQ2O7X88g7
+pr+cQ//ZoioV1u+sdRMcwEBkDVn77Xfe5lKjKTk9lQKTuSzEZlva2nNET00uezD
xoRTcxQopJZkBBVznFwAePYcUc+LJYFw7GwiSXA1K1Pd3LPXlDTFZk2MrtRBo3y7
5QEKtoXflnNFEz27trqpE46jSB9Q38OonDyBCgwS3Xns7LYFdB0g8mTerLiJ32aj
aG1Auw9FCMI1AgX0Kla+a/pJmArH6lyKnZyiteIRW8DCt1K8KFBzxhuMer2+REG3
w4DIEpigi4yu/9/UaaVp8Pe+4khaQ4DvGcqlrYM/P+RuPVey29uqQ31T57/xZeiC
8Zh13tMNFxIZsm1b7By3N/nb/LlyoQ20DH+lJRyhXCmvhfw6MuTbvaidMqb1MWEz
j+B+u1rflmQWY4NXEyDwnQHgfQimYhC+Fl84XVK5e0VnrdWc75PUk+/FKY79UiLy
LalcZNATArHE8witHmj6TGwf6ThrkE8ZuGDF5cgCx/9qSQ3yzjo5tTXSDpH0p3Yo
1ASCmqPwOdc7w3BvGr8P0a5lLVLKxTjPu2e+jhAK99M/e7KpT0BiC85ZY+vhDbnk
OSDayaokre1s8dz6nBUvjNvJzAFXouIiiRy+AM5fOkstV3c2bIxmlUiRdoLOR4Py
j8j9p48cnciqPCt0ab7h76MoG2MQtdW4qFrabnRo3lD7wTI8r28=
=AF2m
-----END PGP SIGNATURE-----

--jd7db2dbo3ne7azg--
