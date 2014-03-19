From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: let cooling devices operate on other units other than state
Date: Wed, 19 Mar 2014 15:14:58 +0000
Message-ID: <1395242098-18375-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48610 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbaCSPPZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Mar 2014 11:15:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>

Currently, cooling devices operate on state, even though some (like
the cpufreq cooling device) have exported functions to convert
frequency to state.  Generalize this interface so that governors can
operate on other units (e.g. frequency, power,...).

Suggested-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>

---

Hi,

We would like to create a governor[1] that talks to cooling devices in
terms of power instead of "state".  At the same time, we'd like to
reuse some of the existing cooling devices.  We need exactly the same
interface (get_cur, get_max, set_cur), so we'd like to extend it to
support "units".

[1] http://article.gmane.org/gmane.linux.power-management.general/43243

This patch is a bit intrusive, so if you have any other ideas on how
to do this in a more elegant way, please let us know.

 drivers/acpi/fan.c                  |   22 ++++++++++++++------
 drivers/acpi/processor_thermal.c    |   23 +++++++++++++++------
 drivers/acpi/video.c                |   22 ++++++++++++++------
 drivers/platform/x86/acerhdf.c      |   24 ++++++++++++++++------
 drivers/platform/x86/intel_menlow.c |   26 +++++++++++++++++-------
 drivers/power/power_supply_core.c   |   24 ++++++++++++++++------
 drivers/thermal/cpu_cooling.c       |   38 ++++++++++++++++++++++++++-----=
----
 drivers/thermal/db8500_thermal.c    |    2 +-
 drivers/thermal/fair_share.c        |    2 +-
 drivers/thermal/intel_powerclamp.c  |   24 ++++++++++++++++------
 drivers/thermal/step_wise.c         |    2 +-
 drivers/thermal/thermal_core.c      |   13 ++++++------
 include/linux/thermal.h             |   13 +++++++++---
 13 files changed, 169 insertions(+), 66 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 09e423f..bc6e984 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -74,20 +74,26 @@ static struct acpi_driver acpi_fan_driver =3D {
=20
 /* thermal cooling device callbacks */
 static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned=
 long
-=09=09=09     *state)
+=09=09=09     *state, enum thermal_cooling_unit unit)
 {
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09/* ACPI fan device only support two states: ON/OFF */
 =09*state =3D 1;
 =09return 0;
 }
=20
 static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned=
 long
-=09=09=09     *state)
+=09=09=09     *state, enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cdev->devdata;
 =09int result;
 =09int acpi_state =3D ACPI_STATE_D0;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (!device)
 =09=09return -EINVAL;
=20
@@ -101,11 +107,15 @@ static int fan_get_cur_state(struct thermal_cooling_d=
evice *cdev, unsigned long
 }
=20
 static int
-fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state=
)
+fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state=
,
+=09=09  enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cdev->devdata;
 =09int result;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (!device || (state !=3D 0 && state !=3D 1))
 =09=09return -EINVAL;
=20
@@ -116,9 +126,9 @@ fan_set_cur_state(struct thermal_cooling_device *cdev, =
unsigned long state)
 }
=20
 static const struct thermal_cooling_device_ops fan_cooling_ops =3D {
-=09.get_max_state =3D fan_get_max_state,
-=09.get_cur_state =3D fan_get_cur_state,
-=09.set_cur_state =3D fan_set_cur_state,
+=09.get_max =3D fan_get_max_state,
+=09.get_cur =3D fan_get_cur_state,
+=09.set_cur =3D fan_set_cur_state,
 };
