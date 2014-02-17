From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 07/13] ARM: dts: mvebu: Add a new set of registers
 to the PMSU node
Date: Sun, 16 Feb 2014 21:57:05 -0500
Message-ID: <20140217025705.GJ7862@titan.lakedaemon.net>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
 <1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59292 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750805AbaBQC5W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Feb 2014 21:57:22 -0500
Content-Disposition: inline
In-Reply-To: <1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Thu, Feb 13, 2014 at 06:33:30PM +0100, Gregory CLEMENT wrote:
> The Power Management Unit Service block also controls the Coherency
> Fabric subsystem. This new set of registers is needed for the CPU idle
> implementation for the Armada XP, it allows to enter in a deep CPU
> idle state where the Coherency Fabric and the L2 cache are powerdown.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt | 12 +++++++-----
>  arch/arm/boot/dts/armada-xp.dtsi                             |  2 +-
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
> index 926b4d6aae7e..8a9db0c32ba5 100644
> --- a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
> +++ b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
> @@ -7,14 +7,16 @@ Required properties:
>  - compatible: "marvell,armada-370-xp-pmsu"
>  
>  - reg: Should contain PMSU registers location and length. First pair
> -  for the per-CPU SW Reset Control registers, second pair for the
> -  Power Management Service Unit.
> +  for the per-CPU SW Reset Control registers, second pair for the CPU
> +  Power Management Service Unit registers, third pair for the Fabric Power
> +  Management Service Unit registers.

Please mention explicitly that previous versions of this binding only
specified the first two registers.  I haven't dug through the rest of
this series yet, but I assume the driver will behave sanely when
encountering an old dtb w/o the third reg entry?

thx,

Jason.

>  
>  Example:
>  
> -armada-370-xp-pmsu@d0022000 {
> +armada-370-xp-pmsu@22000 {
>  	compatible = "marvell,armada-370-xp-pmsu";
> -	reg = <0xd0022100 0x430>,
> -	      <0xd0020800 0x20>;
> +	reg = <0x22100 0x430>,
> +	      <0x20800 0x20>,
> +	      <0x22000 0x24>;
>  };
>  
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index b8b84a22f0f3..f717da4f4d97 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -113,7 +113,7 @@
>  
>  			armada-370-xp-pmsu@22000 {
>  				compatible = "marvell,armada-370-xp-pmsu";
> -				reg = <0x22100 0x400>, <0x20800 0x20>;
> +				reg = <0x22100 0x400>, <0x20800 0x20>, <0x22000 0x24>;
>  			};
>  
>  			eth2: ethernet@30000 {
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
