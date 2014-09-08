From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets' properties
Date: Mon, 8 Sep 2014 14:36:48 +0200
Message-ID: <CACRpkdb_bS0P-fGxogiyCzG9CRPhJK1Gro=H3X1Ks_-UoXh52w@mail.gmail.com>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
	<1410176286-32533-6-git-send-email-linus.walleij@linaro.org>
	<4685530.jbNLD4yaA8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <4685530.jbNLD4yaA8@wuerfel>
Sender: linux-leds-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Florian Fainelli <florian@openwrt.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 8, 2014 at 2:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 08 September 2014 13:38:04 Linus Walleij wrote:
>> +       of_property_read_u32(np, "cache-size", &size);
>> +       of_property_read_u32(np, "cache-sets", &sets);
>> +
>> +       if (!size || !sets)
>> +               return;
>> +
>> +       way_size =3D size / sets;
>
> Going back to this one: Isn't (size / sets) the set-size rather
> than the way-size?
>
> After we discussed this on IRC, I had expected a calculation like
>
>         set_size =3D size / sets;
>         ways =3D set_size / line_size;
>         way_size =3D size / ways;

=46irst: in this PB1176 case:

set_size =3D 128K/8 =3D 16K
ways =3D 16K/32 =3D 512 bytes
way_size =3D 128K/512 =3D 128 bytes

Well maybe it's the ARM reference manual internal lingo that
is actually causing the confusion here. It will say something
like:

[19:17] Way-size 3=E2=80=99b000 =3D Reserved, internally mapped to 16KB
3=E2=80=99b001 =3D 16KB, this is the default value
3=E2=80=99b010 =3D 32KB
3=E2=80=99b011 =3D 64KB
3=E2=80=99b100 =3D 128KB
3=E2=80=99b101 =3D 256KB
3=E2=80=99b110 to 3=E2=80=99b111 =3D Reserved, internally mapped to 256=
 KB

OK way-size ... is in the 16 thru 256KB range, which fits nicely
with set size incidentally. And also corresponds to current
comments in the code such as this from
arch/arm/mach-realview/realview_pb1176.c:

#ifdef CONFIG_CACHE_L2X0
        /*
         * The PL220 needs to be manually configured as the hardware
         * doesn't report the correct sizes.
         * 128kB (16kB/way), 8-way associativity, event monitor and
         * parity enabled, ignore share bit, no force write allocate
         * Bits:  .... ...0 0111 0011 0000 .... .... ....
         */
        l2x0_init(__io_address(REALVIEW_PB1176_L220_BASE), 0x00730000,
0xfe000fff);
#endif

I can add a comment explaining that ARMs terminology does
not match the academic terminology or something, and say that
the thing we poke into "way-size" is actually "set size", if we agree
that is what we're seeing here.

=46lorian: what was your interpretation?

Yours,
Linus Walleij
