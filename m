From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v6 7/9] acpi: bus: Enable HWP CPPC objects
Date: Thu, 20 Oct 2016 15:00:01 -0700
Message-ID: <bccae7ed6bd25cb5ed2bb6ab3fa720a665e5e9da.1477000078.git.tim.c.chen@linux.intel.com>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1477000078.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1477000078.git.tim.c.chen@linux.intel.com>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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
