From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] CPU: Avoid using unititialized error variable in
	disable_nonboot_cpus()
Date: Thu, 27 May 2010 22:16:22 +0200
Message-ID: <201005272216.22472.rjw__33983.2052043223$1274991372$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If there's only one CPU online when disable_nonboot_cpus() is called,
the error variable will not be initialized and that may lead to
erroneous behavior.  Fix this issue by initializing error in
disable_nonboot_cpus() as appropriate.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/cpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/cpu.c
===================================================================
--- linux-2.6.orig/kernel/cpu.c
+++ linux-2.6/kernel/cpu.c
@@ -394,7 +394,7 @@ static cpumask_var_t frozen_cpus;
 
 int disable_nonboot_cpus(void)
 {
-	int cpu, first_cpu, error;
+	int cpu, first_cpu, error = 0;
 
 	cpu_maps_update_begin();
 	first_cpu = cpumask_first(cpu_online_mask);
