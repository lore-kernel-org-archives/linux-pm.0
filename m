From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v2 00/13] power: bq24257: Add support for bq24250/bq24251
Date: Tue, 8 Sep 2015 19:12:24 -0500
Message-ID: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53462 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbbIIANj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Sep 2015 20:13:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

This patch series extends the driver to also support bq24250/bq24251.

The bq24250/251/257 devices have a very similar feature set and are
virtually identical from a control register point of view so it made
sense to extend the existing driver rather than submitting a new driver.
In addition to the new device support the driver is also extended to
allow access to some device features previously hidden. Basic and
potentially dangerous charger config parameters affecting the actual
charging of the Li-Ion battery are only configurable through firmware
rather than sysfs properties. However some newly introduced properties
are exposed through sysfs properties as access to them may be desired
from userspace. For example, it is now possible to manually configure
the maximum current drawn from the input source to accommodate different
chargers (0.5A, 1.5A, 2.0A and so on) based on system knowledge a
userspace application may have rather than rely on the auto-detection
mechanism that may not work in all possible scenarios.

Note that most patches have dependencies on other patches in the series.

v2:
- Aligned DT bindings better with existing "ti,*" charger bindings
- Dropped patch that improperly reported a missing battery as a dead
  battery
- Fixed (hopefully, that is -- still waiting for my test platform)
  issue with how the private ACPI driver_data used to identify which
  bq2425x device to use
- Removed boolean DT/ACPI properties mostly by replacing them with more
  intelligent handling in the driver
- Rework/clarification of DT bindings doc
- Renamed/refactored filenames/symbols from bq24257 to bq2425x to
  better reflect that multiple devices are covered. Despite initial
  hesitation I feel this is a good opportunity for some clean-up as
  the driver is still very new in the Kernel so the change should be
  low risk. This also addresses one of Andrew Davis' feedback items.
  Plus, it makes for a nice alignment with the existing bq2415x_charger
  driver.

v1:
- Initial submission

Andreas Dannenberg (13):
  power: bq24257: Add bit definition for temp sense enable
  power: bq24257: Add basic support for bq24250/bq24251
  power: bq24257: Allow manual setting of input current limit
  power: bq24257: Add SW-based approach for Power Good determination
  power: bq24257: Add over voltage protection setting support
  power: bq24257: Add input DPM voltage threshold setting support
  power: bq24257: Extend scope of mutex protection
  power: bq24257: Add charge type setting support
  power: bq24257: Allow input current limit sysfs access
  power: bq24257: Add various device-specific sysfs properties
  power: bq24257: Add platform data based initialization
  power: bq24257: Renaming for consistency
  dt: power: bq2425x-charger: Cover additional devices

 .../devicetree/bindings/power/bq24257.txt          |   21 -
 .../devicetree/bindings/power/bq2425x.txt          |   70 +
 drivers/power/Kconfig                              |    7 +-
 drivers/power/Makefile                             |    2 +-
 drivers/power/bq24257_charger.c                    |  858 ------------
 drivers/power/bq2425x_charger.c                    | 1404 ++++++++++++++++++++
 include/linux/power/bq2425x_charger.h              |   30 +
 7 files changed, 1509 insertions(+), 883 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/bq24257.txt
 create mode 100644 Documentation/devicetree/bindings/power/bq2425x.txt
 delete mode 100644 drivers/power/bq24257_charger.c
 create mode 100644 drivers/power/bq2425x_charger.c
 create mode 100644 include/linux/power/bq2425x_charger.h

-- 
1.9.1

