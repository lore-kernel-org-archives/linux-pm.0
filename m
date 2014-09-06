From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal: rcar: Add binding docs for new R-Car Gen2
 SoCs
Date: Sat, 6 Sep 2014 12:13:59 -0400
Message-ID: <20140906161357.GA3573@developer>
References: <1409213552-5713-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409213552-5713-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hello Geert,


On Thu, Aug 28, 2014 at 10:12:32AM +0200, Geert Uytterhoeven wrote:
>   - r8a7792 (R-Car V2H)
>   - r8a7793 (R-Car M2-N)
>   - r8a7794 (R-Car E2)
> 
> r8a7791 is now called "R-Car M2-W".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I don't have any concerns on this patch and will be adding to my next
branch. But before that, I have one simple question. Although the
binding description mention about soc types, the rcar thermal driver do
not differentiate soc types, only supports the "renesas,rcar-thermal"
compatible. 

Do you care explaining why we need the soc specific compatibles?

> ---
> v2: Drop RFC
> ---
>  Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> index 0ef00be44b01..43404b197933 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> @@ -7,7 +7,10 @@ Required properties:
>  			    - "renesas,thermal-r8a73a4" (R-Mobile AP6)
>  			    - "renesas,thermal-r8a7779" (R-Car H1)
>  			    - "renesas,thermal-r8a7790" (R-Car H2)
> -			    - "renesas,thermal-r8a7791" (R-Car M2)
> +			    - "renesas,thermal-r8a7791" (R-Car M2-W)
> +			    - "renesas,thermal-r8a7792" (R-Car V2H)
> +			    - "renesas,thermal-r8a7793" (R-Car M2-N)
> +			    - "renesas,thermal-r8a7794" (R-Car E2)
>  - reg			: Address range of the thermal registers.
>  			  The 1st reg will be recognized as common register
>  			  if it has "interrupts".
> -- 
> 1.9.1
> 
