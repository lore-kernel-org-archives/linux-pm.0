From: Robin Gong <b38343@freescale.com>
Subject: Re: [PATCH v4 0/3] add power off driver for i.mx6
Date: Fri, 17 Oct 2014 16:12:02 +0800
Message-ID: <20141017081200.GB6691@Robin-OptiPlex-780>
References: <1411703947-31956-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411703947-31956-1-git-send-email-b38343@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.com, kernel@pengutronix.de, LW@KARO-electronics.de, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, grant.likely@linaro.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Ping!
On Fri, Sep 26, 2014 at 11:59:04AM +0800, Robin Gong wrote:
> Add simple power off driver for i.mx6, including:
> - add basic imx-snvs-poweroff driver in drivers/power/reset
> - add device node in all dts files of i.mx6.
> - enable in config file
> 
> Change from v3:
> - disable poweroff driver in soc level dts and enable it in board level dts
> - replace 'EIO' with 'ENODEV' while of_iomap fail.
> Change from v2:
> - remove useless included head files
> - split device binding doc from dts patch
> - add description for the case that PMIC_ON_REQ not used as external power
>   control
> 
> Robin Gong (3):
>   ARM: dts: imx6: add pm_power_off support for i.mx6 chips
>   power: reset: imx-snvs-poweroff: add power off driver for i.mx6
>   ARM: configs: imx_v6_v7_defconfig: add power off driver
> 
>  arch/arm/boot/dts/imx6qdl.dtsi          |  5 +++
>  arch/arm/boot/dts/imx6sl.dtsi           |  5 +++
>  arch/arm/boot/dts/imx6sx.dtsi           |  5 +++
>  arch/arm/configs/imx_v6_v7_defconfig    |  3 ++
>  drivers/power/reset/Kconfig             |  5 +++
>  drivers/power/reset/Makefile            |  1 +
>  drivers/power/reset/imx-snvs-poweroff.c | 69 +++++++++++++++++++++++++++++++++
>  7 files changed, 93 insertions(+)
>  create mode 100644 drivers/power/reset/imx-snvs-poweroff.c
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
