From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 0/4] thermal: add driver for R-Car Gen3
Date: Mon, 28 Nov 2016 22:09:20 +0100
Message-ID: <20161128210924.2921-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-pm@vger.kernel.org

Finally, here is a new series adding support for the thermal sensors on Renesas
R-Car Gen3 SoCs. The driver has been largely refactored since v2 sent by Khiem.
It is a lot simpler (no interrupts for now, will be added later), so I hope we
could still apply the 'new-driver-rule' and make it for 4.10?

Changes since last version:

Patch 1 (bindings):

* earlier versions had one node per sensor. This version has one node for all,
  but we now have one reg entry per sensor. This makes it easier to use the
  shared resources (FUSE registers, interrupts). There is no driver support
  for shared resources yet, but it will be added incrementally.

* interrupt property specified. We make clear now that all interrupts routed
  must be specified in the binding. It is up to the driver if and how it makes
  use of them. Currently, there is no interrupt support, but it will be added
  later.

* due to the well-specified reg entries, no need anymore for aliases.

* fixed register range for TSC1.

* reformatted paragraphs and fixed some typos.

Patch 2 (driver):

* removed interrupt support, needs to be refactored seperately

* adapt code to the new bindings, especially one node for all sensors.
  Similarly, we have one private structure containing n sensor structs.

* gave register bits proper namespaces, properly seperates H3 and M3-W

* refactored the way default values are determined when there are no fuses
  (which is default case currently)

* refactored the rounding routine

* removed some superfluous macros

* use pass-by-reference instead of pass-by-value where apropriate

* removed BSPisms here and there

Patches 3+4:

* DTSI updates refactored to meet the above changes

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/thermal-on-4.10-next

Tested on a Salvator-X with H3 and M3-W SoCs. Compared against previous and BSP versions
of the driver and the results match when turning the fan on/off.

Please test, review, comment, apply...

Thanks,

   Wolfram


Wolfram Sang (4):
  thermal: rcar_gen3_thermal: Document the R-Car Gen3
  thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
  arm64: dts: r8a7795: Add R-Car Gen3 thermal support
  arm64: dts: r8a7796: Add R-Car Gen3 thermal support

 .../bindings/thermal/rcar-gen3-thermal.txt         |  56 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  58 ++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  58 ++++
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/rcar_gen3_thermal.c                | 347 +++++++++++++++++++++
 6 files changed, 529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c

-- 
2.10.2
