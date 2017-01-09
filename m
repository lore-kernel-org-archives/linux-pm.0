From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Mon, 9 Jan 2017 11:50:12 -0600
Message-ID: <20170109175012.sg7eze7llqq7qevd@rob-hp-laptop>
References: <20170104205536.15963-1-d-gerlach@ti.com>
 <20170104205536.15963-3-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170104205536.15963-3-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 04, 2017 at 02:55:34PM -0600, Dave Gerlach wrote:
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
> v2->v3:
> 	Update k2g_pds node docs to show it should be a child of pmmc node.
> 	In early versions a phandle was used to point to pmmc and docs still
> 	incorrectly showed this.
> 
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 59 ++++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  create mode 100644 include/dt-bindings/genpd/k2g.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> new file mode 100644
> index 000000000000..4c9064e512cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> @@ -0,0 +1,59 @@
> +Texas Instruments TI-SCI Generic Power Domain
> +---------------------------------------------
> +
> +Some TI SoCs contain a system controller (like the PMMC, etc...) that is
> +responsible for controlling the state of the IPs that are present.
> +Communication between the host processor running an OS and the system
> +controller happens through a protocol known as TI-SCI [1]. This pm domain
> +implementation plugs into the generic pm domain framework and makes use of
> +the TI SCI protocol power on and off each device when needed.
> +
> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +
> +PM Domain Node
> +==============
> +The PM domain node represents the global PM domain managed by the PMMC,
> +which in this case is the single implementation as documented by the generic
> +PM domain bindings in Documentation/devicetree/bindings/power/power_domain.txt.
> +Because this relies on the TI SCI protocol to communicate with the PMMC it
> +must be a child of the pmmc node.
> +
> +Required Properties:
> +--------------------
> +- compatible: should be "ti,sci-pm-domain"
> +- #power-domain-cells: Must be 0.
> +
> +Example (K2G):
> +-------------
> +	pmmc: pmmc {
> +		compatible = "ti,k2g-sci";
> +		...
> +
> +		k2g_pds: k2g_pds {
> +			compatible = "ti,sci-pm-domain";
> +			#power-domain-cells = <0>;
> +		};
> +	};
> +
> +PM Domain Consumers
> +===================
> +Hardware blocks that require SCI control over their state must provide
> +a reference to the sci-pm-domain they are part of and a unique device
> +specific ID that identifies the device.
> +
> +Required Properties:
> +--------------------
> +- power-domains: phandle pointing to the corresponding PM domain node.
> +- ti,sci-id: index representing the device id to be passed oevr SCI to
> +	     be used for device control.

As I've already stated before, this goes in power-domain cells. When you 
have a single thing (i.e. node) that controls multiple things, then you 
you need to specify the ID for each of them in phandle args. This is how 
irqs, gpio, clocks, *everything* in DT works.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
