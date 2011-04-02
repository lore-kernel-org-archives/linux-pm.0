From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/18] x86 idle: EXPORT_SYMBOL(default_idle,
 pm_idle) only when APM demands it
Date: Sat, 02 Apr 2011 02:22:46 -0400
Message-ID: <dba24a423948935d0a0c1eb32414a476f3f90e02.1301724243.git.len.brown__38281.2365344309$1301725715$gmane$org@intel.com>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1301725380-10579-1-git-send-email-lenb@kernel.org>
In-reply-to: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
References: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
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
index ff45541..17b8771 100644
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
1.7.5.rc0
