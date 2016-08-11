From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/5] acpi: bus: Enable HWP CPPC objects
Date: Wed, 10 Aug 2016 17:17:26 -0700
Message-ID: <1470874646-70570-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Need to set platform wide _OSC bits CPC version 1 and version 2 bits
so that BIOS presents CPPC objects.
Even though the cppc_acpi supports only version 2, need to set both
_OSC bits for version 1 and version 2, otherwise BIOS ignore _OSC
settings.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 85b7d07..61643a5 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -330,6 +330,13 @@ static void acpi_bus_osc_support(void)
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
 
+#ifdef CONFIG_X86
+	if (boot_cpu_has(X86_FEATURE_HWP)) {
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
+	}
+#endif
+
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
-- 
2.7.4

