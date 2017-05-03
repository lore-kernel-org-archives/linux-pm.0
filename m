From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/3] drivers:power:twl4030-charger: remove nonstandard max_current sysfs attribute
Date: Wed, 3 May 2017 14:20:16 +0200
Message-ID: <10F3DD04-6EE1-4AFF-AE06-F246C445102E@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com> <38afc4e7faaeabb32f153a0956899fa8e97c1b3a.1492194356.git.hns@goldelico.com> <20170501112601.lfh42un6dgohofbu@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_6B088E62-A557-4535-A185-4BA15F1C0BC7"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:25317 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdECMXa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 08:23:30 -0400
In-Reply-To: <20170501112601.lfh42un6dgohofbu@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org


--Apple-Mail=_6B088E62-A557-4535-A185-4BA15F1C0BC7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 01.05.2017 um 13:26 schrieb Sebastian Reichel =
<sebastian.reichel@collabora.co.uk>:
>=20
> Hi,
>=20
> On Fri, Apr 14, 2017 at 08:25:57PM +0200, H. Nikolaus Schaller wrote:
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> I'm not queuing this. Please change the following things for the
> v4 of this patch:
>=20
> - Kernel patches should always have a long description

Ok.

> - Patch needs to update =
Documentation/ABI/testing/sysfs-class-power-twl4030

Ok, forgot about this.

> - Make sure to use recent MAINTAINERS file for getting patch
>   destination (Dmitry and David are no longer listed).
> - And for this case: please also Cc NeilBrown <neil@brown.name>. If
>   the ABI is in use we cannot simply remove it. If its unlikely,
>   that its used I will queue the patch and revert if any problems
>   are reported.

Well, Neil did also work for the GTA04 project, so it is the same =
project.
But I will add him for V4 so that he can comment himself.

>=20
> -- Sebastian


BR and thanks,
Nikolaus


--Apple-Mail=_6B088E62-A557-4535-A185-4BA15F1C0BC7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZCcsAAAoJEIl79TGLgAm60P8QAMExV0cdCXgvVSKXMdjlclrM
0i9Zb2CBenrsZrzOJXbZKVqrOPV2TncXYpiZgDC/jkgYj6I3RxhtrUOtFoO3Bb0X
XeDdssconkTRKMf8LjP60NtTHH6buXMo5QERNbQbohH3zdXp2N65xYpQyJJk/poD
XySNDXJoq5DoNA8oFJnttQ9B4qKGk6ji0aTvihIWUzmp5xrTxilWFwe1ZyCP5uLX
2zlSne6UHBzy74d2x/0LWqhiHMtz0UyWJAwbr7ik/00ToDW4Ypv/KYbhrD31DT5n
xu5jov242is7jleXNqcMTPmxeLbmBHajoA+BSuJPjxS0XCaGzbB+9q673wGFv9oi
NlP8a3o+iIXuwyStw12y65lxx2sOxPSJDpAzuhxA7KJXYQdgXF+/ykQ5m1ezwjxU
ZKuk2KErSmnpttQWP0YLsEGG2syTPVOf5lplHQ4DUA8FQ/xW1xlVJCZWxuRkMjfL
j1b0OU1hJjh2C4YzqK6gXOHgRMVRm8Ee1Qos/QGVkIQ/dDC24W0aYu4hT/hAnW1E
fY8IKv7T6rwMUEC/qMW6qyxTh6livGkLBEchM5NV875YtZ2IFNmT2D5PluyPLOiS
ZXqbUEs4IaTz5DYWcrpSaKWCP4H6iESDosbmbpisFxdBwT3CmV3MtFyY7fZnphJM
zajARV3jkiCZ9siiPF3M
=CZk9
-----END PGP SIGNATURE-----

--Apple-Mail=_6B088E62-A557-4535-A185-4BA15F1C0BC7--
