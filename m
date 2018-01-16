From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 0/8] MIPS: add support for the Microsemi MIPS SoCs
Date: Tue, 16 Jan 2018 11:12:32 +0100
Message-ID: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds initial support for the Microsemi MIPS SoCs. It
is currently focusing on the Microsemi Ocelot (VSC7513, VSC7514).

It also adds support for the reset controller.

This produces a kernel that can boot to the console.

This is a single series for reference but the reset driver can be taken
separately.

Changes in v3:
 - removed the pinctrl driver as it has already been taken
 - removed the irqchip driver as the bindings have been acked and will not
   change
 - changed the reset controller bindings following Rob's review

Changes in v2:
 - removed the wildcard in MAINAINERS
 - corrected the Cc list
 - added proper documentation for both syscons
 - removed the mscc,cpucontrol property
 - updated the ranges property in the ocelot dtsi

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Alexandre Belloni (8):
  dt-bindings: mips: Add bindings for Microsemi SoCs
  dt-bindings: power: reset: Document ocelot-reset binding
  power: reset: Add a driver for the Microsemi Ocelot reset
  MIPS: mscc: Add initial support for Microsemi MIPS SoCs
  MIPS: mscc: add ocelot dtsi
  MIPS: mscc: add ocelot PCB123 device tree
  MIPS: defconfigs: add a defconfig for Microsemi SoCs
  MAINTAINERS: Add entry for Microsemi MIPS SoCs

 Documentation/devicetree/bindings/mips/mscc.txt    |  44 +++++++++
 .../bindings/power/reset/ocelot-reset.txt          |  14 +++
 MAINTAINERS                                        |   7 ++
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  24 +++++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/mscc/Makefile                   |   6 ++
 arch/mips/boot/dts/mscc/ocelot.dtsi                | 110 +++++++++++++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |  27 +++++
 arch/mips/configs/mscc_defconfig                   |  84 ++++++++++++++++
 arch/mips/mscc/Makefile                            |  11 +++
 arch/mips/mscc/Platform                            |  12 +++
 arch/mips/mscc/setup.c                             | 106 ++++++++++++++++++++
 drivers/power/reset/Kconfig                        |   7 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/ocelot-reset.c                 |  88 +++++++++++++++++
 16 files changed, 543 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
 create mode 100644 arch/mips/boot/dts/mscc/Makefile
 create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
 create mode 100644 arch/mips/configs/mscc_defconfig
 create mode 100644 arch/mips/mscc/Makefile
 create mode 100644 arch/mips/mscc/Platform
 create mode 100644 arch/mips/mscc/setup.c
 create mode 100644 drivers/power/reset/ocelot-reset.c

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
