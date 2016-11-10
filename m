From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v7 6/8] acpi: bus: Enable HWP CPPC objects
Date: Thu, 10 Nov 2016 14:36:38 -0800
Message-ID: <9057cbebaf57a98a3118a0d0376fc4bf352b260d.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Need to set platform wide _OSC bits to enable CPPC and CPPC version 2.
If platform supports CPPC, then BIOS exposes CPPC tables.

The primary reason to enable CPPC support is to get the maximum
performance of each CPU to check and enable Intel Turbo Boost Max
Technology 3.0 (ITMT).

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 drivers/acpi/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 56190d0..2f381ba 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -331,6 +331,13 @@ static void acpi_bus_osc_support(void)
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
2.5.5
