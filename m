From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/8] PM: Make PM_TRACE more architecture
	independent
Date: Mon, 19 Nov 2007 23:46:16 +0100
Message-ID: <200711192346.17365.rjw__8933.15066718987$1195512122$gmane$org@sisk.pl>
References: <200711192332.15078.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711192332.15078.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Adrian Bunk <bunk@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>

When trying to debug a suspend failure I started implementing
PM_TRACE for powerpc. I then noticed that I'm debugging a suspend
failure and so PM_TRACE isn't useful at all, but thought that
nonetheless this could be useful in the future.

Basically, to support PM_TRACE, you add a Kconfig option that
selects PM_TRACE and provides the infrastructure as per the
help text of PM_TRACE.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/Makefile |    2 +-
 kernel/power/Kconfig        |   23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/base/power/Makefile
===================================================================
--- linux-2.6.orig/drivers/base/power/Makefile
+++ linux-2.6/drivers/base/power/Makefile
@@ -1,7 +1,7 @@
 obj-y			:= shutdown.o
 obj-$(CONFIG_PM)	+= sysfs.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o
-obj-$(CONFIG_PM_TRACE)	+= trace.o
+obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -44,9 +44,30 @@ config PM_VERBOSE
 	---help---
 	This option enables verbose messages from the Power Management code.
 
+config CAN_PM_TRACE
+	def_bool y
+	depends on PM_DEBUG && PM_SLEEP && EXPERIMENTAL
+
 config PM_TRACE
+	bool
+	help
+	  This enables code to save the last PM event point across
+	  reboot. The architecture needs to support this, x86 for
+	  example does by saving things in the RTC, see below.
+
+	  The architecture specific code must provide the extern
+	  functions from <linux/resume-trace.h> as well as the
+	  <asm/resume-trace.h> header with a TRACE_RESUME() macro.
+
+	  The way the information is presented is architecture-
+	  dependent, x86 will print the information during a
+	  late_initcall.
+
+config PM_TRACE_RTC
 	bool "Suspend/resume event tracing"
-	depends on PM_DEBUG && X86 && PM_SLEEP && EXPERIMENTAL
+	depends on CAN_PM_TRACE
+	depends on X86
+	select PM_TRACE
 	default n
 	---help---
 	This enables some cheesy code to save the last PM event point in the
