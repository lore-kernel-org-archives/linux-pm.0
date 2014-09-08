From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets'
 properties
Date: Mon, 08 Sep 2014 13:33:39 -0700
Message-ID: <540E12A3.2080705@openwrt.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org> <4685530.jbNLD4yaA8@wuerfel> <CACRpkdb_bS0P-fGxogiyCzG9CRPhJK1Gro=H3X1Ks_-UoXh52w@mail.gmail.com> <3479071.8nx1ubr8a9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <3479071.8nx1ubr8a9@wuerfel>
Sender: linux-leds-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/08/2014 06:16 AM, Arnd Bergmann wrote:
> On Monday 08 September 2014 14:36:48 Linus Walleij wrote:
>> On Mon, Sep 8, 2014 at 2:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Monday 08 September 2014 13:38:04 Linus Walleij wrote:
>>>> +       of_property_read_u32(np, "cache-size", &size);
>>>> +       of_property_read_u32(np, "cache-sets", &sets);
>>>> +
>>>> +       if (!size || !sets)
>>>> +               return;
>>>> +
>>>> +       way_size =3D size / sets;
>>>
>>> Going back to this one: Isn't (size / sets) the set-size rather
>>> than the way-size?
>>>
>>> After we discussed this on IRC, I had expected a calculation like
>>>
>>>         set_size =3D size / sets;
>>>         ways =3D set_size / line_size;
>>>         way_size =3D size / ways;
>>
>> First: in this PB1176 case:
>>
>> set_size =3D 128K/8 =3D 16K
>> ways =3D 16K/32 =3D 512 bytes
>> way_size =3D 128K/512 =3D 128 bytes
>=20
> I guess we should first try to find the right units so we know what
> we are talking about. I was under the impression that the set size
> is the number of bytes in a set, while 'ways' is counting the
> associativity and has no unit.

I agree with that.

>=20
> The last line also seems to incorrectly computed. Dividing 128KB
> by 512 bytes should be 256 (no unit).
>=20
>> Well maybe it's the ARM reference manual internal lingo that
>> is actually causing the confusion here. It will say something
>> like:
>>
>> [19:17] Way-size 3=E2=80=99b000 =3D Reserved, internally mapped to 1=
6KB
>> 3=E2=80=99b001 =3D 16KB, this is the default value
>> 3=E2=80=99b010 =3D 32KB
>> 3=E2=80=99b011 =3D 64KB
>> 3=E2=80=99b100 =3D 128KB
>> 3=E2=80=99b101 =3D 256KB
>> 3=E2=80=99b110 to 3=E2=80=99b111 =3D Reserved, internally mapped to =
256 KB
>>
>> OK way-size ... is in the 16 thru 256KB range, which fits nicely
>> with set size incidentally. And also corresponds to current
>> comments in the code such as this from
>> arch/arm/mach-realview/realview_pb1176.c:
>>
>> #ifdef CONFIG_CACHE_L2X0
>>         /*
>>          * The PL220 needs to be manually configured as the hardware
>>          * doesn't report the correct sizes.
>>          * 128kB (16kB/way), 8-way associativity, event monitor and
>>          * parity enabled, ignore share bit, no force write allocate
>>          * Bits:  .... ...0 0111 0011 0000 .... .... ....
>>          */
>>         l2x0_init(__io_address(REALVIEW_PB1176_L220_BASE), 0x0073000=
0,
>> 0xfe000fff);
>> #endif
>=20
> 16KB way-size seems realistic, yes.
>=20
>> I can add a comment explaining that ARMs terminology does
>> not match the academic terminology or something, and say that
>> the thing we poke into "way-size" is actually "set size", if we agre=
e
>> that is what we're seeing here.
>=20
> Let's see again: 16KB way-size * 8 ways =3D 128KB, that seems correct=
=2E
> 16KB way-size / 32B line-size =3D 512 sets, that also seems realistic=
=2E
> 128KB cache-size / 512 sets =3D 256B set-size. 256B / 32B =3D 8 ways,
> so everything fits together.
>=20
> Now in the code:
>=20
> +      of_property_read_u32(np, "cache-size", &size);
>=20
> 131072
>=20
> +       of_property_read_u32(np, "cache-sets", &sets);
>=20
> 512
>=20
> +
> +       if (!size || !sets)
> +               return;
> +
> +       way_size =3D size / sets;
>=20
> 256 -> impossible.
>=20
>=20
>          set_size =3D size / sets;
>=20
> 256
>=20
>          ways =3D set_size / line_size;
>=20
> 8
>=20
>          way_size =3D size / ways;
>=20
> 16KB -> ok

So what we are missing right now is just a 'cache-line-size' property t=
o
get the maths right.
--
=46lorian
