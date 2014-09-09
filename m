From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: l2c: parse cache properties from ePAPR definitions
Date: Tue, 09 Sep 2014 11:45:25 +0200
Message-ID: <3406797.cZXouO3Pko@wuerfel>
References: <1410246633-23407-1-git-send-email-linus.walleij@linaro.org> <3750746.eYplbZAGky@wuerfel> <CACRpkdY8314pTi2nw9gXmFJvmr6sdsyi+1iSUFrs2eVVEZ=3RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY8314pTi2nw9gXmFJvmr6sdsyi+1iSUFrs2eVVEZ=3RA@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 09 September 2014 11:27:55 Linus Walleij wrote:
> 
> >> +     /*
> >> +      * Special checks for the PL310 that only has two settings and
> >> +      * cannot be set to fully associative.
> >> +      */
> >> +     if (max_associativity == 16) {
> >> +             if (assoc == 16)
> >> +                     val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
> >> +             /* Else bit is left zero == 8 way associativity */
> >> +     } else {
> >> +             val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
> >> +     }
> >
> > What happens if we set the bit for assoc=8 on pl310? Is that
> > defined to be ignored or does it have to be zero?
> 
> Only one single bit selects associativity on PL310.
> 
> Bit 16 = 0 -> 8-way associativity
> Bit 16 = 1 -> 16-way associativity
> 
> On L220 there are 1,2,3,4,5,6,7,8 ways of associativity.

I guess the mistake on my side was that I assumed the encoding for
8-way was compatible. However, 16-way on pl310 is encoded the same
way as 8-way on l220 and l210, so these have to be separate. I'm
still not sure if it's a good idea to make the decision based on
the max_associativity value. I think it should either decide based
on some ID, or the register encoding should be moved out to the
caller, and this function just return the way-size and associativity.

> >> +     /*
> >> +      * The l2x0 TRMs call this size "way size" but that is incorrect:
> >> +      * the thing being configured in these register bits is actually
> >> +      * the cache set size, so the variable here has the right name
> >> +      * but the register bit definitions following the TRM are not
> >> +      * in archaic naming.
> >> +      */
> >
> > No, I think actually the comment and the variable name are wrong here,
> > and the TRM is right. I'm surprised you get the right results out of
> > this. The set_size should be a relatively small number, e.g. 256 bytes
> > in case of an 8-way associative cache with 32 byte lines. What is the
> > pr_debug output and the properties you pass in for your example system?
> 
> It looks like that:
> 
> L2C OF: override cache size: 131072 bytes (128KB)
> L2C OF: override set size: 16384 bytes (16 KB)
> L2C OF: override line size: 32 bytes
> L2C OF: override ways: 512 ways
> L2C OF: override way size: 256 bytes
> L2C OF: override associativity: 8

Ok, I found the two problems:

a) your input is wrong, as I said, "cache-sets" in DT needs to be 512,
   not 8.

b) "assoc = way_size / linesize;" is wrong. What you are computing here
   is the same as the "cache-sets" input, i.e. your 'sets' variable.
   'assoc' is supposed to be the same as 'ways' instead, and you can
   remove one or the other.

> L2C: DT/platform modifies aux control register: 0x02020fff -> 0x02030fff
> L2C-220 cache controller enabled, 8 ways, 128 kB
> L2C-220: CACHE_ID 0x41000486, AUX_CTRL 0x06030fff
> 
> Based on that device tree:
> 
>         L2: l2-cache {
>             compatible = "arm,l220-cache";
>             reg = <0x10110000 0x1000>;
>             interrupt-parent = <&intc_dc1176>;
>             interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
>             cache-unified;
>             cache-level = <2>;
>             /*
>              * Override default cache size, sets and
>              * associativity as these may be erroneously set
>              * up by boot loader(s).
>              */
>             arm,override-auxreg;
>             cache-size = <131072>; // 128kB
>             cache-sets = <8>;
>             cache-line-size = <32>;
>         };
> 
> But I'll take a closer look to make sure we get this right.

I think you just copied cache-sets wrong from Florian's original patch.

	Arnd
