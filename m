From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 11/16] ARM: mvebu: dts: Add CA9 MPcore SoC Controller
 node
Date: Mon, 30 Jun 2014 17:37:55 +0200
Message-ID: <20140630173755.32793586@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-12-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56060 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753600AbaF3Ph7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 11:37:59 -0400
In-Reply-To: <1403875377-940-12-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Gregory,

On Fri, 27 Jun 2014 15:22:52 +0200, Gregory CLEMENT wrote:
> The CA9 MPcore SoC Control block allows to do some configuration that
> the SoC could use for a specific use case. In most cases the defaults
> case is enough. However there is few exception: for cpuidle we need to
> use the CA9 MPcore Reset Control register.

I'd reword this to something like:

"""
The CA9 MPcore SoC Control block is a set of registers that allows to
configure certain internal aspects of the core blocks of the SoC
(Cortex-A9, L2 cache controller, etc.). In most cases, the default
values are fine so they aren't many reasons to touch those registers,
but there is one exception: to support cpuidle on Armada 38x, we need
to modify the value of the CA9 MPcore Reset Control register.

Therefore, this commit adds a new Device Tree binding for this hardware
block, and uses this new binding for the Armada 38x Device Tree file.

"""

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt | 14 ++++++++++++++
>  arch/arm/boot/dts/armada-38x.dtsi                          |  5 +++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt b/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
> new file mode 100644
> index 000000000000..0a2df51ba560
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
> @@ -0,0 +1,14 @@
> +Marvell Armada 38x CA9 MPcore SoC Controller
> +============================================
> +
> +Required properties:
> +
> +- compatible: Should be "marvell,armada-380-mpcore-soc-ctrl".
> +
> +- reg: should be register base and length as documented in the

should be *the* register base and length

> +  datasheet for the CA9 MPcore SoC Control registers
> +
> +mpcore-soc-ctrl@20d20 {
> +	compatible = "marvell,armada-380-mpcore-soc-ctrl";
> +	reg = <0x20d20 0x6c>;
> +};
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 689fa1a46728..242d0ecc99f3 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -286,6 +286,11 @@
>  				reg = <0x20800 0x10>;
>  			};
>  
> +			mpcore-soc-ctrl@20d20 {
> +				compatible = "marvell,armada-380-mpcore-soc-ctrl";
> +				reg = <0x20d20 0x6c>;
> +			};
> +
>  			coherency-fabric@21010 {
>  				compatible = "marvell,armada-380-coherency-fabric";
>  				reg = <0x21010 0x1c>;

With those fixed:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
