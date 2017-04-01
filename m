From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
Date: Sat, 1 Apr 2017 12:51:38 -0700
Message-ID: <20170401195136.GD28514@localhost.localdomain>
References: <20170331073132.21457-2-zajec5@gmail.com>
 <20170331201124.656-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36368 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdDATvn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 15:51:43 -0400
Content-Disposition: inline
In-Reply-To: <20170331201124.656-1-zajec5@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>

Rafal,

On Fri, Mar 31, 2017 at 10:11:23PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This commit documents binding for thermal used in Northstar family SoCs.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V3: Add thermal-zones to the example
>     Rob: Because of this update, I didn't include Acked-by I got for V2
> ---
>  .../devicetree/bindings/thermal/brcm,ns-thermal    | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> new file mode 100644
> index 000000000000..c561c7349f17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> @@ -0,0 +1,26 @@
> +* Broadcom Northstar Thermal
> +
> +This binding describes thermal sensor that is part of Northstar's DMU (Device
> +Management Unit).
> +
> +Required properties:
> +- compatible : Must be "brcm,ns-thermal"
> +- reg : iomem address range of PVTMON registers
> +- #thermal-sensor-cells : Should be <0>
> +
> +Example:
> +
> +thermal: thermal@1800c2c0 {
> +	compatible = "brcm,ns-thermal";
> +	reg = <0x1800c2c0 0x10>;
> +	#thermal-sensor-cells = <0>;
> +};
> +
> +thermal-zones {
> +	cpu_thermal: cpu-thermal {
> +		polling-delay-passive = <0>;
> +		polling-delay = <1000>;
> +		coefficients = <(-556) 418000>;
> +		thermal-sensors = <&thermal>;

You need to define trips and cooling devices here. Otherwise, makes
little sense to have this device in thermal subsystem. Here is an
example of minimal set:
https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=linus&id=1e2ac9821de6a85d3e8358f238436708d1d46869

The above has no passive action. It is just gonna shutdown the system if
temperature crosses a threshold. 

But, a typical cooling device would be CPU frequency throttling. Do you have
that up and running in your routers?

> +	};
> +};
> -- 
> 2.11.0
> 
