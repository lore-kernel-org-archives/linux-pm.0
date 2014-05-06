From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 0/7] thermal: Armada 375/380 SoC support
Date: Tue,  6 May 2014 13:59:44 -0300
Message-ID: <1399395591-5713-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53276 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750821AbaEFRA2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 13:00:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This patchset adds the support for the thermal sensor in the recently
introduced Armada 375 and 38x SoC. Compared to the previous patchset
version, only the driver changes are being sent now. The rest has been
merged by Jason Cooper through the mvebu tree.

There are other very minor changes from v2, see below.

The first five patches are preparation work. They add a generic
infrastructure that allows to support similar thermal sensors in
a non-intrusive way.

Patches six and seven uses this infrastructure to support the 
Armada 375 and 380 SoC thermal sensor.

Since there are some issues in the Armada 375 Z1 SoC thermal sensor,
patch eight adds a quirk to workaround such issues. The Z1 silicon stepping
is detected and the compatible string is updated, so the driver can apply
sensor initialization workarounds.

In addition, the quirk moves the offset of the thermal control register,
and allows to specifiy the correct (A0 stepping) offset in the devicetree.
This quirk is applied only for the A375-DB board, being the only board known
to have the problematic Z1 SoC.

The series applies on v3.15-rc1, and has been tested on A375-DB board
and A385-DB board.

Feedback and comments are welcome!

Changes from v2:

  * Renamed the 'offset' fields and macros to the more proper 'shift'.
    This was pointed out on private discussion by Thomas Petazzoni.

  * Fix a typo in the Armada 380 init_sensor() function.

Changes from v1:

  * Introduced the Armada 380 support. In order to support this in a clean
    way, the 'inverted' field was added.

  * Cleaned the A375 workaround in the thermal driver, by detecting the
    device compatible string, as suggested by Jason Cooper.

  * Added details about the register offset in the Z1 stepping to the
    binding documentation as requested by Jason Cooper.

Ezequiel Garcia (7):
  thermal: armada: Rename armada_thermal_ops struct
  thermal: armada: Add infrastructure to support generic formulas
  thermal: armada: Add generic infrastructure to handle the sensor
  thermal: armada: Pass the platform_device to init_sensor()
  thermal: armada: Allow to specify an 'inverted readout' sensor
  thermal: armada: Support Armada 375 SoC
  thermal: armada: Support Armada 380 SoC

 .../devicetree/bindings/thermal/armada-thermal.txt |  12 +-
 drivers/thermal/armada_thermal.c                   | 158 ++++++++++++++++++---
 2 files changed, 150 insertions(+), 20 deletions(-)

-- 
1.9.1

