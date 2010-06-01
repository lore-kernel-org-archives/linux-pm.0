From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 2/2] ACPI: Store NVS state even when entering
	suspend to RAM
Date: Tue,  1 Jun 2010 21:22:24 +0300
Message-ID: <1275416544-4515-2-git-send-email-maximlevitsky__6041.78371509096$1275416853$gmane$org@gmail.com>
References: <1275416390.3778.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275416390.3778.7.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=13931 describes a bug where
a system fails to successfully resume after the second suspend. Maxim
Levitsky discovered that this could be rectified by forcibly saving
and restoring the ACPI non-volatile state. The spec indicates that this
is only required for S4, but testing the behaviour of Windows by adding
an ACPI NVS region to qemu's e820 map and registering a custom memory
read/write handler reveals that it's saved and restored even over suspend
to RAM. We should mimic that behaviour to avoid other broken platforms.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 drivers/acpi/sleep.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index bdb306f..5d26d8e 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -114,6 +114,8 @@ static int __acpi_pm_prepare(void)
 {
 	int error = acpi_sleep_prepare(acpi_target_sleep_state);
 
+	suspend_nvs_save();
+
 	if (error)
 		acpi_target_sleep_state = ACPI_STATE_S0;
 	return error;
@@ -143,6 +145,8 @@ static void acpi_pm_finish(void)
 {
 	u32 acpi_state = acpi_target_sleep_state;
 
+	suspend_nvs_free();
+
 	if (acpi_state == ACPI_STATE_S0)
 		return;
 
@@ -192,6 +196,11 @@ static int acpi_suspend_begin(suspend_state_t pm_state)
 	u32 acpi_state = acpi_suspend_states[pm_state];
 	int error = 0;
 
+	error = suspend_nvs_alloc();
+
+	if (error)
+		return error;
+
 	if (sleep_states[acpi_state]) {
 		acpi_target_sleep_state = acpi_state;
 		acpi_sleep_tts_switch(acpi_target_sleep_state);
@@ -269,6 +278,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	if (acpi_state == ACPI_STATE_S3)
 		acpi_restore_state_mem();
 
+	suspend_nvs_restore();
+
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
@@ -443,7 +454,6 @@ static int acpi_hibernation_enter(void)
 
 static void acpi_hibernation_finish(void)
 {
-	suspend_nvs_free();
 	acpi_ec_unblock_transactions();
 	acpi_pm_finish();
 }
@@ -479,7 +489,7 @@ static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.begin = acpi_hibernation_begin,
 	.end = acpi_pm_end,
 	.pre_snapshot = acpi_hibernation_pre_snapshot,
-	.finish = acpi_hibernation_finish,
+	.finish = acpi_pm_finish,
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-- 
1.7.0.4
