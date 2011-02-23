From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: [PATCH] xen: fix XEN_SAVE_RESTORE Kconfig dependencies
Date: Tue, 22 Feb 2011 23:27:46 -0800
Message-ID: <1298446066-11754-1-git-send-email-rshriram__49321.6756651693$1298446898$gmane$org@cs.ubc.ca>
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
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

Make XEN_SAVE_RESTORE user visible and enable HIBERNATION and SWAP,
if this option is enabled.
Remove XEN_SAVE_RESTORE dependancy from PM_SLEEP.

Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
---
 arch/x86/xen/Kconfig |    6 ++++--
 kernel/power/Kconfig |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 5b54892..ab6c3a2 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -37,8 +37,10 @@ config XEN_MAX_DOMAIN_MEMORY
          portions of which are freed.
 
 config XEN_SAVE_RESTORE
-       bool
-       depends on XEN && PM
+       bool "Enable Xen Guest save/restore/checkpoint"
+       depends on XEN
+       select SWAP
+       select HIBERNATION
        default y
 
 config XEN_DEBUG_FS
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 2657299..ccff0ba 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -92,7 +92,7 @@ config PM_SLEEP_SMP
 
 config PM_SLEEP
 	bool
-	depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
+	depends on SUSPEND || HIBERNATION
 	default y
 
 config PM_SLEEP_ADVANCED_DEBUG
-- 
1.7.0.4
