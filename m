From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] Documentation: dt: Add TI-SCI PM Domains
Date: Fri, 2 Sep 2016 09:31:50 -0500
Message-ID: <20160902143150.GA32012@rob-hp-laptop>
References: <20160819235653.26355-1-nm@ti.com>
 <20160819235653.26355-2-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160819235653.26355-2-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 19, 2016 at 06:56:51PM -0500, Nishanth Menon wrote:
> From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> 
> Add a generic power domain implementation, TI SCI PM Domains, that
> will hook into the genpd framework and allow each PD, which will be
> created one per device, to be managed over the TI-SCI protocol.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 58 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> new file mode 100644
> index 000000000000..059a5d71d692
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> @@ -0,0 +1,58 @@
> +Texas Instruments TI-SCI Generic Power Domain
> +---------------------------------------------
> +
> +Some TI SoCs contain a system controller (like the PMMC, etc...) that are
> +responsible for control the state of the IPs that are present. Communication
> +between the host processor running an OS and the system controller happens
> +through a protocol known as TI-SCI[1]. This pm domain implementation plugs into
> +the generic pm domain framework and makes use of the TI SCI protocol power on
> +and off each device when needed.
> +
> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +
> +PM Domains Nodes
> +================
> +The PM domains node represents the global PM domain managed by the PMMC,
> +which in this case is one cell implementation as documented by the generic
> +PM domain bindings in
> +Documentation/devicetree/bindings/power/power_domain.txt.
> +
> +Required Properties:
> +--------------------
> +- compatible: should be "ti,sci-pm-domains"
> +- #power-domain-cells: Must be 1 so that an offset can be provided in each
> +		       device node.
> +- ti,sci: Phandle to the TI SCI device to use for managing the devices

How about just making this a child node of the SCI device?

Rob

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
