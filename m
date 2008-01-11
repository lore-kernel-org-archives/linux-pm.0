From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Make sleep/main.c compile with
	CONFIG_PM_SLEEP unset
Date: Fri, 11 Jan 2008 23:59:55 +0100
Message-ID: <200801112359.55832.rjw__15709.4665607021$1200092356$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[Len, this patch applies on top of the suspend branch, please add.]
---
From: Rafael J. Wysocki <rjw@sisk.pl>

Make drivers/acpi/sleep/main.c compile with CONFIG_PM_SLEEP unset

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -23,9 +23,9 @@
 #include "sleep.h"
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 
 #ifdef CONFIG_PM_SLEEP
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 static bool acpi_sleep_finish_wake_up;
 
 /*
