From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply
 bindings documentation
Date: Wed, 5 Nov 2014 15:55:25 +0100
Message-ID: <ACF6E448-6936-4212-AB50-0EC4FEEA8C42@dominion.thruhere.net>
References: <20141020221959.2f312906@neptune.home> <20141020223314.0484f795@neptune.home> <20141021101503.GE26842@x1> <20141021180916.432f02e1@neptune.home> <20141021191905.GR21108@lukather> <20141103210244.1425e0c7@neptune.home> <20141104143117.GC26729@lukather> <20141104220827.773c53d0@neptune.home> <20141105144832.GB2989@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCB73UESRQKBBYHU5CRAKGQELEYU6NI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141105144832.GB2989@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: =?iso-8859-1?Q?Bruno_Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org List" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


> Op 5 nov. 2014, om 15:48 heeft Maxime Ripard <maxime.ripard@free-electron=
s.com> het volgende geschreven:
>=20
> On Tue, Nov 04, 2014 at 10:08:27PM +0100, Bruno Pr=C3=A9mont wrote:
>> On Tue, 04 November 2014 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
> wrote:
>>> On Mon, Nov 03, 2014 at 09:02:44PM +0100, Bruno Pr=C3=A9mont wrote:=20
>>>> Doing something like this?:
>>>>=20
>>>> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>>>> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>>>> @@ -126,9 +126,11 @@
>>>>                                interrupt-controller;
>>>>                                #interrupt-cells =3D <1>;
>>>>=20
>>>> -                               backup =3D <3000000 200>;
>>>> -                               battery.resistance =3D <100>;
>>>> -                               battery.capacity =3D <2000>;
>>>> +                               x-powers,backup =3D <3000000 200>;
>>>=20
>>> I don't really remember what was that property used for. Would it make
>>> sense to put it into the battery node?
>>=20
>> The backup/rtc battery is completely distinct from main battery.
>>=20
>> It's presence is in no way related to that of the main battery,
>> thus I would not put it into the same node.
>> As all the information needed is included in the property I see
>> no reason to move it into a separate node.
>=20
> Oh. So it is to model some button battery that might be here to keep
> the RTC state while the board is unpowered?
>=20
> How is that related to the PMIC?

Some PMICs can recharge it and detect it it's empty or not.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
