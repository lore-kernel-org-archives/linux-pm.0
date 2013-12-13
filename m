From: David Cohen <david.a.cohen@linux.intel.com>
Subject: [RFC/PATCH 1/3] pm: make PM macros more smart
Date: Thu, 12 Dec 2013 21:18:23 -0800
Message-ID: <1386911905-2366-2-git-send-email-david.a.cohen@linux.intel.com>
References: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz, rjw@rjwysocki.net, len.brown@intel.com, sarah.a.sharp@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, santosh.shilimkar@ti.com, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This patch makes SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() mor=
e
smart.

Despite those macros check for '#ifdef CONFIG_PM_SLEEP/RUNTIME' to avoi=
d
setting the callbacks when such #ifdef's aren't defined, they don't
handle compiler to avoid messages like that:

drivers/usb/host/xhci-plat.c:200:12: warning: =E2=80=98xhci_plat_suspen=
d=E2=80=99 defined but not used [-Wunused-function]
drivers/usb/host/xhci-plat.c:208:12: warning: =E2=80=98xhci_plat_resume=
=E2=80=99 defined but not used [-Wunused-function]

As result, those macros get rid of #ifdef's when setting callbacks but
not when implementing them.

With this patch, drivers using SET_*_PM_OPS() macros don't need to #ifd=
ef
the callbacks implementation as well.

Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
---
 include/linux/pm.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index a224c7f5c377..41a0f3b42209 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -299,6 +299,8 @@ struct dev_pm_ops {
 	int (*runtime_idle)(struct device *dev);
 };
=20
+#define MAKE_ME_NULL(fn) ((void *)((unsigned long)(fn) - (unsigned lon=
g)(fn)))
+
 #ifdef CONFIG_PM_SLEEP
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	.suspend =3D suspend_fn, \
@@ -308,7 +310,9 @@ struct dev_pm_ops {
 	.poweroff =3D suspend_fn, \
 	.restore =3D resume_fn,
 #else
-#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
+#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend =3D MAKE_ME_NULL(suspend_fn), \
+	.resume =3D MAKE_ME_NULL(resume_fn),
 #endif
=20
 #ifdef CONFIG_PM_RUNTIME
@@ -317,7 +321,10 @@ struct dev_pm_ops {
 	.runtime_resume =3D resume_fn, \
 	.runtime_idle =3D idle_fn,
 #else
-#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
+#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	.runtime_suspend =3D MAKE_ME_NULL(suspend_fn), \
+	.runtime_resume =3D MAKE_ME_NULL(resume_fn), \
+	.runtime_idle =3D MAKE_ME_NULL(idle_fn),
 #endif
=20
 /*
--=20
1.8.4.2
