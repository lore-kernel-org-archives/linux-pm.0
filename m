From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: [PATCH v2] xen: fix XEN_SAVE_RESTORE Kconfig dependencies
Date: Wed, 23 Feb 2011 08:23:41 -0800
Message-ID: <1298478221-14826-1-git-send-email-rshriram__17295.0554559522$1298478458$gmane$org@cs.ubc.ca>
References: <1298446066-11754-1-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298446066-11754-1-git-send-email-rshriram@cs.ubc.ca>
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
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org, Ian Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

Make XEN_SAVE_RESTORE depend on HIBERNATION.
Remove XEN_SAVE_RESTORE dependency from PM_SLEEP.

Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
---
 arch/x86/xen/Kconfig |    2 +-
 kernel/power/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 2c876ed..0e68597 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -38,7 +38,7 @@ config XEN_MAX_DOMAIN_MEMORY
 
 config XEN_SAVE_RESTORE
        bool
-       depends on XEN
+       depends on XEN && HIBERNATION
        default y
 
 config XEN_DEBUG_FS
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 4603f08..74fe864 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -85,7 +85,7 @@ config PM_STD_PARTITION
 
 config PM_SLEEP
 	def_bool y
-	depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
+	depends on SUSPEND || HIBERNATION
 
 config PM_SLEEP_SMP
 	def_bool y
-- 
1.7.0.4
