From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/2] ACPI: Do not prepare for hibernation in
	acpi_shutdown
Date: Sun, 1 Jul 2007 20:53:08 +0200
Message-ID: <200707012053.08663.rjw__6115.55383443392$1183315775$gmane$org@sisk.pl>
References: <200707012051.48338.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707012051.48338.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since we are now explicitly calling hibernation_ops->prepare() before
hibernation_ops->enter() in hibernation_platform_enter() (defined in
kernel/power/disk.c), ACPI should not call acpi_sleep_prepare(ACPI_STATE_S4)
from acpi_shutdown().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/poweroff.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6.22-rc6/drivers/acpi/sleep/poweroff.c
===================================================================
--- linux-2.6.22-rc6.orig/drivers/acpi/sleep/poweroff.c	2007-07-01 15:08:54.000000000 +0200
+++ linux-2.6.22-rc6/drivers/acpi/sleep/poweroff.c	2007-07-01 15:10:07.000000000 +0200
@@ -54,9 +54,6 @@ static int acpi_shutdown(struct sys_devi
 	case SYSTEM_POWER_OFF:
 		/* Prepare to power off the system */
 		return acpi_sleep_prepare(ACPI_STATE_S5);
-	case SYSTEM_SUSPEND_DISK:
-		/* Prepare to suspend the system to disk */
-		return acpi_sleep_prepare(ACPI_STATE_S4);
 	default:
 		return 0;
 	}
