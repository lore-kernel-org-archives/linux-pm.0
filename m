From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/37] ACPI: Print message before calling _PTS
Date: Thu, 31 Jan 2008 23:37:03 -0500
Message-ID: <fca1ac6dca20d23ae708b2bb85b1f4c1b7549f43.1201840183.git.len.brown__30948.789502918$1201843714$gmane$org@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make acpi_sleep_prepare() static and cause it to print a message
specifying the ACPI system sleep state to be entered (helpful for
debugging the suspend/hibernation code).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c  |    4 +++-
 drivers/acpi/sleep/sleep.h |    2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 10db899..485de13 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -43,7 +43,7 @@ static int __init acpi_new_pts_ordering(char *str)
 __setup("acpi_new_pts_ordering", acpi_new_pts_ordering);
 #endif
 
-int acpi_sleep_prepare(u32 acpi_state)
+static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
@@ -59,6 +59,8 @@ int acpi_sleep_prepare(u32 acpi_state)
 	ACPI_FLUSH_CPU_CACHE();
 	acpi_enable_wakeup_device_prep(acpi_state);
 #endif
+	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
+		acpi_state);
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
 }
diff --git a/drivers/acpi/sleep/sleep.h b/drivers/acpi/sleep/sleep.h
index a2ea125..cfaf8f5 100644
--- a/drivers/acpi/sleep/sleep.h
+++ b/drivers/acpi/sleep/sleep.h
@@ -5,5 +5,3 @@ extern int acpi_suspend (u32 state);
 extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
 extern void acpi_enable_wakeup_device(u8 sleep_state);
 extern void acpi_disable_wakeup_device(u8 sleep_state);
-
-extern int acpi_sleep_prepare(u32 acpi_state);
-- 
1.5.4.rc5.16.gc0279
