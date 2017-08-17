From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 04/14] staging: typec: fusb302: Get max snk mv/ma/mw
 from device-properties
Date: Thu, 17 Aug 2017 16:41:31 -0500
Message-ID: <20170817214131.63vetzuove7dz5pi@rob-hp-laptop>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170815200502.17339-5-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Yueyao (Nathan) Zhu" <yueyao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 15, 2017 at 10:04:52PM +0200, Hans de Goede wrote:
> This is board specific info so it should come from board config, such
> as devicetree.
> 
> I've chosen to prefix these with "fcs," treating them as fusb302 driver
> specific for now. We may want to revisit this and replace these with
> properties which are part of a (to be written) generic type-c controller
> devicetree binding.
> 
> Since this commit adds new dt-properties it also adds devicetree-bindings
> documentation (which so far was absent for the fusb302 driver).
> 
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: "Yueyao (Nathan) Zhu" <yueyao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2:
> -Use micro... instead of mili...
> -Add devicetree bindings documentation
> ---
>  .../devicetree/bindings/usb/fcs,fusb302.txt        | 29 ++++++++++++++++++++++
>  drivers/staging/typec/fusb302/TODO                 |  4 +++
>  drivers/staging/typec/fusb302/fusb302.c            | 18 +++++++++++++-
>  3 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> new file mode 100644
> index 0000000..ffc6c87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> @@ -0,0 +1,29 @@
> +Fairchild FUSB302 Type-C Port controllers
> +
> +Required properties :
> +- compatible            : "fcs,fusb302"
> +- reg                   : I2C slave address
> +- interrupts            : Interrupt specifier
> +
> +Optional properties :
> +- fcs,max-snk-microvolt : Maximum voltage to negotiate when configured as sink
> +- fcs,max-snk-microamp  : Maximum current to negotiate when configured as sink
> +- fcs,max-snk-microwatt : Maximum power to negotiate when configured as sink
> +			  If this is less then max-snk-microvolt *
> +			  max-snk-microamp then the configured current will
> +			  be clamped.
> +- fcs,operating-snk-microwatt :

Might as well spell out sink.

Otherwise,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> +                          Minimum amount of power accepted from a sink
> +			  when negotiating
> +
> +Example:
> +
> +fusb302: typec-portc@54 {
> +	compatible = "fcs,fusb302";
> +	reg = <0x54>;
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	fcs,max-snk-microvolt = <12000000>;
> +	fcs,max-snk-microamp = <3000000>;
> +	fcs,max-snk-microwatt = <36000000>;
> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
