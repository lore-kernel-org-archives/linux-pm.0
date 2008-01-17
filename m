From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 8/10] ACPI: CELSIUS_TO_KELVIN fixup
Date: Thu, 17 Jan 2008 15:51:19 +0800
Message-ID: <1200556279.2935.120.camel__22361.5568982952$1200556667$gmane$org@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, sujith.thomas@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Fix an imprecision in CELSIUS_TO_KELVIN and move these
two macroes to a proper place.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
---
 drivers/acpi/thermal.c  |    3 ---
 include/linux/thermal.h |    4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -65,9 +65,6 @@
 #define ACPI_THERMAL_MAX_ACTIVE	10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN 65
 
-#define KELVIN_TO_CELSIUS(t)    (long)(((long)t-2732>=0) ? ((long)t-2732+5)/10 : ((long)t-2732-5)/10)
-#define CELSIUS_TO_KELVIN(t)	((t+273)*10)
-
 #define _COMPONENT		ACPI_THERMAL_COMPONENT
 ACPI_MODULE_NAME("thermal");
 
Index: linux-2.6/include/linux/thermal.h
===================================================================
--- linux-2.6.orig/include/linux/thermal.h
+++ linux-2.6/include/linux/thermal.h
@@ -61,6 +61,10 @@ struct thermal_cooling_device {
 	struct list_head node;
 };
 
+#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
+				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
+#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
+
 struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
