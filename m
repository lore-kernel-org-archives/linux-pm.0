From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] devicetree: bq27425: add documentation for bq27425
 fuel gauge
Date: Tue, 3 Jan 2017 10:47:15 -0600
Message-ID: <20170103164715.pypb5zt22hg4zqlh@rob-hp-laptop>
References: <20161226054442.23599-1-matt@ranostay.consulting>
 <20161226054442.23599-3-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161226054442.23599-3-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 25, 2016 at 09:44:41PM -0800, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  .../devicetree/bindings/power/bq27425.txt          | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/bq27425.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/bq27425.txt b/Documentation/devicetree/bindings/power/bq27425.txt
> new file mode 100644
> index 000000000000..f09f787a9378
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/bq27425.txt
> @@ -0,0 +1,25 @@
> +* TI BQ27425 Fuel Gauge
> +
> +http://www.ti.com/lit/ds/symlink/bq27425-g2a.pdf
> +
> +Please note that if any of the optional properties are defined
> +then all settings must be.
> +
> +Required properties:
> +- compatible: Should be "ti,bq27425"
> +- reg: integer, i2c of the device

s/i2c/I2C address/

> +
> +Optional properties:
> +- ti,design-capacity: integer of mAh of the battery
> +- ti,design-energy: integer of the mWh of the battery
> +- ti,terminate-voltage: integer of mV of the dead voltage of
> +			the battery

These all need unit suffixes. mAh and mWh may need to be added to 
property-units.txt.

> +
> +bq27425 {
> +	compatible = "ti,bq27425";
> +	reg = <0x55>;
> +
> +	ti,design-capacity = <1360>;
> +	ti,design-energy = <4970>;
> +	ti,terminate-voltage = <3200>;
> +};
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
