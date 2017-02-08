From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/8] devicetree: power: bq27xxx: Add monitored-battery
 documentation
Date: Wed, 8 Feb 2017 16:00:04 -0600
Message-ID: <20170208220004.s4gd4bz4mrycuruw@rob-hp-laptop>
References: <20170204091603.32242-1-liam@networkimprov.net>
 <20170204091603.32242-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170204091603.32242-4-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 04, 2017 at 01:15:58AM -0800, Liam Breck wrote:
> From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> 
> From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> 
> Document monitored-battery = <&battery_node>
> 
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> index b0c95ef..f799181 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> @@ -28,9 +28,18 @@ Required properties:
>   * "ti,bq27621" - BQ27621
>  - reg: integer, i2c address of the device.
>  
> +Optional properties:
> +- monitored-battery: phandle of battery information devicetree node
> +
> +  See Documentation/devicetree/bindings/power/supply/battery.txt
> +  If either of the referenced battery's *-full-design-*-hours properties are set,
> +  then both must be.
> +
>  Example:
>  
>  bq27510g3 {

charger@55

Or fuel-gauge@..., I can't tell.

>      compatible = "ti,bq27510g3";
>      reg = <0x55>;
> +
> +    monitored-battery = <&bat>;
>  };
> -- 
> 2.9.3
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
