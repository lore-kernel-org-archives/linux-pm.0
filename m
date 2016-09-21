From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 08/10] acpi: bus: Enable HWP CPPC objects
Date: Wed, 21 Sep 2016 12:19:10 -0700
Message-ID: <1474485552-141429-9-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Need to set platform wide _OSC bits to enable CPPC and CPPC version 2.
If platform supports CPPC, then BIOS exposes CPPC tables.

The primary reason to enable CPPC support is to get the maximum
performance of each CPU to check and enable Intel Turbo Boost Max
Technology 3.0 (ITMT).

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
