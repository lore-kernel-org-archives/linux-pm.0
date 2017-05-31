From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: Drop k2g genpd device ID macros
Date: Wed, 31 May 2017 11:28:50 -0500
Message-ID: <20170531162850.mf6giowmxj5vetxq@rob-hp-laptop>
References: <20170522183737.24946-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170522183737.24946-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Andrew Davis <afd-l0cyMroinI0@public.gmane.org>, Franklin Cooper <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 22, 2017 at 01:37:37PM -0500, Dave Gerlach wrote:
> Commit 7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains") introduced a
> number of K2G_DEV_x macros to represent each device ID available on the
> K2G platform for use by the genpd, clock, and reset drivers. Rather than
> use these macros, which are only used in the device tree for property
> values and not actually used by the drivers, let's just use the device
> ID number directly in the device tree to avoid macro bloat.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
> Based on discussion here [1] it was agreed that these macros are not needed
> and it is better to just use the device IDs directly in dt.
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg577079.html
> 
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  5 +-
>  include/dt-bindings/genpd/k2g.h                    | 90 ----------------------
>  2 files changed, 3 insertions(+), 92 deletions(-)
>  delete mode 100644 include/dt-bindings/genpd/k2g.h

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
