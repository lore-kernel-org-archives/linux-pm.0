From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: bcm283x: Add critical thermal zone for GPU
Date: Thu, 09 Feb 2017 15:34:27 -0800
Message-ID: <8737fnkkfw.fsf@eliezer.anholt.net>
References: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org> <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com> <1486217787-15703-2-git-send-email-stefan.wahren@i2se.com> <20170208041929.GA6809@localhost.localdomain> <20170208042351.GB6809@localhost.localdomain> <93f3ecbc-6d28-3e04-d6f3-4c03f8ac7ab3@i2se.com> <87lgtgea1q.fsf@eliezer.anholt.net> <124007607.358509.1486662532562@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <124007607.358509.1486662532562-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> writes:

> Hi Eric,
>
>> Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org> hat am 8. Februar 2017 um 20:50 geschriebe=
n:
>>=20
>>=20
>> Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> writes:
>>=20
>> > Am 08.02.2017 um 05:23 schrieb Eduardo Valentin:
>> >> On Tue, Feb 07, 2017 at 08:19:31PM -0800, Eduardo Valentin wrote:
>> >>> On Sat, Feb 04, 2017 at 02:16:27PM +0000, Stefan Wahren wrote:
>> >>>> As suggested by Eduardo Valentin this adds the thermal zone for
>> >>>> the bcm2835 SoC. Since we currently don't have any cooling devices
>> >>>> leave this section empty.
>> >>>>
>> >>>> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>> >>>> ---
>> >>>>  arch/arm/boot/dts/bcm283x.dtsi |   19 +++++++++++++++++++
>> >>>>  1 file changed, 19 insertions(+)
>> >>>>
>> >>>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm=
283x.dtsi
>> >>>> index 9c7ec7e..359da9d 100644
>> >>>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>> >>>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>> >>>> @@ -19,6 +19,25 @@
>> >>>>  		bootargs =3D "earlyprintk console=3DttyAMA0";
>> >>>>  	};
>> >>>>=20=20
>> >>>> +	thermal-zones {
>> >>>> +		gpu_thermal: gpu-thermal {
>> >>>> +			polling-delay-passive =3D <0>;
>> >>>> +			polling-delay =3D <1000>;
>> >>>> +
>> >>>> +			thermal-sensors =3D <&thermal>;
>> >> Just came to my mind, dont you need to have an id to specify with sen=
sor
>> >> points to gpu?
>> >
>> > Sorry, i don't know the exact setup of the single thermal sensor on the
>> > SoC (datasheet doesn't provide any helpful information). I adapted the
>> > Renesas R-Car thermal binding because i think it would be the best mat=
ch.
>> >
>> > @Eric: What's your opinion?
>>=20
>> I don't understand the question.
>
> i hope to get it right. We are talking about defining the thermal zone [1=
].
>
> There are 4 examples:
>
> (a) - CPU thermal zone with one internal sensor
> (b) - IC with several internal sensors
> (c) - Several sensors within one single thermal zone
> (d) - Board thermal
>
> I decided to choose (a) for the patch and Eduardo tends to (b).
>
> Here are the questions:
>
> Where is the thermal sensor TSENS located (ARM core or VideoCore 4)?
>
> Do we expect several internal sensors?

There is only one temperature sensor on the chip, and no others on the
board that I know of.  The docs for tsens don't say if the actual sensor
is closer to the center of the ARM or some VC4 component within the
chip.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlic/IMACgkQtdYpNtH8
nuhGcRAAnqfwXmk4xfHdbQPgRXhTlshfFf8uD/L35MXTuWZARn8sFOLdbKkk1ZOR
HC/GBdVTJsHJolTd5gFfFZYUF27eMVnuf7ZHE8UbLsraytwVM7NJHBocfiVV9uLx
VjtrQIWHSmi3+5RUpbiRkSWxLEvvZkY37RXAP8iiSdkxK4bvACBBTSRa/sJNIo3E
A16JbRPuZ+mzWwhYRa1A6816iT37VxX+Etk97I0hG9MlMSQHgURxdpV0hgJUu1Pn
fnfNCu/cNSYQishO13F2pIZTMgeXSz/eiiNTJZ6Mny7XypffTHBbU4SbhmHBUmNj
FgXzX7VjtxAYNPdcI95PdlVpws+yKNrKHP0ExWxTe1a/J0U/Yk1dIgylk/eu5nrg
l7XmiyIG90i9u/cUOXf3lDGylO4lSfnEPToLZcpwVQX+pyfsop8QcsjwuPuu0XKs
8HRh17KBGwMYAuaHmKULszb9jYcC8DzQ6z80GLhORUy3fEjZbZ9q0qDQO1ZcnZoq
xnsnXI7MAerVWs4tp82bYHoXUB0yzEskuRpD414mcIhkQrXDlTXzwYRpJuTeNPv6
0LVw//B3LEnxDBI9j+Sp0QCkzW1HjgHzmo71CwfpCf31VpEzvjV1fH1RE27KViri
tIYH2qEwO8e0yCB+m0GwIx229fjciJIuArBerNjCliUCjLMGoSc=
=+Lv1
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
