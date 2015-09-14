From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v3 0/5] SCPI Sensor support
Date: Mon, 14 Sep 2015 14:00:13 +0100
Message-ID: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:53296 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750944AbbINNBh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 09:01:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, liviu.dudau@arm.com, edubezval@gmail.com, mark.rutland@arm.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Punit Agrawal <punit.agrawal@arm.com>

Hi

The series adds support for SCPI based sensors for ARM development
platform. In addition to supporting sensors, when a temperature sensor
is discovered the driver registers the sensor with the thermal
framework.

The sensor patches here have been split out from a longer series
adding support for registering power model based cooling devices for
the CPU via device tree. Earliers postings can be seen at [0], [1].

Patches 1-3 create a hwmon sensor driver for sensors provided by SCPI
firmware. Patch 4 adds support for the temperature sensors to register
with the thermal framework. This allows setting up platform thermals
using OF thermal bindings.

The last patch adds support for the sensors in the Juno device tree.

The patches depend on SCPI and mailbox patches[2] from Sudeep. The
SCPI protocol document with details of the sensor interface can be
found at [3].

I'd like to aim for merging the patches with the SCPI changes if
possible. The hwmon patches have been acked by Guenter. If there
aren't any objections, I would like to request acks for the binding
updates in Patch 1.

Thanks,
Punit

Changes v2->v3
  - split out the sensor patches (posted here)
  - rebase onto v4.3-rc1
  
Changes v1->v2
  - added documentation for the scpi-hwmon driver
  - replaced static allocation of platform structure in scpi-hwmon.c
    with dynamic allocation
  - re-structured registering of thermal zones to better handle
    error conditions
  - reduced chattiness in scpi-hwmon.c
  - corrected sensor numbering to align with hwmon documentation
  - dynamic allocation of attributes and attribute groups

[0] http://thread.gmane.org/gmane.linux.kernel/2002152
[1] http://thread.gmane.org/gmane.linux.kernel/2011466
[2] http://thread.gmane.org/gmane.linux.kernel/2009735
[3] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html

Punit Agrawal (5):
  Documentation: add DT bindings for ARM SCPI sensors
  firmware: arm_scpi: Extend to support sensors
  hwmon: Support sensors exported via ARM SCP interface
  hwmon: Support registration of thermal zones for SCP temperature
    sensors
  arm64: dts: Add sensor node to Juno dt

 Documentation/devicetree/bindings/arm/arm,scpi.txt |  15 ++
 Documentation/hwmon/scpi-hwmon                     |  33 +++
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   5 +
 drivers/firmware/arm_scpi.c                        |  60 +++++
 drivers/hwmon/Kconfig                              |   8 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scpi-hwmon.c                         | 288 +++++++++++++++++++++
 include/linux/scpi_protocol.h                      |  17 ++
 8 files changed, 427 insertions(+)
 create mode 100644 Documentation/hwmon/scpi-hwmon
 create mode 100644 drivers/hwmon/scpi-hwmon.c

-- 
2.5.0

