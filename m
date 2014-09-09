From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: l2c: parse cache properties from ePAPR definitions
Date: Tue, 09 Sep 2014 10:23:01 +0200
Message-ID: <3872359.cDihUR1d12@wuerfel>
References: <1410246633-23407-1-git-send-email-linus.walleij@linaro.org> <3750746.eYplbZAGky@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <3750746.eYplbZAGky@wuerfel>
Sender: linux-leds-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 09 September 2014 09:42:18 Arnd Bergmann wrote:
> > +     switch (set_size >> 10) {
> > +     case 512:
> > +             set_size_bits = 6;
> > +             break;
> > +     case 256:
> > +             set_size_bits = 5;
> > +             break;
> > +     case 128:
> > +             set_size_bits = 4;
> > +             break;
> > +     case 64:
> > +             set_size_bits = 3;
> > +             break;
> > +     case 32:
> > +             set_size_bits = 2;
> > +             break;
> > +     case 16:
> > +             set_size_bits = 1;
> > +             break;
> > +     default:
> > +             pr_err("L2C OF: cache way size: %d KB is not mapped\n",
> > +                    way_size);
> > +             break;
> > +     }
> > +
> > +     /*
> > +      * The l2x0 TRMs call this size "way size" but that is incorrect:
> > +      * the thing being configured in these register bits is actually
> > +      * the cache set size, so the variable here has the right name
> > +      * but the register bit definitions following the TRM are not
> > +      * in archaic naming.
> > +      */
> 
> No, I think actually the comment and the variable name are wrong here,
> and the TRM is right. I'm surprised you get the right results out of
> this. The set_size should be a relatively small number, e.g. 256 bytes
> in case of an 8-way associative cache with 32 byte lines. What is the
> pr_debug output and the properties you pass in for your example system?
> 

I just saw you had 'cache-sets = <8>' in your original DT file. That
is the wrong number, it needs to be 'cache-sets = <512>'. When you
fix that, you should get the right way_size as well.

	Arnd
