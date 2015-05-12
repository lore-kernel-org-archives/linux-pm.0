From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/2] thermal: add support to slope and offset
Date: Mon, 11 May 2015 20:04:15 -0700
Message-ID: <1431399857-13943-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, hongtao.jia@freescale.com, kong.kongxinwei@hisilicon.com
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello all,

This is a patch series to add support to slope and offset constants
of a linear extrapolation model. This type of model is very common
across different platforms, and many drivers are attempting
to have its support.

The basic idea is to have this mapping in the thermal core,
as part of thermal_zone_params. In this series, I also add
a simple support to read them from DT, i.e.:
                /* hotspot = 1 * adc + 6000 */
		coefficients =          <1      6000>;

I am copying some of the driver writers that attempted to 
use this feature, but by adding their own property. Please,
check if this change is enough to properly map your slope
and offset requirement. Remember, they will be added in your
thermal zone DT node, instead of in your sensor DT node.

BR,

Eduardo Valentin (2):
  thermal: support slope and offset coefficients
  thermal: of-thermal: add support for reading coefficients property

 Documentation/thermal/sysfs-api.txt | 16 ++++++++++++++++
 drivers/thermal/of-thermal.c        | 26 ++++++++++++++++++++++++--
 drivers/thermal/thermal_core.c      |  4 ++++
 include/linux/thermal.h             | 11 +++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.3.4

