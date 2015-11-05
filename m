From: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Subject: Re: [RFCv2 2/2] rpi: add support to enable usb power domain
Date: Thu, 5 Nov 2015 08:15:35 +0100
Message-ID: <563B0217.4030307@lategoodbye.de>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446590711-18928-3-git-send-email-alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Alexander,

i think this subject should better start with "ARM:".

Am 03.11.2015 um 23:45 schrieb Alexander Aring:
> This patch adds support for RPi several Power Domains and enable supp=
ort
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He =
had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_D=
EFER
> if we fail to init or turn-on domain").
>
>[...]
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bc=
m2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi=
,bcm2835-power.txt
> new file mode 100644
> index 0000000..c3abc24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-p=
ower.txt
> @@ -0,0 +1,25 @@
> +Raspberry Pi power domain driver
> +
> +Required properties:
> +
> +- compatible:		Should be "raspberrypi,bcm2835-power".
> +- firmware:		Reference to the RPi firmware device node.
> +- #power-domain-cells:	Should be <1>, we providing multiple power do=
mains.
> +
> +The valid defines for power domain are:
> +
> + RPI_POWER_DOMAIN_USB
> +
> +Example:
> +
> +power: power {
> +	compatible =3D "raspberrypi,bcm2835-power";
> +	firmware =3D <&firmware>;
> +	#power-domain-cells =3D <1>;
> +};
> +
> +Example for using power domain:
> +
> +&usb {
> +       power-domains =3D <&power RPI_POWER_DOMAIN_USB>;
> +};

Refering to Documentation/devicetree/bindings/submitting-patches.txt=20
binding doc should be a separate patch.

> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/b=
cm2835-rpi.dtsi
> index ab5474e..d9b16d1 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -1,3 +1,4 @@
> +#include <dt-bindings/arm/raspberrypi-power.h>
>   #include "bcm2835.dtsi"
>
>   / {
> @@ -20,6 +21,12 @@
>   			compatible =3D "raspberrypi,bcm2835-firmware";
>   			mboxes =3D <&mailbox>;
>   		};
> +
> +		power: power {
> +			compatible =3D "raspberrypi,bcm2835-power";
> +			firmware =3D <&firmware>;
> +			#power-domain-cells =3D <1>;
> +		};
>   	};
>   };
>
> @@ -56,3 +63,7 @@
>   	status =3D "okay";
>   	bus-width =3D <4>;
>   };
> +
> +&usb {
> +	power-domains =3D <&power RPI_POWER_DOMAIN_USB>;
> +};
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm28=
35.dtsi
> index 301c73f..3c899b3 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -149,7 +149,7 @@
>   			status =3D "disabled";
>   		};
>
> -		usb@7e980000 {
> +		usb: usb@7e980000 {
>   			compatible =3D "brcm,bcm2835-usb";
>   			reg =3D <0x7e980000 0x10000>;
>   			interrupts =3D <1 9>;
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 1319c3c..244475e5 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -120,6 +120,16 @@ config ARCH_BCM2835
>   	  This enables support for the Broadcom BCM2835 SoC. This SoC is
>   	  used in the Raspberry Pi and Roku 2 devices.
>
> +config RASPBERRY_POWER

RASPBERRYPI_POWER?

> +	bool "Raspberry Pi power domain driver"
> +	depends on ARCH_BCM2835
> +	depends on RASPBERRYPI_FIRMWARE
> +	select PM_GENERIC_DOMAINS if PM

Since PM_GENERIC_DOMAINS_OF depends on PM_GENERIC_DOMAINS this line=20
should be redundant.

> +	select PM_GENERIC_DOMAINS_OF if PM
> +	help
> +	  This enables support for the RPi power domains which can be enabl=
ed
> +	  or disabled via the RPi firmware.
> +
>   config ARCH_BCM_63XX
>   	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
>   	depends on MMU
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 1780a3f..283295e 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -33,6 +33,7 @@ endif
>
>   # BCM2835
>   obj-$(CONFIG_ARCH_BCM2835)	+=3D board_bcm2835.o
> +obj-$(CONFIG_RASPBERRY_POWER)	+=3D raspberrypi-power.o
>
>   # BCM5301X
>   obj-$(CONFIG_ARCH_BCM_5301X)	+=3D bcm_5301x.o
> diff --git a/arch/arm/mach-bcm/raspberrypi-power.c b/arch/arm/mach-bc=
m/raspberrypi-power.c
> new file mode 100644
> index 0000000..531300f
> --- /dev/null
> +++ b/arch/arm/mach-bcm/raspberrypi-power.c
> @@ -0,0 +1,180 @@
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Authors:
> + * (C) 2015 Pengutronix, Alexander Aring <aar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + * Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pm_domain.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>

Please sort alphabetical.

> +#include <dt-bindings/arm/raspberrypi-power.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define RPI_POWER_DOMAIN(_domain, _name)			\
> +	[_domain] =3D {						\
> +		.domain =3D _domain,				\
> +		.enabled =3D true,				\
> +		.base =3D {					\
> +			.name =3D _name,				\
> +			.power_off =3D raspberrypi_domain_off,	\
> +			.power_on =3D raspberrypi_domain_on,	\
> +		},						\
> +	}
> +
> +struct raspberrypi_power_domain {
> +	u32 domain;
> +	bool enabled;
> +	struct generic_pm_domain base;
> +};
> +
> +struct rpi_power_domain_packet {
> +	u32 domain;
> +	u32 on;
> +} __packet;

It would be nice to use consequently rpi_ as prefix instead of=20
raspberrypi_ .

>  [...]
> diff --git a/include/dt-bindings/arm/raspberrypi-power.h b/include/dt=
-bindings/arm/raspberrypi-power.h
> new file mode 100644
> index 0000000..51f0772
> --- /dev/null
> +++ b/include/dt-bindings/arm/raspberrypi-power.h
> @@ -0,0 +1,14 @@
> +/*
> + *  Copyright =C2=A9 2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H
> +#define _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H

This needs renaming.

Thanks
Stefan

> +
> +#define RPI_POWER_DOMAIN_USB	3
> +
> +#endif /* _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H */
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
