From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH v2] Add suspend/resume for HPET
Date: Thu, 29 Mar 2007 15:46:48 +0200
Message-ID: <200703291546.48996.maximlevitsky@gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<460BBD1B.4040308@ru.mvista.com>
	<200703291531.18253.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703291531.18253.maximlevitsky@gmail.com>
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
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: gregkh@suse.de, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Subject: Add suspend/resume for HPET
This adds support of suspend/resume on i386 for HPET
Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>

---
 arch/i386/kernel/hpet.c |   68 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
index 0fd9fba..7c67780 100644
--- a/arch/i386/kernel/hpet.c
+++ b/arch/i386/kernel/hpet.c
@@ -3,6 +3,8 @@
 #include <linux/errno.h>
 #include <linux/hpet.h>
 #include <linux/init.h>
+#include <linux/sysdev.h>
+#include <linux/pm.h>
 =

 #include <asm/hpet.h>
 #include <asm/io.h>
@@ -310,6 +312,7 @@ int __init hpet_enable(void)
 out_nohpet:
 	iounmap(hpet_virt_address);
 	hpet_virt_address =3D NULL;
+	boot_hpet_disable =3D 1;
 	return 0;
 }
 =

@@ -524,3 +527,68 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
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
-- =

1.4.4.2
