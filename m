From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 6/8] acpi: bus: Enable HWP CPPC objects
Date: Thu,  1 Sep 2016 13:33:42 -0700
Message-ID: <1472762024-88771-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44332 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753793AbcIAVHu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Sep 2016 17:07:50 -0400
In-Reply-To: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Need to set platform wide _OSC bits to enable CPPC and CPPC version 2.
If platform supports CPPC, then BIOS exposess CPPC tables.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 85b7d07..1001b92 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -330,6 +330,11 @@ static void acpi_bus_osc_support(void)
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
 
+	if (IS_ENABLED(CONFIG_X86) && boot_cpu_has(X86_FEATURE_HWP)) {
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
+	}
+
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
-- 
2.7.4

