From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] run sysrq poweroff on boot cpu
Date: Thu, 03 Jul 2008 15:56:54 +0800
Message-ID: <1215071814.3214.1.camel@rzhang-dt.sh.intel.com>
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
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: harbour@sfinx.od.ua
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

schedule sysrq poweroff on boot cpu.

sysrq poweroff needs to disable nonboot cpus, and we need to run this
on boot cpu to avoid any recursion.
http://bugzilla.kernel.org/show_bug.cgi?id=10897

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
tested-by: Rus <harbour@sfinx.od.ua>
---
 kernel/power/poweroff.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/poweroff.c
===================================================================
--- linux-2.6.orig/kernel/power/poweroff.c	2008-06-30 16:01:35.000000000 +0800
+++ linux-2.6/kernel/power/poweroff.c	2008-07-03 10:50:05.000000000 +0800
@@ -25,7 +25,8 @@
 
 static void handle_poweroff(int key, struct tty_struct *tty)
 {
-	schedule_work(&poweroff_work);
+	/* run sysrq poweroff on boot cpu */
+	schedule_work_on(first_cpu(cpu_online_map), &poweroff_work);
 }
 
 static struct sysrq_key_op	sysrq_poweroff_op = {
