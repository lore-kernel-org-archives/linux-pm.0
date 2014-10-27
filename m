From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 01/47] kernel: Add support for power-off handler call chain
Date: Mon, 27 Oct 2014 08:55:08 -0700
Message-ID: <1414425354-10359-2-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49886 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbaJ0P4F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 11:56:05 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XimeK-000az3-JI
	for linux-pm@vger.kernel.org; Mon, 27 Oct 2014 15:56:04 +0000
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

Various drivers implement architecture and/or device specific means to
power off the system.  For the most part, those drivers set the global
variable pm_power_off to point to a function within the driver.

This mechanism has a number of drawbacks.  Typically only one scheme
to remove power is supported (at least if pm_power_off is used).
At least in theory there can be multiple means remove power, some of
which may be less desirable. For example, some mechanisms may only
power off the CPU or the CPU card, while another may power off the
entire system.  Others may really just execute a restart sequence
or drop into the ROM monitor. Using pm_power_off can also be racy
if the function pointer is set from a driver built as module, as the
driver may be in the process of being unloaded when pm_power_off is
called. If there are multiple power-off handlers in the system, removin=
g
a module with such a handler may inadvertently reset the pointer to
pm_power_off to NULL, leaving the system with no means to remove power.

Introduce a system power-off handler call chain to solve the described
problems.  This call chain is expected to be executed from the
architecture specific machine_power_off() function.  Drivers providing
system power-off functionality are expected to register with this call =
chain.
By using the priority field in the notifier block, callers can control
power-off handler execution sequence and thus ensure that the power-off
handler with the optimal capabilities to remove power for a given syste=
m
is called first.

Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Alexander Graf <agraf@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Heiko Stuebner <heiko@sntech.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Philippe R=C3=A9tornaz <philippe.retornaz@gmail.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Rename new file to power_off_handler.c
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
- Execute power-off handlers without any locks held
v2:
- poweroff -> power_off
- Add defines for default priorities
- Use raw notifiers protected by spinlocks instead of atomic notifiers
- Add register_poweroff_handler_simple
- Add devm_register_power_off_handler

 include/linux/pm.h               |  22 ++++
 kernel/power/Makefile            |   1 +
 kernel/power/power_off_handler.c | 268 +++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 291 insertions(+)
 create mode 100644 kernel/power/power_off_handler.c

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 383fd68..49b3420 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -34,7 +34,29 @@
 extern void (*pm_power_off)(void);
 extern void (*pm_power_off_prepare)(void);
=20
+/*
+ * Callbacks to manage power-off handlers
+ */
+
+struct notifier_block;
 struct device; /* we have a circular dep with device.h */
+
+int register_power_off_handler(struct notifier_block *);
+int devm_register_power_off_handler(struct device *, struct notifier_b=
lock *);
+int register_power_off_handler_simple(void (*function)(void), int prio=
rity);
+int unregister_power_off_handler(struct notifier_block *);
+void do_kernel_power_off(void);
+bool have_kernel_power_off(void);
+
+/*
+ * Pre-defined power-off handler priorities
+ */
+#define POWER_OFF_PRIORITY_FALLBACK	0
+#define POWER_OFF_PRIORITY_LOW		64
+#define POWER_OFF_PRIORITY_DEFAULT	128
+#define POWER_OFF_PRIORITY_HIGH		192
+#define POWER_OFF_PRIORITY_HIGHEST	255
+
 #ifdef CONFIG_VT_CONSOLE_SLEEP
 extern void pm_vt_switch_required(struct device *dev, bool required);
 extern void pm_vt_switch_unregister(struct device *dev);
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 29472bf..567eda5 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -2,6 +2,7 @@
 ccflags-$(CONFIG_PM_DEBUG)	:=3D -DDEBUG
=20
 obj-y				+=3D qos.o
+obj-y				+=3D power_off_handler.o
 obj-$(CONFIG_PM)		+=3D main.o
 obj-$(CONFIG_VT_CONSOLE_SLEEP)	+=3D console.o
 obj-$(CONFIG_FREEZER)		+=3D process.o
