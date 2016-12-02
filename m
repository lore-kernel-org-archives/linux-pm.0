From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 1/5] regulator: Extend the power-management APIs
Date: Fri,  2 Dec 2016 14:57:12 +0100
Message-ID: <1480687036-5037-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60729 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760460AbcLBN5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 08:57:21 -0500
In-Reply-To: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

The regulator framework currently provides the regulator_suspend_prepare()
and regulator_suspend_finish() which are supposed to be called from the
platform_suspend_ops ->prepare() and ->finish() hooks.
The regulator_suspend_prepare() function is calling the different
->set_suspend_xx() hooks provided by the regulator drivers in order to
program the regulator suspend state, and ask it to apply this state when
the system is suspended.
The regulator_suspend_finish() is trying to restore the runtime state
when resuming the system.

While this worked fine so far, it has some limitations which prevents it
from being used on some platforms:

1/ the platform ->prepare() hook is called after all devices have been
   suspended, and some regulators are accessible through a bus (usually
   i2c) whose controller might have been suspended, thus preventing
   proper setup of the regulator (the ->set_suspend_xx() hooks are likely
   to send i2c messages).
2/ some regulators do not support (or only partially support) preparing
   the suspend state and applying it afterwards when the system has been
   suspended (no ->set_suspend_xx() implementation).

The idea to address #1 is to let each driver apply the suspend state in
its ->suspend() hook. This should address the bus vs sub-device suspend()
dependency issue.

The idea to solve #2 is to allow runtime changes. Since this kind of
change is likely to have an impact on the whole system, we require the
board to explicitly state that runtime changes are allowed (using a DT
property).

Allowing runtime changes, may also be a problem if devices are not
suspended in the correct order: a device using a regulator should be
suspended before the regulator itself, otherwise we may change the
regulator state while it's still being used.
Hopefully, this problem will be solved with the work done on device
dependency description.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Mark, Raphael,

This is just an attempt at solving the suspend/resume issue I have on
an atmel platform: the PMIC is only supporting partial "suspend state"
definition (enable/disable output), and we need to setup the remaining
parts (voltage and mode) at runtime.

Mark, this patch is trying to implement what I understood of our
discussion on IRC a few days back. As you might have noticed, I'm not
yet understanding all the subtleties of the PM hooks, or how they are
implemented in the regulator framework.
This patch is clearly not meant to be applied as is, it's more something
to start a discussion, so feel free to point my misunderstanding or the
flaws in my approach.

Thanks,

Boris
---
 drivers/regulator/core.c          | 291 ++++++++++++++++++++++++++++++++++++++
 drivers/regulator/of_regulator.c  |   4 +
 include/linux/regulator/driver.h  |  29 ++++
 include/linux/regulator/machine.h |  13 ++
 4 files changed, 337 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 67426c0477d3..4ff155c3e43f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -729,6 +729,207 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	return err;
 }
 
