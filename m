From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] CPU hotplug,
	PM: Remove unused symbol 'suspend_cpu_hotplug'
Date: Fri, 28 Oct 2011 19:17:40 +0530
Message-ID: <20111028134737.18461.60249.stgit__48428.653975907$1319809760$gmane$org@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: mingo@elte.hu, amwang@redhat.com, linux-pm@vger.kernel.org, gregkh@suse.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, a.p.zijlstra@chello.nl
List-Id: linux-pm@vger.kernel.org



Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/cpu.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index b1a635a..6cb60fd 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -196,13 +196,9 @@ static inline void cpu_hotplug_driver_unlock(void)
 #endif		/* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_PM_SLEEP_SMP
-extern int suspend_cpu_hotplug;
-
 extern int disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
 #else /* !CONFIG_PM_SLEEP_SMP */
-#define suspend_cpu_hotplug	0
-
 static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
 #endif /* !CONFIG_PM_SLEEP_SMP */
