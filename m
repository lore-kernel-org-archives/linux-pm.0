From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/7 v6] ARM: l2x0: calculate associativity from ePAPR
 cache props
Date: Mon, 8 Sep 2014 14:43:55 +0200
Message-ID: <CACRpkdaTWt=0cbfgrnbah3jHRsvGUnVzsCb1uqFKPUNfvZ+AhA@mail.gmail.com>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
	<1410176286-32533-7-git-send-email-linus.walleij@linaro.org>
	<65434961.9Ji0STQpff@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <65434961.9Ji0STQpff@wuerfel>
Sender: linux-leds-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 8, 2014 at 2:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 08 September 2014 13:38:05 Linus Walleij wrote:
>>  static void __init l2x0_cache_size_of_parse(const struct device_node *np,
>>                                             u32 *aux_val, u32 *aux_mask,
>> -                                           u32 max_way_size)
>> +                                           u32 max_way_size,
>> +                                           u32 max_associativity)
>>  {
>>         u32 mask = 0, val = 0;
>>         u32 size = 0, sets = 0;
>>         u32 way_size = 0, way_size_bits = 1;
>> +       u32 linesize = 0;
>> +       u32 assoc = 0;
>>
>>         of_property_read_u32(np, "cache-size", &size);
>>         of_property_read_u32(np, "cache-sets", &sets);
>> +       of_property_read_u32(np, "cache-line-size", &linesize);
>>
>
> If I read ePAPR correctly, you have to read "cache-block-size" as well, and
> use that as a fallback if "cache-line-size" is not provided. The line size
> is only required to be in the DT if it's different from the block size.

OK fixed this...

>>         if (way_size > max_way_size) {
>> -               pr_warn("L2C: way size %dKB is too large\n", way_size >> 10);
>> +               pr_warn("L2C OF: way size %dKB is too large\n", way_size >> 10);
>>                 return;
>>         }
>>
>> +       /* All these l2 caches have the same line size actually */
>> +       if (!linesize)
>> +               linesize = CACHE_LINE_SIZE;
>> +       if (linesize != CACHE_LINE_SIZE)
>> +               pr_warn("L2C OF: DT supplied line size %d bytes does "
>> +                       "not match hardware line size of %d bytes\n",
>> +                       linesize,
>> +                       CACHE_LINE_SIZE);
>
> and CACHE_LINE_SIZE seems to be what ePAPR calls cache-block-size, i.e.
> the fundamental unit of cache management as seen from the CPU, independent
> of how it is physically organized.

Yeah. Well, actually that means the variable in cache-l2x0.c should
be renamed from CACHE_LINE_SIZE to CACHE_BLOCK_SIZE
if we go with that terminology, right? That is the real change that
is needed to make terminology consistent then.

>> +       /*
>> +        * This cache is set associative. By increasing associativity
>> +        * we increase the number of blocks per set. Usually this
>> +        * quickly hits the roof at 8 or 16 ways of associativity.
>> +        */
>> +       assoc = way_size / linesize;
>> +       if (assoc > max_associativity)
>> +               assoc = max_associativity;
>> +
>
> I don't see what this helps us. Doesn't this silently try to fix up
> incorrect device trees?

I will look closer... But whatever comes out of the calculation
is always way about 8 or even 16. Probably my arithmetics
get it wrong because of terminology confusion. With the
definitions from your previous mail, maybe it all ends up
correctly. I'll hack around a bit and see.

>> +       } else {
>> +               if (sets == 1)
>> +                       /* Direct-mapped cache */
>> +                       assoc = 1;
>> +               val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
>> +       }
>
> This looks wrong: isn't "sets==1" fully associative rather than
> direct-mapped?

Yep. I'll fix.

Yours,
Linus Walleij
