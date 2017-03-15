From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/5] dt-bindings: Add TI SCI PM Domains
Date: Wed, 15 Mar 2017 12:53:41 -0500
Message-ID: <20170315175341.alba5snfgz5xyrzf@rob-hp-laptop>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
 <1488882154-21485-4-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488882154-21485-4-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 07, 2017 at 04:22:32AM -0600, Dave Gerlach wrote:
> Add a generic power domain implementation, TI SCI PM Domains, that
> will hook into the genpd framework and allow the TI SCI protocol to
> control device power states.
> 
> Also, provide macros representing each device index as understood
> by TI SCI to be used in the device node power-domain references.
> These are identifiers for the K2G devices managed by the PMMC.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 59 ++++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  create mode 100644 include/dt-bindings/genpd/k2g.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> new file mode 100644
> index 000000000000..86a6a3d52ed6
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

The last sentence is mostly Linux implementation details. The binding is 
power domains. The Linux framework is PM domains. Let's keep those 
distinct and the latter doesn't belong in bindings.

> +
> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +
> +PM Domain Node
> +==============
> +The PM domain node represents the global PM domain managed by the PMMC, which
> +in this case is the implementation as documented by the generic PM domain
> +bindings in Documentation/devicetree/bindings/power/power_domain.txt.  Because
> +this relies on the TI SCI protocol to communicate with the PMMC it must be a
> +child of the pmmc node.
> +
> +Required Properties:
> +--------------------
> +- compatible: should be "ti,sci-pm-domain"
> +- #power-domain-cells: Must be 1 so that an id can be provided in each
> +		       device node.
> +
> +Example (K2G):
> +-------------
> +	pmmc: pmmc {
> +		compatible = "ti,k2g-sci";
> +		...
> +
> +		k2g_pds: power-controller {
> +			compatible = "ti,sci-pm-domain";
> +			#power-domain-cells = <1>;
> +		};
> +	};
> +
> +PM Domain Consumers
> +===================
> +Hardware blocks belonging to a PM domain should contain a "power-domains"
> +property that is a phandle pointing to the corresponding PM domain node
> +along with an index representing the device id to be passed to the PMMC
> +for device control.
> +
> +Required Properties:
> +--------------------
> +- power-domains: phandle pointing to the corresponding PM domain node
> +		 and an ID representing the device.
> +
> +See dt-bindings/genpd/k2g.h for the list of valid identifiers for k2g.
> +
> +Example (K2G):
> +--------------------
> +	uart0: serial@02530c00 {
> +		compatible = "ns16550a";
> +		...
> +		power-domains = <&k2g_pds K2G_DEV_UART0>;
> +	};
