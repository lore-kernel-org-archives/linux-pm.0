From: Anand Moon <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] ARM: exynos: Fix Odroid U3 USB/LAN when TFTP booting
 (power sequence)
Date: Mon, 9 Jan 2017 23:34:48 +0530
Message-ID: <CANAwSgSEZvxHje65Kk13fvD9NZGB+iHCJtoGJdQrUdS42ei_WA@mail.gmail.com>
References: <20170107085203.4431-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170107085203.4431-1-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, Markus
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 7 January 2017 at 14:21, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> Thanks to Markus Reichl, I got an Odroid U3 to work with. Thanks to Peter
> Chen, we got a power sequence generic library which solves my long
> standing Odroid U3 problem - no LAN9730 if it was enabled by bootloader.
>
> My previous attempts for this can be found here [0].
>
> This patchset is based on Peter's v11 of power sequence [1].
> Patchset is available also on my Github [2].
>
> More detailed analysis is described in patch 2/4 ("ARM: dts: exynos: Fix
> LAN9730 on Odroid U3 after tftpboot").
>
>

[snip]

On which u-boot should this be tested.

On HK u-boot tftp boot is not supported.
----------------------------------------------------------
U-Boot 2010.12-00000-g9777ca6-dirty (Nov 26 2015 - 10:10:11) for Exynox4412


CPU: S5PC220 [Samsung SOC on SMP Platform Base on ARM CortexA9]
APLL = 1000MHz, MPLL = 800MHz
DRAM:  2 GiB

PMIC VERSION : 0x00, CHIP REV : 2
TrustZone Enabled BSP
BL1 version: 20121128


Checking Boot Mode ... SDMMC
MMC Device 0: 14804 MB
MMC Device 1 not found
*** Warning - using default environment

USB3503 NINT = OUTPUT LOW!
ModeKey Check... run normal_boot
No ethernet found.
Hit any key to stop autoboot:  0
Exynos4412 #
Exynos4412 #
Exynos4412 #
Exynos4412 # usb start
(Re)start USB...
USB0:   Exynos4412-ehci: init hccr 12580000 and hcor 12580010 hc_length 16
usb: usb_refclk_enable is active low: NO
ProTIP: If usb doesn't work - try playing with 'usb_invert_clken' environment
USB EHCI 1.00
scanning bus 0 for devices... EHCI timed out on TD - token=0x80008c80
EHCI fail timeout STS_ASS set

      USB device not accepting new address (error=80000000)
EHCI fail timeout STS_ASS set
1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
       scanning usb for ethernet devices... 0 Ethernet Device(s) found
Exynos4412 #

Best Regards
-Anand
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
