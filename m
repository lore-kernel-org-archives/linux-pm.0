From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v8 7/8] acpi: bus: Set _OSC for diverse core support
Date: Tue, 22 Nov 2016 12:23:59 -0800
Message-ID: <a023623a727e86040a1715797055f6402caefd7e.1479844244.git.tim.c.chen@linux.intel.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1479844244.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1479844244.git.tim.c.chen@linux.intel.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Set the OSC_SB_CPC_DIVERSE_HIGH_SUPPORT (bit 12) to enable diverse
core support.

This is required to inform BIOS the support of Intel Turbo Boost Max
Technology 3.0 feature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2f381ba..806db0d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -338,6 +338,9 @@ static void acpi_bus_osc_support(void)
 	}
 #endif
 
+	if (IS_ENABLED(CONFIG_SCHED_ITMT))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
+
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 689a8b9..639fc63 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -469,6 +469,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_CPCV2_SUPPORT			0x00000040
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
+#define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
-- 
2.5.5
