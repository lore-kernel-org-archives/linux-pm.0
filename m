From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v6 5/9] thermal: extend the cooling device API to include power information
Date: Fri,  5 Dec 2014 19:04:16 +0000
Message-ID: <1417806260-9264-6-git-send-email-javi.merino@arm.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Add three optional callbacks to the cooling device interface to allow
them to express power.  In addition to the callbacks, add helpers to
identify cooling devices that implement the power cooling device API.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/power_allocator.txt | 27 ++++++++++++++++++++++
 drivers/thermal/thermal_core.c            | 38 +++++++++++++++++++++++++++=
++++
 include/linux/thermal.h                   | 12 ++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 Documentation/thermal/power_allocator.txt

diff --git a/Documentation/thermal/power_allocator.txt b/Documentation/ther=
mal/power_allocator.txt
new file mode 100644
index 000000000000..d3bb79050c27
--- /dev/null
+++ b/Documentation/thermal/power_allocator.txt
@@ -0,0 +1,27 @@
+Cooling device power API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Cooling devices controlled by this governor must supply the additional
+"power" API in their `cooling_device_ops`.  It consists on three ops:
+
+1. u32 get_actual_power(struct thermal_cooling_device *cdev);
+@cdev: The `struct thermal_cooling_device` pointer
+
+`get_actual_power()` returns the power currently consumed by the
+device in milliwatts.
+
+2. u32 state2power(struct thermal_cooling_device *cdev, unsigned long
+        state);
+@cdev: The `struct thermal_cooling_device` pointer
+@state: A cooling device state
+
+Convert cooling device state @state into power consumption in
+milliwatts.
+
+3. unsigned long power2state(struct thermal_cooling_device *cdev,
+        u32 power);
+@cdev: The `struct thermal_cooling_device` pointer
+@power: power in milliwatts
+
+Calculate a cooling device state that would make the device consume at
+most @power mW.
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 9021cb72a13a..c490f262ea7f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -866,6 +866,44 @@ emul_temp_store(struct device *dev, struct device_attr=
ibute *attr,
 static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
 #endif/*CONFIG_THERMAL_EMULATION*/
=20
+/**
+ * power_actor_get_max_power() - get the maximum power that a cdev can con=
sume
+ * @cdev:=09pointer to &thermal_cooling_device
+ *
+ * Calculate the maximum power consumption in milliwats that the
+ * cooling device can currently consume.  If @cdev doesn't support the
+ * power_actor API, this function returns 0.
+ */
+u32 power_actor_get_max_power(struct thermal_cooling_device *cdev)
+{
+=09if (!cdev_is_power_actor(cdev))
+=09=09return 0;
+
+=09return cdev->ops->state2power(cdev, 0);
+}
+
+/**
+ * power_actor_set_power() - limit the maximum power that a cooling device=
 can consume
+ * @cdev:=09pointer to &thermal_cooling_device
+ * @power:=09the power in milliwatts
+ *
+ * Set the cooling device to consume at most @power milliwatts.
+ *
+ * Returns: 0 on success, -EINVAL if the cooling device does not
+ * implement the power actor API or -E* for other failures.
+ */
+int power_actor_set_power(struct thermal_cooling_device *cdev, u32 power)
+{
+=09unsigned long state;
+
+=09if (!cdev_is_power_actor(cdev))
+=09=09return -EINVAL;
+
+=09state =3D cdev->ops->power2state(cdev, power);
+
+=09return cdev->ops->set_cur_state(cdev, state);
+}
+
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2c14ab1f5c0d..1155457caf52 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -142,6 +142,9 @@ struct thermal_cooling_device_ops {
 =09int (*get_max_state) (struct thermal_cooling_device *, unsigned long *)=
;
 =09int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *)=
;
 =09int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
+=09u32 (*get_actual_power) (struct thermal_cooling_device *);
+=09u32 (*state2power) (struct thermal_cooling_device *, unsigned long);
+=09unsigned long (*power2state) (struct thermal_cooling_device *, u32);
 };
=20
 struct thermal_cooling_device {
@@ -322,6 +325,15 @@ void thermal_zone_of_sensor_unregister(struct device *=
dev,
 }
=20
 #endif
+
+static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev=
)
+{
+=09return cdev->ops->get_actual_power && cdev->ops->state2power &&
+=09=09cdev->ops->power2state;
+}
+
+u32 power_actor_get_max_power(struct thermal_cooling_device *);
+int power_actor_set_power(struct thermal_cooling_device *, u32);
 struct thermal_zone_device *thermal_zone_device_register(const char *, int=
, int,
 =09=09void *, struct thermal_zone_device_ops *,
 =09=09const struct thermal_zone_params *, int, int);
--=20
1.9.1
