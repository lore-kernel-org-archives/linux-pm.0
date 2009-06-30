From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: [PATCH] pm: clear -EAGAIN in dpm_prepare
Date: Tue, 30 Jun 2009 16:50:47 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906301647520.3286@localhost.localdomain>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

pm: clear -EAGAIN in dpm_prepare

When the last device in the dpm list is unregistered directly after its
prepare() callback returned with -EAGAIN, the return code is passed to
the calling function, resulting in a resume failure. Prevent this by
clearing the return code after -EAGAIN.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 drivers/base/power/main.c |    1 +
 1 file changed, 1 insertion(+)

Index: git.linux-2.6/drivers/base/power/main.c
===================================================================
--- git.linux-2.6.orig/drivers/base/power/main.c	2009-06-30 12:27:33.000000000 +0200
+++ git.linux-2.6/drivers/base/power/main.c	2009-06-30 12:38:26.000000000 +0200
@@ -762,6 +762,7 @@ static int dpm_prepare(pm_message_t stat
 			dev->power.status = DPM_ON;
 			if (error == -EAGAIN) {
 				put_device(dev);
+				error = 0;
 				continue;
 			}
 			printk(KERN_ERR "PM: Failed to prepare device %s "
