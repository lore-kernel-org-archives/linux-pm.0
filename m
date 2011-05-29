From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/8] x86 idle: EXPORT_SYMBOL(default_idle,
 pm_idle) only when APM demands it
Date: Sun, 29 May 2011 05:41:46 -0400
Message-ID: <06ae40ce073daf233607a3c54a489f2c1e44683e.1306662035.git.len.brown@intel.com>
References: <1306662110-29954-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1306662110-29954-1-git-send-email-lenb@kernel.org>
In-reply-to: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
References: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

In the long run, we don't want default_idle() or (pm_idle)() to
be exported outside of process.c.  Start by not exporting them
to modules, unless the APM build demands it.

cc: x86@kernel.org
cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/process.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 2efbfb7..84f3cda 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -340,7 +340,9 @@ EXPORT_SYMBOL(boot_option_idle_override);
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
+#if defined(CONFIG_APM_MODULE) && defined(CONFIG_APM_CPU_IDLE)
 EXPORT_SYMBOL(pm_idle);
+#endif
 
 #ifdef CONFIG_X86_32
 /*
@@ -400,7 +402,7 @@ void default_idle(void)
 		cpu_relax();
 	}
 }
-#ifdef CONFIG_APM_MODULE
+#if defined(CONFIG_APM_MODULE) && defined(CONFIG_APM_CPU_IDLE)
 EXPORT_SYMBOL(default_idle);
 #endif
 
-- 
1.7.5.3.367.ga9930.dirty
