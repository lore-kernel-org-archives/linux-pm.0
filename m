From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: Add TI SCI PM Domains
Date: Fri, 21 Oct 2016 11:48:52 -0700
Message-ID: <7heg39pmgb.fsf@baylibre.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
        <20161019203347.17893-3-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35756 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934841AbcJUSsx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 14:48:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id s8so61287770pfj.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2016 11:48:53 -0700 (PDT)
In-Reply-To: <20161019203347.17893-3-d-gerlach@ti.com> (Dave Gerlach's message
        of "Wed, 19 Oct 2016 15:33:45 -0500")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>

Dave Gerlach <d-gerlach@ti.com> writes:

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
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 54 +++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  create mode 100644 include/dt-bindings/genpd/k2g.h
>
> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> new file mode 100644
> index 000000000000..32f38a349656
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> @@ -0,0 +1,54 @@
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
> +
> +Required Properties:
> +--------------------
> +- compatible: should be "ti,sci-pm-domain"
> +- #power-domain-cells: Must be 0.
> +- ti,sci: Phandle to the TI SCI device to use for managing the devices.
>
> +Example:
> +--------------------
> +k2g_pds: k2g_pds {

should use generic name like "power-contoller", e.g. k2g_pds: power-controller

> +        compatible = "ti,sci-pm-domain";
> +        #power-domain-cells = <0>;
> +        ti,sci = <&pmmc>;
> +};
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

This ID doesn't look right.

Why not use #power-domain-cells = <1> and pass the index in the DT? ...

> +See dt-bindings/genpd/k2g.h for the list of valid identifiers for k2g.
> +
> +Example:
> +--------------------
> +uart0: serial@02530c00 {
> +	compatible = "ns16550a";
> +	...
> +	power-domains = <&k2g_pds>;
> +	ti,sci-id = <K2G_DEV_UART0>;

... like this:

	power-domains = <&k2g_pds K2G_DEV_UART0>;

Kevin
