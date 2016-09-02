From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/5] Documentation: Add support for TI System Control
 Interface (TI-SCI) protocol
Date: Fri, 2 Sep 2016 10:06:28 -0500
Message-ID: <20160902150628.GA19493@rob-hp-laptop>
References: <20160830130647.6828-1-nm@ti.com>
 <20160830130647.6828-2-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160830130647.6828-2-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 30, 2016 at 08:06:43AM -0500, Nishanth Menon wrote:
> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
> is used in Texas Instrument's System on Chip (SoC) such as those in
> newer SoCs in the keystone processor family starting with K2G.
> 
> This message protocol is used to communicate between various compute
> or processing entities (such as ARM, DSP etc.) with a central system
> controller entity.
> 
> TI-SCI message protocol provides support for management of various
> hardware entities within the SoC.
> 
> The message protocol can be found here:
> http://processors.wiki.ti.com/index.php/TISCI
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
> Changes since v1:
> 	- squashed the bindings changes for reset on review comments from
> 		https://patchwork.kernel.org/patch/9291351/
> 
> V1: https://patchwork.kernel.org/patch/9291343/
> 
>  .../devicetree/bindings/arm/keystone/ti,sci.txt    | 66 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> new file mode 100644
> index 000000000000..ed5b8fc185f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> @@ -0,0 +1,66 @@
> +Texas Instruments System Control Interface (TI-SCI) Message Protocol
> +-------------------------------------------------------------------
> +
> +Texas Instrument's processors including those belonging to Keystone generation
> +of processors have separate hardware entity which is now responsible for the
> +management of the System on Chip (SoC) system. These include various system
> +level functions as well.
> +
> +An example of such an SoC is K2G, which contains the system control hardware
> +block called Power Management Micro Controller (PMMC). This hardware block is
> +initialized early into boot process and provides services to Operating Systems
> +on multiple processors including ones running Linux.
> +
> +See http://processors.wiki.ti.com/index.php/TISCI for protocol definition.
> +
> +TI-SCI controller Device Node:
> +=============================
> +
> +Required properties:
> +--------------------
> +- compatible: should be "ti,k2g-sci"
> +- mbox-names:
> +	"rx" - Mailbox corresponding to receive path
> +	"tx" - Mailbox corresponding to transmit path
> +
> +- mboxes: Mailboxes corresponding to the mbox-names. Each value of the mboxes
> +	  property should contain a phandle to the mailbox controller device
> +	  node and an args specifier that will be the phandle to the intended
> +	  sub-mailbox child node to be used for communication.
> +
> +See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
> +about the generic mailbox controller and client driver bindings. Also see
> +Documentation/devicetree/bindings/mailbox/ti,message-manager.txt for typical
> +controller that is used to communicate with this System controllers.
> +
> +Optional Properties:
> +--------------------
> +- reg-names:
> +	debug_messages - Map the Debug message region
> +- reg:  register space corresponding to the debug_messages
> +- ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
> +
> +Example (K2G):
> +--------
> +	pmmc: pmmc {
> +		compatible = "ti,k2g-sci";
> +		mbox-names = "rx", "tx";
> +		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
> +			<&msgmgr &msgmgr_proxy_pmmc_tx>;
> +		reg-names = "debug_messages";
> +		reg = <0x02921800 0x800>;
> +	};
> +
> +
> +TI-SCI Client Device Node:
> +========================
> +
> +Client nodes refer to the required TI-SCI device using the "ti,sci" property.

As I mentioned for power domains, for clients that are self contained 
(i.e. a single function) I think the should be child nodes.

> +
> +Example (K2G):
> +-------------
> +	my_dev_node: dev_node {
> +		...
> +		ti,sci = <&pmmc>;
> +		...
> +	}
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20bb1d00098c..ce7306897ae0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11564,6 +11564,14 @@ S:	Maintained
>  F:	arch/xtensa/
>  F:	drivers/irqchip/irq-xtensa-*
>  
> +Texas Instruments' System Control Interface (TISCI) Protocol Driver
> +M:	Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> +M:	Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> +M:	Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> +L:	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
>  L:	linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -- 
> 2.9.1.200.gb1ec08f
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
