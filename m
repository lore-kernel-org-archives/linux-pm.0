From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 07/10] hwspinlock: Introduce raw capability for hwspinlocks
Date: Wed,  5 Aug 2015 10:32:43 -0600
Message-ID: <1438792366-2737-8-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36277 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbHEQdO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 12:33:14 -0400
Received: by pacrr5 with SMTP id rr5so4923016pac.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 09:33:14 -0700 (PDT)
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: agross@codeaurora.org, msivasub@codeaurora.org, sboyd@codeaurora.org, robh@kernel.org, Lina Iyer <lina.iyer@linaro.org>, Jeffrey Hugo <jhugo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>

The hwspinlock framework, uses a s/w spin lock around the hw spinlock to
ensure that only process acquires the lock at any time. This is the most
general use case. A special case is where a hwspinlock may be acquired
in Linux and a remote entity may release the lock. In such a case, the
s/w spinlock may never be unlocked as Linux would never call
hwspin_unlock on the hwlock.

This special case is needed for serializing the processor across context
switches from Linux to firmware. Multiple cores may enter cpu idle and
would switch context to firmware to power off. A cpu holding the
hwspinlock would cause other cpus to wait to acquire the lock, until the
lock is released by the firmware. The last core to power down per Linux
has the correct state of the shared resources and should be the one
considered by the firmware. However, a cpu may be stuck handling FIQs
and therefore the last man view of Linux and the firmware may differ. A
hwspinlock avoids this problem by serializing the entry from Linux to
firmware.

Introduce hwcaps member for hwspinlock_device. The hwcaps represents the
hw capability of each hwlock. The platform driver is responsible for
specifying this capability for each lock in the bank. A lock that has
HWL_CAP_ALLOW_RAW set, would indicate to the framework, the capability
for ensure locking correctness in the platform. Since no sw spinlock
guards the hwspinlock, it is the responsibility of the platform driver
to ensure that an unique value is written to the hwspinlock to ensure
locking correctness.

Drivers may use hwspin_trylock_raw() and hwspin_unlock_raw() api to lock
and unlock a hwlock with raw capability.

Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Andy Gross <agross@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/hwspinlock.txt             | 16 +++++++
 drivers/hwspinlock/hwspinlock_core.c     | 75 +++++++++++++++++++-------------
 drivers/hwspinlock/hwspinlock_internal.h |  6 +++
 include/linux/hwspinlock.h               | 41 +++++++++++++++++
 4 files changed, 108 insertions(+), 30 deletions(-)

diff --git a/Documentation/hwspinlock.txt b/Documentation/hwspinlock.txt
index 61c1ee9..4fd3f55 100644
--- a/Documentation/hwspinlock.txt
+++ b/Documentation/hwspinlock.txt
@@ -132,6 +132,15 @@ independent, drivers.
      notably -EBUSY if the hwspinlock was already taken).
      The function will never sleep.
 
+  int hwspin_trylock_raw(struct hwspinlock *hwlock);
+   - attempt to lock a previously-assigned hwspinlock, but immediately fail if
+     it is already taken. The lock must have been declared by the platform
+     drv code with raw capability support.
+     Returns 0 on success and an appropriate error code otherwise (most
+     notably -EBUSY if the hwspinlock was already taken).
+     This function does not use a sw spinlock around the hwlock. The
+     responsiblity of the lock is guaranteed by the platform code.
+
   void hwspin_unlock(struct hwspinlock *hwlock);
    - unlock a previously-locked hwspinlock. Always succeed, and can be called
      from any context (the function never sleeps). Note: code should _never_
@@ -154,6 +163,13 @@ independent, drivers.
      and the state of the local interrupts is restored to the state saved at
      the given flags. This function will never sleep.
 
+  void hwspin_unlock_raw(struct hwspinlock *hwlock);
+   - unlock a previously-locked hwspinlock. Always succeed, and can be called
+     from any context (the function never sleeps). Note: code should _never_
+     unlock an hwspinlock which is already unlocked (there is no protection
+     against this). The platform driver must support raw capability for this
+     hwlock.
+
   int hwspin_lock_get_id(struct hwspinlock *hwlock);
    - retrieve id number of a given hwspinlock. This is needed when an
      hwspinlock is dynamically assigned: before it can be used to achieve
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 52f708b..0d2baa3 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -80,7 +80,10 @@ static DEFINE_MUTEX(hwspinlock_tree_lock);
  * whether he wants their previous state to be saved. It is up to the user
  * to choose the appropriate @mode of operation, exactly the same way users
  * should decide between spin_trylock, spin_trylock_irq and
