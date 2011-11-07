From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/14] ACPI: Drop ACPI_NO_HARDWARE_INIT
Date: Sun, 06 Nov 2011 23:11:57 -0500
Message-ID: <4505a2015f4c4b2f21137cc3a6b7400b0f3e073e.1320636776.git.len.brown@intel.com>
References: <1320639124-16178-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1320639124-16178-1-git-send-email-lenb@kernel.org>
In-reply-to: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
References: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>

ACPI_NO_HARDWARE_INIT is only used by acpi_early_init() and
acpi_bus_init() when calling acpi_enable_subsystem(), but
acpi_enable_subsystem() doesn't check that flag, so it can be
dropped.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c     |    8 ++------
 include/acpi/actypes.h |    1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 437ddbf..9ecec98 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -911,10 +911,7 @@ void __init acpi_early_init(void)
 	}
 #endif
 
-	status =
-	    acpi_enable_subsystem(~
-				  (ACPI_NO_HARDWARE_INIT |
-				   ACPI_NO_ACPI_ENABLE));
+	status = acpi_enable_subsystem(~ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to enable ACPI\n");
 		goto error0;
@@ -935,8 +932,7 @@ static int __init acpi_bus_init(void)
 
 	acpi_os_initialize1();
 
-	status =
-	    acpi_enable_subsystem(ACPI_NO_HARDWARE_INIT | ACPI_NO_ACPI_ENABLE);
+	status = acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
 		       "Unable to start the ACPI Interpreter\n");
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index b67231b..ed73f67 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -470,7 +470,6 @@ typedef u64 acpi_integer;
  */
 #define ACPI_FULL_INITIALIZATION        0x00
 #define ACPI_NO_ADDRESS_SPACE_INIT      0x01
-#define ACPI_NO_HARDWARE_INIT           0x02
 #define ACPI_NO_EVENT_INIT              0x04
 #define ACPI_NO_HANDLER_INIT            0x08
 #define ACPI_NO_ACPI_ENABLE             0x10
-- 
1.7.7.rc0.72.g4b5ea
