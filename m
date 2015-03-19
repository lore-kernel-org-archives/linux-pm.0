From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/7] irqchip: renesas-irqc: Add functional clock to
 bindings
Date: Thu, 19 Mar 2015 10:41:44 +0900
Message-ID: <20150319014143.GI14051@verge.net.au>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
 <1426704961-27322-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426704961-27322-4-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 18, 2015 at 07:55:57PM +0100, Geert Uytterhoeven wrote:
> The external IRQ controller has a functional clock, which is used for
> power management. Document it.
> 
> Fix a typo in the r8a73a4 SoC name while we're at it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  .../devicetree/bindings/interrupt-controller/renesas,irqc.txt         | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> index 1a88e62228e59631..4f85aeb658e4c833 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> @@ -4,7 +4,7 @@ Required properties:
>  
>  - compatible: has to be "renesas,irqc-<soctype>", "renesas,irqc" as fallback.
>    Examples with soctypes are:
> -    - "renesas,irqc-r8a73a4" (R-Mobile AP6)
> +    - "renesas,irqc-r8a73a4" (R-Mobile APE6)
>      - "renesas,irqc-r8a7790" (R-Car H2)
>      - "renesas,irqc-r8a7791" (R-Car M2-W)
>      - "renesas,irqc-r8a7792" (R-Car V2H)
> @@ -12,6 +12,7 @@ Required properties:
>      - "renesas,irqc-r8a7794" (R-Car E2)
>  - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
>    interrupts.txt in this directory
> +- clocks: Must contain a reference to the functional clock.
>  
>  Optional properties:
>  
> @@ -29,4 +30,5 @@ Example:
>  			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 3 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R8A7790_CLK_IRQC>;
>  	};
> -- 
> 1.9.1
> 
