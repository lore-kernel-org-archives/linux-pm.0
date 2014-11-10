From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 21/48] ipmi: Register with kernel
	power-off handler
Date: Sun,  9 Nov 2014 17:42:38 -0800
Message-ID: <1415583785-6980-22-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: openipmi-developer@lists.sourceforge.net, Corey Minyard <minyard@acm.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with high priority to reflect that the original code
overwrites pm_power_off unconditionally.

Register power-off handler after the ipmi system is ready, and unregister
it prior to cleanup. This avoids having to check for the ready variable
in the poweroff callback.

Reviewed-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use pr_warn instead of pr_err
- Call unregister_power_off_handler on exit only if not already unregistered

 drivers/char/ipmi/ipmi_poweroff.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 9f2e3be..4ae2f22 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -63,9 +63,6 @@ static ipmi_user_t ipmi_user;
 static int ipmi_ifnum;
 static void (*specific_poweroff_func)(ipmi_user_t user);
 
-/* Holds the old poweroff function so we can restore it on removal. */
-static void (*old_poweroff_func)(void);
-
 static int set_param_ifnum(const char *val, struct kernel_param *kp)
 {
 	int rv = param_set_int(val, kp);
@@ -544,15 +541,17 @@ static struct poweroff_function poweroff_functions[] = {
 
 
 /* Called on a powerdown request. */
-static void ipmi_poweroff_function(void)
+static void ipmi_poweroff_function(struct power_off_handler_block *this)
 {
-	if (!ready)
-		return;
-
 	/* Use run-to-completion mode, since interrupts may be off. */
 	specific_poweroff_func(ipmi_user);
 }
 
+static struct power_off_handler_block ipmi_power_off_hb = {
+	.handler = ipmi_poweroff_function,
+	.priority = POWER_OFF_PRIORITY_HIGH,
+};
+
 /* Wait for an IPMI interface to be installed, the first one installed
    will be grabbed by this code and used to perform the powerdown. */
 static void ipmi_po_new_smi(int if_num, struct device *device)
@@ -631,9 +630,12 @@ static void ipmi_po_new_smi(int if_num, struct device *device)
 	printk(KERN_INFO PFX "Found a %s style poweroff function\n",
 	       poweroff_functions[i].platform_type);
 	specific_poweroff_func = poweroff_functions[i].poweroff_func;
-	old_poweroff_func = pm_power_off;
-	pm_power_off = ipmi_poweroff_function;
+
 	ready = 1;
+
+	rv = register_power_off_handler(&ipmi_power_off_hb);
+	if (rv)
+		pr_warn(PFX "failed to register power-off handler\n");
 }
 
 static void ipmi_po_smi_gone(int if_num)
@@ -644,9 +646,10 @@ static void ipmi_po_smi_gone(int if_num)
 	if (ipmi_ifnum != if_num)
 		return;
 
+	unregister_power_off_handler(&ipmi_power_off_hb);
+
 	ready = 0;
 	ipmi_destroy_user(ipmi_user);
-	pm_power_off = old_poweroff_func;
 }
 
 static struct ipmi_smi_watcher smi_watcher = {
@@ -733,11 +736,11 @@ static void __exit ipmi_poweroff_cleanup(void)
 	ipmi_smi_watcher_unregister(&smi_watcher);
 
 	if (ready) {
+		unregister_power_off_handler(&ipmi_power_off_hb);
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


------------------------------------------------------------------------------
