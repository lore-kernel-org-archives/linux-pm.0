From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v5 06/10] thermal: introduce the Power Actor API
Date: Thu, 10 Jul 2014 15:18:44 +0100
Message-ID: <1405001928-12697-7-git-send-email-javi.merino@arm.com>
References: <1405001928-12697-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405001928-12697-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch introduces the Power Actor API in the thermal framework.
With it, devices that can report their power consumption and control
it can be registered.  This base interface is meant to be used to
derive specific power actors, such as a cpu power actor.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/power_actor.txt | 56 ++++++++++++++++++++++++++++
 drivers/thermal/Kconfig               |  3 ++
 drivers/thermal/Makefile              |  3 ++
 drivers/thermal/power_actor.c         | 70 +++++++++++++++++++++++++++++++=
++++
 include/linux/power_actor.h           | 60 ++++++++++++++++++++++++++++++
 5 files changed, 192 insertions(+)
 create mode 100644 Documentation/thermal/power_actor.txt
 create mode 100644 drivers/thermal/power_actor.c
 create mode 100644 include/linux/power_actor.h

diff --git a/Documentation/thermal/power_actor.txt b/Documentation/thermal/=
power_actor.txt
new file mode 100644
index 000000000000..11ca2d0bf0bd
--- /dev/null
+++ b/Documentation/thermal/power_actor.txt
@@ -0,0 +1,56 @@
+Power Actor API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The base power actor API is meant to be used to derive specific power
+actors, such as a cpu power actor.  Power actors can be registered by
+calling `power_actor_register()` and should be unregistered by calling
+`power_actor_unregister()` with the `struct power_actor *` received in
+the call to `power_actor_register()`.
+
+This can't be implemented using the cooling device API because:
+
+1.  get_max_state() gives you the maximum cooling state which, for
+    passive devices, is the minimum performance (frequency in case of
+    cpufreq cdev).  get_max_power() gives you the maximum power, which
+    gives you the maximum performance (frequency in the case of CPUs,
+    GPUs and buses)
+
+2.  You need to pass the thermal_zone_device to all the callbacks,
+    something that the current cooling device API doesn't do.
+
+Callbacks
+---------
+
+1. u32 get_req_power(struct power_actor *actor,
+=09=09=09=09=09struct thermal_zone_device *tz)
+@actor: a valid `struct power_actor *` registered with
+        `power_actor_register()`
+@tz:=09the thermal zone closest to the actor (typically, the thermal
+=09=09zone the caller is operating on)
+
+`get_req_power()` returns the current requested power in milliwatts.
+
+2. u32 get_max_power(struct power_actor *actor,
+=09=09=09=09=09struct thermal_zone_device *tz)
+@actor: a valid `struct power_actor *` registered with
+        `power_actor_register()`
+@tz:=09the thermal zone closest to the actor (typically, the thermal
+=09=09zone the caller is operating on)
+
+`get_max_power()` returns the maximum power that the device could
+consume if it was fully utilized.  It's a function as some devices'
+maximum power consumption can change due to external factors such as
+temperature.
+
+3. int set_power(struct power_actor *actor,
+=09=09=09=09struct thermal_zone_device *tz, u32 power)
+@actor: a valid `struct power_actor *` registered with
+        `power_actor_register()`
+@tz:=09the thermal zone closest to the actor (typically, the thermal
+=09=09zone the caller is operating on)
+@power: power in milliwatts
+
+`set_power()` should configure the device to consume @power
+milliwatts.
+
+Returns 0 on success, -E* on error.
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f9a13867cb70..ce4ebe17252c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -89,6 +89,9 @@ config THERMAL_GOV_USER_SPACE
 =09help
 =09  Enable this to let the user space manage the platform thermals.
=20
+config THERMAL_POWER_ACTOR
+=09bool
+
 config CPU_THERMAL
 =09bool "generic cpu cooling support"
 =09depends on CPU_FREQ
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index de0636a57a64..d83aa42ab573 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -14,6 +14,9 @@ thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)=09+=3D fair_=
share.o
 thermal_sys-$(CONFIG_THERMAL_GOV_STEP_WISE)=09+=3D step_wise.o
 thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)=09+=3D user_space.o
