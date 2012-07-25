From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/52] ACPI: Set hotplug _OST support bit to _OSC
Date: Tue, 24 Jul 2012 23:41:21 -0400
Message-ID: <c2f4191a9c4dbbb5c8bc7f2c0eb5023b97dd2a49.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Toshi Kani <toshi.kani@hp.com>

When ACPI_HOTPLUG_OST is defined, set hotplug _OST support bit
OSC_SB_HOTPLUG_OST_SUPPORT to indicate that the OS supports hotplug
_OST by calling the platform-wide ACPI Operating System Capabilities
(_OSC).

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3188da3..3d4fc7a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -548,6 +548,10 @@ static void acpi_bus_osc_support(void)
 	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PPC_OST_SUPPORT;
 #endif
 
+#ifdef ACPI_HOTPLUG_OST
+	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_HOTPLUG_OST_SUPPORT;
+#endif
+
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
-- 
1.7.12.rc0
