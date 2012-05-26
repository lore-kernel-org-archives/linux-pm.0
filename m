From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT][PATCH 1/4] ACPI / PM: Make
	acpi_pm_device_sleep_state() follow the specification
Date: Sat, 26 May 2012 23:19:33 +0200
Message-ID: <201205262319.33464.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
	<201205262227.47442.rjw@sisk.pl> <201205262316.30096.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205262316.30096.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The comparison between the system sleep state being entered
and the lowest system sleep state the given device may wake up
from in acpi_pm_device_sleep_state() is reversed, because the
specification (ACPI 5.0) says that for wakeup to work:

"The sleeping state being entered must be less than or equal to the
 power state declared in element 1 of the _PRW object."

In other words, the state returned by _PRW is the deepest
(lowest-power) system sleep state the device is capable of waking up
the system from.

Moreover, acpi_pm_device_sleep_state() also should check if the
wakeup capability is supported through ACPI, because in principle it
may be done via native PCIe PME, for example, in which case _SxW
should not be evaluated.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/acpi/sleep.c
===================================================================
--- linux.orig/drivers/acpi/sleep.c
+++ linux/drivers/acpi/sleep.c
@@ -732,8 +732,8 @@ int acpi_pm_device_sleep_state(struct de
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (device_may_wakeup(dev) &&
-	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+	    (device_may_wakeup(dev) && adev->wakeup.flags.valid &&
+	     adev->wakeup.sleep_state >= acpi_target_sleep_state)) {
 		acpi_status status;
 
 		acpi_method[3] = 'W';
