From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/11] ACPI / PM: Report wakeup events from buttons
Date: Thu, 6 Jan 2011 23:36:01 +0100
Message-ID: <201101062336.01492.rjw__38408.5694131956$1294355744$gmane$org@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since ACPI buttons and lids can be configured to wake up the system
from sleep states, report wakeup events from these devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/button.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/acpi/button.c
===================================================================
--- linux-2.6.orig/drivers/acpi/button.c
+++ linux-2.6/drivers/acpi/button.c
@@ -279,6 +279,9 @@ static int acpi_lid_send_state(struct ac
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
 
+	if (state)
+		pm_wakeup_event(&device->dev, 0);
+
 	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret == NOTIFY_DONE)
 		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
@@ -314,6 +317,8 @@ static void acpi_button_notify(struct ac
 			input_sync(input);
 			input_report_key(input, keycode, 0);
 			input_sync(input);
+
+			pm_wakeup_event(&device->dev, 0);
 		}
 
 		acpi_bus_generate_proc_event(device, event, ++button->pushed);
