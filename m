From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: delete CONFIG_ACPI_PROCFS_SLEEP (again)
Date: Tue, 31 Jul 2007 23:27:10 -0400
Message-ID: <200707312327.10755.lenb@kernel.org>
References: <200707251238.50218.lenb@kernel.org>
	<200707292323.29601.rjw@sisk.pl>
	<alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

CONFIG_ACPI_PROCFS_SLEEP is a NO-OP -- delete it (again).

Apparently 296699de6bdc717189a331ab6bbe90e05c94db06 creating CONFIG_SUSPEND
and CONFIG_PM_SLEEP was based on an out-dated version of drivers/acpi/Kconfig,
as it erroneously restored this recently deleted config option.

Signed-off-by: Len Brown <len.brown@intel.com>
---
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 934d639..f1372de 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -68,14 +68,6 @@ config ACPI_PROCFS
 
 	  Say N to delete /proc/acpi/ files that have moved to /sys/
 
-config ACPI_PROCFS_SLEEP
-	bool "/proc/acpi/sleep (deprecated)"
-	depends on PM_SLEEP && ACPI_PROCFS
-	default n
-	---help---
-	  Create /proc/acpi/sleep
-	  Deprecated by /sys/power/state
-
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
