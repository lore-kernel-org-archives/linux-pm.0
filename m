From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/15] ACPI / PM: Make
	acpi_pm_device_sleep_state() follow the specification
Date: Mon,  4 Jun 2012 01:39:58 -0400
Message-ID: <dbe9a2edd17d843d80faf2b99f20a691c1853418.1338786831.git.len.brown@intel.com>
References: <1338788406-29981-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338788406-29981-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
References: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
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
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>

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
 drivers/acpi/sleep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index a564fc3..d8b381e 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -773,8 +773,8 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (device_may_wakeup(dev) &&
-	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+	    (device_may_wakeup(dev) && adev->wakeup.flags.valid &&
+	     adev->wakeup.sleep_state >= acpi_target_sleep_state)) {
 		acpi_status status;
 
 		acpi_method[3] = 'W';
-- 
1.7.11.rc0.100.g5498c5f
