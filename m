From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Date: Wed, 27 Feb 2019 17:54:55 -0600
Message-ID: <20190227235455.GA15211@bogus>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de" <heiko@sn>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 27, 2019 at 08:46:21AM +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V9:
> 	- change #thermal-sensor-cells value in example to 1, since there are other
> 	  thermal sensors inside system controller, it is just because there are still
> 	  some issue, so system controller does NOT expose them for now, they could
> 	  be exposed later, so it should be 1 from HW perspective.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 72d481c..855270b 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -122,6 +122,21 @@ RTC bindings based on SCU Message Protocol
>  Required properties:
>  - compatible: should be "fsl,imx8qxp-sc-rtc";
>  
> +Thermal bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible:			Should be :
> +				  "fsl,imx8qxp-sc-thermal"
> +				followed by "fsl,imx-sc-thermal";
> +
> +- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
> +				for a description.
> +
> +- imx,sensor-resource-id: 	A single integer for single thermal zone's resource ID or
> +				an array of integers to specify each thermal zone's sensor
> +				resource ID.

Can't you put the resource ids in the thermal-sensor cells? Why do you 
need to list them here?

Rob
