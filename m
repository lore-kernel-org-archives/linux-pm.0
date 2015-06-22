From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/7] soc: brcmstb: add system suspend support for STB SoCs
Date: Mon, 22 Jun 2015 12:47:14 -0700
Message-ID: <20150622194714.GM4917@ld-irv-0074>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

+ others

On Thu, Jun 18, 2015 at 05:11:29PM -0700, Brian Norris wrote:
> Hi,
> 
> This patch set introduces system suspend/resume support for Broadcom STB SoCs.
> There are two suspend modes (S2 and S3) as well as a related low-power shutdown
> mode (S5).
> 
> Along with the core PM support, include a driver for the wakeup-timer, which
> allows for simple testing of suspend/resume wakeup cycles.
> 
> Brian

Somehow I completely missed out on sending this to a few of the right
places, like linux-pm and the PM maintainers. I guess I just trusted
get_maintainer.pl (which doesn't know what to do with drivers/soc/) too
much, and forgot to turn my brain on...

Anyway, if y'all can track down the patches via archives, feel free. Or
I will resend this shortly as a v2, with a few suggested fixes and with
a more complete CC list.

Regards,
Brian

> Brian Norris (7):
>   Documentation: dt: brcmstb: add system PM bindings
>   Documentation: dt: brcmstb: add waketimer documentation
>   soc: add stubs for brcmstb SoC's
>   soc: brcmstb: add PM suspend/resume support (S2/S3/S5)
>   soc: brcmstb: add wake-timer driver
>   ARM: brcmstb: mask GIC IRQs on suspend
>   ARM: dts: brcmstb: add BCM7445 system PM DT nodes
> 
>  .../ABI/testing/sysfs-driver-wktmr-brcmstb         |  12 +
>  .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   | 142 +++++-
>  .../soc/brcmstb/brcm,brcmstb-waketimer.txt         |  20 +
>  arch/arm/boot/dts/bcm7445.dtsi                     | 102 ++++
>  arch/arm/mach-bcm/Kconfig                          |   1 +
>  arch/arm/mach-bcm/brcmstb.c                        |  10 +
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/brcmstb/Kconfig                        |  22 +
>  drivers/soc/brcmstb/Makefile                       |   4 +
>  drivers/soc/brcmstb/common.c                       |  33 ++
>  drivers/soc/brcmstb/pm/Makefile                    |   1 +
>  drivers/soc/brcmstb/pm/aon_defs.h                  |  85 ++++
>  drivers/soc/brcmstb/pm/pm.c                        | 512 +++++++++++++++++++++
>  drivers/soc/brcmstb/pm/pm.h                        |  40 ++
>  drivers/soc/brcmstb/pm/s2.S                        |  73 +++
>  drivers/soc/brcmstb/wktmr.c                        | 242 ++++++++++
>  include/soc/brcmstb/common.h                       |  15 +
>  18 files changed, 1314 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-wktmr-brcmstb
>  create mode 100644 Documentation/devicetree/bindings/soc/brcmstb/brcm,brcmstb-waketimer.txt
>  create mode 100644 drivers/soc/brcmstb/Kconfig
>  create mode 100644 drivers/soc/brcmstb/Makefile
>  create mode 100644 drivers/soc/brcmstb/common.c
>  create mode 100644 drivers/soc/brcmstb/pm/Makefile
>  create mode 100644 drivers/soc/brcmstb/pm/aon_defs.h
>  create mode 100644 drivers/soc/brcmstb/pm/pm.c
>  create mode 100644 drivers/soc/brcmstb/pm/pm.h
>  create mode 100644 drivers/soc/brcmstb/pm/s2.S
>  create mode 100644 drivers/soc/brcmstb/wktmr.c
>  create mode 100644 include/soc/brcmstb/common.h
> 
> -- 
> 1.9.1
> 
