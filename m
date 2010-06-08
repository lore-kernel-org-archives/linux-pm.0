From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/5] ACPI / ACPICA: Fix sysfs GPE interface
Date: Tue, 8 Jun 2010 10:50:53 +0200
Message-ID: <201006081050.53599.rjw__13120.4505138614$1275988699$gmane$org@sisk.pl>
References: <201006080024.46142.rjw@sisk.pl> <201006081046.48488.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006081046.48488.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The sysfs interface allowing user space to disable/enable GPEs
doesn't work correctly, because a GPE disabled this way will be
re-enabled shortly by acpi_ev_asynch_enable_gpe() if it was
previosuly enabled by acpi_enable_gpe() (in which case the
corresponding bit in its enable register's enable_for_run mask is
set).

To address this issue make the sysfs GPE interface use
acpi_enable_gpe() and acpi_disable_gpe() instead of acpi_set_gpe()
so that GPE reference counters are modified by it along with the
values of GPE enable registers.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/system.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/system.c
===================================================================
--- linux-2.6.orig/drivers/acpi/system.c
+++ linux-2.6/drivers/acpi/system.c
@@ -388,10 +388,12 @@ static ssize_t counter_set(struct kobjec
 	if (index < num_gpes) {
 		if (!strcmp(buf, "disable\n") &&
 				(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_set_gpe(handle, index, ACPI_GPE_DISABLE);
+			result = acpi_disable_gpe(handle, index,
+						ACPI_GPE_TYPE_RUNTIME);
 		else if (!strcmp(buf, "enable\n") &&
 				!(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_set_gpe(handle, index, ACPI_GPE_ENABLE);
+			result = acpi_enable_gpe(handle, index,
+						ACPI_GPE_TYPE_RUNTIME);
 		else if (!strcmp(buf, "clear\n") &&
 				(status & ACPI_EVENT_FLAG_SET))
 			result = acpi_clear_gpe(handle, index);
