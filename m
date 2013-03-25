From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/4] thermal: Add driver for Armada 370/XP SoC thermal
 management
Date: Mon, 25 Mar 2013 19:33:57 +0100
Message-ID: <20130325183357.GB631@lunn.ch>
References: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364225229-2857-2-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:59891 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932472Ab3CYSfB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 14:35:01 -0400
Content-Disposition: inline
In-Reply-To: <1364225229-2857-2-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>

On Mon, Mar 25, 2013 at 12:27:06PM -0300, Ezequiel Garcia wrote:
> This driver supports both Armada 370 and Armada XP SoC
> thermal management controllers.
> 
> Armada 370 has a register to check a valid temperature, whereas
> Armada XP does not. Each has a different initialization (i.e. calibration)
> function. The temperature conversion formula is the same for both.
> 
> The controller present in each SoC have a very similar feature set,
> so it corresponds to have one driver to support both of them.
> 
> Although this driver may present similarities to Dove and Kirkwood
> thermal driver, the exact differences and coincidences are not fully
> known. For this reason, support is given through a separate driver.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/thermal/armada-thermal.txt |   22 ++
>  drivers/thermal/Kconfig                            |    8 +
>  drivers/thermal/Makefile                           |    1 +
>  drivers/thermal/armada_thermal.c                   |  236 ++++++++++++++++++++
>  4 files changed, 267 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/armada-thermal.txt
>  create mode 100644 drivers/thermal/armada_thermal.c
> 
> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> new file mode 100644
> index 0000000..fff93d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> @@ -0,0 +1,22 @@
> +* Marvell Armada 370/XP thermal management
> +
> +Required properties:
> +
> +- compatible:	Should be set to one of the following:
> +		marvell,armada370-thermal
> +		marvell,armadaxp-thermal
> +
> +- reg:		Device's register space.
> +		Two entries are expected, see the examples below.
> +		The first one is required for the sensor register;
> +		the second one is required for the control register
> +		to be used for sensor initialization (a.k.a. calibration).
> +
> +Example:
> +
> +	thermal@d0018300 {
> +		compatible = "marvell,armada370-thermal";
> +                reg = <0xd0018300 0x4
> +		       0xd0018304 0x4>;
> +		status = "okay";
> +	};
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index a764f16..fcd5a27 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -134,6 +134,14 @@ config DOVE_THERMAL
>  	  Support for the Dove thermal sensor driver in the Linux thermal
>  	  framework.
>  
> +config ARMADA_THERMAL
> +	tristate "Armada 370/XP thermal management"
> +	depends on ARCH_MVEBU
> +	depends on OF
> +	help
> +	  Enable this option if you want to have support for thermal management
> +	  controller present in Armada 370 and Armada XP SoC.
> +

Hi Ezequiel

For some unknown reason, the Kconfig entries are in reverse alphabetic
order. So you should insert this entry after DB8500. Same for the Makefile.

       Andrew
