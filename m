From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] irqchip: gic: Document optional Clock and Power
 Domain properties
Date: Tue, 15 Sep 2015 13:57:01 -0500
Message-ID: <55F869FD.4090900@kernel.org>
References: <1442261204-30931-1-git-send-email-geert+renesas@glider.be>
 <1442261204-30931-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1442261204-30931-3-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/14/2015 03:06 PM, Geert Uytterhoeven wrote:
> Depending on the GIC variant, the GIC module has one or more clock
> inputs. Document the optional "clocks" and "clock-names" properties,
> and their possible values, based on the Technical Reference Manuals.
> optional.
> 
> Add the optional "power-domains" property.
> 
> This will allow to describe in DT the relationship between the GIC and
> the Clock and/or Power Domain topology on SoCs where this is relevant
> and needed for proper operation.
> 
> Note: As the current GIC driver doesn't support Runtime PM yet, PM
> Domain constraints must be handled elsewhere in e.g. platform code.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Note: v1 was Acked-by: Rob Herring <robh@kernel.org>, but I didn't add
>       it, due to the addition of clock-names.

For both: ack.

> 
> v2:
>   - Add "clock-names",
>   - Document clock inputs on various GIC variants.
> 
> Clock inputs are based on the following documentation:
>   - "ARM11 MPCore Processor Technical Reference Manual" (r2p0),
>   - "Cortex-A9 MPCore Technical Reference Manual" (r4p1, r2p0),
>   - "Cortex-A15 Technical Reference Manual" (r4p0, r2p0),
>   - "CoreLink GIC-400 Generic Interrupt Controller Technical Reference
>     Manual" (r0p1, r0p0),
>   - "PrimeCell Generic Interrupt Controller (PL390) Technical Reference
>     Manual" (r0p0).
> 
> I could not find clock input information in:
>   - "ARM1176JZF Development Chip Technical Reference Manual" (r0p0),
>   - "Cortex-A7 MPCore processors" (r0p5, r0p3).
> 
> Other:
>   - "brcm,brahma-b15-gic" seems to be always used together with
>     "arm,cortex-a15-gic".
> 
> No access to datasheets:
>   - "qcom,msm-8660-qgic",
>   - "qcom,msm-qgic2".
> ---
>  Documentation/devicetree/bindings/arm/gic.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 24742853ba460223..cc56021eb60babea 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -59,6 +59,21 @@ Optional
>    regions, used when the GIC doesn't have banked registers. The offset is
>    cpu-offset * cpu-nr.
>  
> +- clocks        : List of phandle and clock-specific pairs, one for each entry
> +  in clock-names.
> +- clock-names   : List of names for the GIC clock input(s). Valid clock names
> +  depend on the GIC variant:
> +	"ic_clk" (for "arm,arm11mp-gic")
> +	"PERIPHCLKEN" (for "arm,cortex-a15-gic")
> +	"PERIPHCLK", "PERIPHCLKEN" (for "arm,cortex-a9-gic")
> +	"clk" (for "arm,gic-400")
> +	"gclk" (for "arm,pl390")
> +
> +- power-domains : A phandle and PM domain specifier as defined by bindings of
> +		  the power controller specified by phandle, used when the GIC
> +		  is part of a Power or Clock Domain.
> +
> +
>  Example:
>  
>  	intc: interrupt-controller@fff11000 {
> 

