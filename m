From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Tue, 17 Apr 2007 19:18:10 +0200
Message-ID: <1176830290.6225.9.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175810054.3489.34.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

For powermac, we need to do some things between suspending devices and
device_power_off, for example setting the decrementer. This patch
allows architectures to define arch_s2ram_{en,dis}able_irqs in their
asm/suspend.h to have control over this step.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
Even though I don't like it, here it is. I still don't see why this
shouldn't be part of pm_ops when pm_ops is responsible for everything
else related to s2ram. But it at least lets me do what I need to.

 kernel/power/main.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- wireless-dev.orig/kernel/power/main.c	2007-04-17 18:52:24.536830941 +02=
00
+++ wireless-dev/kernel/power/main.c	2007-04-17 19:09:40.966830941 +0200
@@ -128,13 +128,22 @@ static int suspend_prepare(suspend_state
 	return error;
 }
 =

+#ifndef arch_s2ram_disable_irqs
+#define arch_s2ram_disable_irqs(flags) local_irq_save(*flags)
+#endif
+
+#ifndef arch_s2ram_enable_irqs
+#define arch_s2ram_enable_irqs(flags) local_irq_restore(*flags)
+#endif
+
 =

 int suspend_enter(suspend_state_t state)
 {
 	int error =3D 0;
 	unsigned long flags;
 =

-	local_irq_save(flags);
+	arch_s2ram_disable_irqs(&flags);
+	BUG_ON(!irqs_disabled());
 =

 	if ((error =3D device_power_down(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to power down\n");
@@ -143,7 +152,8 @@ int suspend_enter(suspend_state_t state)
 	error =3D pm_ops->enter(state);
 	device_power_up();
  Done:
-	local_irq_restore(flags);
+	arch_s2ram_enable_irqs(&flags);
+	BUG_ON(irqs_disabled());
 	return error;
 }
 =