+/**
+ * regulator_restore_runtime_state - restore the runtime state on a regulator
+ * @rdev: regulator device
+ *
+ * This function will restore the runtime state that was applied by
+ * regulator_apply_suspend_state() during the suspend sequence.
+ * It only restores things that were set at runtime (i.e. everything that was
+ * not configured with ->set_suspend_xx()). For everything that was set with
+ * ->set_suspend_xx(), we assume that the regulator will restore the runtime
+ * state by itself.
+ *
+ * This function should be called from the regulator driver ->resume() hook.
+ *
+ * This function returns 0 if it managed to restore the state, a negative
+ * error code otherwise.
+ */
+int regulator_restore_runtime_state(struct regulator_dev *rdev)
+{
+	struct regulator_state *save;
+	int ret;
+
+	save = &rdev->suspend.save;
+
+	if (save->enabled)
+		ret = rdev->desc->ops->enable(rdev);
+	else if (save->disabled)
+		ret = rdev->desc->ops->disable(rdev);
+	else
+		ret = 0;
+
+	if (ret < 0) {
+		rdev_err(rdev, "failed to enabled/disable\n");
+		return ret;
+	}
+
+	if (save->uV > 0) {
+		ret = _regulator_do_set_voltage(rdev, save->uV, save->uV);
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set voltage\n");
+			return ret;
+		}
+	}
+
+	if (save->mode > 0) {
+		ret = rdev->desc->ops->set_mode(rdev, save->mode);
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set mode\n");
+			return ret;
+		}
+	}
+
+	memset(&rdev->suspend.save, 0, sizeof(rdev->suspend.save));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(regulator_restore_runtime_state);
+
+/**
+ * regulator_apply_suspend_state - apply the suspend state to a regulator
+ * @rdev: regulator device
+ *
+ * This function will apply the suspend pointed by rdev->suspend.target.
+ * If the regulator implements the ->set_suspend_xx() hooks, then these methods
+ * are called, and the regulator will not apply the new state directly, but
+ * instead store the new configuration internally and apply it afterwards after
+ * the system has been suspended.
+ * If the regulator does not support this 'program suspend state' feature, the
+ * core can apply the new setting at runtime, but this has to be explicitely
+ * requested (with the ->allow_changes_at_runtime flag) because it can be
+ * dangerous to do so.
+ *
+ * This function should be called from the regulator driver ->suspend() hook
+ * and after the platform has called regulator_suspend_begin() to properly set
+ * the rdev->suspend.target field.
+ *
+ * This function returns 0 if it managed to apply the new state, a negative
+ * error code otherwise.
+ */
+int regulator_apply_suspend_state(struct regulator_dev *rdev)
+{
+	struct regulator_state *target, *save;
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int ret;
+
+	target = rdev->suspend.target;
+	save = &rdev->suspend.save;
+	memset(save, 0, sizeof(*save));
+
+	if (!target)
+		return 0;
+
+	if (target->enabled && target->disabled) {
+		rdev_err(rdev, "invalid configuration\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * If the regulator supports configuring a suspend state that will be
+	 * applied afterward (->set_suspend_xx() hooks), use this feature.
+	 * Otherwise, if runtime modifications are allowed, save the current
+	 * state and use the regular methods to apply the suspend state.
+	 *
+	 * Note that we do not care saving the status when the
+	 * ->set_suspend_xx() methods are implemented because we assume the
+	 * regulator will automatically restore the runtime state when going
+	 * out of its suspend mode.
+	 */
+	if (target->enabled) {
+		if (ops->set_suspend_enable) {
+			ret = ops->set_suspend_enable(rdev);
+		} else if (target->allow_changes_at_runtime &&
+			   ops->enable) {
+			save->enabled = _regulator_is_enabled(rdev);
+			ret = rdev->desc->ops->enable(rdev);
+		} else {
+			ret = 0;
+		}
+	} else if (target->disabled) {
+		if (ops->set_suspend_disable) {
+			ret = ops->set_suspend_disable(rdev);
+		} else if (target->allow_changes_at_runtime &&
+			   ops->disable) {
+			save->disabled = !_regulator_is_enabled(rdev);
+			ret = rdev->desc->ops->disable(rdev);
+		} else {
+			ret = 0;
+		}
+	} else {
+		ret = 0;
+	}
+
+	if (ret < 0) {
+		rdev_err(rdev, "failed to enabled/disable\n");
+		return ret;
+	}
+
+	if (target->uV > 0) {
+		if (ops->set_suspend_voltage) {
+			ret = ops->set_suspend_voltage(rdev, target->uV);
+		} else if (target->allow_changes_at_runtime) {
+			ret = _regulator_get_voltage(rdev);
+			if (ret < 0) {
+				rdev_err(rdev, "failed to get current voltage\n");
+				goto err_restore;
+			}
+
+			save->uV = ret;
+
+			ret = _regulator_do_set_voltage(rdev, target->uV,
+							target->uV);
+		} else {
+			rdev_err(rdev,
+				 "suspend voltage specified, but no way to set it\n");
+			goto err_restore;
+		}
+
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set voltage\n");
+			save->uV = 0;
+			goto err_restore;
+		}
+	}
+
+	if (target->mode > 0 && !rdev->desc->ops->set_suspend_mode &&
+	    rdev->desc->ops->set_mode) {
+		if (ops->set_suspend_mode) {
+			ret = ops->set_suspend_mode(rdev, target->mode);
+		} else if (target->allow_changes_at_runtime && ops->get_mode &&
+			   ops->set_mode) {
+			ret = ops->get_mode(rdev);
+			if (ret < 0) {
+				rdev_err(rdev, "failed to get mode\n");
+				goto err_restore;
+			}
+
+			save->mode = ret;
+
+			ret = ops->set_mode(rdev, target->mode);
+		} else {
+			rdev_err(rdev,
+				 "suspend mode specified, but no way to set it\n");
+			goto err_restore;
+		}
+
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set mode\n");
+			save->mode = 0;
+			goto err_restore;
+		}
+	}
+
+
+	return 0;
+
+err_restore:
+	regulator_restore_runtime_state(rdev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_apply_suspend_state);
+
 static int suspend_set_state(struct regulator_dev *rdev,
 	struct regulator_state *rstate)
 {
@@ -801,6 +1002,38 @@ static int suspend_prepare(struct regulator_dev *rdev, suspend_state_t state)
 	}
 }
 
