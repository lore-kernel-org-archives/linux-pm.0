From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Wed, 8 Feb 2006 13:04:22 +0000
Message-ID: <20060208130422.GB25659@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060208125753.GA25562@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Whoops - missing <linux/module.h>. Here's the fixed version.

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
index 46110d5..453cd0e 100644
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
@@ -39,6 +40,39 @@ void pm_set_ops(struct pm_ops * ops)
 	up(&pm_sem);
 }
 
+/**
+ *	pm_set_ac_status - Set the ac status callback
+ *	@ops:	Pointer to function
+ */
+
+void pm_set_ac_status(int (*ac_status_function)(void))
+{
+	down(&pm_sem);
+	get_ac_status = ac_status_function;
+	up(&pm_sem);
+}
+
+EXPORT_SYMBOL(pm_set_ac_status);
+
+/**
+ *	pm_get_ac_status - return true if the system is on AC
+ */
+
+int pm_get_ac_status(void)
+{
+	int status;
+
+	down (&pm_sem);
+	if (get_ac_status)
+		status = get_ac_status();
+	else
+		status = 0;
+	up (&pm_sem);
+
+	return status;
+}
+
+EXPORT_SYMBOL(pm_get_ac_status);
 
 /**
  *	suspend_prepare - Do prep work before entering low-power state.


-- 
Matthew Garrett | mjg59@srcf.ucam.org
