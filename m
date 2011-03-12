From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: [PATCH v3 5/5] xen: fix XEN_SAVE_RESTORE Kconfig
	dependencies
Date: Fri, 11 Mar 2011 21:08:03 -0800
Message-ID: <1299906483-31053-1-git-send-email-rshriram@cs.ubc.ca>
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
To: xen-devel@lists.xensource.com
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Make XEN_SAVE_RESTORE select HIBERNATION.
Remove XEN_SAVE_RESTORE dependency from PM_SLEEP.

Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
---
 arch/x86/xen/Kconfig |    1 +
 kernel/power/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 2c876ed..41e71f9 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -39,6 +39,7 @@ config XEN_MAX_DOMAIN_MEMORY
 config XEN_SAVE_RESTORE
        bool
        depends on XEN
+       select HIBERNATION
        default y
 
 config XEN_DEBUG_FS
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 493c678..41dafb2 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -90,7 +90,7 @@ config PM_STD_PARTITION
 
 config PM_SLEEP
 	def_bool y
-	depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
+	depends on SUSPEND || HIBERNATION
 
 config PM_SLEEP_SMP
 	def_bool y
-- 
1.7.0.4
