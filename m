From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] tracing / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Sat, 06 Dec 2014 03:40:52 +0100
Message-ID: <1729515.GUkTny2h5Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56474 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751482AbaLFCTZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Dec 2014 21:19:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so files that are
build conditionally if CONFIG_PM_RUNTIME is set may now be build
if CONFIG_PM is set.

Replace CONFIG_PM_RUNTIME with CONFIG_PM in kernel/trace/Makefile
for this reason.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
PM_SLEEP is selected) which is only in linux-next at the moment (via the
linux-pm tree).

Please let me know if it is OK to take this one into linux-pm.

---
 kernel/trace/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/kernel/trace/Makefile
===================================================================
--- linux-pm.orig/kernel/trace/Makefile
+++ linux-pm/kernel/trace/Makefile
@@ -55,7 +55,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_eve
 obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
 obj-$(CONFIG_KPROBE_EVENT) += trace_kprobe.o
 obj-$(CONFIG_TRACEPOINTS) += power-traces.o
-ifeq ($(CONFIG_PM_RUNTIME),y)
+ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_TRACEPOINTS) += rpm-traces.o
 endif
 ifeq ($(CONFIG_TRACING),y)

