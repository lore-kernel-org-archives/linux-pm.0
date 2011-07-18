From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 3/5] PM: PM notifier error injection
Date: Mon, 18 Jul 2011 10:16:04 +0900
Message-ID: <1310951766-3840-4-git-send-email-akinobu.mita__44810.6684642427$1310951956$gmane$org@gmail.com>
References: <1310951766-3840-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1310951766-3840-1-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: linux-pm@lists.linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: linux-pm@vger.kernel.org

This provides the ability to inject artifical errors to PM notifier
chain callbacks.  It is controlled through debugfs interface under
/sys/kernel/debug/pm-notifier-error-inject/

Each of the files in the directory represents an event which can be
failed and contains the error code.  If the notifier call chain should
be failed with some events notified, write the error code to the files.

Example: Inject PM suspend error (-12 = -ENOMEM)

	# cd /sys/kernel/debug/pm-notifier-error-inject
	# echo -12 > PM_SUSPEND_PREPARE
	# echo mem > /sys/power/state
	bash: echo: write error: Cannot allocate memory

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
---
* v2
- improve Kconfig help text
- make CONFIG_PM_NOTIFIER_ERROR_INJECTION visible even if PM_DEBUG is disabled
- make CONFIG_PM_NOTIFIER_ERROR_INJECTION default if PM_DEBUG is enabled

 kernel/power/main.c |   30 ++++++++++++++++++++++++++++++
 lib/Kconfig.debug   |   16 ++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6c601f8..04b3774 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -42,6 +42,36 @@ int pm_notifier_call_chain(unsigned long val)
 	return notifier_to_errno(ret);
 }
 
+#ifdef CONFIG_PM_NOTIFIER_ERROR_INJECTION
+
+static struct err_inject_notifier_block err_inject_pm_notifier = {
+	.actions = {
+		{ ERR_INJECT_NOTIFIER_ACTION(PM_HIBERNATION_PREPARE) },
+		{ ERR_INJECT_NOTIFIER_ACTION(PM_SUSPEND_PREPARE) },
+		{ ERR_INJECT_NOTIFIER_ACTION(PM_RESTORE_PREPARE) },
+		{}
+	}
+};
+
+static int __init err_inject_pm_notifier_init(void)
+{
+	int err;
+
+	err = err_inject_notifier_block_init(&err_inject_pm_notifier,
+				"pm-notifier-error-inject", -1);
+	if (err)
+		return err;
+
+	err = register_pm_notifier(&err_inject_pm_notifier.nb);
+	if (err)
+		err_inject_notifier_block_cleanup(&err_inject_pm_notifier);
+
+	return err;
+}
+late_initcall(err_inject_pm_notifier_init);
+
+#endif /* CONFIG_PM_NOTIFIER_ERROR_INJECTION */
+
 /* If set, devices may be suspended and resumed asynchronously. */
 int pm_async_enabled = 1;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d1bbedd..e5671ba 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1049,6 +1049,22 @@ config CPU_NOTIFIER_ERROR_INJECTION
 	  # echo 0 > /sys/devices/system/cpu/cpu1/online
 	  bash: echo: write error: Operation not permitted
 
+config PM_NOTIFIER_ERROR_INJECTION
+	bool "PM notifier error injection"
+	depends on PM && NOTIFIER_ERROR_INJECTION
+	default PM_DEBUG
+	help
+	  This option provides the ability to inject artifical errors to
+	  PM notifier chain callbacks.  It is controlled through debugfs
+	  interface.
+
+	  Example: Inject PM suspend error (-12 = -ENOMEM)
+
+	  # cd /sys/kernel/debug/pm-notifier-error-inject
+	  # echo -12 > PM_SUSPEND_PREPARE
+	  # echo mem > /sys/power/state
+	  bash: echo: write error: Cannot allocate memory
+
 config CPU_NOTIFIER_ERROR_INJECT
 	tristate "CPU notifier error injection module"
 	depends on HOTPLUG_CPU && DEBUG_KERNEL
-- 
1.7.4.4
