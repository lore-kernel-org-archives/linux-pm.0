From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ARM: l2c: parse cache properties from ePAPR
	definitions
Date: Tue, 9 Sep 2014 11:02:02 +0100
Message-ID: <20140909100202.GE12361@n2100.arm.linux.org.uk>
References: <1410246633-23407-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410246633-23407-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-leds-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 09, 2014 at 09:10:33AM +0200, Linus Walleij wrote:
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

Right, and from that we get:

	set_size = cache_size / sets
	ways = cache_size / (sets * line_size)
	way_size = cache_size / (cache_size / (sets * line_size))
	way_size = sets * line_size
	associativity = sets

the last of which disagrees with arch/powerpc/kernel/cacheinfo.c, which
calculates associativity as:

	(size / nr_sets) / line_size

which is "ways".

In any case, "ways" refers to the number in "N-way set associative cache".

> 
> This patch is an extended version based on the initial patch
> by Florian Fainelli.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/l2cc.txt |   6 ++
>  arch/arm/mm/cache-l2x0.c                       | 134 +++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index af527ee111c2..b77343914c66 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -44,6 +44,12 @@ Optional properties:
>    I/O coherent mode. Valid only when the arm,pl310-cache compatible
>    string is used.
>  - interrupts : 1 combined interrupt.
> +- cache-size : specifies the size in bytes of the cache
> +- cache-sets : specifies the number of associativity sets of the cache
> +- cache-block-size : specifies the size in bytes of a cache block
> +- cache-line-size : specifies the size in bytes of a line in the cache,
> +  if this is not specified, the line size is assumed to be equal to the
> +  cache block size
>  - cache-id-part: cache id part number to be used if it is not present
>    on hardware
>  - wt-override: If present then L2 is forced to Write through mode
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 5f2c988a06ac..8157b913f3f3 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -945,6 +945,134 @@ static int l2_wt_override;
>   * pass it though the device tree */
>  static u32 cache_id_part_number_from_dt;
>  
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
> +
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
> +
> +	if (linesize != CACHE_LINE_SIZE)
> +		pr_warn("L2C OF: DT supplied line size %d bytes does "
> +			"not match hardware line size of %d bytes\n",
> +			linesize,
> +			CACHE_LINE_SIZE);
> +
> +	set_size = cache_size / sets;
> +	ways = set_size / linesize;
> +	way_size = cache_size / ways;
> +
> +	if (set_size > max_set_size) {
> +		pr_warn("L2C: set size %dKB is too large\n", set_size >> 10);
> +		return;
> +	}
> +
> +	/*
> +	 * This cache is set associative. By increasing associativity
> +	 * we increase the number of blocks per set.
> +	 */
> +	assoc = way_size / linesize;
> +	if (assoc > max_associativity) {
> +		pr_err("L2C OF: cache setting yield too high associativity\n");
> +		pr_err("L2C OF: %d calculated, max %d\n",
> +		       assoc, max_associativity);
> +		return;
> +	}
> +	/* This is the PL3x0 case */
> +	if (max_associativity == 16 && (assoc != 8 && assoc != 16)) {
> +		pr_err("L2C OF: cache setting yield illegal associativity\n");
> +		pr_err("L2C OF: %d calculated, only 8 and 16 legal\n", assoc);
> +		return;
> +	}
> +
> +	mask |= L2X0_AUX_CTRL_ASSOC_MASK;
> +
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
> +
> +	pr_debug("L2C OF: cache size: %d bytes (%dKB)\n",
> +		 cache_size, cache_size >> 10);
> +	pr_debug("L2C OF: set size: %d bytes (%d KB)\n",
> +		 set_size, set_size >> 10);
> +	pr_debug("L2C OF: line size: %d bytes\n", linesize);
> +	pr_debug("L2C OF: ways: %d ways\n", ways);
> +	pr_debug("L2C OF: way size: %d bytes\n", way_size);
> +	pr_debug("L2C OF: associativity: %d\n", assoc);
> +
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
> +	mask |= L2C_AUX_CTRL_WAY_SIZE_MASK;
> +	val |= (set_size_bits << L2C_AUX_CTRL_WAY_SIZE_SHIFT);

This is not correct.  There is no confusion with ARMs terminology, ARMs
terminology is correct.  This is the way size, and that comes from the
way_size you calculated above.

What's slightly confusing is the "associtivity" term, but as I prove
above, it's exactly the same as "ways" (which is what's used in ARM
documentation.)

So really all this code can be simplified.

Here's a useful table, for an 8 way cache:

Way size        Tag bits        Index bits      log2(num_sets)	num_sets
16KB            18              9               9               512
32KB            17              10              10              1024
64KB            16              11              11              2048
128KB           17              12              12              4096
256KB           18              13              13              8192

The tag/index bits there refer to the virtual address.

Now, since:

	way_size * num_ways = cache_size = set_size * num_sets

and (see the bookshelf below for this...):

	num_ways * num_sets * line_size = cache_size

if we halve the number of ways in a set, keeping the same number of sets
(hence keeping the same number of index bits), the cache size is halved,
and the set size is also halved.

So, way size and set size are not the same thing...


An easier way to think about this is by thinking of the cache as a
bookshelf.  Here's a PDF which illustrates this:

http://csillustrated.berkeley.edu/PDFs/handouts/cache-3-associativity-handout.pdf

So:

- the number of slots = number of sets
- size of each slot = size of each book * number of books
     slot_size = line_size * num_ways
- cache size = slot_size * num_slots
- the number of books in each slot is the number of ways

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
