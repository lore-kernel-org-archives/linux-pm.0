From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH 0/3] power: reset: add reset for renesas r7s72100
Date: Mon, 13 Feb 2017 13:25:29 -0500
Message-ID: <20170213182532.4042-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-pm@vger.kernel.org

Some Renesas SoCs do not have a reset register and the only way to do a SW
controlled reset is to use the watchdog timer.

Additionally, since all the WDT timeout options are so quick, a system
reset is about the only thing it's good for.
For example, the longest WDT overflow you can get with a RZ/A1 (R7S72100)
with its 8-bit wide counter is 125ms.


Chris Brandt (3):
  power: reset: Add Renesas reset driver
  dt-bindings: power: reset: add document for renesas-reset driver
  ARM: dts: r7s72100: Add reset handler

 .../bindings/power/reset/renesas-reset.txt         |  15 +++
 arch/arm/boot/dts/r7s72100.dtsi                    |   5 +
 drivers/power/reset/Kconfig                        |   9 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/renesas-reset.c                | 103 +++++++++++++++++++++
 5 files changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/renesas-reset.txt
 create mode 100644 drivers/power/reset/renesas-reset.c

-- 
2.10.1
