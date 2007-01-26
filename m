From: Greg KH <gregkh@suse.de>
Subject: Re: [patch] suspend/resume debugging: device filter
Date: Thu, 25 Jan 2007 17:55:36 -0800
Message-ID: <20070126015536.GA14917@suse.de>
References: <20070125110501.GA25151@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070125110501.GA25151@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 25, 2007 at 12:05:01PM +0100, Ingo Molnar wrote:
> Subject: [patch] suspend/resume debugging: device filter
> From: Ingo Molnar <mingo@elte.hu>
> =

> this patch implements the /sys/power/filter attribute, which takes a =

> string. If a device's name matches the filter string (exactly), then =

> that device is excluded from suspend/resume.
> =

> this can be helpful in a number of ways when debugging suspend and =

> resume problems:
> =

>  - if CONFIG_DISABLE_CONSOLE_SUSPEND is used then the serial
>    console is still suspended after which point there's no
>    log output. Doing "echo serial > /sys/power/filter" keeps
>    the serial port active, so any messages (and crash info)
>    after that point is displayed.
> =

>  - if a device is suspected to be the reason of resume failure
>    then it can be excluded via the filter. That device obviously
>    wont work, but users can thus help us debug resume problems
>    in combination with pm_trace, without having to hack the kernel.
> =

> (note that you can obvious break suspend/resume via the filter, by =

> excluding a vital device - so it is only to be used when suspend or =

> resume is broken to begin with.)
> =

> it might be better to do this centrally in sysfs, via a per-device =

> attribute, to individually enable suspend and resume on a per device =

> basis, but my sysfs-fu is not strong enough for that now ;-)

Here's a (compile tested only) patch that does this on a per-device
basis, which is smaller, and should work just as well as your patch.

It creates a new file in the power/ directory for every device called
"can_suspend".  Write a '0' to it to prevent that device from being
suspended.

Does this work for you?

Yeah, the wording of the filename and variable isn't the best, I'm open
to better choices if anyone has them.

thanks,

greg k-h

---
 drivers/base/power/suspend.c |    2 +-
 drivers/base/power/sysfs.c   |   30 ++++++++++++++++++++++++++++++
 include/linux/device.h       |    1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/base/power/suspend.c
+++ gregkh-2.6/drivers/base/power/suspend.c
@@ -78,7 +78,7 @@ int suspend_device(struct device * dev, =

 		suspend_report_result(dev->class->suspend, error);
 	}
 =

-	if (!error && dev->bus && dev->bus->suspend && !dev->power.power_state.ev=
ent) {
+	if (!error && !dev->no_suspend && dev->bus && dev->bus->suspend && !dev->=
power.power_state.event) {
 		dev_dbg(dev, "%s%s\n",
 			suspend_verb(state.event),
 			((state.event =3D=3D PM_EVENT_SUSPEND)
--- gregkh-2.6.orig/drivers/base/power/sysfs.c
+++ gregkh-2.6/drivers/base/power/sysfs.c
@@ -141,12 +141,42 @@ wake_store(struct device * dev, struct d
 =

 static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
 =

+static ssize_t can_suspend_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", dev->no_suspend ? "no" : "yes");
+}
+
+static ssize_t can_suspend_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t n)
+{
+	if (!n)
+		return -EINVAL;
+
+	switch (buf[0]) {
+	case 'y':
+	case 'Y':
+	case '1':
+		dev->no_suspend =3D 0;
+		break;
+	case 'n':
+	case 'N':
+	case '0':
+		dev->no_suspend =3D 1;
+		break;
+	}
+
+	return n;
+}
+static DEVICE_ATTR(can_suspend, 0644, can_suspend_show, can_suspend_store);
 =

 static struct attribute * power_attrs[] =3D {
 #ifdef	CONFIG_PM_SYSFS_DEPRECATED
 	&dev_attr_state.attr,
 #endif
 	&dev_attr_wakeup.attr,
+	&dev_attr_can_suspend.attr,
 	NULL,
 };
 static struct attribute_group pm_attr_group =3D {
--- gregkh-2.6.orig/include/linux/device.h
+++ gregkh-2.6/include/linux/device.h
@@ -365,6 +365,7 @@ struct device {
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 	struct device_type	*type;
 	unsigned		is_registered:1;
+	unsigned		no_suspend:1;
 	struct device_attribute uevent_attr;
 	struct device_attribute *devt_attr;
 =
