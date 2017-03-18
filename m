From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/5] dt-bindings: Add TI SCI PM Domains
Date: Sat, 18 Mar 2017 15:38:40 -0500
Message-ID: <CAL_JsqLUsp2nK-kX85OANVwfX15p1MyQS9Q03zsUqk-=hpYa6w@mail.gmail.com>
References: <1488882154-21485-4-git-send-email-d-gerlach@ti.com> <20170316182722.18486-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170316182722.18486-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 16, 2017 at 1:27 PM, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
> Add a generic power domain implementation, TI SCI PM Domains, that
> will hook into the genpd framework and allow the TI SCI protocol to
> control device power states.
>
> Also, provide macros representing each device index as understood
> by TI SCI to be used in the device node power-domain references.
> These are identifiers for the K2G devices managed by the PMMC.
>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 57 ++++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  create mode 100644 include/dt-bindings/genpd/k2g.h

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
