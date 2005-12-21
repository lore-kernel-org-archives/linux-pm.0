From: Todd Poynor <tpoynor@mvista.com>
Subject: What woke system up?
Date: Tue, 20 Dec 2005 16:29:58 -0800
Message-ID: <20051221002958.GA15851@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75213622926411539=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============75213622926411539==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Next in our series of wakeup patches: a consumer electronics maker asked
for a userspace interface to inquire what woke the system up, in order
to present different behaviors depending on the wakeup source.  This is
to be encouraged, as it places these kinds of policy decisions into the
power policy application and out of the kernel.

So here's a quick try at adding a /sys/power/waker attribute and a
pm_add_waker() kernel function that either drivers or board PM code can
use to add (so far format-free) strings useful for telling what woke the
system up.  The idea is that a buffer of these strings is cleared at
each suspend and added to by the platform's resume path and/or driver
resume methods.

I'll send a patch or two for embedded boards showing how
this could be used for SoC-specific wakeup sources.

Any interest in this or something like it for Linux in general, or any
other suggestions?  Thanks -- Todd

Add /sys/power/waker and pm_add_waker() for board-specific wakeup info.

Index: linux-2.6.15-rc4/kernel/power/main.c
===================================================================
--- linux-2.6.15-rc4.orig/kernel/power/main.c
+++ linux-2.6.15-rc4/kernel/power/main.c
@@ -103,11 +103,18 @@ static int suspend_prepare(suspend_state
 }
 
 
+#define WAKERINFO_LEN 1024
+
+static char *wakerinfo;
+
 static int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
 
+	if (wakerinfo)
+		*wakerinfo = '\0';
+
 	local_irq_save(flags);
 
 	if ((error = device_power_down(PMSG_SUSPEND))) {
@@ -281,8 +288,35 @@ static ssize_t state_store(struct subsys
 
 power_attr(state);
 
+void pm_add_waker(char * buf)
+{
+	if (! wakerinfo) {
+		wakerinfo = kmalloc(WAKERINFO_LEN, GFP_KERNEL);
+
+		if (wakerinfo)
+			*wakerinfo = '\0';
+	}
+
+	if (wakerinfo)
+		strlcat(wakerinfo, buf, WAKERINFO_LEN);
+}
+
+static ssize_t waker_show(struct subsystem * subsys, char * buf)
+{
+	return sprintf(buf,"%s\n", wakerinfo ? wakerinfo : "");
+}
+
+static ssize_t waker_store(struct subsystem * subsys, const char * buf,
+			   size_t n)
+{
+	return -EINVAL;
+}
+
+power_attr(waker);
+
 static struct attribute * g[] = {
 	&state_attr.attr,
+	&waker_attr.attr,
 	NULL,
 };
 
Index: linux-2.6.15-rc4/include/linux/pm.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/pm.h
+++ linux-2.6.15-rc4/include/linux/pm.h
@@ -130,7 +130,7 @@ struct pm_ops {
 extern void pm_set_ops(struct pm_ops *);
 extern struct pm_ops *pm_ops;
 extern int pm_suspend(suspend_state_t state);
-
+extern void pm_add_waker(char * buf);
 
 /*
  * Device power management


--===============75213622926411539==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============75213622926411539==--
