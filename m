From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v4 0/5] ARM: K2G: Add support for TI-SCI Generic PM Domains
Date: Sun, 12 Mar 2017 18:02:35 +0100
Message-ID: <2133897.t9KqoeriS0@aspire.rjw.lan>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488882154-21485-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 07, 2017 04:22:29 AM Dave Gerlach wrote:
> Hi,
> This is v4 of the series to add support for TI-SCI Generic PM Domains.
> Previous versions can be found here:
> 
> v3: https://www.spinics.net/lists/kernel/msg2413975.html
> v2: https://www.spinics.net/lists/kernel/msg2364612.html
> v1: http://www.spinics.net/lists/arm-kernel/msg525204.html
> 
> After much debate I have returned to using the phandle cell to pass the SCI ID
> rather than the separate "ti,sci-id" property that was not very popular. In
> order to do this I needed to make a change to the genpd framework which can be
> seen in patch 2 and should benefit others that have client . Rather than
> checking for zero phandle args and failing if any are present the
> of_genpd_add_provider_simple call does not check at all and instead leaves
> parsing and interpretation up to the platform genpd driver.
> 
> This allows the ti_sci_pm_domains driver to parse the phandle and use the first
> phandle cell as the sci-id rather than getting it from a separate property.
> 
> Besides that none of the original patches have changed apart from updating the
> year to 2017 in patches 3 and 4 and of course a small update to patch 4 to let
> the ti_sci_pm_domains parse the phandle and extract the sci-id rather than
> looking for the rejected ti,sci-id property.
> 
> I did not update the "power-domain" binding document because in regards to
> #power-domain-cells it already states "can be any value as specified by device
> tree binding documentation of particular provider" which I think already
> describes the change in patch 2.

I'm assuming that this will go in through the arm-soc tree.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
