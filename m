From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] PM: Do not destroy/create devices while
	suspended in cpuid.c
Date: Wed, 2 Jan 2008 00:42:11 +0100
Message-ID: <200801020042.12466.rjw__4907.31443646855$1199230943$gmane$org@sisk.pl>
References: <200801020032.45529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801020032.45529.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The cpuid driver should not attempt to destroy/create a device while
suspended, unless this device corresponds to a nonboot CPU that
failed to go online during a resume, in which case the PM core should
be asked to remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/cpuid.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/x86/kernel/cpuid.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpuid.c
+++ linux-2.6/arch/x86/kernel/cpuid.c
@@ -157,15 +157,15 @@ static int __cpuinit cpuid_class_cpu_cal
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-	case CPU_UP_PREPARE_FROZEN:
 		err = cpuid_device_create(cpu);
 		break;
 	case CPU_UP_CANCELED:
-	case CPU_UP_CANCELED_FROZEN:
 	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
 		cpuid_device_destroy(cpu);
 		break;
+	case CPU_UP_CANCELED_FROZEN:
+		destroy_suspended_device(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
+		break;
 	}
 	return err ? NOTIFY_BAD : NOTIFY_OK;
 }
