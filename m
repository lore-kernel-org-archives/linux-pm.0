From: Santosh Shilimkar <santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] dt-bindings: Drop k2g genpd device ID macros
Date: Thu, 20 Jul 2017 11:53:53 -0700
Message-ID: <4beacba1-26f7-a4a4-9b1d-e3eb3db44b25@oracle.com>
References: <20170720180403.14279-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170720180403.14279-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, Franklin Cooper <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 7/20/2017 11:04 AM, Dave Gerlach wrote:
> Commit 7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains") introduced a
> number of K2G_DEV_x macros to represent each device ID available on the
> K2G platform for use by the genpd, clock, and reset drivers. Rather than
> use these macros, which are only used in the device tree for property
> values and not actually used by the drivers, let's just use the device
> ID number directly in the device tree to avoid macro bloat.
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
> Santosh, Resend of https://www.spinics.net/lists/devicetree/msg177717.html
> rebased on v4.13-rc1 and with Rob's ack included, unchanged otherwise and
> ready for merge.
>
Adding to the queue. Thanks Dave !!

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
