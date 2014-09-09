From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: l2c: parse cache properties from ePAPR definitions
Date: Tue, 09 Sep 2014 09:42:18 +0200
Message-ID: <3750746.eYplbZAGky@wuerfel>
References: <1410246633-23407-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:60403 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbaIIHm6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 03:42:58 -0400
In-Reply-To: <1410246633-23407-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>

On Tuesday 09 September 2014 09:10:33 Linus Walleij wrote:
> When both 'cache-size' and 'cache-sets' are specified for a L2 cache
> controller node, parse those properties and set up the
> set size based on which type of L2 cache controller we are using.
> 
> Update the L2 cache controller Device Tree binding with the optional
> 'cache-size', 'cache-sets', 'cache-block-size' and 'cache-line-size'
> properties. These come from the ePAPR specification.
> 
> Using the cache size, number of sets and cache line size we can
> calculate desired associativity of the L2 cache. This is done
> by the calculation:
> 
>     set size = cache size / sets
>     ways = set size / line size
>     way size = cache size / ways
>     associativity = way size / line size
> 
> This patch is an extended version based on the initial patch
> by Florian Fainelli.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks much better!

> +static void __init l2x0_cache_size_of_parse(const struct device_node *np,
> +					    u32 *aux_val, u32 *aux_mask,
> +					    u32 max_set_size,
> +					    u32 max_associativity)
> +{
> +	u32 mask = 0, val = 0;
> +	u32 cache_size = 0, sets = 0;
> +	u32 set_size = 0, set_size_bits = 1;
> +	u32 ways = 0, way_size = 0;
> +	u32 blocksize = 0;
> +	u32 linesize = 0;
> +	u32 assoc = 0;
> +
> +	of_property_read_u32(np, "cache-size", &cache_size);
> +	of_property_read_u32(np, "cache-sets", &sets);
> +	of_property_read_u32(np, "cache-block-size", &blocksize);
> +	of_property_read_u32(np, "cache-line-size", &linesize);
> +
> +	if (!cache_size || !sets)
> +		return;

I wonder if we should add another property here that tells
the OS to override the aux register setting for way-size
and associativity. In theory the properties above are meant
to be there for any cache, but I don't think we want to actually
re-compute the auxctrl register values based on this all the
time.

> +	/* All these l2 caches have the same line = block size actually */
> +	if (!linesize) {
> +		if (blocksize) {
> +			/* If linesize if not given, it is equal to blocksize */
> +			linesize = blocksize;
> +		} else {
> +			/* Fall back to known size */
> +			linesize = CACHE_LINE_SIZE;
> +		}
> +	}

Maybe add a warning for the last fallback?

> +	/* This is the PL3x0 case */
> +	if (max_associativity == 16 && (assoc != 8 && assoc != 16)) {
> +		pr_err("L2C OF: cache setting yield illegal associativity\n");
> +		pr_err("L2C OF: %d calculated, only 8 and 16 legal\n", assoc);
> +		return;
> +	}

I'd rather see another function argument for the minimum associativity
here. We have a few other cache controllers that are partially compatible
with l2x0 (tauros3, aurora, bcm11351) and one of these or one we might
add in the future could support a maximum of 16 but also some other sizes
below 8.

> +	/*
> +	 * Special checks for the PL310 that only has two settings and
> +	 * cannot be set to fully associative.
> +	 */
> +	if (max_associativity == 16) {
> +		if (assoc == 16)
> +			val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
> +		/* Else bit is left zero == 8 way associativity */
> +	} else {
> +		val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
> +	}

What happens if we set the bit for assoc=8 on pl310? Is that
defined to be ignored or does it have to be zero?

> +	switch (set_size >> 10) {
> +	case 512:
> +		set_size_bits = 6;
> +		break;
> +	case 256:
> +		set_size_bits = 5;
> +		break;
> +	case 128:
> +		set_size_bits = 4;
> +		break;
> +	case 64:
> +		set_size_bits = 3;
> +		break;
> +	case 32:
> +		set_size_bits = 2;
> +		break;
> +	case 16:
> +		set_size_bits = 1;
> +		break;
> +	default:
> +		pr_err("L2C OF: cache way size: %d KB is not mapped\n",
> +		       way_size);
> +		break;
> +	}
> +
> +	/*
> +	 * The l2x0 TRMs call this size "way size" but that is incorrect:
> +	 * the thing being configured in these register bits is actually
> +	 * the cache set size, so the variable here has the right name
> +	 * but the register bit definitions following the TRM are not
> +	 * in archaic naming.
> +	 */

No, I think actually the comment and the variable name are wrong here,
and the TRM is right. I'm surprised you get the right results out of
this. The set_size should be a relatively small number, e.g. 256 bytes
in case of an 8-way associative cache with 32 byte lines. What is the
pr_debug output and the properties you pass in for your example system?

	Arnd
