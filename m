From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] ARM: l2c: parse cache properties from ePAPR definitions
Date: Wed, 10 Sep 2014 11:44:52 +0200
Message-ID: <4196671.LQ3YKNLqVB@wuerfel>
References: <1410339572-23694-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65211 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaIJJpd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 05:45:33 -0400
In-Reply-To: <1410339572-23694-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>

On Wednesday 10 September 2014 10:59:32 Linus Walleij wrote:

> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index af527ee111c2..918b4489ab73 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -43,7 +43,17 @@ Optional properties:
>  - arm,io-coherent : indicates that the system is operating in an hardware
>    I/O coherent mode. Valid only when the arm,pl310-cache compatible
>    string is used.
> +- arm,override-auxreg : this boolean property tells the OS implementation of
> +  the l2cc driver code to override the default cache size, sets (and thus
> +  associativity) settings from the auxilary control register. This is to be
> +  used when the boot code does not set up these properties correctly.

For the last one, I mentioned this to Russell yesterday on IRC and
he said he was fine with the approach from the earlier patch without
this property.

>  - interrupts : 1 combined interrupt.
> +- cache-size : specifies the size in bytes of the cache
> +- cache-sets : specifies the number of associativity sets of the cache
> +- cache-block-size : specifies the size in bytes of a cache block
> +- cache-line-size : specifies the size in bytes of a line in the cache,
> +  if this is not specified, the line size is assumed to be equal to the
> +  cache block size

I think this should point to ePAPR for a more detailed description of
the meanings.

> +	/*
> +	 * Since:
> +	 * set size = cache size / sets
> +	 * ways = cache size / (sets * line size)
> +	 * way size = cache size / (cache size / (sets * line size))
> +	 * way size = sets * line size
> +	 * associativity = ways = cache size / way size
> +	 */
> +	way_size = sets * line_size;
> +	*associativity = cache_size / way_size;

Ah, that's better, it also avoids doing multiple divisions, which
could potentially all result in divide-by-zero exceptions, and
you check that neither cache_size nor way_size is zero.

> +	if (way_size > max_way_size) {
> +		pr_err("L2C OF: set size %dKB is too large\n", way_size);
> +		return;
> +	}
> +
> +	pr_info("L2C OF: override cache size: %d bytes (%dKB)\n",
> +		cache_size, cache_size >> 10);
> +	pr_info("L2C OF: override line size: %d bytes\n", line_size);
> +	pr_info("L2C OF: override way size: %d bytes (%dKB)\n",
> +		way_size, way_size >> 10);
> +	pr_info("L2C OF: override associativity: %d\n", *associativity);

I think it would be really nice to print both the original setting
and the setting from DT here.

> +	switch (way_size >> 10) {
> +	case 512:
> +		way_size_bits = 6;
> +		break;
> +	case 256:
> +		way_size_bits = 5;
> +		break;
> +	case 128:
> +		way_size_bits = 4;
> +		break;
> +	case 64:
> +		way_size_bits = 3;
> +		break;
> +	case 32:
> +		way_size_bits = 2;
> +		break;
> +	case 16:
> +		way_size_bits = 1;
> +		break;
> +	default:
> +		pr_err("L2C OF: cache way size illegal: %dKB is not mapped\n",
> +		       way_size);
> +		break;
> +	}

There is probably a nicer way to express this using ilog2, but
this works for me.

> @@ -1250,6 +1388,15 @@ static void __init aurora_of_parse(const struct device_node *np,
>  		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
>  	}
>  
> +	l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_256K);
> +	if (assoc > 8) {
> +		pr_err("l2x0 of: cache setting yield too high associativity\n");
> +		pr_err("l2x0 of: %d calculated, max 8\n", assoc);
> +	} else {
> +		mask |= L2X0_AUX_CTRL_ASSOC_MASK;
> +		val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
> +	}
> +

I think this is completely wrong for aurora:

According to
http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf

Way Disabling Mechanism: The L2 controller is a 16/32-way, set associative cache,
and it supports a Way Disabling mechanism for power reduction by changing the
cache <Associativity> field in the L2 Auxiliary Control Register (Table 295 p. 692).

and
Bit	Field		Type/InitVal	Description
19:17  WaySize  	RO 0x4		Way Size
					2 = 16KB
					3 = 32KB
					4 = 64KB
					5 = 128KB
					6 = 256KB
					7 = 512KB

16:13  Associativity   RW 0xf		L2 Cache Way  Associative
					3 = 4: Ways
					7 = 8: Ways
					11 = 16: Ways
					15 = 32: Ways

11:10  L2 Size         RO 0x3		L2 Cache Size
					1 = 0.5MB: 8 ways of 64KB
					2 = 1MB: 16 ways of 64KB
					3 = 2MB: 32 ways of 64KB

The encoding for Associativity and L2 size looks completely
incompatible with both l210 and pl310.

The easiest way to deal with it is probably to just ignore the
aurora case and assume that the register is set up correctly,
which seems to be the case for all the chips we support at this
point.

	Arnd
