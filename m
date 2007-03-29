From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch, v2] add suspend/resume for HPET
Date: Thu, 29 Mar 2007 19:47:35 +0200
Message-ID: <20070329174735.GA3216@elte.hu>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703290747.28929.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703290930540.6730@woody.linux-foundation.org>
	<200703291851.19424.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703291022100.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703291022100.6730@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


update: i've tested Maxim's v2 patch on both a hpet-capable and a =

hpet-less system, and it works fine here.

on a dual-core hpet-capable system, running a NO_HZ+!HIGH_RES_TIMERS =

kernel:

  europe:~> grep Clock /proc/timer_list
  Clock Event Device: hpet
  Clock Event Device: lapic
  Clock Event Device: lapic

s2ram works fine now - it hung on resume before.

on a dual-core non-hpet system, with a NO_HZ+!HIGH_RES_TIMERS kernel:

  neptune:~> grep Clock /proc/timer_list
  Clock Event Device: pit
  Clock Event Device: lapic
  Clock Event Device: lapic

s2ram worked fine before - and it still works now.

(The combination of NO_HZ+!HIGH_RES_TIMERS was the most fragile wrt. =

suspend because in the !HIGH_RES_TIMERS there's just a single instance =

after resume that we touch the timer hardware, and we very much rely on =

the periodic interrupt being set to the precise value.)

So this is a go on my systems - good work Maxim! (I've reproduced =

Maxim's patch below with minor patch-metadata updates.)

	Ingo

---------------------------->
Subject: [patch] add suspend/resume for HPET
From: Maxim Levitsky <maximlevitsky@gmail.com>

This adds support for suspend/resume on i386 for HPET.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>

---
 arch/i386/kernel/hpet.c |   68 +++++++++++++++++++++++++++++++++++++++++++=
+++++
 1 file changed, 68 insertions(+)

Index: linux/arch/i386/kernel/hpet.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/i386/kernel/hpet.c
+++ linux/arch/i386/kernel/hpet.c
@@ -3,6 +3,8 @@
 #include <linux/errno.h>
 #include <linux/hpet.h>
 #include <linux/init.h>
+#include <linux/sysdev.h>
+#include <linux/pm.h>
 =

 #include <asm/hpet.h>
 #include <asm/io.h>
@@ -307,6 +309,7 @@ int __init hpet_enable(void)
 out_nohpet:
 	iounmap(hpet_virt_address);
 	hpet_virt_address =3D NULL;
+	boot_hpet_disable =3D 1;
 	return 0;
 }
 =

@@ -523,3 +526,68 @@ irqreturn_t hpet_rtc_interrupt(int irq, =

 	return IRQ_HANDLED;
 }
 #endif
+
+
+/*
+ * Suspend/resume part
+ */
+
+#ifdef CONFIG_PM
+
+static int hpet_suspend(struct sys_device *sys_device, pm_message_t state)
+{
+	unsigned long cfg =3D hpet_readl(HPET_CFG);
+
+	cfg &=3D ~(HPET_CFG_ENABLE|HPET_CFG_LEGACY);
+	hpet_writel(cfg, HPET_CFG);
+
+	return 0;
+}
+
+static int hpet_resume(struct sys_device *sys_device)
+{
+	unsigned int id;
+
+	hpet_start_counter();
+
+	id =3D hpet_readl(HPET_ID);
+
+	if (id & HPET_ID_LEGSUP)
+		hpet_enable_int();
+
+	return 0;
+}
+
+static struct sysdev_class hpet_class =3D {
+	set_kset_name("hpet"),
+	.suspend	=3D hpet_suspend,
+	.resume		=3D hpet_resume,
+};
+
+static struct sys_device hpet_device =3D {
+	.id		=3D 0,
+	.cls		=3D &hpet_class,
+};
+
+
+static __init int hpet_register_sysfs(void)
+{
+	int err;
+
+	if (!is_hpet_capable())
+		return 0;
+
+	err =3D sysdev_class_register(&hpet_class);
+
+	if (!err) {
+		err =3D sysdev_register(&hpet_device);
+		if (err)
+			sysdev_class_unregister(&hpet_class);
+	}
+
+	return err;
+}
+
+device_initcall(hpet_register_sysfs);
+
+#endif
