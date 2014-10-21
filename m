From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 21/47] ipmi: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:37 -0700
Message-ID: <1413864783-3271-22-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Corey Minyard <minyard@acm.org>, openipmi-developer@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with high priority to reflect that the original code
overwrites pm_power_off unconditionally.

Register poweroff handler after the ipmi system is ready, and unregister
it prior to cleanup. This avoids having to check for the ready variable
in the poweroff callback.

Reviewed-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Use define to specify poweroff handler priority
- Use pr_warn instead of pr_err
- Call unregister_power_off_handler on exit only if not already unregistered

 drivers/char/ipmi/ipmi_poweroff.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 9f2e3be..41067da 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -36,6 +36,7 @@
 #include <linux/proc_fs.h>
 #include <linux/string.h>
 #include <linux/completion.h>
+#include <linux/notifier.h>
 #include <linux/pm.h>
 #include <linux/kdev_t.h>
 #include <linux/ipmi.h>
@@ -63,9 +64,6 @@ static ipmi_user_t ipmi_user;
 static int ipmi_ifnum;
 static void (*specific_poweroff_func)(ipmi_user_t user);
 
-/* Holds the old poweroff function so we can restore it on removal. */
-static void (*old_poweroff_func)(void);
-
 static int set_param_ifnum(const char *val, struct kernel_param *kp)
 {
 	int rv = param_set_int(val, kp);
@@ -544,15 +542,20 @@ static struct poweroff_function poweroff_functions[] = {
 
 
 /* Called on a powerdown request. */
-static void ipmi_poweroff_function(void)
+static int ipmi_poweroff_function(struct notifier_block *this,
+				  unsigned long unused1, void *unused2)
 {
-	if (!ready)
-		return;
-
 	/* Use run-to-completion mode, since interrupts may be off. */
 	specific_poweroff_func(ipmi_user);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block ipmi_poweroff_nb = {
+	.notifier_call = ipmi_poweroff_function,
+	.priority = POWEROFF_PRIORITY_HIGH,
+};
+
 /* Wait for an IPMI interface to be installed, the first one installed
    will be grabbed by this code and used to perform the powerdown. */
 static void ipmi_po_new_smi(int if_num, struct device *device)
@@ -631,9 +634,12 @@ static void ipmi_po_new_smi(int if_num, struct device *device)
 	printk(KERN_INFO PFX "Found a %s style poweroff function\n",
 	       poweroff_functions[i].platform_type);
 	specific_poweroff_func = poweroff_functions[i].poweroff_func;
-	old_poweroff_func = pm_power_off;
-	pm_power_off = ipmi_poweroff_function;
+
 	ready = 1;
+
+	rv = register_power_off_handler(&ipmi_poweroff_nb);
+	if (rv)
+		pr_warn(PFX "failed to register poweroff handler\n");
 }
 
 static void ipmi_po_smi_gone(int if_num)
@@ -644,9 +650,10 @@ static void ipmi_po_smi_gone(int if_num)
 	if (ipmi_ifnum != if_num)
 		return;
 
+	unregister_power_off_handler(&ipmi_poweroff_nb);
+
 	ready = 0;
 	ipmi_destroy_user(ipmi_user);
-	pm_power_off = old_poweroff_func;
 }
 
 static struct ipmi_smi_watcher smi_watcher = {
@@ -733,11 +740,11 @@ static void __exit ipmi_poweroff_cleanup(void)
 	ipmi_smi_watcher_unregister(&smi_watcher);
 
 	if (ready) {
+		unregister_power_off_handler(&ipmi_poweroff_nb);
 		rv = ipmi_destroy_user(ipmi_user);
 		if (rv)
 			printk(KERN_ERR PFX "could not cleanup the IPMI"
 			       " user: 0x%x\n", rv);
-		pm_power_off = old_poweroff_func;
 	}
 }
 module_exit(ipmi_poweroff_cleanup);
-- 
1.9.1
