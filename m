From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 7/7] ACPI: Print message before calling _PTS
Date: Thu, 27 Dec 2007 19:20:01 +0100
Message-ID: <200712271920.02207.rjw@sisk.pl>
References: <200712271903.53961.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712271903.53961.rjw@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, "Moore,
	Robert" <robert.moore@intel.com>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make acpi_sleep_prepare() static and cause it to print a message
specifying the ACPI system sleep state to be entered (helpful for
debugging the suspend/hibernation code).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c  |    4 +++-
 drivers/acpi/sleep/sleep.h |    2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -29,7 +29,7 @@ static u32 acpi_target_sleep_state = ACP
 static bool acpi_sleep_finish_wake_up;
 #endif
 
-int acpi_sleep_prepare(u32 acpi_state)
+static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
@@ -45,6 +45,8 @@ int acpi_sleep_prepare(u32 acpi_state)
 	ACPI_FLUSH_CPU_CACHE();
 	acpi_enable_wakeup_device_prep(acpi_state);
 #endif
+	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
+		acpi_state);
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
 }
Index: linux-2.6/drivers/acpi/sleep/sleep.h
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/sleep.h
+++ linux-2.6/drivers/acpi/sleep/sleep.h
@@ -5,5 +5,3 @@ extern int acpi_suspend (u32 state);
 extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
 extern void acpi_enable_wakeup_device(u8 sleep_state);
 extern void acpi_disable_wakeup_device(u8 sleep_state);
-
-extern int acpi_sleep_prepare(u32 acpi_state);
