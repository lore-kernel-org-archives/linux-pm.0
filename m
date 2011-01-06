From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 9/11] ACPI: Always check if _PRW is present
	before trying to evaluate it
Date: Thu, 6 Jan 2011 23:40:00 +0100
Message-ID: <201101062340.00868.rjw__36129.0080509663$1294355622$gmane$org@sisk.pl>
References: <201101062331.17079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101062331.17079.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Andreas Mohr <andi@lisas.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Before evaluating _PRW for devices that are reported as inactive or
not present by their _STA control methods we should check if those
methods are actually present (otherwise the evaulation of _PRW will
obviously fail and a scary message will be printed unnecessarily).

Reported-by: Andreas Mohr <andi@lisas.de>
Reported-by: Maciej Rutecki <maciej.rutecki@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -1388,7 +1388,6 @@ static acpi_status acpi_bus_check_add(ac
 	struct acpi_bus_ops *ops = context;
 	int type;
 	unsigned long long sta;
-	struct acpi_device_wakeup wakeup;
 	struct acpi_device *device;
 	acpi_status status;
 	int result;
@@ -1399,7 +1398,13 @@ static acpi_status acpi_bus_check_add(ac
 
 	if (!(sta & ACPI_STA_DEVICE_PRESENT) &&
 	    !(sta & ACPI_STA_DEVICE_FUNCTIONING)) {
-		acpi_bus_extract_wakeup_device_power_package(handle, &wakeup);
+		struct acpi_device_wakeup wakeup;
+		acpi_handle temp;
+
+		status = acpi_get_handle(handle, "_PRW", &temp);
+		if (ACPI_SUCCESS(status))
+			acpi_bus_extract_wakeup_device_power_package(handle,
+								     &wakeup);
 		return AE_CTRL_DEPTH;
 	}
 