=20
+# power actors
+obj-$(CONFIG_THERMAL_POWER_ACTOR) +=3D power_actor.o
+
 # cpufreq cooling
 thermal_sys-$(CONFIG_CPU_THERMAL)=09+=3D cpu_cooling.o
=20
diff --git a/drivers/thermal/power_actor.c b/drivers/thermal/power_actor.c
new file mode 100644
index 000000000000..0b123f9850ea
--- /dev/null
+++ b/drivers/thermal/power_actor.c
@@ -0,0 +1,70 @@
+/*
+ * Basic interface for power actors
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "Power actor: " fmt
+
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/power_actor.h>
+#include <linux/rculist.h>
+#include <linux/slab.h>
+
+LIST_HEAD(actor_list);
+static DEFINE_MUTEX(actor_list_lock);
+
+/**
+ * power_actor_register() - Register an actor in the power actor API
+ * @ops:=09&struct power_actor_ops for this actor
+ * @privdata:=09pointer to private data related to the actor
+ *
+ * Return: The &struct power_actor * on success, ERR_PTR() on failure
+ */
+struct power_actor *power_actor_register(struct power_actor_ops *ops,
+=09=09=09=09=09void *privdata)
+{
+=09struct power_actor *actor;
+
+=09if (!ops->get_req_power || !ops->get_max_power || !ops->set_power)
+=09=09return ERR_PTR(-EINVAL);
+
+=09actor =3D kzalloc(sizeof(*actor), GFP_KERNEL);
+=09if (!actor)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09actor->ops =3D ops;
+=09actor->data =3D privdata;
+
+=09mutex_lock(&actor_list_lock);
+=09list_add_rcu(&actor->actor_node, &actor_list);
+=09mutex_unlock(&actor_list_lock);
+
+=09return actor;
+}
+EXPORT_SYMBOL(power_actor_register);
+
+/**
+ * power_actor_unregister() - Unregister an actor
+ * @actor:=09the actor to unregister
+ */
+void power_actor_unregister(struct power_actor *actor)
+{
+=09mutex_lock(&actor_list_lock);
+=09list_del_rcu(&actor->actor_node);
+=09mutex_unlock(&actor_list_lock);
+=09synchronize_rcu();
+
+=09kfree(actor);
+}
+EXPORT_SYMBOL(power_actor_unregister);
diff --git a/include/linux/power_actor.h b/include/linux/power_actor.h
new file mode 100644
index 000000000000..c2357fe7aad5
--- /dev/null
+++ b/include/linux/power_actor.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2014 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __POWER_ACTOR_H__
+#define __POWER_ACTOR_H__
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+struct power_actor;
+
+/**
+ * struct power_actor_ops - callbacks for power actors
+ * @get_req_power:=09return the current requested power in milliwatts
+ * @get_max_power:=09return the max power that the device can currently
+ *=09=09=09consume in milliwatts
+ * @set_power:=09=09configure the device to consume a certain power in
+ *=09=09=09milliwatts
+ */
+struct power_actor_ops {
+=09u32 (*get_req_power)(struct power_actor *,
+=09=09=09struct thermal_zone_device *);
+=09u32 (*get_max_power)(struct power_actor *,
+=09=09=09struct thermal_zone_device *);
+=09int (*set_power)(struct power_actor *, struct thermal_zone_device *,
+=09=09=09u32);
+};
+
+/**
+ * struct power_actor - structure for a power actor
+ * @ops:=09callbacks for the power actor
+ * @data:=09a private pointer for type-specific data
+ * @actor_node:=09node in actor_list
+ */
+struct power_actor {
+=09struct power_actor_ops *ops;
+=09void *data;
+=09struct list_head actor_node;
+};
+
+struct power_actor *power_actor_register(struct power_actor_ops *ops,
+=09=09=09=09=09void *privdata);
+void power_actor_unregister(struct power_actor *actor);
+
+extern struct list_head actor_list;
+
+#endif /* __POWER_ACTOR_H__ */
--=20
1.9.1
