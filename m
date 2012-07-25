From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/52] ACPICA: Lint fixes for acpi_write,
	no functional changes
Date: Tue, 24 Jul 2012 23:40:59 -0400
Message-ID: <5134abfcfb4a8a9ef42c82dabad05762fbf04376.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

acpi_write was widened to 64-bit data, this change eliminates some
lint warnings.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwesleep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 29e8592..3680c45 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -117,7 +117,8 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state, u8 flags)
 
 	/* Clear wake status (WAK_STS) */
 
-	status = acpi_write(ACPI_X_WAKE_STATUS, &acpi_gbl_FADT.sleep_status);
+	status =
+	    acpi_write((u64)ACPI_X_WAKE_STATUS, &acpi_gbl_FADT.sleep_status);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -147,7 +148,7 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state, u8 flags)
 	    ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
 	     ACPI_X_SLEEP_TYPE_MASK);
 
-	status = acpi_write((sleep_type_value | ACPI_X_SLEEP_ENABLE),
+	status = acpi_write((u64)(sleep_type_value | ACPI_X_SLEEP_ENABLE),
 			    &acpi_gbl_FADT.sleep_control);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -195,7 +196,7 @@ acpi_status acpi_hw_extended_wake_prep(u8 sleep_state, u8 flags)
 		    ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
 		     ACPI_X_SLEEP_TYPE_MASK);
 
-		(void)acpi_write((sleep_type_value | ACPI_X_SLEEP_ENABLE),
+		(void)acpi_write((u64)(sleep_type_value | ACPI_X_SLEEP_ENABLE),
 				 &acpi_gbl_FADT.sleep_control);
 	}
 
@@ -239,7 +240,7 @@ acpi_status acpi_hw_extended_wake(u8 sleep_state, u8 flags)
 	 * and use it to determine whether the system is rebooting or
 	 * resuming. Clear WAK_STS for compatibility.
 	 */
-	(void)acpi_write(ACPI_X_WAKE_STATUS, &acpi_gbl_FADT.sleep_status);
+	(void)acpi_write((u64)ACPI_X_WAKE_STATUS, &acpi_gbl_FADT.sleep_status);
 	acpi_gbl_system_awake_and_running = TRUE;
 
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
-- 
1.7.12.rc0
