From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: l2c: parse cache properties from ePAPR definitions
Date: Tue, 9 Sep 2014 11:27:55 +0200
Message-ID: <CACRpkdY8314pTi2nw9gXmFJvmr6sdsyi+1iSUFrs2eVVEZ=3RA@mail.gmail.com>
References: <1410246633-23407-1-git-send-email-linus.walleij@linaro.org>
	<3750746.eYplbZAGky@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <3750746.eYplbZAGky@wuerfel>
Sender: linux-leds-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 9, 2014 at 9:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 September 2014 09:10:33 Linus Walleij wrote:

> I wonder if we should add another property here that tells
> the OS to override the aux register setting for way-size
> and associativity. In theory the properties above are meant
> to be there for any cache, but I don't think we want to actually
> re-compute the auxctrl register values based on this all the
> time.

OK added that.

>> +     /* All these l2 caches have the same line = block size actually */
>> +     if (!linesize) {
>> +             if (blocksize) {
>> +                     /* If linesize if not given, it is equal to blocksize */
>> +                     linesize = blocksize;
>> +             } else {
>> +                     /* Fall back to known size */
>> +                     linesize = CACHE_LINE_SIZE;
>> +             }
>> +     }
>
> Maybe add a warning for the last fallback?

OK.

>> +     /* This is the PL3x0 case */
>> +     if (max_associativity == 16 && (assoc != 8 && assoc != 16)) {
>> +             pr_err("L2C OF: cache setting yield illegal associativity\n");
>> +             pr_err("L2C OF: %d calculated, only 8 and 16 legal\n", assoc);
>> +             return;
>> +     }
>
> I'd rather see another function argument for the minimum associativity
> here. We have a few other cache controllers that are partially compatible
> with l2x0 (tauros3, aurora, bcm11351) and one of these or one we might
> add in the future could support a maximum of 16 but also some other sizes
> below 8.

Well it's more like a list in that case. PL310 supports 8 or 16 way
associativity, not 7, 9, 10...

>> +     /*
>> +      * Special checks for the PL310 that only has two settings and
>> +      * cannot be set to fully associative.
>> +      */
>> +     if (max_associativity == 16) {
>> +             if (assoc == 16)
>> +                     val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
>> +             /* Else bit is left zero == 8 way associativity */
>> +     } else {
>> +             val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
>> +     }
>
> What happens if we set the bit for assoc=8 on pl310? Is that
> defined to be ignored or does it have to be zero?

Only one single bit selects associativity on PL310.

Bit 16 = 0 -> 8-way associativity
Bit 16 = 1 -> 16-way associativity

On L220 there are 1,2,3,4,5,6,7,8 ways of associativity.

>> +     /*
>> +      * The l2x0 TRMs call this size "way size" but that is incorrect:
>> +      * the thing being configured in these register bits is actually
>> +      * the cache set size, so the variable here has the right name
>> +      * but the register bit definitions following the TRM are not
>> +      * in archaic naming.
>> +      */
>
> No, I think actually the comment and the variable name are wrong here,
> and the TRM is right. I'm surprised you get the right results out of
> this. The set_size should be a relatively small number, e.g. 256 bytes
> in case of an 8-way associative cache with 32 byte lines. What is the
> pr_debug output and the properties you pass in for your example system?

It looks like that:

L2C OF: override cache size: 131072 bytes (128KB)
L2C OF: override set size: 16384 bytes (16 KB)
L2C OF: override line size: 32 bytes
L2C OF: override ways: 512 ways
L2C OF: override way size: 256 bytes
L2C OF: override associativity: 8
L2C: DT/platform modifies aux control register: 0x02020fff -> 0x02030fff
L2C-220 cache controller enabled, 8 ways, 128 kB
L2C-220: CACHE_ID 0x41000486, AUX_CTRL 0x06030fff

Based on that device tree:

        L2: l2-cache {
            compatible = "arm,l220-cache";
            reg = <0x10110000 0x1000>;
            interrupt-parent = <&intc_dc1176>;
            interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
            cache-unified;
            cache-level = <2>;
            /*
             * Override default cache size, sets and
             * associativity as these may be erroneously set
             * up by boot loader(s).
             */
            arm,override-auxreg;
            cache-size = <131072>; // 128kB
            cache-sets = <8>;
            cache-line-size = <32>;
        };

But I'll take a closer look to make sure we get this right.

Yours,
Linus Walleij