- * spin_trylock_irqsave.
+ * spin_trylock_irqsave and even no spinlock, if the hwspinlock is always
+ * acquired in an interrupt disabled context. The platform driver that
+ * registers such a lock, would explicity specify the capability for the
+ * lock with the HWL_CAP_ALLOW_RAW capability flag.
  *
  * Returns 0 if we successfully locked the hwspinlock or -EBUSY if
  * the hwspinlock was already taken.
@@ -92,6 +95,7 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 
 	BUG_ON(!hwlock);
 	BUG_ON(!flags && mode == HWLOCK_IRQSTATE);
+	BUG_ON((hwlock->hwcaps & HWL_CAP_ALLOW_RAW) && (mode != HWLOCK_NOLOCK));
 
 	/*
 	 * This spin_lock{_irq, _irqsave} serves three purposes:
@@ -106,32 +110,36 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 	 *    problems with hwspinlock usage (e.g. scheduler checks like
 	 *    'scheduling while atomic' etc.)
 	 */
-	if (mode == HWLOCK_IRQSTATE)
-		ret = spin_trylock_irqsave(&hwlock->lock, *flags);
-	else if (mode == HWLOCK_IRQ)
-		ret = spin_trylock_irq(&hwlock->lock);
-	else
-		ret = spin_trylock(&hwlock->lock);
-
-	/* is lock already taken by another context on the local cpu ? */
-	if (!ret)
-		return -EBUSY;
-
-	/* try to take the hwspinlock device */
-	ret = hwlock->bank->ops->trylock(hwlock);
-
-	/* if hwlock is already taken, undo spin_trylock_* and exit */
-	if (!ret) {
+	if (mode != HWLOCK_NOLOCK) {
 		if (mode == HWLOCK_IRQSTATE)
-			spin_unlock_irqrestore(&hwlock->lock, *flags);
+			ret = spin_trylock_irqsave(&hwlock->lock, *flags);
 		else if (mode == HWLOCK_IRQ)
-			spin_unlock_irq(&hwlock->lock);
+			ret = spin_trylock_irq(&hwlock->lock);
 		else
-			spin_unlock(&hwlock->lock);
+			ret = spin_trylock(&hwlock->lock);
 
-		return -EBUSY;
+		/* is lock already taken by another context on the local cpu? */
+		if (!ret)
+			return -EBUSY;
+	}
+
+	/* try to take the hwspinlock device */
+	ret = hwlock->bank->ops->trylock(hwlock);
+
+	if (mode != HWLOCK_NOLOCK) {
+		/* if hwlock is already taken, undo spin_trylock_* and exit */
+		if (!ret) {
+			if (mode == HWLOCK_IRQSTATE)
+				spin_unlock_irqrestore(&hwlock->lock, *flags);
+			else if (mode == HWLOCK_IRQ)
+				spin_unlock_irq(&hwlock->lock);
+			else
+				spin_unlock(&hwlock->lock);
+		}
 	}
 
+	if (!ret)
+		return -EBUSY;
 	/*
 	 * We can be sure the other core's memory operations
 	 * are observable to us only _after_ we successfully take
@@ -223,7 +231,10 @@ EXPORT_SYMBOL_GPL(__hwspin_lock_timeout);
  * if yes, whether he wants their previous state to be restored. It is up
  * to the user to choose the appropriate @mode of operation, exactly the
  * same way users decide between spin_unlock, spin_unlock_irq and
- * spin_unlock_irqrestore.
+ * spin_unlock_irqrestore and even no spinlock, if the hwspinlock is always
+ * acquired in an interrupt disabled context. The platform driver that
+ * registers such a lock, would explicity specify the capability for the
+ * lock with the HWL_CAP_ALLOW_RAW capability flag.
  *
  * The function will never sleep.
  */
@@ -231,6 +242,7 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 {
 	BUG_ON(!hwlock);
 	BUG_ON(!flags && mode == HWLOCK_IRQSTATE);
+	BUG_ON((hwlock->hwcaps & HWL_CAP_ALLOW_RAW) && (mode != HWLOCK_NOLOCK));
 
 	/*
 	 * We must make sure that memory operations (both reads and writes),
@@ -248,13 +260,15 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 
 	hwlock->bank->ops->unlock(hwlock);
 
-	/* Undo the spin_trylock{_irq, _irqsave} called while locking */
-	if (mode == HWLOCK_IRQSTATE)
-		spin_unlock_irqrestore(&hwlock->lock, *flags);
-	else if (mode == HWLOCK_IRQ)
-		spin_unlock_irq(&hwlock->lock);
-	else
-		spin_unlock(&hwlock->lock);
+	if (mode != HWLOCK_NOLOCK) {
+		/* Undo the spin_trylock{_irq, _irqsave} called while locking */
+		if (mode == HWLOCK_IRQSTATE)
+			spin_unlock_irqrestore(&hwlock->lock, *flags);
+		else if (mode == HWLOCK_IRQ)
+			spin_unlock_irq(&hwlock->lock);
+		else
+			spin_unlock(&hwlock->lock);
+	}
 }
 EXPORT_SYMBOL_GPL(__hwspin_unlock);
 
@@ -421,7 +435,8 @@ int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 	for (i = 0; i < num_locks; i++) {
 		hwlock = &bank->lock[i];
 
-		spin_lock_init(&hwlock->lock);
+		if (!(hwlock->hwcaps & HWL_CAP_ALLOW_RAW))
+			spin_lock_init(&hwlock->lock);
 		hwlock->bank = bank;
 
 		ret = hwspin_lock_register_single(hwlock, base_id + i);
diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index d26f78b..24a4d79 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -21,6 +21,9 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 
+/* hwspinlock capability properties */
+#define HWL_CAP_ALLOW_RAW	BIT(1)
+
 struct hwspinlock_device;
 
 /**
@@ -44,11 +47,14 @@ struct hwspinlock_ops {
  * @bank: the hwspinlock_device structure which owns this lock
  * @lock: initialized and used by hwspinlock core
  * @priv: private data, owned by the underlying platform-specific hwspinlock drv
+ * @hwcaps: hardware capablity, like raw lock, that does not need s/w spinlock
+ * around the hwspinlock.
  */
 struct hwspinlock {
 	struct hwspinlock_device *bank;
 	spinlock_t lock;
 	void *priv;
+	int hwcaps;
 };
 
 /**
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 859d673..f173352 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -24,6 +24,7 @@
 /* hwspinlock mode argument */
 #define HWLOCK_IRQSTATE	0x01	/* Disable interrupts, save state */
 #define HWLOCK_IRQ	0x02	/* Disable interrupts, don't save state */
+#define HWLOCK_NOLOCK	0xFF	/* Dont take any lock */
 
 struct device;
 struct device_node;
@@ -196,6 +197,27 @@ static inline int hwspin_trylock(struct hwspinlock *hwlock)
 }
 
 /**
+ * hwspin_trylock_raw() - attempt to lock a specific hwspinlock without s/w
+ * spinlocks
+ * @hwlock: the hwspinlock which we want to trylock
+ *
+ * This function attempts to lock the hwspinlock without acquiring a s/w
+ * spinlock. The function will return failure if the lock is already taken.
+ *
+ * The function can only be used on a hwlock that has been initialized with
+ * raw capability by the platform drv.
+ *
+ * The function is expected to be called in an interrupt disabled context.
+ *
+ * Returns 0 if we successfully locked the hwspinlock, -EBUSY if the hwspinlock
+ * is already taken.
+ */
+static inline int hwspin_trylock_raw(struct hwspinlock *hwlock)
+{
+	return __hwspin_trylock(hwlock, HWLOCK_NOLOCK, NULL);
+}
+
+/**
  * hwspin_lock_timeout_irqsave() - lock hwspinlock, with timeout, disable irqs
  * @hwlock: the hwspinlock to be locked
  * @to: timeout value in msecs
@@ -317,4 +339,23 @@ static inline void hwspin_unlock(struct hwspinlock *hwlock)
 	__hwspin_unlock(hwlock, 0, NULL);
 }
 
+/**
+ * hwspin_unlock_raw() - unlock hwspinlock
+ * @hwlock: a previously acquired hwspinlock which we want to unlock
+ *
+ * This function will unlock a specific hwspinlock that was acquired using the
+ * hwspin_trylock_raw() call.
+ *
+ * The function can only be used on a hwlock that has been initialized with
+ * raw capability by the platform drv.
+ *
+ * @hwlock must be already locked (e.g. by hwspin_trylock()) before calling
+ * this function: it is a bug to call unlock on a @hwlock that is already
+ * unlocked.
+ */
+static inline void hwspin_unlock_raw(struct hwspinlock *hwlock)
+{
+	__hwspin_unlock(hwlock, HWLOCK_NOLOCK, NULL);
+}
+
 #endif /* __LINUX_HWSPINLOCK_H */
-- 
2.1.4

