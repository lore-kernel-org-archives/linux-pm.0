From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/7 v6] ARM: l2x0: calculate associativity from ePAPR cache props
Date: Mon, 08 Sep 2014 14:15:35 +0200
Message-ID: <65434961.9Ji0STQpff@wuerfel>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org> <1410176286-32533-7-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1410176286-32533-7-git-send-email-linus.walleij@linaro.org>
Sender: linux-leds-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 08 September 2014 13:38:05 Linus Walleij wrote:
>  static void __init l2x0_cache_size_of_parse(const struct device_node *np,
>                                             u32 *aux_val, u32 *aux_mask,
> -                                           u32 max_way_size)
> +                                           u32 max_way_size,
> +                                           u32 max_associativity)
>  {
>         u32 mask = 0, val = 0;
>         u32 size = 0, sets = 0;
>         u32 way_size = 0, way_size_bits = 1;
> +       u32 linesize = 0;
> +       u32 assoc = 0;
>  
>         of_property_read_u32(np, "cache-size", &size);
>         of_property_read_u32(np, "cache-sets", &sets);
> +       of_property_read_u32(np, "cache-line-size", &linesize);
>  

If I read ePAPR correctly, you have to read "cache-block-size" as well, and
use that as a fallback if "cache-line-size" is not provided. The line size
is only required to be in the DT if it's different from the block size.

>         if (!size || !sets)
>                 return;
> @@ -962,10 +966,56 @@ static void __init l2x0_cache_size_of_parse(const struct device_node *np,
>         way_size = size / sets;
>  
>         if (way_size > max_way_size) {
> -               pr_warn("L2C: way size %dKB is too large\n", way_size >> 10);
> +               pr_warn("L2C OF: way size %dKB is too large\n", way_size >> 10);
>                 return;
>         }
>  
> +       /* All these l2 caches have the same line size actually */
> +       if (!linesize)
> +               linesize = CACHE_LINE_SIZE;
> +       if (linesize != CACHE_LINE_SIZE)
> +               pr_warn("L2C OF: DT supplied line size %d bytes does "
> +                       "not match hardware line size of %d bytes\n",
> +                       linesize,
> +                       CACHE_LINE_SIZE);

and CACHE_LINE_SIZE seems to be what ePAPR calls cache-block-size, i.e.
the fundamental unit of cache management as seen from the CPU, independent
of how it is physically organized.

> +       /*
> +        * This cache is set associative. By increasing associativity
> +        * we increase the number of blocks per set. Usually this
> +        * quickly hits the roof at 8 or 16 ways of associativity.
> +        */
> +       assoc = way_size / linesize;
> +       if (assoc > max_associativity)
> +               assoc = max_associativity;
> +

I don't see what this helps us. Doesn't this silently try to fix up
incorrect device trees?
If so, I'd rather see the cache get disabled and a warning printed
here.

> +       /*
> +        * Special checks for the PL310 that only has two settings and
> +        * cannot be set to fully associative.
> +        */
> +       if (max_associativity == 16) {
> +               if (assoc <= 8) {
> +                       assoc = 8;
> +                       /* Leave bit 16 in associativity set to 0 */
> +               }
> +               if (assoc > 8 && assoc <= 16) {
> +                       assoc = 16;
> +                       val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
> +               }

Same thing here.

> +       } else {
> +               if (sets == 1)
> +                       /* Direct-mapped cache */
> +                       assoc = 1;
> +               val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
> +       }

This looks wrong: isn't "sets==1" fully associative rather than
direct-mapped?

	Arnd