diff --git a/kernel/power/power_off_handler.c b/kernel/power/power_off_=
handler.c
new file mode 100644
index 0000000..f838e63
--- /dev/null
+++ b/kernel/power/power_off_handler.c
@@ -0,0 +1,268 @@
+/*
+ * linux/kernel/power/power_off_handler.c - Power-off handling functio=
ns
+ *
+ * Copyright (c) 2014 Guenter Roeck
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt)	"power-off: " fmt
+
+#include <linux/ctype.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/kallsyms.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	to power off the system.
+ */
+static RAW_NOTIFIER_HEAD(power_off_handler_list);
+static DEFINE_SPINLOCK(power_off_handler_lock);
+
+/*
+ * Internal function to register power-off notifier.
+ * Must be called with power-off spinlock acquired.
+ */
+static int _register_power_off_handler(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&power_off_handler_list, nb);
+}
+
+/**
+ *	register_power_off_handler - Register function to be called to powe=
r off
+ *				     the system
+ *	@nb: Info about handler function to be called
+ *	@nb->priority:	Handler priority. Handlers should follow the
+ *			following guidelines for setting priorities.
+ *			0:	Power-off handler of last resort,
+ *				with limited power-off capabilities,
+ *				such as power-off handlers which
+ *				do not really power off the system
+ *				but loop forever or stop the CPU.
+ *			128:	Default power-off handler; use if no other
+ *				power-off handler is expected to be available,
+ *				and/or if power-off functionality is
+ *				sufficient to power off the entire system
+ *			255:	Highest priority power-off handler, will
+ *				preempt all other power-off handlers
+ *
+ *	Registers a function with code to be called to power off the
+ *	system.
+ *
+ *	Registered functions will be called from machine_power_off as last
+ *	step of the power-off sequence. Registered functions are expected
+ *	to power off the system immediately. If more than one function is
+ *	registered, the power-off handler priority selects which function
+ *	will be called first.
+ *
+ *	Power-off handlers may be registered from architecture code or from
+ *	drivers. A typical use case would be a system where power off
+ *	functionality is provided through a multi-function chip or through
+ *	a programmable power controller. Multiple power-off handlers may ex=
ist;
+ *	for example, one power-off handler might power off the entire syste=
m,
+ *	while another only powers off the CPU card. In such cases, the
+ *	power-off handler which only powers off part of the hardware is
+ *	expected to register with low priority to ensure that it only
+ *	runs if no other means to power off the system are available.
+ *
+ *	Always returns zero, as raw_notifier_chain_register() always
+ *	returns zero.
+ */
+int register_power_off_handler(struct notifier_block *nb)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&power_off_handler_lock, flags);
+	ret =3D _register_power_off_handler(nb);
+	spin_unlock_irqrestore(&power_off_handler_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(register_power_off_handler);
+
+/**
+ *	unregister_power_off_handler - Unregister previously registered
+ *				       power-off handler
+ *	@nb: Hook to be unregistered
+ *
+ *	Unregisters a previously registered power-off handler function.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+int unregister_power_off_handler(struct notifier_block *nb)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&power_off_handler_lock, flags);
+	ret =3D raw_notifier_chain_unregister(&power_off_handler_list, nb);
+	spin_unlock_irqrestore(&power_off_handler_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(unregister_power_off_handler);
+
+struct _power_off_handler_data {
+	void (*handler)(void);
+	struct notifier_block power_off_nb;
+};
+
+static int _power_off_handler(struct notifier_block *this,
+			      unsigned long _unused1, void *_unused2)
+{
+	struct _power_off_handler_data *poh =3D
+		container_of(this, struct _power_off_handler_data,
+			     power_off_nb);
+
+	poh->handler();
+
+	return NOTIFY_DONE;
+}
+
+static struct _power_off_handler_data power_off_handler_data;
+
+/**
+ *	register_power_off_handler_simple - Register function to be called
+ *					    to power off the system
+ *	@handler:	Function to be called to power off the system
+ *	@priority:	Handler priority. For priority guidelines see
+ *			register_power_off_handler.
+ *
+ *	This is a simplified version of register_power_off_handler. It does
+ *	not take a notifier as argument, but a function pointer. The functi=
on
+ *	registers a power-off handler with specified priority. Power-off
+ *	handlers registered with this function can not be unregistered,
+ *	and only a single power-off handler can be installed using it.
+ *
+ *	This function must not be called from modules and is therefore
+ *	not exported.
+ *
+ *	Returns -EBUSY if a power-off handler has already been registered
+ *	using register_power_off_handler_simple. Otherwise returns zero,
+ *	since raw_notifier_chain_register() currently always returns zero.
+ */
+int register_power_off_handler_simple(void (*handler)(void), int prior=
ity)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&power_off_handler_lock, flags);
+
+	if (power_off_handler_data.handler) {
+		pr_warn("Power-off function already registered (%ps), cannot registe=
r %ps",
+			power_off_handler_data.handler, handler);
+		ret =3D -EBUSY;
+		goto abort;
+	}
+
+	power_off_handler_data.handler =3D handler;
+	power_off_handler_data.power_off_nb.notifier_call =3D _power_off_hand=
ler;
+	power_off_handler_data.power_off_nb.priority =3D priority;
+
+	ret =3D _register_power_off_handler(&power_off_handler_data.power_off=
_nb);
+abort:
+	spin_unlock_irqrestore(&power_off_handler_lock, flags);
+	return ret;
+}
+
+/* Device managed power-off handler registration */
+
+static void devm_power_off_release(struct device *dev, void *res)
+{
+	struct notifier_block *nb =3D *(struct notifier_block **)res;
+
+	unregister_power_off_handler(nb);
+}
+
+/**
+ *	devm_register_power_off_handler - Register function to be called
+ *					  to power off the system
+ *	@dev:		The device registering the power-off handler.
+ *	@handler:	Function to be called to power off the system
+ *	@priority:	Handler priority. For priority guidelines see
+ *			register_power_off_handler.
+ *
+ *	This is the device managed version of register_power_off_handler.
+ *
+ *	Returns -EINVAL if dev is NULL. Returns -ENOMEM if the system is ou=
t
+ *	of memory. Otherwise returns zero, since raw_notifier_chain_registe=
r()
+ *	currently always returns zero.
+ */
+int devm_register_power_off_handler(struct device *dev,
+				    struct notifier_block *nb)
+{
+	struct notifier_block **ptr;
+	unsigned long flags;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ptr =3D devres_alloc(devm_power_off_release, sizeof(*ptr), GFP_KERNEL=
);
+	if (!ptr)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&power_off_handler_lock, flags);
+	ret =3D _register_power_off_handler(nb);
+	spin_unlock_irqrestore(&power_off_handler_lock, flags);
+	if (ret)
+		goto error;
+
+	*ptr =3D nb;
+	devres_add(dev, ptr);
+	return 0;
+error:
+	devres_free(ptr);
+	return ret;
+}
+EXPORT_SYMBOL(devm_register_power_off_handler);
+
+/**
+ *	do_kernel_power_off - Execute kernel power-off handler call chain
+ *
+ *	Calls functions registered with register_power_off_handler.
+ *
+ *	Expected to be called from machine_power_off as last step of
+ *	the power-off sequence.
+ *
+ *	Powers the system off immediately if a power-off handler function
+ *	has been registered. Otherwise does nothing.
+ */
+void do_kernel_power_off(void)
+{
+	/*
+	 * No locking. This code can be called from both atomic and non-atomi=
c
+	 * context, with interrupts enabled or disabled, depending on the
+	 * architecture and platform.
+	 *
+	 * Power-off handler registration and de-registration are executed in
+	 * atomic context with interrupts disabled, which guarantees that
+	 * do_kernel_power_off() will not be called while a power-off handler
+	 * is installed or removed.
+	 * There is a theoretic risc that a power-off handler is installed or
+	 * removed while the call chain is traversed, but we'll have to carry
+	 * that risk.
+	 */
+	raw_notifier_call_chain(&power_off_handler_list, 0, NULL);
+}
+
+/**
+ * have_kernel_power_off() - Check if kernel power-off handler is avai=
lable
+ *
+ * Returns true is a kernel power-off handler is available, false othe=
rwise.
+ */
+bool have_kernel_power_off(void)
+{
+	return pm_power_off !=3D NULL || power_off_handler_list.head !=3D NUL=
L;
+}
+EXPORT_SYMBOL(have_kernel_power_off);
--=20
1.9.1

