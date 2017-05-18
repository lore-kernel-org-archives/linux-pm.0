From: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v14 0/7] power: add power sequence library
Date: Thu, 18 May 2017 08:48:56 +0800
Message-ID: <1495068543-6938-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, jun.li-3arQi8VN3Tc@public.gmane.org, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This is a follow-up for my last power sequence framework patch set [1].
According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
power sequence instances will be added at postcore_initcall, the match
criteria is compatible string first, if the compatible string is not
matched between dts and library, it will try to use generic power sequence.
	 
The host driver just needs to call of_pwrseq_on/of_pwrseq_off
if only one power sequence instance is needed, for more power sequences
are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).

In future, if there are special power sequence requirements, the special
power sequence library can be created.

This patch set is tested on i.mx6 sabresx evk using a dts change, I use
two hot-plug devices to simulate this use case, the related binding
change is updated at patch [1/6], The udoo board changes were tested
using my last power sequence patch set.[3]

Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
need to power on itself before it can be found by ULPI bus.

Changes for v14:
- Rebase for v4.12-rc1
- Delete some USB sysdev patches which has already merged

Changes for v13:
- Add more design descriptions at design doc and fix one build error
  introduced by v12 wrongly [Patch 2/12]
- Add the last three dts patches which were forgotten at last series
- Move the comment for usb_create_shared_hcd to correct place [Patch 3/12]
- Add sysdev for shared hcd too for xhci-plat.c [Patch 6/12]

Rafael, if the first two power sequence patches are ok for you, would you consider
accept these first, the other USB patches can go through USB tree at v4.12-rc1?

Changes for v12:
- Add design doc and more comments at generic power sequence source file [Patch 2/9]
- Introduce four Arnd Bergmann patches and one my ehci related patches, these patches
  are used to get property DT/firmware information at USB code, and these information
  are needed for power sequence operation at USB. With these five patches, my chipidea
  hack patch in previous patch set can be removed. [Patch 3-7/9]
- Add -ENOENT judgement to avoid USB error if no power sequence library is chosen [9/9]

Changes for v11:
- Fix warning: (USB) selects POWER_SEQUENCE which has unmet direct dependencies (OF)
- Delete redundant copyright statement.
- Change pr_warn to pr_debug at wrseq_find_available_instance
- Refine kerneldoc
- %s/ENONET/ENOENT 
- Allocate pwrseq list node before than carry out power sequence on 
- Add mutex_lock/mutex_lock for pwrseq node browse at pwrseq_find_available_instance
- Add pwrseq_suspend/resume for API both single instance and list 
- Add .pwrseq_suspend/resume for pwrseq_generic.c
- Add pwrseq_suspend_list and pwrseq_resume_list for USB hub suspend
  and resume routine

Changes for v10:
- Improve the kernel-doc for power sequence core, including exported APIs and
  main structure. [Patch 2/8]
- Change Kconfig, and let the user choose power sequence. [Patch 2/8]
- Delete EXPORT_SYMBOL and change related APIs as local, these APIs do not
  be intended to export currently. [Patch 2/8]
- Selete POWER_SEQUENCE at USB core's Kconfig. [Patch 4/8]

Changes for v9:
- Add Vaibhav Hiremath's reviewed-by [Patch 4/8]
- Rebase to v4.9-rc1

Changes for v8:
- Allocate one extra pwrseq instance if pwrseq_get has succeed, it can avoid
  preallocate instances problem which the number of instance is decided at
  compile time, thanks for Heiko Stuebner's suggestion [Patch 2/8]
- Delete pwrseq_compatible_sample.c which is the demo purpose to show compatible
  match method. [Patch 2/8]
- Add Maciej S. Szmigiero's tested-by. [Patch 7/8]

Changes for v7:
- Create kinds of power sequence instance at postcore_initcall, and match
  the instance with node using compatible string, the beneit of this is
  the host driver doesn't need to consider which pwrseq instance needs
  to be used, and pwrseq core will match it, however, it eats some memories
  if less power sequence instances are used. [Patch 2/8]
