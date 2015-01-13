From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: [PATCH 2/2] thermal: of: Match function for of-thermal
Date: Tue, 13 Jan 2015 17:51:22 +0000
Message-ID: <1421171482-16101-3-git-send-email-kapileshwar.singh@arm.com>
References: <1421171482-16101-1-git-send-email-kapileshwar.singh@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48254 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbAMRv3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jan 2015 12:51:29 -0500
In-Reply-To: <1421171482-16101-1-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@arm.com, punit.agrawal@arm.com

From: KP Singh <kapileshwar.singh@arm.com>

This patch introduces the following changes:

* Creation of a parsed_bind_params data structure to
  uniquely identify the bind parameters per coolig
  device and optimize the match callback

* Adding a match call-back to of-thermal to replace
  the specific bind operation

* In the previous implementation the thermal_zone_params
  and thermal_bind_params are not populated and the weight
  parameter which is read from the device tree
  (as contribution) does not get propagated to the governor

Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---
 drivers/thermal/of-thermal.c |  340 ++++++++++++++++++++++++++++++++++----=
----
 1 file changed, 278 insertions(+), 62 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index e145b66df444..82f7e4b48845 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -31,6 +31,7 @@
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/thermal.h>
+#include <linux/bitops.h>
=20
 #include "thermal_core.h"
=20
@@ -54,6 +55,26 @@ struct __thermal_bind_params {
 };
=20
 /**
+ * struct parsed_bind_params - parsed bind parameters from device tree
+ * @cdev_node: a pointer to identify the device tree node of the cdev
+ * @trip_mask: a mask of all the trips the cdev is to be bound to
+ * @weight: the percentage (0 to 100) of cooling conrtibution
+ * @binding_limits: the max and min limits for each trip point
+ *
+ * The struct __thermal_bind_params is a raw representation of the
+ * data read from the device tree. This is then parsed into this
+ * struct such that there is only on param per cooling device
+ * and can be correlated efficiently with thermal_bind_params.
+ */
+
+struct parsed_bind_params {
+=09struct device_node *cdev_node;
+=09unsigned long trip_mask;
+=09unsigned int weight;
+=09unsigned long *binding_limits;
+};
+
+/**
  * struct __thermal_zone - internal representation of a thermal zone
  * @mode: current thermal zone device mode (enabled/disabled)
  * @passive_delay: polling interval while passive cooling is activated
@@ -78,6 +99,8 @@ struct __thermal_zone {
 =09/* cooling binding data */
 =09int num_tbps;
 =09struct __thermal_bind_params *tbps;
+=09struct parsed_bind_params *pbs;
+=09int num_parsed_tbps;
=20
 =09/* sensor interface */
 =09void *sensor_data;
@@ -208,60 +231,6 @@ static int of_thermal_get_trend(struct thermal_zone_de=
vice *tz, int trip,
 =09return 0;
 }
