From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: genpd: Add K2G device definitions
Date: Thu, 25 Aug 2016 09:32:47 +0200
Message-ID: <CAPDyKFq2XjO5Tzsp-1EMYp=EWdMLwWmA_ZneGntrGR6LtyHFmw@mail.gmail.com>
References: <20160819235653.26355-1-nm@ti.com> <20160819235653.26355-3-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160819235653.26355-3-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20 August 2016 at 01:56, Nishanth Menon <nm@ti.com> wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
>
> Provide macros representing each devices index as understood by TI
> SCI to be used in the device node power-domain references. These
> are identifiers for the K2G devices managed by the PMMC. Includes
> contributions from Peter Ujfalusi <peter.ujfalusi@ti.com>
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

I would squash this change into patch 1/3, as the DT documentation
patch refers to dt-bindings/genpd/k2g.h which is added in @subject
patch.

Otherwise feel free to add my tag below, which applied to patch 1/3 as well.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  MAINTAINERS                     |  1 +
>  include/dt-bindings/genpd/k2g.h | 90 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 include/dt-bindings/genpd/k2g.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 657fb6a10286..ea14b08c30bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11574,6 +11574,7 @@ F:      Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>  F:     drivers/firmware/ti_sci*
>  F:     include/linux/soc/ti/ti_sci_protocol.h
>  F:     Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> +F:     include/dt-bindings/genpd/k2g.h
>
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:     Hans Verkuil <hverkuil@xs4all.nl>
> diff --git a/include/dt-bindings/genpd/k2g.h b/include/dt-bindings/genpd/k2g.h
> new file mode 100644
> index 000000000000..91ad827e0ca1
> --- /dev/null
> +++ b/include/dt-bindings/genpd/k2g.h
> @@ -0,0 +1,90 @@
> +/*
> + * TI K2G SoC Device definitions
> + *
> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _DT_BINDINGS_GENPD_K2G_H
> +#define _DT_BINDINGS_GENPD_K2G_H
> +
> +/* Documented in http://processors.wiki.ti.com/index.php/TISCI */
> +
> +#define K2G_DEV_PMMC0                  0x0000
> +#define K2G_DEV_MLB0                   0x0001
> +#define K2G_DEV_DSS0                   0x0002
> +#define K2G_DEV_MCBSP0                 0x0003
> +#define K2G_DEV_MCASP0                 0x0004
> +#define K2G_DEV_MCASP1                 0x0005
> +#define K2G_DEV_MCASP2                 0x0006
> +#define K2G_DEV_DCAN0                  0x0008
> +#define K2G_DEV_DCAN1                  0x0009
> +#define K2G_DEV_EMIF0                  0x000a
> +#define K2G_DEV_MMCHS0                 0x000b
> +#define K2G_DEV_MMCHS1                 0x000c
> +#define K2G_DEV_GPMC0                  0x000d
> +#define K2G_DEV_ELM0                   0x000e
> +#define K2G_DEV_SPI0                   0x0010
> +#define K2G_DEV_SPI1                   0x0011
> +#define K2G_DEV_SPI2                   0x0012
> +#define K2G_DEV_SPI3                   0x0013
> +#define K2G_DEV_ICSS0                  0x0014
> +#define K2G_DEV_ICSS1                  0x0015
> +#define K2G_DEV_USB0                   0x0016
> +#define K2G_DEV_USB1                   0x0017
> +#define K2G_DEV_NSS0                   0x0018
> +#define K2G_DEV_PCIE0                  0x0019
> +#define K2G_DEV_GPIO0                  0x001b
> +#define K2G_DEV_GPIO1                  0x001c
> +#define K2G_DEV_TIMER64_0              0x001d
> +#define K2G_DEV_TIMER64_1              0x001e
> +#define K2G_DEV_TIMER64_2              0x001f
> +#define K2G_DEV_TIMER64_3              0x0020
> +#define K2G_DEV_TIMER64_4              0x0021
> +#define K2G_DEV_TIMER64_5              0x0022
> +#define K2G_DEV_TIMER64_6              0x0023
> +#define K2G_DEV_MSGMGR0                        0x0025
> +#define K2G_DEV_BOOTCFG0               0x0026
> +#define K2G_DEV_ARM_BOOTROM0           0x0027
> +#define K2G_DEV_DSP_BOOTROM0           0x0029
> +#define K2G_DEV_DEBUGSS0               0x002b
> +#define K2G_DEV_UART0                  0x002c
> +#define K2G_DEV_UART1                  0x002d
> +#define K2G_DEV_UART2                  0x002e
> +#define K2G_DEV_EHRPWM0                        0x002f
> +#define K2G_DEV_EHRPWM1                        0x0030
> +#define K2G_DEV_EHRPWM2                        0x0031
> +#define K2G_DEV_EHRPWM3                        0x0032
> +#define K2G_DEV_EHRPWM4                        0x0033
> +#define K2G_DEV_EHRPWM5                        0x0034
> +#define K2G_DEV_EQEP0                  0x0035
> +#define K2G_DEV_EQEP1                  0x0036
> +#define K2G_DEV_EQEP2                  0x0037
> +#define K2G_DEV_ECAP0                  0x0038
> +#define K2G_DEV_ECAP1                  0x0039
> +#define K2G_DEV_I2C0                   0x003a
> +#define K2G_DEV_I2C1                   0x003b
> +#define K2G_DEV_I2C2                   0x003c
> +#define K2G_DEV_EDMA0                  0x003f
> +#define K2G_DEV_SEMAPHORE0             0x0040
> +#define K2G_DEV_INTC0                  0x0041
> +#define K2G_DEV_GIC0                   0x0042
> +#define K2G_DEV_QSPI0                  0x0043
> +#define K2G_DEV_ARM_64B_COUNTER0       0x0044
> +#define K2G_DEV_TETRIS0                        0x0045
> +#define K2G_DEV_CGEM0                  0x0046
> +#define K2G_DEV_MSMC0                  0x0047
> +#define K2G_DEV_CBASS0                 0x0049
> +#define K2G_DEV_BOARD0                 0x004c
> +#define K2G_DEV_EDMA1                  0x004f
> +
> +#endif
> --
> 2.9.1.200.gb1ec08f
>
