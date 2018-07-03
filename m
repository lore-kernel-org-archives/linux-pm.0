From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 17/23] dt-bindings: cp110: add the thermal node in the
 syscon file
Date: Tue, 3 Jul 2018 15:14:35 -0600
Message-ID: <20180703211435.GA11282@rob-hp-laptop>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-18-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180625151239.20976-18-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 25, 2018 at 05:12:33PM +0200, Miquel Raynal wrote:
> Explain the thermal bindings now that the thermal IP is described being
> inside of a system controller. Add a reference to the thermal-zone node.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../arm/marvell/cp110-system-controller.txt        | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> index 54b0d64ce819..cd4a7a57491e 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> @@ -11,6 +11,9 @@ For the top level node:
>   - compatible: must be: "syscon", "simple-mfd";
>   - reg: register area of the CP110 system controller
>  
> +SYSTEM CONTROLLER 0
> +===================
> +
>  Clocks:
>  -------
>  
> @@ -186,3 +189,37 @@ CP110_LABEL(syscon0): system-controller@440000 {
>  	};
>  
>  };
> +
> +SYSTEM CONTROLLER 1
> +===================
> +
> +Thermal:
> +--------
> +
> +The thermal IP can probe the temperature all around the processor. It
> +may feature several channels, each of them wired to one sensor.
> +
> +For common binding part and usage, refer to
> +Documentation/devicetree/bindings/thermal/thermal.txt
> +
> +Required properties:
> +- compatible: must be one of:
> +  * marvell,armada-cp110-thermal
> +- reg: register range associated with the thermal functions.
> +
> +Optional properties:
> +- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
> +  to this IP and represents the channel ID. There is one sensor per
> +  channel. O refers to the thermal IP internal channel.
> +
> +Example:
> +CP110_LABEL(syscon1): system-controller@6f8000 {
> +	compatible = "syscon", "simple-mfd";
> +	reg = <0x6f8000 0x1000>;
> +
> +	CP110_LABEL(thermal): ap-thermal@70 {

thermal-sensor@...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		compatible = "marvell,armada-cp110-thermal";
> +		reg = <0x70 0x10>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +};
> -- 
> 2.14.1
> 
