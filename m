From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Avoid infinite recurrence while
	registering power resources
Date: Mon, 25 Apr 2011 22:15:58 +0200
Message-ID: <201104252215.58860.rjw__43957.5963108384$1303762583$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Pascal Dormeau <pdormeau@free.fr>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There is at least one BIOS with a DSDT containing a power resource
object with a _PR0 entry pointing back to that power resource.  In
consequence, while registering that power resource
acpi_bus_get_power_flags() sees that it depends on itself and tries
to register it again, which leads to an infinitely deep recurrence.
This problem was introduced by commit bf325f9538d8c89312be305b9779e
(ACPI / PM: Register power resource devices as soon as they are
needed).

To fix this problem use the observation that power resources cannot
be power manageable and prevent acpi_bus_get_power_flags() from
being called for power resource objects.

References: https://bugzilla.kernel.org/show_bug.cgi?id=31872
Reported-and-tested-by: Pascal Dormeau <pdormeau@free.fr>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -943,6 +943,10 @@ static int acpi_bus_get_flags(struct acp
 	if (ACPI_SUCCESS(status))
 		device->flags.lockable = 1;
 
+	/* Power resources cannot be power manageable. */
+	if (device->device_type == ACPI_BUS_TYPE_POWER)
+		return 0;
+
 	/* Presence of _PS0|_PR0 indicates 'power manageable' */
 	status = acpi_get_handle(device->handle, "_PS0", &temp);
 	if (ACPI_FAILURE(status))
