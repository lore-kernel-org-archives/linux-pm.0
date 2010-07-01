From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5] ACPI / Sleep: Do not allocate memory for
	saving NVS in advance
Date: Fri, 2 Jul 2010 00:11:21 +0200
Message-ID: <201007020011.22118.rjw__9241.44449313662$1278022670$gmane$org@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007020010.13755.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

We only can try to allocate memory for saving the NVS region if it
is known that the target system sleep state is valid.  Otherwise
we will leak memory if suspend_nvs_alloc() is successful and the
target state is invalid, because suspend_nvs_free() will not be
called in that case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -195,20 +195,15 @@ static u32 acpi_suspend_states[] = {
 static int acpi_suspend_begin(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
-	int error = 0;
-
-	error = suspend_nvs_alloc();
-
-	if (error)
-		return error;
+	int error = -ENOSYS;
 
 	if (sleep_states[acpi_state]) {
 		acpi_target_sleep_state = acpi_state;
 		acpi_sleep_tts_switch(acpi_target_sleep_state);
+		error = suspend_nvs_alloc();
 	} else {
 		printk(KERN_ERR "ACPI does not support this state: %d\n",
 			pm_state);
-		error = -ENOSYS;
 	}
 	return error;
 }
