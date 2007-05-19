From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: (fwd) empty /sys/power/state?
Date: Sun, 20 May 2007 01:33:16 +0200 (CEST)
Message-ID: <tkrat.64219d323de1c016@s5r6.in-berlin.de>
References: <Pine.LNX.4.44L0.0705191714070.32062-100000@netrider.rowland.org>
	<200705200053.58388.rjw@sisk.pl> <464F8395.4080300@s5r6.in-berlin.de>
	<200705200120.45892.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705200120.45892.rjw@sisk.pl>
Content-Disposition: INLINE
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> We use the CPU hotplug code for disabling/enabling nonboot CPUs.
> 
> You need to enable it to be able to suspend (BTW, it's also necesary for
> the suspend to RAM).

I now noticed that this is documented in the help text of i386's
Kconfig.  But it is not mentioned in the help text of x86_64's Kconfig.
Also, I think that should already be shown in the prompt, not just in
the help text.


From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: i386, x86-64: show that CONFIG_HOTPLUG_CPU is required for suspend on SMP

Point out the non-obvious.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 arch/i386/Kconfig   |    2 +-
 arch/x86_64/Kconfig |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -891,7 +891,7 @@ config PHYSICAL_ALIGN
 	  Don't change this unless you know what you are doing.
 
 config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	bool "Support for suspend on SMP hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
 	---help---
 	  Say Y here to experiment with turning CPUs off and on, and to
Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig
+++ linux/arch/x86_64/Kconfig
@@ -428,12 +428,15 @@ config NR_CPUS
 	  memory in the static kernel configuration.
 
 config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	bool "Support for suspend on SMP and hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL
 	help
 		Say Y here to experiment with turning CPUs off and on.  CPUs
 		can be controlled through /sys/devices/system/cpu/cpu#.
-		Say N if you want to disable CPU hotplug.
+		This is also required for suspend on SMP systems.
+
+		Say N if you want to disable CPU hotplug and don't need to
+		suspend.
 
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y


-- 
Stefan Richter
-=====-=-=== -=-= =-=--
http://arcgraph.de/sr/
