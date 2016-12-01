From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 0/4] thermal: add driver for R-Car Gen3
Date: Thu,  1 Dec 2016 23:04:38 +0100
Message-ID: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:56242 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbcLAWE4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Dec 2016 17:04:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Here is the next series for adding thermal support to Renesas R-Car Gen3 SoCs.
All changes from last revision went into patch 2/4, so please check the
changelog there. This series has again been tested on Salvator-X boards with
H3 and M3-W SoCs. The updated branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/thermal-on-4.10-next

I know we are ultra close, but I still dare to hope the new-driver-rule might
apply for this driver?

Please review, comment, apply. Thanks,

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
 drivers/thermal/rcar_gen3_thermal.c                | 324 +++++++++++++++++++++
 6 files changed, 506 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c

-- 
2.10.2

