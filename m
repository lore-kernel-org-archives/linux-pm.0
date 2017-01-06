From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v11 0/8] power: add power sequence library
Date: Fri, 6 Jan 2017 17:18:41 +0200
Message-ID: <20170106151841.l6ehqmpben4ilkaf@kozik-lap>
References: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35710 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754453AbdAFPSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2017 10:18:53 -0500
Content-Disposition: inline
In-Reply-To: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com, heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, hverkuil@xs4all.nl, krzk@kernel.org

On Thu, Jan 05, 2017 at 02:01:51PM +0800, Peter Chen wrote:
> Hi all,
> 
> This is a follow-up for my last power sequence framework patch set [1].
> According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> power sequence instances will be added at postcore_initcall, the match
> criteria is compatible string first, if the compatible string is not
> matched between dts and library, it will try to use generic power sequence.
> 	 
> The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence instance is needed, for more power sequences
> are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> 
> In future, if there are special power sequence requirements, the special
> power sequence library can be created.
> 
> This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> two hot-plug devices to simulate this use case, the related binding
> change is updated at patch [1/6], The udoo board changes were tested
> using my last power sequence patch set.[3]
> 
> Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> need to power on itself before it can be found by ULPI bus.
> 
> [1] http://www.spinics.net/lists/linux-usb/msg142755.html
> [2] http://www.spinics.net/lists/linux-usb/msg143106.html
> [3] http://www.spinics.net/lists/linux-usb/msg142815.html
> 

Unfortunately I was unable to utilize this library to solve Odroid U3
usb3503/lan9730 power sequence (as a continuation of my old series [0][1]).

The main problem is that power sequence instance (pwrseq_generic.c) is
not a device. I don't get why it is not a device. It would be rather
intuitive to me to make it a device. Also it would make life easier
because you could use all device-like consumer APIs (of getting clocks,
GPIOs etc). Since it is not a device, it is not possible to use
regulator consumer API.

I need a regulator because I need to toggle the power.

Other encountered issue is that power sequence happens early, before the
unused regulators are turned off by the system. However maybe this is
the necessity from other point of view.

My case is annoyingly over-complicated so I am slowly getting sertain
that it is not generic. Anyway it looks like this:

EHCI controller
     |
     |--HSIC0--lan9730 (reset is done only through regulator)
     |--HSIC1--usb3504 (it has a reset GPIO... but it is toggled by
                        usb3504 driver)

Overall, I want to reset the lan9730. This can be done only through
power - buck8. buck8 state is an logical OR of register set by I2C and
GPIO. Thus to turn it off, it is not sufficient just to set register to
0x0 because the GPIO is keeping it on. The best way is to switch the
buck8 to gpio-enable-control thus only GPIO will be toggling it... still
through the regulator consumer API (because it is an GPIO for the
regulator, not for the reset!).

However these two seems coupled. On invalid reset sequence, both chips
die. The usb3504 has its own existing reset sequence and my findings
show that it should happen after lan9730 reset sequence. Otherwise all
devices might be lost...

[0] http://www.spinics.net/lists/linux-mmc/msg37386.html
[1] https://github.com/krzk/linux/commits/for-next/odroid-u3-usb3503-lan-boot-fixes-v4

Best regards,
Krzysztof

