From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 7/8] acpi: bus: Set _OSC for diverse core support
Date: Thu,  1 Sep 2016 13:33:43 -0700
Message-ID: <1472762024-88771-8-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Set the OSC_SB_CPC_DIVERSE_HIGH_SUPPORT (bit 12) to enable diverse
core support.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1001b92..eacd4be 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -335,6 +335,9 @@ static void acpi_bus_osc_support(void)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
 	}
 
+	if (IS_ENABLED(CONFIG_SCHED_ITMT))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
+
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e746552..53841a2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -462,6 +462,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_CPCV2_SUPPORT			0x00000040
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
+#define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
-- 
2.7.4

