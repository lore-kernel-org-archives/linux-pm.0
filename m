From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 00/13] power: bq24257: Add support for bq24250/bq24251
Date: Mon, 31 Aug 2015 21:10:22 -0500
Message-ID: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55486 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736AbbIACLT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:11:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

This patch series extends the driver to also support bq24250/bq24251. Most
patches have dependencies on other patches in the series but I left them spread
out so that one can better understand the change history. However I can
certainly fold them together and resubmit if needed.

The bq24250/251/257 devices have a very similar feature set and are virtually
identical from a control register point of view so it made sense to extend the
existing driver rather than submitting a new driver. In addition to the new
device support the driver is also extended to allow access to some device
features previously hidden. As per offline discussion with Laurentiu the basic
and potentially dangerous charger config parameters affecting the actual
charging of the Li-Ion battery are still only configurable through firmware
rather than sysfs properties. However some newly introduced properties are
exposed through sysfs properties as access to them may be desired from
userspace. For example, it is now possible to manually configure the maximum
current drawn from the input source to accommodate different chargers (0.5A,
1.5A, 2.0A and so on) based on system knowledge a userspace application may
have rather than rely on the auto-detection mechanism that may not work in
all possible scenarios.

Laurentiu-- I've spent quite some time testing the driver however the one piece
I could not test was the ACPI integration due to lack of suitable HW. For this
do you think you could give this a quick try?  I'm particularly interested if
the private driver data from the bq24257_acpi_match[] structure gets properly
passed down into bq24257_probe(). Also if you could recommend an embedded HW
platform that I could generally use to test ACPI support I'd appreciate that
(MinnowBoard MAX?).

--
Andreas Dannenberg
Texas Instruments Inc


Andreas Dannenberg (13):
  power: bq24257: Add bit definition for temp sense enable
  power: bq24257: Add dead battery reporting
  power: bq24257: Add basic support for bq24250/bq24251
  power: bq24257: Allow manual setting of input current limit
  power: bq24257: Add SW-based approach for Power Good determination
  power: bq24257: Add over voltage protection setting support
  power: bq24257: Add VINDPM voltage threshold setting support
  power: bq24257: Extend scope of mutex protection
  power: bq24257: Add charge type setting support
  power: bq24257: Add in_ilimit setting support
  power: bq24257: Add various device-specific sysfs properties
  power: bq24257: Add platform data based initialization
  dt: power: bq24257-charger: Cover additional devices

 .../devicetree/bindings/power/bq24257.txt          |  59 +-
 drivers/power/Kconfig                              |   5 +-
 drivers/power/bq24257_charger.c                    | 652 +++++++++++++++++++--
 include/linux/power/bq24257_charger.h              |  30 +
 4 files changed, 677 insertions(+), 69 deletions(-)
 create mode 100644 include/linux/power/bq24257_charger.h

-- 
1.9.1

