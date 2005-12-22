From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: What woke system up?
Date: Wed, 21 Dec 2005 19:46:30 -0800
Message-ID: <20051222034630.GA4320@slurryseal.ddns.mvista.com>
References: <20051221002958.GA15851@slurryseal.ddns.mvista.com>
	<Pine.LNX.4.50.0512201809520.21656-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7495033403506639=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512201809520.21656-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============7495033403506639==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 20, 2005 at 06:11:40PM -0800, Patrick Mochel wrote:
> What about stashing a pointer to the device that did the wakeup, then
> using a symlink to point to the sysfs directory of that device? That way,
> instead of some arbitrary string, like "wake wake wake", you can
> definitively know what device it was, as well as any other status..
> 
> You can remove the symlink on suspend, just like you could clear the
> string, and re-add it on resume.

Sounds good, here's a new version that does just that.  Any further
improvements?  Thanks -- Todd

Add /sys/power/waker and pm_set_waker() for querying which device woke
the system.

Signed-off-by: Todd Poynor <tpoynor@mvista.com>

Index: linux-2.6.15-rc4/kernel/power/main.c
===================================================================
--- linux-2.6.15-rc4.orig/kernel/power/main.c
+++ linux-2.6.15-rc4/kernel/power/main.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/device.h>
 
 
 #include "power.h"
@@ -27,6 +28,8 @@ DECLARE_MUTEX(pm_sem);
 struct pm_ops *pm_ops;
 suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
 
+static void clear_waker(void);
+
 /**
  *	pm_set_ops - Set the global power method table. 
  *	@ops:	Pointer to ops structure.
@@ -108,6 +111,7 @@ static int suspend_enter(suspend_state_t
 	int error = 0;
 	unsigned long flags;
 
+	clear_waker();
 	local_irq_save(flags);
 
 	if ((error = device_power_down(PMSG_SUSPEND))) {
@@ -281,6 +285,16 @@ static ssize_t state_store(struct subsys
 
 power_attr(state);
 
+static void clear_waker(void)
+{
+	sysfs_remove_link(&power_subsys.kset.kobj, "waker");
+}
+
+void pm_set_waker(struct device *dev)
+{
+	sysfs_create_link(&power_subsys.kset.kobj, &dev->kobj, "waker");
+}
+
 static struct attribute * g[] = {
 	&state_attr.attr,
 	NULL,
Index: linux-2.6.15-rc4/include/linux/pm.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/pm.h
+++ linux-2.6.15-rc4/include/linux/pm.h
@@ -131,6 +131,9 @@ extern void pm_set_ops(struct pm_ops *);
 extern struct pm_ops *pm_ops;
 extern int pm_suspend(suspend_state_t state);
 
+struct device;
+
+extern void pm_set_waker(struct device *dev);
 
 /*
  * Device power management


--===============7495033403506639==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============7495033403506639==--
