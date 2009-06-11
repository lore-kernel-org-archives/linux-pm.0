From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 01/19] PM: Warn if interrupts are enabled during
	suspend-resume of sysdevs
Date: Thu, 11 Jun 2009 21:42:35 +0000 (UTC)
Message-ID: <S4AoGnG.A.D7H.mZXMKB@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Sysdevs have to be suspended and resumed with interrupts disabled and
things usually break in a way that's difficult to debug if one of
sysdev drivers enables interrupts by mistake during suspend or
resume.  Add extra checks that will generate warnings in such cases.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/sys.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/base/sys.c b/drivers/base/sys.c
index 3236b43..9742a78 100644
--- a/drivers/base/sys.c
+++ b/drivers/base/sys.c
@@ -343,11 +343,15 @@ static void __sysdev_resume(struct sys_device *dev)
 	/* First, call the class-specific one */
 	if (cls->resume)
 		cls->resume(dev);
+	WARN_ONCE(!irqs_disabled(),
+		"Interrupts enabled after %pF\n", cls->resume);
 
 	/* Call auxillary drivers next. */
 	list_for_each_entry(drv, &cls->drivers, entry) {
 		if (drv->resume)
 			drv->resume(dev);
+		WARN_ONCE(!irqs_disabled(),
+			"Interrupts enabled after %pF\n", drv->resume);
 	}
 }
 
@@ -377,6 +381,9 @@ int sysdev_suspend(pm_message_t state)
 	if (ret)
 		return ret;
 
+	WARN_ONCE(!irqs_disabled(),
+		"Interrupts enabled while suspending system devices\n");
+
 	pr_debug("Suspending System Devices\n");
 
 	list_for_each_entry_reverse(cls, &system_kset->list, kset.kobj.entry) {
@@ -393,6 +400,9 @@ int sysdev_suspend(pm_message_t state)
 					if (ret)
 						goto aux_driver;
 				}
+				WARN_ONCE(!irqs_disabled(),
+					"Interrupts enabled after %pF\n",
+					drv->suspend);
 			}
 
 			/* Now call the generic one */
@@ -400,6 +410,9 @@ int sysdev_suspend(pm_message_t state)
 				ret = cls->suspend(sysdev, state);
 				if (ret)
 					goto cls_driver;
+				WARN_ONCE(!irqs_disabled(),
+					"Interrupts enabled after %pF\n",
+					cls->suspend);
 			}
 		}
 	}
@@ -452,6 +465,9 @@ int sysdev_resume(void)
 {
 	struct sysdev_class *cls;
 
+	WARN_ONCE(!irqs_disabled(),
+		"Interrupts enabled while resuming system devices\n");
+
 	pr_debug("Resuming System Devices\n");
 
 	list_for_each_entry(cls, &system_kset->list, kset.kobj.entry) {
-- 
1.5.2.4
