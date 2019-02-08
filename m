From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
Date: Fri, 8 Feb 2019 16:23:42 +0100
Message-ID: <20190208152342.GB23062@piout.net>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
 <20190206181221.27914-2-nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206181221.27914-2-nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/02/2019 19:12:20+0100, Nicolas Ferre wrote:
> Update the Reset Controller's binding to add new SoC compatibility string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: split series and collect tag
> 
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index dd7864f2bb2b..dfc91bc02b97 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -22,6 +22,7 @@ Its subnodes can be:
>  RSTC Reset Controller required properties:
>  - compatible: Should be "atmel,<chip>-rstc".
>    <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
> +  it also can be "microchip,sam9x60-rstc"
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
