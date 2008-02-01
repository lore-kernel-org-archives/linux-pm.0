From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/37] PM: Make PM_TRACE more architecture
	independent
Date: Thu, 31 Jan 2008 23:36:44 -0500
Message-ID: <76eb98a092c3481b3c1f1b9c67c97e77b8cdcea0.1201840183.git.len.brown__7246.6057762087$1201842917$gmane$org@intel.com>
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
Cc: linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/base/power/Makefile |    2 +-
 kernel/power/Kconfig        |   23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index de28dfd..911208b 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_PM)	+= sysfs.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o
-obj-$(CONFIG_PM_TRACE)	+= trace.o
+obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 ccflags-$(CONFIG_PM_VERBOSE)   += -DDEBUG
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 8e186c6..06a08f7 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
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
-- 
1.5.4.rc5.16.gc0279
