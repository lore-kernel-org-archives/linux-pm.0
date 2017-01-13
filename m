From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/7] devicetree: power: add battery state machine
 documentation
Date: Fri, 13 Jan 2017 11:23:30 -0600
Message-ID: <20170113172330.2osu2io24mwpnc57@rob-hp-laptop>
References: <20170111062003.10110-1-matt@ranostay.consulting>
 <20170111062003.10110-2-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170111062003.10110-2-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 10, 2017 at 10:19:57PM -0800, Matt Ranostay wrote:
> Documentation on battery properties that can be defined for
> fine tuning fuel gauge state machines.
> 
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  .../devicetree/bindings/power/supply/battery.txt     | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 000000000000..a6ca761e0a29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,20 @@
> +Battery State Machine Support
> +
> +Optional Properties
> + - nominal-microvolt: dead battery voltage in microvolts
> + - design-microwatt-hours: battery design mWh in microwatts

mWh in microwatts?

mWh would be milliwatt-hours.

> + - design-microamp-hours: battery design mAh in microamps

ditto

> +
> +Example:
> +
> +	bat: battery@0 {

No reg prop, so no unit-address.

> +		nominal-microvolt = <3700000>;
> +		design-microwatt-hours = <5290000>;
> +		design-microamp-hours = <1430000>;
> +	};
> +
> +	charger: charger@0 {
> +		....
> +		monitored-battery = <&bat>;
> +		...
> +	};
> -- 
> 2.10.2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
