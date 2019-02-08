From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: atmel: add missing samx7 to
 reset controller
Date: Fri, 8 Feb 2019 16:23:31 +0100
Message-ID: <20190208152331.GA23062@piout.net>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206181221.27914-1-nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/02/2019 19:12:19+0100, Nicolas Ferre wrote:
> Add this missing compatibility string to the Reset Controller
> compatible string chip list.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: split series and collect tag
> 
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index df444073d376..dd7864f2bb2b 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -21,7 +21,7 @@ Its subnodes can be:
>  
>  RSTC Reset Controller required properties:
>  - compatible: Should be "atmel,<chip>-rstc".
> -  <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
> +  <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
>  - reg: Should contain registers location and length
>  - clocks: phandle to input clock.
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
