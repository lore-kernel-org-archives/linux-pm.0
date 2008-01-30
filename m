From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] CPUidle: compile fix for non-x86
Date: Tue, 29 Jan 2008 21:52:12 -0800
Message-ID: <871w7zn9mb.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Wrap cpu_idle_wait() in an x86 #ifdef since it's x86 only.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d2fabe7..4d0f9b0 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -82,7 +82,9 @@ void cpuidle_uninstall_idle_handler(void)
 {
 	if (enabled_devices && (pm_idle != pm_idle_old)) {
 		pm_idle = pm_idle_old;
+#ifdef CONFIG_X86
 		cpu_idle_wait();
+#endif
 	}
 }
