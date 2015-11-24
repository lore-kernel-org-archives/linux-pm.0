From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
Date: Tue, 24 Nov 2015 21:44:59 +0100
Message-ID: <CAPDyKFqiGe+E6WRELduZJoKwFRkgnFxBvPjEa3jX04EAC3vXrA@mail.gmail.com>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
	<1447956490-22930-3-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36690 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbbKXUpA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 15:45:00 -0500
Received: by ykdr82 with SMTP id r82so33307645ykd.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2015 12:44:59 -0800 (PST)
In-Reply-To: <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vg

[...]

> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 8c53c55..20479d7 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -134,6 +134,16 @@ config ARCH_BCM2835
>           This enables support for the Broadcom BCM2835 SoC. This SoC is
>           used in the Raspberry Pi and Roku 2 devices.
>
> +config RASPBERRYPI_POWER

You don't need a new Kconfig option I think. If you fold in the below
"select" under ARCH_BCM2835, that should work as well, right?

select PM_GENERIC_DOMAINS if (RASPBERRYPI_FIRMWARE && PM && OF)

> +       bool "Raspberry Pi power domain driver"
> +       depends on ARCH_BCM2835
> +       depends on RASPBERRYPI_FIRMWARE
> +       select PM_GENERIC_DOMAINS if PM
> +       select PM_GENERIC_DOMAINS_OF if PM
> +       help
> +         This enables support for the RPi power domains which can be enabled
> +         or disabled via the RPi firmware.
> +
>  config ARCH_BCM_63XX
>         bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
>         depends on MMU
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 892261f..fec2d6b 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -36,6 +36,7 @@ endif
>
>  # BCM2835
>  obj-$(CONFIG_ARCH_BCM2835)     += board_bcm2835.o
> +obj-$(CONFIG_RASPBERRYPI_POWER)        += raspberrypi-power.o

According to above, then this should become:

obj-$(CONFIG_PM_GENERIC_DOMAINS) += raspberrypi-power.o

[...]

Kind regards
Uffe
