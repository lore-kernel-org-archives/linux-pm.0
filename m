From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] Thermal: ACPI INT3403 thermal driver
Date: Sun, 26 Jan 2014 20:31:40 -0800
Message-ID: <1390797101-3301-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20006 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbaA0Ebu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 26 Jan 2014 23:31:50 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


v2:
Updated description of CONFIG_ACPI_INT3403_THERMAL:

Linus didn't like the config help text. This patch updated the help text to
"
Newer laptops and tablets that use ACPI may have thermal sensors outside the
core CPU/SOC for thermal safety reasons. These temperature sensors are also
exposed for the OS to use via the so called INT3403 ACPI object. This driver
will, on devices that have such sensors, expose the temperature information
from these sensors to userspace via the normal thermal framework. This means
that a wide range of applications and GUI widgets can show this information to
the user or use this information for making decisions. For example, the Intel
Thermal Daemon can use this information to allow the user to select his laptop
to run without turning on the fans.
"

v1:
Base version reviewed and merged to linux-next

Srinivas Pandruvada (1):
  Thermal: ACPI INT3403 thermal driver

 drivers/thermal/Kconfig           |  15 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/int3403_thermal.c | 237 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 drivers/thermal/int3403_thermal.c

-- 
1.8.3.2

