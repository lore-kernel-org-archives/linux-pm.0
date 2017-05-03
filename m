From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH RESEND 1/3 v4] drivers:power:twl4030-charger: don't check if battery is present
Date: Wed, 3 May 2017 14:20:29 +0200
Message-ID: <E634AF27-5FD1-4729-AB06-3DAFE63A5FC2@goldelico.com>
References: <cd36deb10a769825620828a43d2bab4f949f3370.1492198177.git.hns@goldelico.com> <20170501112631.2kz4bbga4hfznhsz@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_30D5D9E0-243B-4800-8099-929C207BA7FE"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170501112631.2kz4bbga4hfznhsz@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Apple-Mail=_30D5D9E0-243B-4800-8099-929C207BA7FE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 01.05.2017 um 13:26 schrieb Sebastian Reichel =
<sebastian.reichel@collabora.co.uk>:
>=20
> Hi,
>=20
> On Fri, Apr 14, 2017 at 09:29:38PM +0200, H. Nikolaus Schaller wrote:
>> We can't assume that the battery is or stays present after probing
>> on devices with replaceable battery.
>>=20
>> On some devices (e.g. GTA04 or OpenPanodra) it can be removed
>> and even be hot swapped by the user while device continues to operate
>> through external AC or USB power (as long as system power consumption
>> remains below ca. 500mA as provided by USB). Under certain conditions
>> it is possible to boot without battery.
>>=20
>> So it makes no sense to check for this situation during probe and =
make
>> the charger driver (and its status reports) completely =
non-operational if
>> the battery can be inserted later.
>>=20
>> Tested on: GTA04 and OpenPandora.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> Thanks, queued.

TNX,
Nikolaus


--Apple-Mail=_30D5D9E0-243B-4800-8099-929C207BA7FE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZCcsNAAoJEIl79TGLgAm6eBEP/3Rd3gH7JnP0lO5s0D2GJ6fF
9oprbm2xH8DWa5ubgQqi2K8HtgIaT0S+KU7D0nBAcE2/SgeHELLIYV1by6dKwuXl
pjnI9UfJ0gvHR9VhPaAFUKfPgvPhWhYqiSgCwZs4il3Ula05Y3s2501RhEVCedHR
HzFj0r9hNIDMOpC8gNK6JAiWdbQo/+XAgdEwoyDE6CSclb8vUDJyq7bNfo+jSCiv
X2n0xY8Wg1BJ+1K4U7NzEIBupJEwJixRBL8RFWG7vyP0K2U841clu+DJeMeZ+w4B
ft5FDBtQmqRTvPw/oRyOz2hPHQ3gjf1Su2wid8Rud3VQPWSyun4Ble5PRy4IrZZp
xgY6uz7gNh4lkUU6N2abcD8+QQm01k/9qofB1i68GodFDPHJ0XDFIkPtcJU14ZkY
nN8sC0acK7pnrlGLZDjDFCRtzxdZucW9sBJP11UFLj0MmYJ3j5WMdsC/8a0FGIQh
Oa1jLUGeKcH+OdnHcUGJNvzRK6XNaQMc7xCdMrGShR2vAJ3qo+Q33QOAZtSUC30V
buGSFuRnYL5l8opRuKaqOMp8+DHkdaOI/6Z2H0t0kG46xwmA7S1sEm0SA0QALiMi
PZ3uWXLur2IBS3WYkbYkz2DcPHYojWKbklbkGQukOQa0bdnOQBvOiU+rkuF50b3D
EDK6xS5XfjxBhm4M7fFV
=nbwF
-----END PGP SIGNATURE-----

--Apple-Mail=_30D5D9E0-243B-4800-8099-929C207BA7FE--
