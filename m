From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 2/4] ARM: Kirkwood: Add support thermal sensor for
 88F6282 and 88F6283
Date: Mon, 04 Feb 2013 11:14:53 +0800
Message-ID: <1359947693.2250.50.camel@rzhang1-mobl4>
References: <1359815749-27705-1-git-send-email-andrew@lunn.ch>
	 <1359815749-27705-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36877 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753757Ab3BDDO6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 3 Feb 2013 22:14:58 -0500
In-Reply-To: <1359815749-27705-3-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

On Sat, 2013-02-02 at 15:35 +0100, Andrew Lunn wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> Kirkwood 88F6282 and 88F6283 have a thermal sensor.
> This patch adds a DT node and enables the driver in the kernel config.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

I can take this one but I need ACK from ARM experts first.

thanks,
rui
> ---
>  arch/arm/boot/dts/kirkwood-6282.dtsi |    6 ++++++
>  arch/arm/configs/kirkwood_defconfig  |    2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
> index 4ccea21..bd168b6 100644
> --- a/arch/arm/boot/dts/kirkwood-6282.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
> @@ -32,6 +32,12 @@
>  			};
>  		};
>  
> +		thermal@10078 {
> +			compatible = "marvell,kirkwood-thermal";
> +			reg = <0x10078 0x4>;
> +			status = "okay";
> +		};
> +
>  		i2c@11100 {
>  			compatible = "marvell,mv64xxx-i2c";
>  			reg = <0x11100 0x20>;
> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> index 93f3794..3d8667f 100644
> --- a/arch/arm/configs/kirkwood_defconfig
> +++ b/arch/arm/configs/kirkwood_defconfig
> @@ -118,6 +118,8 @@ CONFIG_SPI=y
>  CONFIG_SPI_ORION=y
>  CONFIG_GPIO_SYSFS=y
>  # CONFIG_HWMON is not set
> +CONFIG_THERMAL=y
> +CONFIG_KIRKWOOD_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_ORION_WATCHDOG=y
>  CONFIG_HID_DRAGONRISE=y


