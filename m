From: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Subject: [PATCH 0/2] power: supply: add sbs-charger driver
Date: Wed, 23 Nov 2016 12:20:42 +0100
Message-ID: <1479900044-19270-1-git-send-email-nicolas.saenz@prodys.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from host.prodys.net ([89.248.106.65]:38851 "EHLO host.prodys.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933205AbcKWLVG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Nov 2016 06:21:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.saenz@prodys.net

Hi,

This series adds support for all SBS compatible battery chargers, as defined
here: http://sbs-forum.org/specs/sbc110.pdf.

The first patch changes the sbs-battery device name in order to be able to
create a proper supplier/supplied relation between the two of them.

The second introduces the driver.

Regards,
Nicolas

changes since v1:
- added dt bindings
- updated driver with Sebastian's comments
- s/Nicola/Nicolas/ in commits

Nicolas Saenz Julienne (2):
  power: supply: add sbs-charger driver
  dt-bindings: power: add bindings for sbs-charger

 .../bindings/power/supply/sbs_sbs-charger.txt      |  22 ++
 drivers/power/supply/Kconfig                       |   6 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sbs-charger.c                 | 264 +++++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
 create mode 100644 drivers/power/supply/sbs-charger.c

-- 
2.7.4