=20
 /* -----------------------------------------------------------------------=
---
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_ther=
mal.c
index e003663..48179ed 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -200,11 +200,15 @@ static int acpi_processor_max_state(struct acpi_proce=
ssor *pr)
 }
 static int
 processor_get_max_state(struct thermal_cooling_device *cdev,
-=09=09=09unsigned long *state)
+=09=09=09unsigned long *state,
+=09=09=09enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cdev->devdata;
 =09struct acpi_processor *pr;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (!device)
 =09=09return -EINVAL;
=20
@@ -218,11 +222,15 @@ processor_get_max_state(struct thermal_cooling_device=
 *cdev,
=20
 static int
 processor_get_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09unsigned long *cur_state)
+=09=09=09unsigned long *cur_state,
+=09=09=09enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cdev->devdata;
 =09struct acpi_processor *pr;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (!device)
 =09=09return -EINVAL;
=20
@@ -238,13 +246,16 @@ processor_get_cur_state(struct thermal_cooling_device=
 *cdev,
=20
 static int
 processor_set_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09unsigned long state)
+=09=09=09unsigned long state, enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cdev->devdata;
 =09struct acpi_processor *pr;
 =09int result =3D 0;
 =09int max_pstate;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (!device)
 =09=09return -EINVAL;
=20
@@ -270,7 +281,7 @@ processor_set_cur_state(struct thermal_cooling_device *=
cdev,
 }
=20
 const struct thermal_cooling_device_ops processor_cooling_ops =3D {
-=09.get_max_state =3D processor_get_max_state,
-=09.get_cur_state =3D processor_get_cur_state,
-=09.set_cur_state =3D processor_set_cur_state,
+=09.get_max =3D processor_get_max_state,
+=09.get_cur =3D processor_get_cur_state,
+=09.set_cur =3D processor_set_cur_state,
 };
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b6ba88e..8168a09 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -284,23 +284,29 @@ static const struct backlight_ops acpi_backlight_ops =
=3D {
=20
 /* thermal cooling device callbacks */
 static int video_get_max_state(struct thermal_cooling_device *cooling_dev,=
 unsigned
-=09=09=09       long *state)
+=09=09=09       long *state, enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cooling_dev->devdata;
 =09struct acpi_video_device *video =3D acpi_driver_data(device);
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09*state =3D video->brightness->count - 3;
 =09return 0;
 }
=20
 static int video_get_cur_state(struct thermal_cooling_device *cooling_dev,=
 unsigned
-=09=09=09       long *state)
+=09=09=09       long *state, enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cooling_dev->devdata;
 =09struct acpi_video_device *video =3D acpi_driver_data(device);
 =09unsigned long long level;
 =09int offset;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (acpi_video_device_lcd_get_level_current(video, &level, false))
 =09=09return -EINVAL;
 =09for (offset =3D 2; offset < video->brightness->count; offset++)
@@ -313,12 +319,16 @@ static int video_get_cur_state(struct thermal_cooling=
_device *cooling_dev, unsig
 }
=20
 static int
-video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned l=
ong state)
+video_set_cur_state(struct thermal_cooling_device *cooling_dev,
+=09=09unsigned long state, enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cooling_dev->devdata;
 =09struct acpi_video_device *video =3D acpi_driver_data(device);
 =09int level;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (state >=3D video->brightness->count - 2)
 =09=09return -EINVAL;
=20
@@ -328,9 +338,9 @@ video_set_cur_state(struct thermal_cooling_device *cool=
ing_dev, unsigned long st
 }
=20
 static const struct thermal_cooling_device_ops video_cooling_ops =3D {
-=09.get_max_state =3D video_get_max_state,
-=09.get_cur_state =3D video_get_cur_state,
-=09.set_cur_state =3D video_set_cur_state,
+=09.get_max =3D video_get_max_state,
+=09.get_cur =3D video_get_cur_state,
+=09.set_cur =3D video_set_cur_state,
 };
=20
 /*
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.=
c
index f94467c..0bb85e2 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -439,18 +439,26 @@ static struct thermal_zone_device_ops acerhdf_dev_ops=
 =3D {
  * get maximal fan cooling state
  */
 static int acerhdf_get_max_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long *state)
+=09=09=09=09 unsigned long *state,
+=09=09=09=09 enum thermal_cooling_unit unit)
 {
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09*state =3D 1;
=20
 =09return 0;
 }
=20
 static int acerhdf_get_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long *state)
