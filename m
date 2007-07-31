From: Len Brown <lenb@kernel.org>
Subject: [PATCH] create CONFIG_SUSPEND_UP_POSSIBLE
Date: Mon, 30 Jul 2007 23:54:22 -0400
Message-ID: <200707302354.23237.lenb__15924.9303200797$1185854462$gmane$org@kernel.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Without this change, it is possible to build CONFIG_HIBERNATE
on all !SMP architectures, but not necessarily their SMP versions.

I don't know for sure if the architecture list under SUSPEND_UP_POSSIBLE
is correct.  For now it simply matches the list for SUSPEND_SMP_POSSIBLE.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Kconfig |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 412859f..ccf6576 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -72,6 +72,11 @@ config PM_TRACE
 	CAUTION: this option will cause your machine's real-time clock to be
 	set to an invalid time after a resume.
 
+config SUSPEND_UP_POSSIBLE
+	bool
+	depends on (X86 && !X86_VOYAGER) || (PPC64 && (PPC_PSERIES || PPC_PMAC))
+	default y
+
 config SUSPEND_SMP_POSSIBLE
 	bool
 	depends on (X86 && !X86_VOYAGER) || (PPC64 && (PPC_PSERIES || PPC_PMAC))
@@ -92,7 +97,7 @@ config PM_SLEEP
 config SUSPEND
 	bool "Suspend to RAM and standby"
 	depends on PM
-	depends on !SMP || SUSPEND_SMP_POSSIBLE
+	depends on (!SMP && SUSPEND_UP_POSSIBLE) || (SMP && SUSPEND_SMP_POSSIBLE)
 	default y
 	---help---
 	  Allow the system to enter sleep states in which main memory is
