From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 0/4] thermal: introduce DT thermal builder
Date: Tue, 9 Jul 2013 10:00:10 -0400
Message-ID: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40434 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131Ab3GIOAj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Jul 2013 10:00:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, durgadoss.r@intel.com, amit.daniel@samsung.com
Cc: rui.zhang@intel.com, Eduardo Valentin <eduardo.valentin@ti.com>

Hello all,

This is a series of patches containing changes to add
a way to describe a thermal zone in a DT descriptor file
and then assign it to a temperature sensor. The sensor
code then would use this infrastructure to build
thermal zones based on that sensor, using what has been
described within the DT.

I have also changed the hwmod file because  I intend
to add wrapper from hwmon drivers to this DT parser.

I modified the ti-soc-thermal driver so that we can
see how this would fit in a  existing driver.

Comments are welcome.

Eduardo Valentin (4):
  thermal: hwmon: move hwmon support to single file
  thermal: introduce device tree parser
  thermal: ti-soc-thermal: use thermal DT infrastructure
  arm: dts: add omap4430 thermal data

 .../devicetree/bindings/thermal/thermal.txt        |  92 +++++
 arch/arm/boot/dts/omap443x.dtsi                    |  31 ++
 drivers/thermal/Kconfig                            |  22 ++
 drivers/thermal/Makefile                           |   4 +
 drivers/thermal/thermal_core.c                     | 255 +------------
 drivers/thermal/thermal_dt.c                       | 412 +++++++++++++++++++++
 drivers/thermal/thermal_dt.h                       |  44 +++
 drivers/thermal/thermal_hwmon.c                    | 268 ++++++++++++++
 drivers/thermal/thermal_hwmon.h                    |  49 +++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  35 +-
 include/linux/thermal.h                            |   3 +
 11 files changed, 951 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal.txt
 create mode 100644 drivers/thermal/thermal_dt.c
 create mode 100644 drivers/thermal/thermal_dt.h
 create mode 100644 drivers/thermal/thermal_hwmon.c
 create mode 100644 drivers/thermal/thermal_hwmon.h

-- 
1.8.2.1.342.gfa7285d