=20
-static int of_thermal_bind(struct thermal_zone_device *thermal,
-=09=09=09   struct thermal_cooling_device *cdev)
-{
-=09struct __thermal_zone *data =3D thermal->devdata;
-=09int i;
-
-=09if (!data || IS_ERR(data))
-=09=09return -ENODEV;
-
-=09/* find where to bind */
-=09for (i =3D 0; i < data->num_tbps; i++) {
-=09=09struct __thermal_bind_params *tbp =3D data->tbps + i;
-
-=09=09if (tbp->cooling_device =3D=3D cdev->np) {
-=09=09=09int ret;
-
-=09=09=09ret =3D thermal_zone_bind_cooling_device(thermal,
-=09=09=09=09=09=09tbp->trip_id, cdev,
-=09=09=09=09=09=09tbp->max,
-=09=09=09=09=09=09tbp->min);
-=09=09=09if (ret)
-=09=09=09=09return ret;
-=09=09}
-=09}
-
-=09return 0;
-}
-
-static int of_thermal_unbind(struct thermal_zone_device *thermal,
-=09=09=09     struct thermal_cooling_device *cdev)
-{
-=09struct __thermal_zone *data =3D thermal->devdata;
-=09int i;
-
-=09if (!data || IS_ERR(data))
-=09=09return -ENODEV;
-
-=09/* find where to unbind */
-=09for (i =3D 0; i < data->num_tbps; i++) {
-=09=09struct __thermal_bind_params *tbp =3D data->tbps + i;
-
-=09=09if (tbp->cooling_device =3D=3D cdev->np) {
-=09=09=09int ret;
-
-=09=09=09ret =3D thermal_zone_unbind_cooling_device(thermal,
-=09=09=09=09=09=09tbp->trip_id, cdev);
-=09=09=09if (ret)
-=09=09=09=09return ret;
-=09=09}
-=09}
-
-=09return 0;
-}
-
 static int of_thermal_get_mode(struct thermal_zone_device *tz,
 =09=09=09       enum thermal_device_mode *mode)
 {
@@ -384,9 +353,6 @@ static struct thermal_zone_device_ops of_thermal_ops =
=3D {
 =09.get_trip_hyst =3D of_thermal_get_trip_hyst,
 =09.set_trip_hyst =3D of_thermal_set_trip_hyst,
 =09.get_crit_temp =3D of_thermal_get_crit_temp,
-
-=09.bind =3D of_thermal_bind,
-=09.unbind =3D of_thermal_unbind,
 };
=20
 /***   sensor API   ***/
@@ -621,6 +587,237 @@ static int thermal_of_populate_bind_params(struct dev=
ice_node *np,
 =09return ret;
 }
=20
+int of_thermal_match_bind_param(struct thermal_zone_device *tz,
+=09=09=09=09struct thermal_cooling_device *cdev,
+=09=09=09=09int index)
+{
+=09struct __thermal_zone *__tz;
+=09struct parsed_bind_params *pbs;
+=09struct thermal_bind_params *tbp;
+=09int i;
+
+=09if (!tz->devdata)
+=09=09return 1;
+
+=09__tz =3D (struct __thermal_zone *)tz->devdata;
+
+=09if (!__tz->pbs || !__tz->num_parsed_tbps)
+=09=09return 1;
+
+=09pbs =3D __tz->pbs;
+=09tbp =3D tz->tzp->tbp;
+
+=09for (i =3D 0; i < __tz->num_parsed_tbps; i++) {
+=09=09if (pbs[i].cdev_node =3D=3D cdev->np) {
+=09=09=09if (tbp[index].trip_mask !=3D pbs[i].trip_mask)
+=09=09=09=09return 1;
+=09=09=09if (tbp[index].binding_limits !=3D pbs[i].binding_limits)
+=09=09=09=09return 1;
+=09=09=09if (tbp[index].weight !=3D pbs[i].weight)
+=09=09=09=09return 1;
+=09=09=09return 0;
+=09=09}
+=09}
+=09return 1;
+}
+
+/**
+ * get_unique_mask - return a mask indicating repeated cdevs
+ * @__tbp: __thermal_bind_params internal data structre
+ * @num_tbps: total number of cdev<->trip bindings
+ *
+ * A cooling device may be bound to more than one
+ * thermal trips. These multiple bindings are populated as
+ * separate entries in the @__tbp params internal data structure
+ * from the device tree. The unique mask identifies the location
+ * of re-ocurring cooling devices which is further used to
+ * populate the thermal_bind_params external data structre.
+ *
+ * Return: the calculated bitmask (long)
+=09   (set bit means a non-unique cdev at that index)
+ */
+static unsigned long get_unique_mask(struct __thermal_bind_params *__tbp,
+=09=09=09       unsigned int num_tbps)
+{
+=09unsigned long unique_mask =3D 0;
+=09int i, j;
+=09/*
+=09 * A bit set in the mask means that the cooling device
+=09 * at that position is not unique
+=09 */
+=09for (i =3D 0; i < num_tbps; i++)
+=09=09for (j =3D i + 1; j < num_tbps; j++)
+=09=09=09if (!test_bit(j, &unique_mask) &&
+=09=09=09   (__tbp[i].cooling_device =3D=3D __tbp[j].cooling_device))
+=09=09=09=09set_bit(j, &unique_mask);
+
+=09return  unique_mask;
+}
+
+static void fill_parsed_params(struct parsed_bind_params *pbs,
+=09=09=09=09struct __thermal_bind_params *__tbp,
+=09=09=09=09int unique)
+{
+=09pbs->binding_limits[2 * __tbp->trip_id] =3D __tbp->min;
+=09pbs->binding_limits[2 * __tbp->trip_id + 1] =3D __tbp->max;
+
+=09if (unique) {
+=09=09pbs->weight =3D __tbp->usage;
+=09=09pbs->trip_mask =3D (1  << __tbp->trip_id);
+=09=09pbs->cdev_node =3D __tbp->cooling_device;
+=09} else {
+=09=09if (pbs->weight !=3D __tbp->usage)
+=09=09=09pr_err("Multiple weights (%u, %u) sepcified for cdev %s",
+=09=09=09       pbs->weight, __tbp->usage, pbs->cdev_node->name);
+=09=09pbs->trip_mask |=3D (1 << __tbp->trip_id);
+=09}
+}
+
+/**
+ * of_thermal_parse_bind_params - parse the populated bind params
+ * @__tz: __thermal_zone private device data for of-thermal
+ *
+ * This function creates a reflection of the thermal_bind_params
+ * data structure and condenses the cooling-map populated from the
+ * device tree. This structure is then used when the match
+ * callback of_thermal_match_bind_param is invoked.
+ *
+ * Return: parsed_bind_parameters structure
+ */
+static struct parsed_bind_params*
+of_thermal_parse_bind_params(struct __thermal_zone *__tz)
+{
+=09struct parsed_bind_params *pbs;
+=09struct __thermal_bind_params *__tbp =3D __tz->tbps;
+=09unsigned long unique_mask;
+=09unsigned long *limits;
+=09unsigned int num_parsed;
+=09int i, j, err;
+=09int bind_count =3D 0;
+
+=09unique_mask =3D get_unique_mask(__tbp, __tz->num_tbps);
+=09num_parsed =3D __tz->num_tbps - hweight_long(unique_mask);
+=09__tz->num_parsed_tbps =3D num_parsed;
+
+=09pbs =3D kcalloc(num_parsed, sizeof(*pbs), GFP_KERNEL);
+=09if (!pbs) {
+=09=09err =3D -ENOMEM;
+=09=09goto err_exit;
+=09}
+
+=09/* We have a number of trips in tz */
+=09for (i =3D 0; i < __tz->num_tbps; i++) {
+
+=09=09/*
+=09=09 * We have two cases here :
+=09=09 * First occurence of the cooling device
+=09=09 * In this case we need to allocate a new binding_limits array
+=09=09 * and assign the limits ( __tbp[i].min and __tbp[i].max )
+=09=09 * and set the bit in the trip mask
+=09=09 *
+=09=09 * Repeated occurence of the cooling device:
+=09=09 * In this case we need to find the previously allocated
+=09=09 * binding_param and update the binding_limits and trip_mask.
+=09=09 */
+
+=09=09int unique =3D !test_bit(i, &unique_mask);
+
+=09=09if (unique) {
+=09=09=09pbs[bind_count].weight =3D __tbp[i].usage;
+=09=09=09limits =3D kcalloc(2 * __tz->ntrips, sizeof(*limits),
+=09=09=09=09=09 GFP_KERNEL);
+=09=09=09if (!limits) {
+=09=09=09=09err =3D -ENOMEM;
+=09=09=09=09goto free_bp;
+=09=09=09}
+=09=09=09pbs[bind_count].binding_limits =3D limits;
+=09=09=09fill_parsed_params(&pbs[bind_count], &__tbp[i],
+=09=09=09=09=09     unique);
+=09=09=09bind_count++;
+=09=09} else {
+=09=09=09struct device_node *curr;
+=09=09=09struct device_node *prev;
+
+=09=09=09for (j =3D 0; j < bind_count; j++) {
+=09=09=09=09curr =3D __tbp[i].cooling_device;
+=09=09=09=09prev =3D pbs[j].cdev_node;
+=09=09=09=09if (curr =3D=3D prev) {
+=09=09=09=09=09fill_parsed_params(&pbs[j],
+=09=09=09=09=09=09=09   &__tbp[i],
+=09=09=09=09=09=09=09   unique);
+=09=09=09=09=09break;
+=09=09=09=09}
+=09=09=09}
+=09=09}
+
+=09}
+
+=09return pbs;
+
+free_bp:
+=09for (i =3D 0; i < num_parsed; i++)
+=09=09kfree(pbs[i].binding_limits);
+=09kfree(pbs);
+
+err_exit:
+=09return ERR_PTR(err);
+
+}
+
+/**
+ * of_thermal_populate_tzp - populate the thermal zone params
+ * @__tz: __thermal_zone private device data for of-thermal
+ *
+ * This function populates the thermal_zone_params and also the
+ * tzp->tbp based on the parsed_bind_params (__tz->pbs)
+ *
+ * Return: struct thermal_zone params
+ */
+static struct thermal_zone_params*
+of_thermal_populate_tzp(struct __thermal_zone *__tz)
+{
+
+=09struct thermal_zone_params *tzp;
+=09struct parsed_bind_params *pbs =3D __tz->pbs;
+=09struct thermal_bind_params *tbp;
+=09int err;
+=09int i;
+
+=09tzp =3D kzalloc(sizeof(*tzp), GFP_KERNEL);
+=09if (!tzp)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09if (!pbs || !__tz->num_parsed_tbps) {
+=09=09err =3D -ENODEV;
+=09=09goto free_tzp;
+=09}
+
+=09tbp =3D kcalloc(__tz->num_parsed_tbps, sizeof(*tbp), GFP_KERNEL);
+=09if (!tbp) {
+=09=09err =3D -ENOMEM;
+=09=09goto free_tzp;
+=09 }
+
+=09for (i =3D 0; i < __tz->num_parsed_tbps; i++) {
+=09=09tbp[i].weight =3D pbs[i].weight;
+=09=09tbp[i].binding_limits =3D pbs[i].binding_limits;
+=09=09tbp[i].trip_mask =3D pbs[i].trip_mask;
+=09=09tbp[i].match =3D of_thermal_match_bind_param;
+=09}
+
+=09tzp->tbp =3D tbp;
+=09tzp->num_tbps =3D __tz->num_parsed_tbps;
+
+=09/* No hwmon because there might be hwmon drivers registering */
+=09tzp->no_hwmon =3D true;
+
+=09return tzp;
+
+free_tzp:
+=09kfree(tzp);
+=09return ERR_PTR(err);
+}
+
 /**
  * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
  * into the device tree binding of 'trip', property type.
@@ -800,6 +997,12 @@ thermal_of_build_thermal_zone(struct device_node *np)
 =09=09=09goto free_tbps;
 =09}
=20
+=09tz->pbs =3D of_thermal_parse_bind_params(tz);
+=09if (IS_ERR(tz->pbs)) {
+=09=09ret =3D -ENOMEM;
+=09=09goto free_tbps;
+=09}
+
 finish:
 =09of_node_put(child);
 =09tz->mode =3D THERMAL_DEVICE_DISABLED;
@@ -829,6 +1032,8 @@ static inline void of_thermal_free_zone(struct __therm=
al_zone *tz)
 =09for (i =3D 0; i < tz->num_tbps; i++)
 =09=09of_node_put(tz->tbps[i].cooling_device);
 =09kfree(tz->tbps);
+=09/* Free the parsed_bind_params */
+=09kfree(tz->pbs);
 =09for (i =3D 0; i < tz->ntrips; i++)
 =09=09of_node_put(tz->trips[i].np);
 =09kfree(tz->trips);
@@ -879,15 +1084,14 @@ int __init of_parse_thermal_zones(void)
 =09=09if (!ops)
 =09=09=09goto exit_free;
=20
-=09=09tzp =3D kzalloc(sizeof(*tzp), GFP_KERNEL);
-=09=09if (!tzp) {
+
+=09=09tzp =3D of_thermal_populate_tzp(tz);
+
+=09=09if (IS_ERR(tzp)) {
 =09=09=09kfree(ops);
 =09=09=09goto exit_free;
 =09=09}
=20
-=09=09/* No hwmon because there might be hwmon drivers registering */
-=09=09tzp->no_hwmon =3D true;
-
 =09=09zone =3D thermal_zone_device_register(child->name, tz->ntrips,
 =09=09=09=09=09=09    0, tz,
 =09=09=09=09=09=09    ops, tzp,
@@ -936,6 +1140,7 @@ void of_thermal_destroy_zones(void)
=20
 =09for_each_child_of_node(np, child) {
 =09=09struct thermal_zone_device *zone;
+=09=09int i;
=20
 =09=09/* Check whether child is enabled or not */
 =09=09if (!of_device_is_available(child))
@@ -946,6 +1151,17 @@ void of_thermal_destroy_zones(void)
 =09=09=09continue;
=20
 =09=09thermal_zone_device_unregister(zone);
+=09=09/*
+=09=09 * free the binding_limits
+=09=09 * free the thermal_bind_params
+=09=09 */
+=09=09if (zone->tzp && zone->tzp->tbp) {
+=09=09=09const struct thermal_zone_params *tzp =3D zone->tzp;
+
+=09=09=09for (i =3D 0; i < tzp->num_tbps; i++)
+=09=09=09=09kfree(tzp->tbp[i].binding_limits);
+=09=09=09kfree(tzp->tbp);
+=09=09}
 =09=09kfree(zone->tzp);
 =09=09kfree(zone->ops);
 =09=09of_thermal_free_zone(zone->devdata);
--=20
1.7.9.5


