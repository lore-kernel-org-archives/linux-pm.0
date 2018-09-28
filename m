From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: add LX2160ARDB board support
Date: Fri, 28 Sep 2018 14:37:15 -0500
Message-ID: <CADRPPNS1Zj=47M-yOBAJ=X=sjjxmh0k7tNcj1A8uY=cPM398tQ@mail.gmail.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com> <1537747741-6245-7-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537747741-6245-7-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vabhav.sharma@nxp.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, Scott Wood <oss@buserror.net>, lkml <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundati>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 24, 2018 at 7:51 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.

Please send next version with Shawn Guo and me in the "to" recipient
so that its less likely we will miss it.

>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |  1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 88 +++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 86e18ad..445b72b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> new file mode 100644
> index 0000000..1bbe663
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2160ARDB
> +//
> +// Copyright 2018 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +       model = "NXP Layerscape LX2160ARDB";
> +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       i2c-mux@77 {
> +               compatible = "nxp,pca9547";
> +               reg = <0x77>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +
> +                       power-monitor@40 {
> +                               compatible = "ti,ina220";
> +                               reg = <0x40>;
> +                               shunt-resistor = <1000>;
> +                       };
> +               };
> +
> +               i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +
> +                       temperature-sensor@4c {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4c>;

Need a vcc-supply property according to the binding.

> +                       };
> +
> +                       temperature-sensor@4d {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4d>;

Ditto.

> +                       };
> +               };
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +
> +       rtc@51 {
> +               compatible = "nxp,pcf2129";
> +               reg = <0x51>;
> +               // IRQ10_B
> +               interrupts = <0 150 0x4>;
> +               };
> +
> +};
> +
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> +
> +&crypto {
> +       status = "okay";
> +};
> --
> 2.7.4
>
