From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH v3 0/6] power: add power sequence library
Date: Thu, 28 Jul 2016 08:56:40 -0700
Message-ID: <579A2B38.3000202@gmail.com>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34812 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758868AbcG1P4p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 11:56:45 -0400
In-Reply-To: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

Hi, Peter

On 07/20/2016 02:40 AM, Peter Chen wrote:
> Hi all,
>
> This is a follow-up for my last power sequence framework patch set [1].
> According to Rob Herring and Ulf Hansson's comments[2], I use a generic
> power sequence library for parsing the power sequence elements on DT,
> and implement generic power sequence on library. The host driver
> can allocate power sequence instance, and calls pwrseq APIs accordingly.
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
> Peter Chen (6):
>   binding-doc: power: pwrseq-generic: add binding doc for generic power
>     sequence library
>   power: add power sequence library
>   binding-doc: usb: usb-device: add optional properties for power
>     sequencediff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
> index 9780877..da36b78 100644
> --- a/drivers/usb/core/Makefile
> +++ b/drivers/usb/core/Makefile
> @@ -5,8 +5,9 @@
>  usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
> -usbcore-y += port.o of.o
> +usbcore-y += port.o
>  
> +usbcore-$(CONFIG_OF)		+= of.o
>  usbcore-$(CONFIG_PCI)		+= hcd-pci.o
>  usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
>  
> diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
> index 2289700..3de4f88 100644
> --- a/drivers/usb/core/of.c
> +++ b/drivers/usb/core/of.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include <linux/of.h>
> +#include <linux/usb/of.h>
>   usb: core: add power sequence handling for USB devices
>   usb: chipidea: let chipidea core device of_node equal's glue layer
>     device of_node
>   ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property
>
>  .../bindings/power/pwrseq/pwrseq-generic.txt       |  48 +++++++
>  .../devicetree/bindings/usb/usb-device.txt         |  10 +-
>  MAINTAINERS                                        |   9 ++
>  arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  26 ++--
>  drivers/power/Kconfig                              |   1 +
>  drivers/power/Makefile                             |   1 +
>  drivers/power/pwrseq/Kconfig                       |  20 +++
>  drivers/power/pwrseq/Makefile                      |   2 +
>  drivers/power/pwrseq/core.c                        |  71 ++++++++++
>  drivers/power/pwrseq/pwrseq_generic.c              | 151 +++++++++++++++++++++
>  drivers/usb/chipidea/core.c                        |  10 ++
>  drivers/usb/core/Makefile                          |   1 +
>  drivers/usb/core/hub.c                             |  12 +-
>  drivers/usb/core/hub.h                             |  12 ++
>  drivers/usb/core/pwrseq.c                          | 100 ++++++++++++++
>  include/linux/power/pwrseq.h                       |  50 +++++++
>  16 files changed, 507 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>  create mode 100644 drivers/usb/core/pwrseq.c
>  create mode 100644 include/linux/power/pwrseq.h
>

With these patches our on-board USB hub,
a Microchip USB2513BI-AEZG,  works exactly as it does
with the fake regulator kludge, so...
Tested-by Joshua Clayton <stillcompiling@gmail.com>

I assume there is a v4 coming due to rmk's comments on patch 5.
I couldn't figure out where to null the of_node in error paths, but in testing
we did put a line of code to null the of_node on release.

but...
As an aside,
I was hoping this series would magically fix a problem
with the imx6q-evi which has forced us to disable
runtime power management. But it did not. :(

If runtime power management is enabled,  when nothing is
connected to the hub it disconnects and immediately reconnects
about every 2 seconds, and after some seemingly random number
of these events the whole system hangs (possibly udev related?).

Our board has the vbus detect on the hub connected directly to 3.3v,
rather than to the imx6's usbh1_vbus line. This is listed as a supported
configuration, but might be the source of the problem.

Thanks,
Joshua
