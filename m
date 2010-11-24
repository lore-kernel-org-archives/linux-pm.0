From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/13] ACPI / PM: Do not refcount power resources
	that can't be turned on
Date: Thu, 25 Nov 2010 00:03:32 +0100
Message-ID: <201011250003.32330.rjw@sisk.pl>
References: <201011250001.11297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011250001.11297.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If turning on a power resource fails, do not reference count it,
since it cannot be in use in that case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/power.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -213,11 +213,13 @@ static int acpi_power_on(acpi_handle han
 				  resource->name));
 	} else {
 		result = __acpi_power_on(resource);
+		if (result)
+			resource->ref_count--;
 	}
 
 	mutex_unlock(&resource->resource_lock);
 
-	return 0;
+	return result;
 }
 
 static int acpi_power_off_device(acpi_handle handle)
