From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 00/19] Thermal: ACPI INT340X thermal drivers
Date: Thu, 18 Sep 2014 09:53:31 +0800
Message-ID: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5126 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756264AbaIRByM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Sep 2014 21:54:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>

Hi,

Newer laptops and tablets that use ACPI may have thermal sensors and other
devices with thermal control capabilities outside the core CPU/SOC, for
thermal safety reasons.
They are exposed for the OS to use via the ACPI INT340x device objects.

This patch set introduces kernel drivers for those INT340X devices and
expose their telemetry and cooling capability to user space via the normal
thermal framework. So that a wide range of applications and GUI widgets
can show this information to the user or use this information for making
decisions. For example, the Intel Thermal Daemon can use this information
to allow the user to select his laptop to run w/ or w/o turning on the fans.

thanks,
rui

----------------------------------------------------------------
Aaron Lu (9):
      ACPI / fan: remove unused macro
      ACPI / fan: remove no need check for device pointer
      ACPI / fan: use acpi_device_xxx_power instead of acpi_bus equivelant
      ACPI / fan: convert to platform driver
      ACPI / Fan: add ACPI 4.0 style fan support
      ACPI / Fan: support INT3404 thermal device
      Thermal: move the KELVIN_TO_MILLICELSIUS macro to thermal.h
      Thermal: introduce INT3402 thermal driver
      Thermal: introduce INT3406 thermal driver

Jacob Pan (2):
      Thermal: int340x_thermal: expose acpi thermal relationship tables
      Thermal: int3400_thermal: use acpi_thermal_rel parsing APIs

Lan Tianyu (1):
      Thermal: introduce int3403 thermal driver

Zhang Rui (7):
      ACPI: introduce ACPI int340x thermal scan handler
      ACPI: make acpi_create_platform_device() an external API
      ACPI: add ACPI_TYPE_LOCAL_REFERENCE support to acpi_extract_package()
      Thermal: introduce int3400 thermal driver
      Thermal: int3400 thermal: add capability to detect supporting UUIDs
      Thermal: int3400 thermal: register to thermal framework
      Thermal: int340x thermal: select ACPI fan driver

 drivers/acpi/Kconfig                               |   2 +-
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/acpi_platform.c                       |   1 +
 drivers/acpi/device_pm.c                           |   1 +
 drivers/acpi/fan.c                                 | 341 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 drivers/acpi/int340x_thermal.c                     |  51 ++++++++++++++++
 drivers/acpi/internal.h                            |   3 +-
 drivers/acpi/scan.c                                |   1 +
 drivers/acpi/thermal.c                             |  18 +++---
 drivers/acpi/utils.c                               |  28 ++++++++-
 drivers/acpi/video.c                               |  78 +++++++++++++-----------
 drivers/thermal/Kconfig                            |  39 +++++++-----
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/int3403_thermal.c                  | 296 ----------------------------------------------------------------------------------------
 drivers/thermal/int340x_thermal/Makefile           |   5 ++
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 400 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/int340x_thermal/acpi_thermal_rel.h |  84 +++++++++++++++++++++++++
 drivers/thermal/int340x_thermal/int3400_thermal.c  | 271 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/int340x_thermal/int3402_thermal.c  | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/int340x_thermal/int3403_thermal.c  | 489 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/int340x_thermal/int3406_thermal.c  | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/backlight/backlight.c                |  44 +++++++++-----
 include/acpi/acpi_bus.h                            |   1 +
 include/acpi/video.h                               |  20 ++++++
 include/linux/acpi.h                               |   7 +++
 include/linux/backlight.h                          |   2 +
 include/linux/thermal.h                            |   4 ++
 27 files changed, 2208 insertions(+), 453 deletions(-)
 create mode 100644 drivers/acpi/int340x_thermal.c
 delete mode 100644 drivers/thermal/int3403_thermal.c
 create mode 100644 drivers/thermal/int340x_thermal/Makefile
 create mode 100644 drivers/thermal/int340x_thermal/acpi_thermal_rel.c
 create mode 100644 drivers/thermal/int340x_thermal/acpi_thermal_rel.h
 create mode 100644 drivers/thermal/int340x_thermal/int3400_thermal.c
 create mode 100644 drivers/thermal/int340x_thermal/int3402_thermal.c
 create mode 100644 drivers/thermal/int340x_thermal/int3403_thermal.c
 create mode 100644 drivers/thermal/int340x_thermal/int3406_thermal.c
