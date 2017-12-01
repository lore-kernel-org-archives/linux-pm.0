From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 06/13] dt-bindings: power: reset: Document ocelot-reset
 binding
Date: Thu, 30 Nov 2017 19:54:08 -0600
Message-ID: <20171201015408.gg5di47m7nic57cz@rob-hp-laptop>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-7-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34999 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdLAByK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Nov 2017 20:54:10 -0500
Content-Disposition: inline
In-Reply-To: <20171128152643.20463-7-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Nov 28, 2017 at 04:26:36PM +0100, Alexandre Belloni wrote:
> Add binding documentation for the Microsemi Ocelot reset block.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> To: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> 
>  .../bindings/power/reset/ocelot-reset.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> new file mode 100644
> index 000000000000..2d3f2c21fadd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> @@ -0,0 +1,24 @@
> +Microsemi Ocelot reset driver

Bindings are not drivers.

> +
> +The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
> +SoC MIPS core.
> +
> +Required Properties:
> + - compatible: "mscc,ocelot-chip-reset"
> + - mscc,cpucontrol: phandle to the CPU system control syscon block
> +
> +Example:
> +		cpu_ctrl: syscon@70000000 {
> +			compatible = "syscon";

syscon alone is not valid.

> +			reg = <0x70000000 0x2c>;
> +		};
> +
> +		syscon@71070000 {
> +			compatible = "simple-mfd", "syscon";

SoC specific compatible?

> +			reg = <0x71070000 0x1c>;
> +
> +			reset {
> +				compatible = "mscc,ocelot-chip-reset";
> +				mscc,cpucontrol = <&cpu_ctrl>;

This looks strange. A syscon pointing to another syscon?

Doesn't look like you even need this node, but hard to know if you don't 
document the parent node completely (i.e. what are all the functions in 
this syscon).

> +			};
> +		};
> -- 
> 2.15.0
> 
