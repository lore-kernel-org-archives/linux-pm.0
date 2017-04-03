From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] power: supply: ltc2941-battery-gauge: Add vendor
 to compatibles in binding
Date: Mon, 3 Apr 2017 10:15:21 -0500
Message-ID: <20170403151521.aq75yc7zafwgerkl@rob-hp-laptop>
References: <20170329160057.8298-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170329160057.8298-1-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 29, 2017 at 12:00:56PM -0400, Javier Martinez Canillas wrote:
> The DT binding document for LTC2941 and LTC2943 battery gauges did not use
> a vendor prefix in the listed compatible strings. The driver says that the
> manufacturer is Linear Technology which is "lltc" in vendor-prefixes.txt.
> 
> There isn't an upstream Device Tree source file that has nodes defined for
> these devices, so there's no need to keep the old compatible strings.
> 
> Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/power/supply/ltc2941.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