- Add pwrseq_compatible_sample.c to test match pwrseq using device_id. [Patch 2/8]
- Fix the comments Vaibhav Hiremath adds for error path for clock and do not
  use device_node for parameters at pwrseq_on. [Patch 2/8]
- Simplify the caller to use power sequence, follows Alan's commnets [Patch 4/8]
- Tested three pwrseq instances together using both specific compatible string and
  generic libraries.

Changes for v6:
- Add Matthias Kaehlcke's Reviewed-by and Tested-by. (patch [2/6])
- Change chipidea core of_node assignment for coming user. (patch [5/6])
- Applies Joshua Clayton's three dts changes for two boards,
  the USB device's reg has only #address-cells, but without #size-cells.

Changes for v5:
- Delete pwrseq_register/pwrseq_unregister, which is useless currently
- Fix the linker error when the pwrseq user is compiled as module

Changes for v4:
- Create the patch on next-20160722 
- Fix the of_node is not NULL after chipidea driver is unbinded [Patch 5/6]
- Using more friendly wait method for reset gpio [Patch 2/6]
- Support multiple input clocks [Patch 2/6]
- Add Rob Herring's ack for DT changes
- Add Joshua Clayton's Tested-by

Changes for v3:
- Delete "power-sequence" property at binding-doc, and change related code
  at both library and user code.
- Change binding-doc example node name with Rob's comments
- of_get_named_gpio_flags only gets the gpio, but without setting gpio flags,
  add additional code request gpio with proper gpio flags
- Add Philipp Zabel's Ack and MAINTAINER's entry

Changes for v2:
- Delete "pwrseq" prefix and clock-names for properties at dt binding
- Should use structure not but its pointer for kzalloc
- Since chipidea core has no of_node, let core's of_node equals glue
  layer's at core's probe

[1] http://www.spinics.net/lists/linux-usb/msg142755.html
[2] http://www.spinics.net/lists/linux-usb/msg143106.html
[3] http://www.spinics.net/lists/linux-usb/msg142815.html
[4] http://www.spinics.net/lists/linux-usb/msg152375.html

Joshua Clayton (2):
  ARM: dts: imx6qdl: Enable usb node children with <reg>
  ARM: dts: imx6q-evi: Fix onboard hub reset line

Peter Chen (5):
  binding-doc: power: pwrseq-generic: add binding doc for generic power
    sequence library
  power: add power sequence library
  binding-doc: usb: usb-device: add optional properties for power
    sequence
  usb: core: add power sequence handling for USB devices
  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property

 .../bindings/power/pwrseq/pwrseq-generic.txt       |  48 +++
 .../devicetree/bindings/usb/usb-device.txt         |  10 +-
 Documentation/power/power-sequence/design.rst      |  54 ++++
 MAINTAINERS                                        |   9 +
 arch/arm/boot/dts/imx6q-evi.dts                    |  25 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  26 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   6 +
 drivers/power/Kconfig                              |   1 +
 drivers/power/Makefile                             |   1 +
 drivers/power/pwrseq/Kconfig                       |  20 ++
 drivers/power/pwrseq/Makefile                      |   2 +
 drivers/power/pwrseq/core.c                        | 335 +++++++++++++++++++++
 drivers/power/pwrseq/pwrseq_generic.c              | 234 ++++++++++++++
 drivers/usb/Kconfig                                |   1 +
 drivers/usb/core/hub.c                             |  49 ++-
 drivers/usb/core/hub.h                             |   1 +
 include/linux/power/pwrseq.h                       |  81 +++++
 17 files changed, 866 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
 create mode 100644 Documentation/power/power-sequence/design.rst
 create mode 100644 drivers/power/pwrseq/Kconfig
 create mode 100644 drivers/power/pwrseq/Makefile
 create mode 100644 drivers/power/pwrseq/core.c
 create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
 create mode 100644 include/linux/power/pwrseq.h

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
