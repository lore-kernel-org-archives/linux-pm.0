From: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Subject: [PATCH v4 0/2] power: supply: add sbs-charger driver
Date: Tue, 20 Dec 2016 16:31:12 +0100
Message-ID: <1482247874-28713-1-git-send-email-nicolas.saenz@prodys.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.saenz@prodys.net
List-Id: linux-pm@vger.kernel.org

Hi,

This series adds support for all SBS compatible battery chargers, as defined
here: http://sbs-forum.org/specs/sbc110.pdf.

Regards,
Nicolas

changes since v3:
- update dt-binding to use part number and fallback

changes since v2:
- updated driver and dt-binding with Sebatian's comments

changes since v1:
- added dt bindings
- updated driver with Sebastian's comments
- s/Nicola/Nicolas/ in commits

Nicolas Saenz Julienne (2):
  power: supply: add sbs-charger driver
  dt-bindings: power: add bindings for sbs-charger

 .../bindings/power/supply/sbs_sbs-charger.txt      |  23 ++
 drivers/power/supply/Kconfig                       |   6 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sbs-charger.c                 | 274 +++++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
 create mode 100644 drivers/power/supply/sbs-charger.c

-- 
2.7.4