> Changes for v11:
> - Fix warning: (USB) selects POWER_SEQUENCE which has unmet direct dependencies (OF)
> - Delete redundant copyright statement.
> - Change pr_warn to pr_debug at wrseq_find_available_instance
> - Refine kerneldoc
> - %s/ENONET/ENOENT 
> - Allocate pwrseq list node before than carry out power sequence on 
> - Add mutex_lock/mutex_lock for pwrseq node browse at pwrseq_find_available_instance
> - Add pwrseq_suspend/resume for API both single instance and list 
> - Add .pwrseq_suspend/resume for pwrseq_generic.c
> - Add pwrseq_suspend_list and pwrseq_resume_list for USB hub suspend
>   and resume routine
> 
> Changes for v10:
> - Improve the kernel-doc for power sequence core, including exported APIs and
>   main structure. [Patch 2/8]
> - Change Kconfig, and let the user choose power sequence. [Patch 2/8]
> - Delete EXPORT_SYMBOL and change related APIs as local, these APIs do not
>   be intended to export currently. [Patch 2/8]
> - Selete POWER_SEQUENCE at USB core's Kconfig. [Patch 4/8]
> 
> Changes for v9:
> - Add Vaibhav Hiremath's reviewed-by [Patch 4/8]
> - Rebase to v4.9-rc1
> 
> Changes for v8:
> - Allocate one extra pwrseq instance if pwrseq_get has succeed, it can avoid
>   preallocate instances problem which the number of instance is decided at
>   compile time, thanks for Heiko Stuebner's suggestion [Patch 2/8]
> - Delete pwrseq_compatible_sample.c which is the demo purpose to show compatible
>   match method. [Patch 2/8]
> - Add Maciej S. Szmigiero's tested-by. [Patch 7/8]
> 
> Changes for v7:
> - Create kinds of power sequence instance at postcore_initcall, and match
>   the instance with node using compatible string, the beneit of this is
>   the host driver doesn't need to consider which pwrseq instance needs
>   to be used, and pwrseq core will match it, however, it eats some memories
>   if less power sequence instances are used. [Patch 2/8]
> - Add pwrseq_compatible_sample.c to test match pwrseq using device_id. [Patch 2/8]
> - Fix the comments Vaibhav Hiremath adds for error path for clock and do not
>   use device_node for parameters at pwrseq_on. [Patch 2/8]
> - Simplify the caller to use power sequence, follows Alan's commnets [Patch 4/8]
> - Tested three pwrseq instances together using both specific compatible string and
>   generic libraries.
> 
> Changes for v6:
> - Add Matthias Kaehlcke's Reviewed-by and Tested-by. (patch [2/6])
> - Change chipidea core of_node assignment for coming user. (patch [5/6])
> - Applies Joshua Clayton's three dts changes for two boards,
>   the USB device's reg has only #address-cells, but without #size-cells.
> 
> Changes for v5:
> - Delete pwrseq_register/pwrseq_unregister, which is useless currently
> - Fix the linker error when the pwrseq user is compiled as module
> 
> Changes for v4:
> - Create the patch on next-20160722 
> - Fix the of_node is not NULL after chipidea driver is unbinded [Patch 5/6]
> - Using more friendly wait method for reset gpio [Patch 2/6]
> - Support multiple input clocks [Patch 2/6]
> - Add Rob Herring's ack for DT changes
> - Add Joshua Clayton's Tested-by
> 
> Changes for v3:
> - Delete "power-sequence" property at binding-doc, and change related code
>   at both library and user code.
> - Change binding-doc example node name with Rob's comments
> - of_get_named_gpio_flags only gets the gpio, but without setting gpio flags,
>   add additional code request gpio with proper gpio flags
> - Add Philipp Zabel's Ack and MAINTAINER's entry
> 
> Changes for v2:
> - Delete "pwrseq" prefix and clock-names for properties at dt binding
> - Should use structure not but its pointer for kzalloc
> - Since chipidea core has no of_node, let core's of_node equals glue
>   layer's at core's probe
> 
> Joshua Clayton (2):
>   ARM: dts: imx6qdl: Enable usb node children with <reg>
>   ARM: dts: imx6q-evi: Fix onboard hub reset line
> 
> Peter Chen (6):
>   binding-doc: power: pwrseq-generic: add binding doc for generic power
>     sequence library
>   power: add power sequence library
>   binding-doc: usb: usb-device: add optional properties for power
>     sequence
>   usb: core: add power sequence handling for USB devices
>   usb: chipidea: let chipidea core device of_node equal's glue layer
>     device of_node
>   ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property
> 
>  .../bindings/power/pwrseq/pwrseq-generic.txt       |  48 +++
>  .../devicetree/bindings/usb/usb-device.txt         |  10 +-
>  MAINTAINERS                                        |   9 +
>  arch/arm/boot/dts/imx6q-evi.dts                    |  25 +-
>  arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  26 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |   6 +
>  drivers/power/Kconfig                              |   1 +
>  drivers/power/Makefile                             |   1 +
>  drivers/power/pwrseq/Kconfig                       |  20 ++
>  drivers/power/pwrseq/Makefile                      |   2 +
>  drivers/power/pwrseq/core.c                        | 335 +++++++++++++++++++++
>  drivers/power/pwrseq/pwrseq_generic.c              | 224 ++++++++++++++
>  drivers/usb/Kconfig                                |   1 +
>  drivers/usb/chipidea/core.c                        |  27 +-
>  drivers/usb/core/hub.c                             |  48 ++-
>  drivers/usb/core/hub.h                             |   1 +
>  include/linux/power/pwrseq.h                       |  81 +++++
>  17 files changed, 823 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>  create mode 100644 include/linux/power/pwrseq.h
> 
> -- 
> 2.7.4
> 
