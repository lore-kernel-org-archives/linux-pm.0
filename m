From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] power: tps65217_charger: Add properties like voltage
 and current charge
Date: Fri, 28 Apr 2017 11:49:21 -0500
Message-ID: <20170428164921.sbhmzr46443cfxto@rob-hp-laptop>
References: <20170421155032.22784-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170421155032.22784-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 21, 2017 at 05:50:32PM +0200, Enric Balletbo i Serra wrote:
> Allow the possibility to configure the charge and the current voltage of
> the charger and also the NTC type for battery temperature measurement.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v1:
>  - Requested by Rob Herring
>    - Rename ti,charge-* to charge-* to be standard properties.
>    - Use unit suffixes as per bindings/property-units.txt
> ---
>  .../bindings/power/supply/tps65217_charger.txt     |  15 ++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/power/supply/tps65217_charger.c            | 187 +++++++++++++++++++--
>  include/linux/mfd/tps65217.h                       |   2 +
>  3 files changed, 192 insertions(+), 12 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