+/* locks held by caller */
+static int suspend_begin(struct regulator_dev *rdev, suspend_state_t state)
+{
+	struct regulator_state *target;
+
+	if (!rdev->constraints)
+		return -EINVAL;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		target = &rdev->constraints->state_standby;
+		break;
+	case PM_SUSPEND_MEM:
+		target = &rdev->constraints->state_mem;
+		break;
+	case PM_SUSPEND_MAX:
+		target = &rdev->constraints->state_disk;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rdev->suspend.target = target;
+	return 0;
+}
+
+static void suspend_end(struct regulator_dev *rdev)
+{
+	/* Reset the suspend state. */
+	memset(&rdev->suspend, 0, sizeof(rdev->suspend));
+}
+
 static void print_constraints(struct regulator_dev *rdev)
 {
 	struct regulation_constraints *constraints = rdev->constraints;
@@ -4139,6 +4372,64 @@ int regulator_suspend_prepare(suspend_state_t state)
 }
 EXPORT_SYMBOL_GPL(regulator_suspend_prepare);
 
+static int _regulator_suspend_begin(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+	const suspend_state_t *state = data;
+	int ret;
+
+	mutex_lock(&rdev->mutex);
+	ret = suspend_begin(rdev, *state);
+	mutex_unlock(&rdev->mutex);
+
+	return ret;
+}
+
+/**
+ * regulator_suspend_begin - begin a system wide suspend sequence
+ * @state: system suspend state
+ *
+ * Assign rdev->suspend.target for each regulator device. This target state
+ * can then be used by regulator drivers in their suspend function to
+ * apply a suspend state.
+ * All they need to do is call regulator_apply_suspend_state() from their
+ * ->suspend() hook.
+ */
+int regulator_suspend_begin(suspend_state_t state)
+{
+	/* ON is handled by regulator active state */
+	if (state == PM_SUSPEND_ON)
+		return -EINVAL;
+
+	return class_for_each_device(&regulator_class, NULL, &state,
+				     _regulator_suspend_begin);
+}
+EXPORT_SYMBOL_GPL(regulator_suspend_begin);
+
+static int _regulator_suspend_end(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+
+	mutex_lock(&rdev->mutex);
+	suspend_end(rdev);
+	mutex_unlock(&rdev->mutex);
+
+	return 0;
+}
+
+/**
+ * regulator_suspend_end - end a suspend sequence
+ *
+ * Reset all regulators suspend state, either because the suspend sequence
+ * was aborted or because the system resumed from suspend.
+ */
+void regulator_suspend_end(void)
+{
+	class_for_each_device(&regulator_class, NULL, NULL,
+			      _regulator_suspend_end);
+}
+EXPORT_SYMBOL_GPL(regulator_suspend_end);
+
 static int _regulator_suspend_finish(struct device *dev, void *data)
 {
 	struct regulator_dev *rdev = dev_to_rdev(dev);
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 4f613ec99500..61634d7e4248 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -163,6 +163,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 					"regulator-suspend-microvolt", &pval))
 			suspend_state->uV = pval;
 
