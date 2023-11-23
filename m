Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CEC6B0
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 04:08:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C70F91042;
	Thu, 23 Nov 2023 04:09:37 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93FF53F7A6;
	Thu, 23 Nov 2023 04:08:50 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/2] pmdomain: arm_scmi: Move Kconfig options to the pmdomain subsystem
Date: Thu, 23 Nov 2023 12:08:46 +0000
Message-ID: <20231123120847.2825444-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the firmware to the pmdomain subsystem.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig | 25 -------------------------
 drivers/pmdomain/Kconfig          |  1 +
 drivers/pmdomain/arm/Kconfig      | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 25 deletions(-)
 create mode 100644 drivers/pmdomain/arm/Kconfig

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 706d1264d038..aa5842be19b2 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -168,31 +168,6 @@ config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE

 endif #ARM_SCMI_PROTOCOL

-config ARM_SCMI_POWER_DOMAIN
-	tristate "SCMI power domain driver"
-	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
-	default y
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the SCMI power domains which can be
-	  enabled or disabled via the SCP firmware
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called scmi_pm_domain. Note this may needed early in boot
-	  before rootfs may be available.
-
-config ARM_SCMI_PERF_DOMAIN
-	tristate "SCMI performance domain driver"
-	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
-	default y
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the SCMI performance domains which can be
-	  enabled or disabled via the SCP firmware.
-
-	  This driver can also be built as a module. If so, the module will be
-	  called scmi_perf_domain.
-
 config ARM_SCMI_POWER_CONTROL
 	tristate "SCMI system power control driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index c98c5bf75a14..23c64851a5b0 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -4,6 +4,7 @@ menu "PM Domains"
 source "drivers/pmdomain/actions/Kconfig"
 source "drivers/pmdomain/amlogic/Kconfig"
 source "drivers/pmdomain/apple/Kconfig"
+source "drivers/pmdomain/arm/Kconfig"
 source "drivers/pmdomain/bcm/Kconfig"
 source "drivers/pmdomain/imx/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
new file mode 100644
index 000000000000..acbe4331aaf7
--- /dev/null
+++ b/drivers/pmdomain/arm/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config ARM_SCMI_PERF_DOMAIN
+	tristate "SCMI performance domain driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the SCMI performance domains which can be
+	  enabled or disabled via the SCP firmware.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called scmi_perf_domain.
+
+config ARM_SCMI_POWER_DOMAIN
+	tristate "SCMI power domain driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the SCMI power domains which can be
+	  enabled or disabled via the SCP firmware
+
+	  This driver can also be built as a module. If so, the module
+	  will be called scmi_pm_domain. Note this may needed early in boot
+	  before rootfs may be available.
--
2.42.0