+=09=09=09=09 unsigned long *state,
+=09=09=09=09 enum thermal_cooling_unit unit)
 {
 =09int err =3D 0, tmp;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09err =3D acerhdf_get_fanstate(&tmp);
 =09if (err)
 =09=09return err;
@@ -461,10 +469,14 @@ static int acerhdf_get_cur_state(struct thermal_cooli=
ng_device *cdev,
=20
 /* change current fan state - is overwritten when running in kernel mode *=
/
 static int acerhdf_set_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long state)
+=09=09=09=09 unsigned long state,
+=09=09=09=09 enum thermal_cooling_unit unit)
 {
 =09int cur_temp, cur_state, err =3D 0;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (!kernelmode)
 =09=09return 0;
=20
@@ -498,9 +510,9 @@ err_out:
=20
 /* bind fan callbacks to fan device */
 static struct thermal_cooling_device_ops acerhdf_cooling_ops =3D {
-=09.get_max_state =3D acerhdf_get_max_state,
-=09.get_cur_state =3D acerhdf_get_cur_state,
-=09.set_cur_state =3D acerhdf_set_cur_state,
+=09.get_max =3D acerhdf_get_max_state,
+=09.get_cur =3D acerhdf_get_cur_state,
+=09.set_cur =3D acerhdf_set_cur_state,
 };
=20
 /* suspend / resume functionality */
diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/int=
el_menlow.c
index e8b46d2..9792da4 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -61,7 +61,8 @@ static void intel_menlow_unregister_sensor(void);
  * GTHS returning '0' would mean that no bandwidth control states are supp=
orted
  */
 static int memory_get_max_bandwidth(struct thermal_cooling_device *cdev,
-=09=09=09=09    unsigned long *max_state)
+=09=09=09=09unsigned long *max_state,
+=09=09=09=09enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cdev->devdata;
 =09acpi_handle handle =3D device->handle;
@@ -70,6 +71,9 @@ static int memory_get_max_bandwidth(struct thermal_coolin=
g_device *cdev,
 =09union acpi_object arg;
 =09acpi_status status =3D AE_OK;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09arg_list.count =3D 1;
 =09arg_list.pointer =3D &arg;
 =09arg.type =3D ACPI_TYPE_INTEGER;
@@ -87,7 +91,8 @@ static int memory_get_max_bandwidth(struct thermal_coolin=
g_device *cdev,
 }
=20
 static int memory_get_cur_bandwidth(struct thermal_cooling_device *cdev,
-=09=09=09=09    unsigned long *value)
+=09=09=09=09    unsigned long *value,
+=09=09=09=09    enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cdev->devdata;
 =09acpi_handle handle =3D device->handle;
@@ -96,6 +101,9 @@ static int memory_get_cur_bandwidth(struct thermal_cooli=
ng_device *cdev,
 =09union acpi_object arg;
 =09acpi_status status =3D AE_OK;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09arg_list.count =3D 1;
 =09arg_list.pointer =3D &arg;
 =09arg.type =3D ACPI_TYPE_INTEGER;
@@ -110,7 +118,8 @@ static int memory_get_cur_bandwidth(struct thermal_cool=
ing_device *cdev,
 }
=20
 static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
-=09=09=09=09    unsigned long state)
+=09=09=09=09    unsigned long state,
+=09=09=09=09    enum thermal_cooling_unit unit)
 {
 =09struct acpi_device *device =3D cdev->devdata;
 =09acpi_handle handle =3D device->handle;
@@ -120,7 +129,10 @@ static int memory_set_cur_bandwidth(struct thermal_coo=
ling_device *cdev,
 =09unsigned long long temp;
 =09unsigned long max_state;
=20
-=09if (memory_get_max_bandwidth(cdev, &max_state))
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
+=09if (memory_get_max_bandwidth(cdev, &max_state, THERMAL_UNIT_STATE))
 =09=09return -EFAULT;
=20
 =09if (state > max_state)
@@ -143,9 +155,9 @@ static int memory_set_cur_bandwidth(struct thermal_cool=
ing_device *cdev,
 }
=20
 static struct thermal_cooling_device_ops memory_cooling_ops =3D {
-=09.get_max_state =3D memory_get_max_bandwidth,
-=09.get_cur_state =3D memory_get_cur_bandwidth,
-=09.set_cur_state =3D memory_set_cur_bandwidth,
+=09.get_max =3D memory_get_max_bandwidth,
+=09.get_cur =3D memory_get_cur_bandwidth,
+=09.set_cur =3D memory_set_cur_bandwidth,
 };
=20
 /*
diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply=
_core.c
index 2660664..69dc290 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -440,12 +440,16 @@ static void psy_unregister_thermal(struct power_suppl=
y *psy)
=20
 /* thermal cooling device callbacks */
 static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd=
,
-=09=09=09=09=09unsigned long *state)
+=09=09=09=09=09unsigned long *state,
+=09=09=09=09=09enum thermal_cooling_unit unit)
 {
 =09struct power_supply *psy;
 =09union power_supply_propval val;
 =09int ret;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09psy =3D tcd->devdata;
 =09ret =3D psy->get_property(psy,
 =09=09POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX, &val);
@@ -456,12 +460,16 @@ static int ps_get_max_charge_cntl_limit(struct therma=
l_cooling_device *tcd,
 }
=20
 static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *tcd=
,
-=09=09=09=09=09unsigned long *state)
+=09=09=09=09=09unsigned long *state,
+=09=09=09=09=09enum thermal_cooling_unit unit)
 {
 =09struct power_supply *psy;
 =09union power_supply_propval val;
 =09int ret;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09psy =3D tcd->devdata;
 =09ret =3D psy->get_property(psy,
 =09=09POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
@@ -472,12 +480,16 @@ static int ps_get_cur_chrage_cntl_limit(struct therma=
l_cooling_device *tcd,
 }
=20
 static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd=
,
-=09=09=09=09=09unsigned long state)
+=09=09=09=09=09unsigned long state,
+=09=09=09=09=09enum thermal_cooling_unit unit)
 {
 =09struct power_supply *psy;
 =09union power_supply_propval val;
 =09int ret;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09psy =3D tcd->devdata;
 =09val.intval =3D state;
 =09ret =3D psy->set_property(psy,
@@ -487,9 +499,9 @@ static int ps_set_cur_charge_cntl_limit(struct thermal_=
cooling_device *tcd,
 }
=20
 static struct thermal_cooling_device_ops psy_tcd_ops =3D {
-=09.get_max_state =3D ps_get_max_charge_cntl_limit,
-=09.get_cur_state =3D ps_get_cur_chrage_cntl_limit,
-=09.set_cur_state =3D ps_set_cur_charge_cntl_limit,
+=09.get_max =3D ps_get_max_charge_cntl_limit,
+=09.get_cur =3D ps_get_cur_chrage_cntl_limit,
+=09.set_cur =3D ps_set_cur_charge_cntl_limit,
 };
=20
 static int psy_register_cooler(struct power_supply *psy)
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 4246262..f3f4e6b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -348,14 +348,17 @@ static int cpufreq_thermal_notifier(struct notifier_b=
lock *nb,
  * cpufreq_get_max_state - callback function to get the max cooling state.
  * @cdev: thermal cooling device pointer.
  * @state: fill this variable with the max cooling state.
+ * @unit: the units in which @state should be in.
  *
- * Callback for the thermal cooling device to return the cpufreq
- * max cooling state.
+ * Callback for the thermal cooling device to return the cpufreq max
+ * cooling state.  Currently only THERMAL_UNIT_STATE is valid for
+ * @unit.
  *
  * Return: 0 on success, an error code otherwise.
  */
 static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long *state)
+=09=09=09=09unsigned long *state,
+=09=09=09=09enum thermal_cooling_unit unit)
 {
 =09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
 =09struct cpumask *mask =3D &cpufreq_device->allowed_cpus;
@@ -363,6 +366,9 @@ static int cpufreq_get_max_state(struct thermal_cooling=
_device *cdev,
 =09unsigned int count =3D 0;
 =09int ret;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09cpu =3D cpumask_any(mask);
=20
 =09ret =3D get_property(cpu, 0, &count, GET_MAXL);
@@ -377,17 +383,23 @@ static int cpufreq_get_max_state(struct thermal_cooli=
ng_device *cdev,
  * cpufreq_get_cur_state - callback function to get the current cooling st=
ate.
  * @cdev: thermal cooling device pointer.
  * @state: fill this variable with the current cooling state.
+ * @unit: the units in which state should be in
  *
  * Callback for the thermal cooling device to return the cpufreq
- * current cooling state.
+ * current cooling state.  Currently only THERMAL_UNIT_STATE is valid
+ * for @unit.
  *
  * Return: 0 on success, an error code otherwise.
  */
 static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long *state)
+=09=09=09=09 unsigned long *state,
+=09=09=09=09 enum thermal_cooling_unit unit)
 {
 =09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09*state =3D cpufreq_device->cpufreq_state;
=20
 =09return 0;
@@ -397,25 +409,31 @@ static int cpufreq_get_cur_state(struct thermal_cooli=
ng_device *cdev,
  * cpufreq_set_cur_state - callback function to set the current cooling st=
ate.
  * @cdev: thermal cooling device pointer.
  * @state: set this variable to the current cooling state.
+ * @unit: the units in which @state should be in.
  *
  * Callback for the thermal cooling device to change the cpufreq
- * current cooling state.
+ * current cooling state.  Currently only THERMAL_UNIT_STATE is valid for
+ * @unit.
  *
  * Return: 0 on success, an error code otherwise.
  */
 static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long state)
+=09=09=09=09 unsigned long state,
+=09=09=09=09 enum thermal_cooling_unit unit)
 {
 =09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09return cpufreq_apply_cooling(cpufreq_device, state);
 }
=20
 /* Bind cpufreq callbacks to thermal cooling device ops */
 static struct thermal_cooling_device_ops const cpufreq_cooling_ops =3D {
-=09.get_max_state =3D cpufreq_get_max_state,
-=09.get_cur_state =3D cpufreq_get_cur_state,
-=09.set_cur_state =3D cpufreq_set_cur_state,
+=09.get_max =3D cpufreq_get_max_state,
+=09.get_cur =3D cpufreq_get_cur_state,
+=09.set_cur =3D cpufreq_set_cur_state,
 };
=20
 /* Notifier for cpufreq policy change */
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_ther=
mal.c
index 1e3b3bf..0842a2e 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -67,7 +67,7 @@ static int db8500_cdev_bind(struct thermal_zone_device *t=
hermal,
 =09unsigned long max_state, upper, lower;
 =09int i, ret =3D -EINVAL;
=20
-=09cdev->ops->get_max_state(cdev, &max_state);
+=09cdev->ops->get_max(cdev, &max_state, THERMAL_UNIT_STATE);
=20
 =09for (i =3D 0; i < ptrips->num_trips; i++) {
 =09=09if (db8500_thermal_match_cdev(cdev, &ptrips->trip_points[i]))
diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 944ba2f..8e6eb48 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -51,7 +51,7 @@ static long get_target_state(struct thermal_zone_device *=
tz,
 {
 =09unsigned long max_state;
=20
-=09cdev->ops->get_max_state(cdev, &max_state);
+=09cdev->ops->get_max(cdev, &max_state, THERMAL_UNIT_STATE);
=20
 =09return (long)(weight * level * max_state) / (100 * tz->trips);
 }
diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_pow=
erclamp.c
index a084325..c32bee1 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -616,16 +616,24 @@ static struct notifier_block powerclamp_cpu_notifier =
=3D {
 };
=20
 static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long *state)
+=09=09=09=09unsigned long *state,
+=09=09=09=09enum thermal_cooling_unit unit)
 {
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09*state =3D MAX_TARGET_RATIO;
=20
 =09return 0;
 }
=20
 static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long *state)
+=09=09=09=09unsigned long *state,
+=09=09=09=09enum thermal_cooling_unit unit)
 {
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09if (true =3D=3D clamping)
 =09=09*state =3D pkg_cstate_ratio_cur;
 =09else
@@ -636,10 +644,14 @@ static int powerclamp_get_cur_state(struct thermal_co=
oling_device *cdev,
 }
=20
 static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
-=09=09=09=09 unsigned long new_target_ratio)
+=09=09=09=09unsigned long new_target_ratio,
+=09=09=09=09enum thermal_cooling_unit unit)
 {
 =09int ret =3D 0;
=20
+=09if (unit !=3D THERMAL_UNIT_STATE)
+=09=09return -EINVAL;
+
 =09new_target_ratio =3D clamp(new_target_ratio, 0UL,
 =09=09=09=09(unsigned long) (MAX_TARGET_RATIO-1));
 =09if (set_target_ratio =3D=3D 0 && new_target_ratio > 0) {
@@ -663,9 +675,9 @@ exit_set:
=20
 /* bind to generic thermal layer as cooling device*/
 static struct thermal_cooling_device_ops powerclamp_cooling_ops =3D {
-=09.get_max_state =3D powerclamp_get_max_state,
-=09.get_cur_state =3D powerclamp_get_cur_state,
-=09.set_cur_state =3D powerclamp_set_cur_state,
+=09.get_max =3D powerclamp_get_max_state,
+=09.get_cur =3D powerclamp_get_cur_state,
+=09.set_cur =3D powerclamp_set_cur_state,
 };
=20
 /* runs on Nehalem and later */
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index f251521..2a2cd4e 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -58,7 +58,7 @@ static unsigned long get_target_state(struct thermal_inst=
ance *instance,
 =09 * Otherwise, we use the current state of the
 =09 * cdev in use to determine the next_target.
 =09 */
-=09cdev->ops->get_cur_state(cdev, &cur_state);
+=09cdev->ops->get_cur(cdev, &cur_state, THERMAL_UNIT_STATE);
 =09next_target =3D instance->target;
 =09dev_dbg(&cdev->device, "cur_state=3D%ld\n", cur_state);
=20
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 71b0ec0..8865feb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -827,7 +827,7 @@ thermal_cooling_device_max_state_show(struct device *de=
v,
 =09unsigned long state;
 =09int ret;
=20
-=09ret =3D cdev->ops->get_max_state(cdev, &state);
+=09ret =3D cdev->ops->get_max(cdev, &state, THERMAL_UNIT_STATE);
 =09if (ret)
 =09=09return ret;
 =09return sprintf(buf, "%ld\n", state);
@@ -841,7 +841,7 @@ thermal_cooling_device_cur_state_show(struct device *de=
v,
 =09unsigned long state;
 =09int ret;
=20
-=09ret =3D cdev->ops->get_cur_state(cdev, &state);
+=09ret =3D cdev->ops->get_cur(cdev, &state, THERMAL_UNIT_STATE);
 =09if (ret)
 =09=09return ret;
 =09return sprintf(buf, "%ld\n", state);
@@ -862,7 +862,7 @@ thermal_cooling_device_cur_state_store(struct device *d=
ev,
 =09if ((long)state < 0)
 =09=09return -EINVAL;
=20
-=09result =3D cdev->ops->set_cur_state(cdev, state);
+=09result =3D cdev->ops->set_cur(cdev, state, THERMAL_UNIT_STATE);
 =09if (result)
 =09=09return result;
 =09return count;
@@ -939,7 +939,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zon=
e_device *tz,
 =09if (tz !=3D pos1 || cdev !=3D pos2)
 =09=09return -EINVAL;
=20
-=09cdev->ops->get_max_state(cdev, &max_state);
+=09cdev->ops->get_max(cdev, &max_state, THERMAL_UNIT_STATE);
=20
 =09/* lower default 0, upper default max_state */
 =09lower =3D lower =3D=3D THERMAL_NO_LIMIT ? 0 : lower;
@@ -1099,8 +1099,7 @@ __thermal_cooling_device_register(struct device_node =
*np,
 =09if (type && strlen(type) >=3D THERMAL_NAME_LENGTH)
 =09=09return ERR_PTR(-EINVAL);
=20
-=09if (!ops || !ops->get_max_state || !ops->get_cur_state ||
-=09    !ops->set_cur_state)
+=09if (!ops || !ops->get_max || !ops->get_cur || !ops->set_cur)
 =09=09return ERR_PTR(-EINVAL);
=20
 =09cdev =3D kzalloc(sizeof(struct thermal_cooling_device), GFP_KERNEL);
@@ -1285,7 +1284,7 @@ void thermal_cdev_update(struct thermal_cooling_devic=
e *cdev)
 =09=09=09target =3D instance->target;
 =09}
 =09mutex_unlock(&cdev->lock);
-=09cdev->ops->set_cur_state(cdev, target);
+=09cdev->ops->set_cur(cdev, target, THERMAL_UNIT_STATE);
 =09cdev->updated =3D true;
 =09dev_dbg(&cdev->device, "set to state %lu\n", target);
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f7e11c7..013cfa7 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -106,6 +106,10 @@ enum {
 };
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
=20
+enum thermal_cooling_unit {
+=09THERMAL_UNIT_STATE,
+};
+
 struct thermal_zone_device_ops {
 =09int (*bind) (struct thermal_zone_device *,
 =09=09     struct thermal_cooling_device *);
@@ -135,9 +139,12 @@ struct thermal_zone_device_ops {
 };
=20
 struct thermal_cooling_device_ops {
-=09int (*get_max_state) (struct thermal_cooling_device *, unsigned long *)=
;
-=09int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *)=
;
-=09int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
+=09int (*get_max)(struct thermal_cooling_device *, unsigned long *,
+=09=09=09enum thermal_cooling_unit);
+=09int (*get_cur)(struct thermal_cooling_device *, unsigned long *,
+=09=09=09enum thermal_cooling_unit);
+=09int (*set_cur)(struct thermal_cooling_device *, unsigned long,
+=09=09=09enum thermal_cooling_unit);
 };
=20
 struct thermal_cooling_device {
--=20
1.7.9.5