+		if (of_property_read_bool(suspend_np,
+					"regulator-allow-changes-at-runtime"))
+			suspend_state->allow_changes_at_runtime = true;
+
 		if (i == PM_SUSPEND_MEM)
 			constraints->initial_state = PM_SUSPEND_MEM;
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 37b532410528..d3550d0e8f3f 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/machine.h>
 
 struct regmap;
 struct regulator_dev;
@@ -384,6 +385,29 @@ struct regulator_config {
 };
 
 /*
+ * struct struct regulator_suspend_ctx
+ *
+ * The suspend context attached to a regulator device.
+ *
+ * This context is used to store the target regulato state which should be
+ * entered when the system is suspended.
+ * The regulator_suspend_begin() will make @target point to the appropriate
+ * suspent state, and the regulator driver is then responsible for calling
+ * regulator_apply_suspend_state() from its ->suspend() hook.
+ * regulator_apply_suspend_state() will save the current regulator state, and
+ * the driver can then restore this state at resume time by calling
+ * regulator_restore_runtime_state() from its ->resume() hook.
+ *
+ *
+ * @target: target state to apply on suspend
+ * @save: runtime state that should be restored at resume time
+ */
+struct regulator_suspend_ctx {
+	struct regulator_state *target;
+	struct regulator_state save;
+};
+
+/*
  * struct regulator_dev
  *
  * Voltage / Current regulator class device. One for each
@@ -415,6 +439,8 @@ struct regulator_dev {
 	const char *supply_name;
 	struct regmap *regmap;
 
+	struct regulator_suspend_ctx suspend;
+
 	struct delayed_work disable_work;
 	int deferred_disables;
 
@@ -477,4 +503,7 @@ int regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
 					  bool enable);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 
+int regulator_apply_suspend_state(struct regulator_dev *rdev);
+int regulator_restore_runtime_state(struct regulator_dev *rdev);
+
 #endif
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index ad3e5158e586..e2348cd145a5 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -60,12 +60,16 @@ enum regulator_active_discharge {
  * @mode: Operating mode during suspend.
  * @enabled: Enabled during suspend.
  * @disabled: Disabled during suspend.
+ * @allow_changes_at_runtime: Allow the core to call the ->set_mode() or
+ *			      ->set_voltage() directly if ->set_suspend_mode()
+ *			      or ->set_suspend_voltage() are missing.
  */
 struct regulator_state {
 	int uV;	/* suspend voltage */
 	unsigned int mode; /* suspend regulator operating mode */
 	int enabled; /* is regulator enabled in this suspend state */
 	int disabled; /* is the regulator disbled in this suspend state */
+	bool allow_changes_at_runtime;
 };
 
 /**
@@ -216,12 +220,18 @@ struct regulator_init_data {
 
 #ifdef CONFIG_REGULATOR
 void regulator_has_full_constraints(void);
+int regulator_suspend_begin(suspend_state_t state);
 int regulator_suspend_prepare(suspend_state_t state);
 int regulator_suspend_finish(void);
+void regulator_suspend_end(void);
 #else
 static inline void regulator_has_full_constraints(void)
 {
 }
+static inline int regulator_suspend_begin(suspend_state_t state)
+{
+	return 0;
+}
 static inline int regulator_suspend_prepare(suspend_state_t state)
 {
 	return 0;
@@ -230,6 +240,9 @@ static inline int regulator_suspend_finish(void)
 {
 	return 0;
 }
+static inline void regulator_suspend_end(void)
+{
+}
 #endif
 
 #endif
-- 
2.7.4

