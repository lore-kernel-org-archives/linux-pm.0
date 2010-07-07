From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 1/4] ACPI: Fix bogus GPE test in
	acpi_bus_set_run_wake_flags()
Date: Thu, 8 Jul 2010 00:42:51 +0200
Message-ID: <201007080042.52019.rjw__354.61518350548$1278543114$gmane$org@sisk.pl>
References: <201007080041.38627.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007080041.38627.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

When we check if a GPE can be used for runtime signaling, we only
search the FADT GPE blocks, which is incorrect, becuase the GPE
may be located elsewhere.  We really should be using the GPE device
information previously returned by _PRW here, so make that happen.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -764,8 +764,9 @@ static void acpi_bus_set_run_wake_flags(
 		return;
 	}
 
-	status = acpi_get_gpe_status(NULL, device->wakeup.gpe_number,
-					&event_status);
+	status = acpi_get_gpe_status(device->wakeup.gpe_device,
+					device->wakeup.gpe_number,
+						&event_status);
 	if (status == AE_OK)
 		device->wakeup.flags.run_wake =
 				!!(event_status & ACPI_EVENT_FLAG_HANDLE);
