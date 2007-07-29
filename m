From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] unexport pm_power_off_prepare
Date: Sun, 29 Jul 2007 16:59:35 +0200
Message-ID: <20070729145935.GJ16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: pavel@suse.cz, rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(pm_power_off_prepare).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.23-rc1-mm1/kernel/sys.c.old	2007-07-28 07:38:45.000000000 +0200
+++ linux-2.6.23-rc1-mm1/kernel/sys.c	2007-07-28 07:38:59.000000000 +0200
@@ -104,7 +104,6 @@ EXPORT_SYMBOL(cad_pid);
  */
 
 void (*pm_power_off_prepare)(void);
-EXPORT_SYMBOL(pm_power_off_prepare);
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
