From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] PM_SLEEP_SMP: fix kconfig warning
Date: Sat, 11 Sep 2010 15:57:20 -0700
Message-ID: <20100911155720.c4fe6b4b.randy.dunlap__48652.7323177599$1284246103$gmane$org@oracle.com>
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
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix kconfig unmet dependency warning:

warning: (PM_SLEEP_SMP && SMP && (ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE) && PM_SLEEP) selects HOTPLUG_CPU which has unmet direct dependencies (SMP && HOTPLUG)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 kernel/power/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20100908.orig/kernel/power/Kconfig
+++ linux-next-20100908/kernel/power/Kconfig
@@ -83,7 +83,7 @@ config PM_TRACE_RTC
 
 config PM_SLEEP_SMP
 	bool
-	depends on SMP
+	depends on SMP && HOTPLUG
 	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
