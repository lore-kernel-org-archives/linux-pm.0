From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: supply: add battery charge voltage/current
Date: Fri, 26 May 2017 14:20:02 -0700
Message-ID: <CAKvHMgTvUkJENP=Y_rdge6Oqq-La341nYW5prB=BpXWo7rF-0A@mail.gmail.com>
References: <20170526110413.24836-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170526110413.24836-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Enric,

On Fri, May 26, 2017 at 4:04 AM, Enric Balletbo i Serra
<enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> Add charging voltage and current characteristics to the battery DT for
> proper handling of the battery by fuel-gauge and charger chips.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v2:
>  - Requested by Sebastian Reichel
>    - Move to its own patch and apply to simple-battery framework.
> Changes since v1:
>  - Requested by Rob Herring
>    - Rename ti,charge-* to charge-* to be standard properties.
>    - Use unit suffixes as per bindings/property-units.txt
>
>  Documentation/devicetree/bindings/power/supply/battery.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 63a7028..c87a439 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -12,6 +12,8 @@ Optional Properties:
>   - voltage-min-design-microvolt: drained battery voltage
>   - energy-full-design-microwatt-hours: battery design energy
>   - charge-full-design-microamp-hours: battery design capacity
> + - charge-voltage-microvolt: battery charging voltage
> + - charge-current-microamp: battery charging current

I think you mean constant-charge-* which is how you surface these
properties in your tps65217_charger patch.

I'll add these to v14 of my patchset which adds simple-battery
support. Rob requested a single patch for this file.

I've been waiting for feedback on v13.2 from Sebastian. If I don't
hear from him within a few days, I'll post v14.

>  Batteries must be referenced by chargers and/or fuel-gauges
>  using a phandle. The phandle's property should be named
> @@ -24,6 +26,8 @@ Example:
>                 voltage-min-design-microvolt = <3200000>;
>                 energy-full-design-microwatt-hours = <5290000>;
>                 charge-full-design-microamp-hours = <1430000>;
> +               charge-voltage-microvolt = <4100000>;
> +               charge-current-microamp = <300000>;
>         };
>
>         charger: charger@11 {
> --
> 2.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
