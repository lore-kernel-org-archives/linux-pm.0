From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Mon, 31 Oct 2016 14:06:20 -0700
Message-ID: <87h97sut2r.fsf@eliezer.anholt.net>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org> <1474446227-1147-3-git-send-email-kernel@martin.sperl.org> <87twczg27x.fsf@eliezer.anholt.net> <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com> <87eg35snvg.fsf@eliezer.anholt.net> <1190898538.120930.02d69662-0b1a-447d-9c29-782aec7a1189.open-xchange@email.1und1.de> <1477363675.2298.2.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:44820 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S946883AbcJaVGY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Oct 2016 17:06:24 -0400
In-Reply-To: <1477363675.2298.2.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Stefan Wahren <stefan.wahren@i2se.com>, kernel@martin.sperl.org
Cc: Will Deacon <will.deacon@arm.com>, Lee Jones <lee@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zhang Rui <rui.zhang@intel.com> writes:

> On Mon, 2016-10-24 at 20:25 +0200, Stefan Wahren wrote:
>> >=20
>> > Eric Anholt <eric@anholt.net> hat am 24. Oktober 2016 um 18:38
>> > geschrieben:
>> >=20
>> >=20
>> > Stefan Wahren <stefan.wahren@i2se.com> writes:
>> >=20
>> > >=20
>> > > Hi Martin,
>> > >=20
>> > > Am 28.09.2016 um 23:10 schrieb Eric Anholt:
>> > > >=20
>> > > > kernel@martin.sperl.org writes:
>> > > >=20
>> > > > >=20
>> > > > > From: Martin Sperl <kernel@martin.sperl.org>
>> > > > >=20
>> > > > > Add basic thermal driver for bcm2835 SOC.
>> > > > >=20
>> > > > > This driver currently relies on the firmware setting up the
>> > > > > tsense HW block and does not set it up itself.
>> > > > >=20
>> > > > > Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> > > > > Acked-by: Eric Anholt <eric@anholt.net>
>> > > > > Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>> > > > What's the status of merging this one?=C2=A0=C2=A0I'd like to merg=
e the
>> > > > other
>> > > > patches.
>> > > i think it's necessary to rebase the whole series. Maybe we could
>> > > get it
>> > > into 4.10.
>> > Why would it need to be rebased?=C2=A0=C2=A0The status, as far as I kn=
ow, is
>> > that
>> > we're still waiting for the subsystem maintainer to respond.
>> Since at least this patch won't apply anymore, but feedback from
>> maintainer is
>> still good :-)
>>=20
>> Sorry for this impatience, but i'm afraid that we possibly miss 4.10.
>
> Eduardo,
>
> any comments on this patchset?

It's been a month on v7 of this patch.  Can we please merge it?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYF7JNAAoJELXWKTbR/J7ohu8QAKwyyNVCaNtrNL2vhlBW8yd/
B2Y9B+ir6M7E5iEQMQkLlQMAFsjAFN2wrBREer9gAwTyHL9P2B9hwtjVifDnzsd7
MBe3eSqRX4oBuDLWJdaZEcNNmihpoTJjetG3c1YSFuh7vPoUJim10UHSCp6m5AGP
5L5+np2q4J+57jpsBrBOWWPpOneAXGblzsQOS2RWyw4o7qldTUN82ITnLDEsRjUZ
FJUebCkYAl/38I3Gafayfyiv4irmSTUDxVKAGMsZAA1nQ/c+lsT1zLEqEqwGKcNj
kCxzg/YnsLdxw2HFPoSH9BPSGlmSNQjUOjrB0utpZEnCkpP1pk9xwq/4T/YXomoA
QA2SKcuw/X+JVOmqKYbdD02F8A5A+XkpbzggqqEUuHfSlygyiEcX6XNApRVkQT+3
k60S6hfDY2aaEA80gpiEWaSn4RyCnN7GiX+UklLSARH4xwFwpXwF9XYqianoc9Mz
j5V/CnMcGTS/yzlIexLuJPbPenFxkLd8ydPw8cSMOvbDqSqd9jcbd1YCGUGYyA/a
c1hL1KXP5svK14B3Suodg/zdvxclkJ+kHn4JZkQyTcCHNrRFwa6B7u7/mN4TKv5q
5JKNkoO+mqTCKkCauOAw47EoVkQQXIpRBvEK/KYujWh3O8vx1lI9cFVHOdXqMlXG
dzUzTCEGRMwwUFguGtY0
=QdCr
-----END PGP SIGNATURE-----
--=-=-=--
