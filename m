From: Javi Merino <javi.merino@arm.com>
Subject: [RFC PATCH v2 4/7] thermal: introduce the Power Actor API
Date: Tue, 20 May 2014 15:10:54 +0100
Message-ID: <1400595057-8585-5-git-send-email-javi.merino@arm.com>
References: <1400595057-8585-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37737 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbaETOLr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 10:11:47 -0400
In-Reply-To: <1400595057-8585-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

This patch introduces the Power Actor API in the thermal framework.
With it, devices that can report their power consumption and control
it can be registered.  This base interface is meant to be used to
derive specific power actors, such as a cpu power actor.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/power_actor.txt     |   29 +++++++++++++
 drivers/thermal/Kconfig                   |    3 ++
 drivers/thermal/Makefile                  |    2 +
 drivers/thermal/power_actor/Makefile      |    5 +++
 drivers/thermal/power_actor/power_actor.c |   66 +++++++++++++++++++++++++=
++++
 drivers/thermal/power_actor/power_actor.h |   63 +++++++++++++++++++++++++=
++
 6 files changed, 168 insertions(+)
 create mode 100644 Documentation/thermal/power_actor.txt
 create mode 100644 drivers/thermal/power_actor/Makefile
 create mode 100644 drivers/thermal/power_actor/power_actor.c
 create mode 100644 drivers/thermal/power_actor/power_actor.h

diff --git a/Documentation/thermal/power_actor.txt b/Documentation/thermal/=
power_actor.txt
new file mode 100644
index 000000000000..a0f06e091907
--- /dev/null
+++ b/Documentation/thermal/power_actor.txt
@@ -0,0 +1,29 @@
+
+Power Actor API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The base power actor API is meant to be used to derive specific power
+actors, such as a cpu power actor.  When registering, they should call
+`power_actor_register()` with a unique `enum power_actor_types`.  When
+unregistering, the power actor should call `power_actor_unregister()`
+with the `struct power_actor *` received in the call to
+`power_actor_register()`.
+
+Callbacks
+---------
+
+1. u32 get_req_power(struct power_actor *actor)
+@actor: a valid `struct power_actor *` registered with
+        `power_actor_register()`
+
+`get_req_power()` returns the current requested power in milliwatts.
+
+2. int set_power(struct power_actor *actor, u32 power)
+@actor: a valid `struct power_actor *` registered with
+        `power_actor_register()`
+@power: power in milliwatts
+
+`set_power()` should configure the device to consume @power
+milliwatts.
+
+Returns 0 on success, -E* on error.
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d51912a6e40..47e2f15537ca 100644
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
index 54e4ec9eb5df..878a02cab7d1 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -14,6 +14,8 @@ thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)=09+=3D fair_=
share.o
 thermal_sys-$(CONFIG_THERMAL_GOV_STEP_WISE)=09+=3D step_wise.o
 thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)=09+=3D user_space.o
=20
+obj-$(CONFIG_THERMAL_POWER_ACTOR) +=3D power_actor/
+
 # cpufreq cooling
 thermal_sys-$(CONFIG_CPU_THERMAL)=09+=3D cpu_cooling.o
=20
diff --git a/drivers/thermal/power_actor/Makefile b/drivers/thermal/power_a=
ctor/Makefile
new file mode 100644
index 000000000000..46478f4928be
--- /dev/null
+++ b/drivers/thermal/power_actor/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the power actors
+#
+
+obj-y +=3D power_actor.o
diff --git a/drivers/thermal/power_actor/power_actor.c b/drivers/thermal/po=
wer_actor/power_actor.c
new file mode 100644
index 000000000000..3edcb1ab4dff
--- /dev/null
+++ b/drivers/thermal/power_actor/power_actor.c
@@ -0,0 +1,66 @@
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
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "power_actor.h"
+
+LIST_HEAD(actor_list);
+
+/**
+ * power_actor_register - Register an actor in the power actor API
+ * @type:=09actor type
+ * @ops:=09struct power_actor_ops for this actor
+ * @max_power:=09maximum power that this actor can consume
+ * @privdata:=09pointer to private data related to the actor
+ *
+ * Returns the struct power_actor * on success, ERR_PTR() on failure
+ */
+struct power_actor *power_actor_register(enum power_actor_types type,
+=09=09=09=09=09struct power_actor_ops *ops,
+=09=09=09=09=09u32 max_power, void *privdata)
+{
+=09struct power_actor *actor;
+
+=09if (!ops->get_req_power || !ops->set_power)
+=09=09return ERR_PTR(-EINVAL);
+
+=09actor =3D kzalloc(sizeof(*actor), GFP_KERNEL);
+=09if (!actor)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09actor->type =3D type;
+=09actor->ops =3D ops;
+=09actor->max_power =3D max_power;
+=09actor->data =3D privdata;
+
+=09list_add(&actor->actor_node, &actor_list);
+
+=09return actor;
+}
+
+/**
+ * power_actor_unregister - Unregister an actor
+ * @actor:=09the actor to unregister
+ */
+void power_actor_unregister(struct power_actor *actor)
+{
+=09list_del(&actor->actor_node);
+=09kfree(actor);
+}
diff --git a/drivers/thermal/power_actor/power_actor.h b/drivers/thermal/po=
wer_actor/power_actor.h
new file mode 100644
index 000000000000..82be19ce741d
--- /dev/null
+++ b/drivers/thermal/power_actor/power_actor.h
@@ -0,0 +1,63 @@
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
+
+#define MAX_NUM_ACTORS 8
+
+enum power_actor_types {
+};
+
+struct power_actor;
+
+/**
+ * struct power_actor_ops - callbacks for power actors
+ * @get_req_power:=09return the current requested power in milliwatts
+ * @set_power:=09=09configure the device to consume a certain power in
+ *=09=09=09milliwatts
+ */
+struct power_actor_ops {
+=09u32 (*get_req_power)(struct power_actor *);
+=09int (*set_power)(struct power_actor *, u32);
+};
+
+/**
+ * struct power_actor - structure for a power actor
+ * @type:=09the type of power actor.
+ * @ops:=09callbacks for the power actor
+ * @max_power:=09the maximum power that this actor can consume, in milliwa=
tts
+ * @data:=09a private pointer for type-specific data
+ * @actor_node:=09node in actor_list
+ */
+struct power_actor {
+=09enum power_actor_types type;
+=09struct power_actor_ops *ops;
+=09u32 max_power;
+=09void *data;
+=09struct list_head actor_node;
+};
+
+struct power_actor *power_actor_register(enum power_actor_types type,
+=09=09=09=09=09struct power_actor_ops *ops,
+=09=09=09=09=09u32 max_power, void *privdata);
+void power_actor_unregister(struct power_actor *actor);
+
+extern struct list_head actor_list;
+
+#endif /* __POWER_ACTOR_H__ */
--=20
1.7.9.5


