From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/2] ARM: dts: bcm283x: Add critical thermal zone for GPU
Date: Wed, 08 Feb 2017 11:50:57 -0800
Message-ID: <87lgtgea1q.fsf@eliezer.anholt.net>
References: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org> <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com> <1486217787-15703-2-git-send-email-stefan.wahren@i2se.com> <20170208041929.GA6809@localhost.localdomain> <20170208042351.GB6809@localhost.localdomain> <93f3ecbc-6d28-3e04-d6f3-4c03f8ac7ab3@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:35576 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdBHTvF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Feb 2017 14:51:05 -0500
In-Reply-To: <93f3ecbc-6d28-3e04-d6f3-4c03f8ac7ab3@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Am 08.02.2017 um 05:23 schrieb Eduardo Valentin:
>> On Tue, Feb 07, 2017 at 08:19:31PM -0800, Eduardo Valentin wrote:
>>> On Sat, Feb 04, 2017 at 02:16:27PM +0000, Stefan Wahren wrote:
>>>> As suggested by Eduardo Valentin this adds the thermal zone for
>>>> the bcm2835 SoC. Since we currently don't have any cooling devices
>>>> leave this section empty.
>>>>
>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>> ---
>>>>  arch/arm/boot/dts/bcm283x.dtsi |   19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283=
x.dtsi
>>>> index 9c7ec7e..359da9d 100644
>>>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>>>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>>>> @@ -19,6 +19,25 @@
>>>>  		bootargs =3D "earlyprintk console=3DttyAMA0";
>>>>  	};
>>>>=20=20
>>>> +	thermal-zones {
>>>> +		gpu_thermal: gpu-thermal {
>>>> +			polling-delay-passive =3D <0>;
>>>> +			polling-delay =3D <1000>;
>>>> +
>>>> +			thermal-sensors =3D <&thermal>;
>> Just came to my mind, dont you need to have an id to specify with sensor
>> points to gpu?
>
> Sorry, i don't know the exact setup of the single thermal sensor on the
> SoC (datasheet doesn't provide any helpful information). I adapted the
> Renesas R-Car thermal binding because i think it would be the best match.
>
> @Eric: What's your opinion?

I don't understand the question.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlibdqEACgkQtdYpNtH8
nuhuuxAAgofsfFPGnonSUy9c5aa04RKiN0tjelAVdR9qu57WlCQzs06K/vYrBadM
ZsPv3hK9NcjItIhebV3WhV/G90pVoS3aRm3vI5XDJnoDl3hvkBUKYb6C715T1NuK
9yqR+DCjPPaaP/tDNeWl8Lj+OuqgwziR5DfsCogeT3XHVzxxdhloq7weWuY9LWzI
9Apmld4hwWdGKnXDWFMjtwwRelKeg5Qs05q4EilBzolgNEqbyqyc2+7LwuSDQ9NI
4UjWsgU+Gi5Tr0C1ubaaZQhIdoXkXeffEaFdSAMH1yFOKk/Tz79IVf6xIhbuuPFD
Gbs68jKcYfwvaAMgW6a4rCDoST3L8IK2UcFzY/gbEBvatsbgXVSF6QJsaKMyi6yr
f6eOyxfv7GI/cXwPhzi2KM5HP0QppqfoW/EkTGcItaABY8QubWIeYtMZkGFeKkSE
L+hNgYiseXMZ7LGf6TDR4xe4dpVYV8fOX2HhrTsgqxlbdmBoCrggkJNCYtaF6CPi
WOO/UUZ1Kpq8PTjCtLiiMJn2/dLRMeESyk3I/6eQExC+szkOWDPnQWQLcUyTw8QK
cTPUuHNf/+RbuBH0FNwzbYmcGsJWnIm8MghtZpnvdwBnG8lumdPE4izkH7ozXYvz
Z4khDCzEY30zFs/OSp01+V/fDZ5EW1otXcEypwbD9I4nRuUeMJc=
=PRVb
-----END PGP SIGNATURE-----
--=-=-=--
