From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller
 nodes
Date: Tue, 8 Dec 2015 19:16:56 +0000
Message-ID: <20151208191656.GD11797@leverpostej>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
 <5665D4C7.1050705@arm.com>
 <20151207190355.GE28024@leverpostej>
 <5667267E.2080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5667267E.2080601@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 08, 2015 at 07:50:38PM +0100, Dirk Behme wrote:
> On 07.12.2015 20:03, Mark Rutland wrote:
> >On Mon, Dec 07, 2015 at 06:49:43PM +0000, Sudeep Holla wrote:
> >>
> >>On 07/12/15 18:24, Geert Uytterhoeven wrote:
> >>>+	L2_CA57: cache-controller@0 {
> >>>+		compatible = "cache";
> >>>+		arm,data-latency = <4 4 1>;
> >>>+		arm,tag-latency = <3 3 3>;
> >>
> >>Interesting, only PL2xx/3xx cache controller driver reads this from the
> >>DT and configures the controller. The integrated L2 found in
> >>A15/A7/A57/A53 needs doesn't make use of these values from the DT.
> >
> >These properties seem to be from l2cc.txt, which really only corresponds
> >to PL210/PL220/PL310 (and variants) and isn't as generic as it sounds.
> >
> >I don't see that these are necessary at all.
> 
> 
> What's about a documentation patch like [1], then?

I think it would be better to s/l2cc/l2x0/, and to make it clear that
the document only applies to the variants listed above.

If ePAPR doesn't cover the other cases, we should document those
separately.

> For what is the arm64 dts entry
> 
> cpu@0 {
> 	...
> 	next-level-cache = <&L2_0>;
> };
> 
> L2_0: l2-cache0 {
> 	compatible = "cache";
> };
> 
> good for at all, then?

With the other properties from ePAPR you can acquire information on the
geometry of the cache, which cannot be acquired from architected
registers.

Thanks,
Mark.

> [1]
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt
> b/Documentation/devicetree/bindings/arm/l2cc.txt
> index 06c88a4..f687aed 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -1,12 +1,18 @@
>  * ARM L2 Cache Controller
> 
> -ARM cores often have a separate level 2 cache controller. There are
> various
> +ARM 32-bit cores often have a separate level 2 cache controller.
> There are various
>  implementations of the L2 cache controller with compatible
> programming models.
>  Some of the properties that are just prefixed "cache-*" are taken
> from section
>  3.7.3 of the ePAPR v1.1 specification which can be found at:
> 
> https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf
> 
> -The ARM L2 cache representation in the device tree should be done
> as follows:
> +ARM 64-bit cores (e.g. A15/A7/A57/A53) have an integrated level 2
> cache which
> +doesn't make use of any values from the kernel device tree. There is no
> +L2 cache configuration done in the kernel. The L2 cache is assumed to be
> +preconfigured by early secure boot code.
> +
> +The ARM L2 cache representation for 32-bit cores in the device tree
> should be done
> +as follows:
> 
>  Required properties:
> 
> 
