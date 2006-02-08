From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Wed, 8 Feb 2006 17:08:58 +0000
Message-ID: <20060208170857.GA29818@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org>
	<20060208130422.GB25659@srcf.ucam.org>
	<20060208165803.GA15239@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89365202401936195=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060208165803.GA15239@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============89365202401936195==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2006 at 08:58:03AM -0800, Greg KH wrote:
> > +void pm_set_ac_status(int (*ac_status_function)(void))
> 
> No extra line in there please.

That matches the style used in the rest of the file.

> And perhaps a bit more description of what this is used for?

Ok.

> > +{
> > +	down(&pm_sem);
> 
> Shouldn't this be a mutex?

It is, isn't it? The name's somewhat misleading, but I was just using 
what already existed...

> > +	get_ac_status = ac_status_function;
> > +	up(&pm_sem);
> > +}
> > +
> > +EXPORT_SYMBOL(pm_set_ac_status);
> 
> No extra line between the function and the EXPORT_SYMBOL please.

Sure.

> Also, how about EXPORT_SYMBOL_GPL()?

If that's considered reasonable, sure.

> And, who will be using this interface, and what for?

The backlight interface only supports exporting and setting the current 
brightness. For various bits of hardware, the AC and DC brightnesses are 
stored separately. Drivers would need to know which brightness value to 
export to userspace. I have an HP backlight driver here which would 
benefit from this, and I'm looking at the same issue for a Panasonic 
one.

Here's an updated version, anyway.

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 5be87ba..59ece0f 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -129,6 +129,8 @@ struct pm_ops {
 
 extern void pm_set_ops(struct pm_ops *);
 extern struct pm_ops *pm_ops;
+extern void pm_set_ac_status(int (*ac_status_function)(void));
+extern int pm_get_ac_status(void);
 extern int pm_suspend(suspend_state_t state);
 
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 46110d5..929a3c0 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pm.h>
-
+#include <linux/module.h>
 
 #include "power.h"
 
@@ -25,6 +25,7 @@
 DECLARE_MUTEX(pm_sem);
 
 struct pm_ops *pm_ops = NULL;
+int (*get_ac_status)(void);
 suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
 
 /**
@@ -39,6 +40,36 @@ void pm_set_ops(struct pm_ops * ops)
 	up(&pm_sem);
 }
 
+/**
+ *	pm_set_ac_status - Set the ac status callback. Returns true if the
+ *                         system is on AC and has a registered callback.
+ *	@ops:	Pointer to function
+ */
+
+void pm_set_ac_status(int (*ac_status_function)(void))
+{
+	down(&pm_sem);
+	get_ac_status = ac_status_function;
+	up(&pm_sem);
+}
+EXPORT_SYMBOL_GPL(pm_set_ac_status);
+
+/**
+ *	pm_get_ac_status - return true if the system is on AC
+ */
+
+int pm_get_ac_status(void)
+{
+	int status=0;
+
+	down (&pm_sem);
+	if (get_ac_status)
+		status = get_ac_status();
+	up (&pm_sem);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(pm_get_ac_status);
 
 /**
  *	suspend_prepare - Do prep work before entering low-power state.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

--===============89365202401936195==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89365202401936195==--
