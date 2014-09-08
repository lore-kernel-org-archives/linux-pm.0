From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets'
 properties
Date: Mon, 08 Sep 2014 12:57:34 -0700
Message-ID: <540E0A2E.9030106@openwrt.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>	<1410176286-32533-6-git-send-email-linus.walleij@linaro.org>	<4685530.jbNLD4yaA8@wuerfel> <CACRpkdb_bS0P-fGxogiyCzG9CRPhJK1Gro=H3X1Ks_-UoXh52w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdb_bS0P-fGxogiyCzG9CRPhJK1Gro=H3X1Ks_-UoXh52w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 09/08/2014 05:36 AM, Linus Walleij wrote:
> On Mon, Sep 8, 2014 at 2:20 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> On Monday 08 September 2014 13:38:04 Linus Walleij wrote:
>>> +       of_property_read_u32(np, "cache-size", &size);
>>> +       of_property_read_u32(np, "cache-sets", &sets);
>>> +
>>> +       if (!size || !sets)
>>> +               return;
>>> +
>>> +       way_size =3D size / sets;
>>
>> Going back to this one: Isn't (size / sets) the set-size rather
>> than the way-size?
>>
>> After we discussed this on IRC, I had expected a calculation like
>>
>>         set_size =3D size / sets;
>>         ways =3D set_size / line_size;
>>         way_size =3D size / ways;
>=20
> First: in this PB1176 case:
>=20
> set_size =3D 128K/8 =3D 16K
> ways =3D 16K/32 =3D 512 bytes
> way_size =3D 128K/512 =3D 128 bytes
>=20
> Well maybe it's the ARM reference manual internal lingo that
> is actually causing the confusion here. It will say something
> like:
>=20
> [19:17] Way-size 3=E2=80=99b000 =3D Reserved, internally mapped to 16=
KB
> 3=E2=80=99b001 =3D 16KB, this is the default value
> 3=E2=80=99b010 =3D 32KB
> 3=E2=80=99b011 =3D 64KB
> 3=E2=80=99b100 =3D 128KB
> 3=E2=80=99b101 =3D 256KB
> 3=E2=80=99b110 to 3=E2=80=99b111 =3D Reserved, internally mapped to 2=
56 KB
>=20
> OK way-size ... is in the 16 thru 256KB range, which fits nicely
> with set size incidentally. And also corresponds to current
> comments in the code such as this from
> arch/arm/mach-realview/realview_pb1176.c:
>=20
> #ifdef CONFIG_CACHE_L2X0
>         /*
>          * The PL220 needs to be manually configured as the hardware
>          * doesn't report the correct sizes.
>          * 128kB (16kB/way), 8-way associativity, event monitor and
>          * parity enabled, ignore share bit, no force write allocate
>          * Bits:  .... ...0 0111 0011 0000 .... .... ....
>          */
>         l2x0_init(__io_address(REALVIEW_PB1176_L220_BASE), 0x00730000=
,
> 0xfe000fff);
> #endif
>=20
> I can add a comment explaining that ARMs terminology does
> not match the academic terminology or something, and say that
> the thing we poke into "way-size" is actually "set size", if we agree
> that is what we're seeing here.
>=20
> Florian: what was your interpretation?

Yes that was my interpretation as well, that we could have 'way-size'
and 'set-size' be the same things here, now that I re-think about it, I
am not sure anymore. More to follow on Arnd's reply to this email.
--
=46lorian

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
