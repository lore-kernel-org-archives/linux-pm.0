From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v4 2/2] PM / Core: partial resume/suspend API for
 suspend_again users.
Date: Tue, 17 May 2011 13:59:06 +0900
Message-ID: <1305608346-23800-2-git-send-email-myungjoo.ham__33776.5675191351$1305608431$gmane$org@samsung.com>
References: <20110512061928.GB2460@localhost.ucw.cz>
	<1305608346-23800-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1305608346-23800-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com
List-Id: linux-pm@vger.kernel.org

The API, suspend_again, is supposed to be used by platforms when the
platforms want to execute some code while suspended (wakeup by an alarm
or periodic ticks, run code, suspend again). Because suspend_again is
not called when every device is resumed, but is called right after
suspend_enter() is called, the suspend_again callback should include
device resume and suspend features.

This patch provides two APIs: dpm_partial_resume and
dpm_partial_suspend. They are supposed to be used in suspend_again to
actiavte required devices.

A usage example is:

/* Devices required to run "monitor_something()". */
static device *devs[] = {
	&console_serial,
	&device_x,
	&device_y,
	...
};

bool example_suspend_again(void)
{
	int error, monitor_result;

	if (!wakeup_reason_is_polling())
		return false;

	dpm_partial_resume(PMSG_RESUME, devs, ARRAY_SIZE(devs));
	resume_console();

	monitor_result = monitor_something();

	suspend_console();
	error = dpm_partial_suspend(PMSG_SUSPEND, devs, ARRAY_SIZE(devs));

	if (error || monitor_result == ERROR)
		return false;

	return true;
}

Tested at Exynos4-NURI.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
No changes from v3.
---
 drivers/base/power/main.c |  154 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h        |    4 +
 2 files changed, 158 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 052dc53..71dc693 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1082,3 +1082,157 @@ int device_pm_wait_for_dev(struct device *subordinate, struct device *dev)
 	return async_error;
 }
 EXPORT_SYMBOL_GPL(device_pm_wait_for_dev);
+
+/**
+ * __dpm_partial_resume - Execute "resume" callbacks for the listed devices.
+ * @state: PM transition being carried out.
+ * @devs: Array of pointers for the devices being resumed
+ * @size: The size of devs array.
+ */
+static void __dpm_partial_resume(pm_message_t state, struct device **devs,
+				 int size)
+{
+	int i;
+	struct device *dev;
+
+	for (i = 0; i < size; i++) {
+		int error;
+
+		dev = devs[i];
+		get_device(dev);
+
+		error = device_resume(dev, state, false);
+		if (error)
+			pm_dev_err(dev, state, "", error);
+
+		put_device(dev);
+	}
+}
+
+/**
+ * __dpm_partial_complete - Complete a PM transition for the listed devices.
+ * @state: PM transition being carried out.
+ * @devs: Array of pointers for the devices being resumed
+ * @size: The size of devs array.
+ */
+static void __dpm_partial_complete(pm_message_t state, struct device **devs,
+				   int size)
+{
+	int i;
+	struct device *dev;
+
+	for (i = 0; i < size; i++) {
+		dev = devs[i];
+
+		get_device(dev);
+		dev->power.in_suspend = false;
+
+		device_complete(dev, state);
+
+		put_device(dev);
+	}
+}
+
+/**
+ * dpm_partial_resume - Execute "resume" callbacks and complete system
+ *			transaction for the chosen devices only.
+ * @state: PM transition being carried out.
+ * @devs: Array of pointers for the devices being resumed
+ * @size: The size of devs array.
+ *
+ * Execute "resume" callbacks for the listed devices and complete the PM
+ * transition of them.
+ *
+ * Because the only a part of devices will be resumed, asynchronous resume
+ * is dropped.
+ */
+void dpm_partial_resume(pm_message_t state, struct device **devs, int size)
+{
+	/* Partial dpm_resume */
+	__dpm_partial_resume(state, devs, size);
+
+	/* Partial dpm_complete */
+	__dpm_partial_complete(state, devs, size);
+}
+EXPORT_SYMBOL_GPL(dpm_partial_resume);
+
+/**
+ * dpm_partial_suspend - Prepare the given devices for PM transition and
+ *			suspend them.
+ * @state: PM transition being carried out.
+ * @devs: Array of pointers for the devices being suspended
+ * @size: The size of devs array.
+ *
+ * Prepare the given devices for system PM transition and execute "suspend"
+ * callbacks for them.
+ *
+ * The devs array is iterated in the reversed order to use the same devs
+ * array with dpm_partial_resume().
+ */
+int dpm_partial_suspend(pm_message_t state, struct device **devs, int size)
+{
+	int error = 0, i;
+	struct device *dev;
+
+	/* Partial dpm_prepare */
+	for (i = size - 1; i >= 0; i--) {
+		dev = devs[i];
+
+		get_device(dev);
+
+		pm_runtime_get_noresume(dev);
+		if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
+			pm_wakeup_event(dev, 0);
+
+		pm_runtime_put_sync(dev);
+		error = pm_wakeup_pending() ?
+				-EBUSY : device_prepare(dev, state);
+
+		if (error) {
+			if (error == -EAGAIN) {
+				put_device(dev);
+				error = 0;
+				i++; /* Try Again */
+				continue;
+			}
+			printk(KERN_INFO "PM: Device %s not prepared "
+				"for power transition: code %d\n",
+				dev_name(dev), error);
+			put_device(dev);
+			break;
+		}
+		dev->power.in_suspend = true;
+		put_device(dev);
+	}
+
+	if (error)
+		goto err_prepare;
+
+	/* Partial dpm_suspend */
+	for (i = size - 1; i >= 0; i--) {
+		dev = devs[i];
+
+		get_device(dev);
+
+		/* Synchronous suspend. The list shouldn't be long */
+		error = __device_suspend(dev, pm_transition, false);
+
+		if (error) {
+			pm_dev_err(dev, state, "", error);
+			put_device(dev);
+			break;
+		}
+		put_device(dev);
+	}
+
+	if (!error)
+		return 0;
+
+	__dpm_partial_resume(PMSG_RESUME, devs + i + 1, size - i - 1);
+	i = -1;
+err_prepare:
+	__dpm_partial_complete(PMSG_RESUME, devs + i + 1, size - i - 1);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(dpm_partial_suspend);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 512e091..b407762 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -540,10 +540,14 @@ static inline int sysdev_resume(void) { return 0; }
 extern void device_pm_lock(void);
 extern void dpm_resume_noirq(pm_message_t state);
 extern void dpm_resume_end(pm_message_t state);
+extern void dpm_partial_resume(pm_message_t state, struct device **devs,
+			       int size);
 
 extern void device_pm_unlock(void);
 extern int dpm_suspend_noirq(pm_message_t state);
 extern int dpm_suspend_start(pm_message_t state);
+extern int dpm_partial_suspend(pm_message_t state, struct device **devs,
+			       int size);
 
 extern void __suspend_report_result(const char *function, void *fn, int ret);
 
-- 
1.7.4.1
