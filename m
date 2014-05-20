From: Javi Merino <javi.merino@arm.com>
Subject: [RFC PATCH v2 2/7] thermal: document struct thermal_zone_device and thermal_governor
Date: Tue, 20 May 2014 15:10:52 +0100
Message-ID: <1400595057-8585-3-git-send-email-javi.merino@arm.com>
References: <1400595057-8585-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400595057-8585-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Document struct thermal_zone_device and struct thermal_governor fields
and their use by the thermal framework code.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---

Hi linux-pm,

This was sent as a separate patch to linux-pm and can be merged
independently, as it documents the current thermal framework.

 include/linux/thermal.h |   44 ++++++++++++++++++++++++++++++++++++++++++-=
-
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f7e11c7ea7d9..9b7cb804e03f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -158,6 +158,40 @@ struct thermal_attr {
 =09char name[THERMAL_NAME_LENGTH];
 };
=20
+/**
+ * struct thermal_zone_device - structure for a thermal zone
+ * @id:=09=09unique id number for each thermal zone
+ * @type:=09the thermal zone device type
+ * @device:=09struct device for this thermal zone
+ * @trip_temp_attrs:=09attributes for trip points for sysfs: trip temperat=
ure
+ * @trip_type_attrs:=09attributes for trip points for sysfs: trip type
+ * @trip_hyst_attrs:=09attributes for trip points for sysfs: trip hysteres=
is
+ * @devdata:=09private pointer for device private data
+ * @trips:=09number of trip points the thermal zone supports
+ * @passive_delay:=09number of milliseconds to wait between polls when
+ *=09=09=09performing passive cooling.  Only used by the step-wise
+ *=09=09=09governor
+ * @polling_delay:=09number of milliseconds to wait between polls when
+ *=09=09=09checking whether trip points have been crossed (0 for
+ *=09=09=09interrupt driven systems)
+ * @temperature:=09current temperature.  This is only for core code,
+ *=09=09=09drivers should use thermal_zone_get_temp() to get the
+ *=09=09=09current temperature
+ * @last_temperature:=09previous temperature read
+ * @emul_temperature:=09emulated temperature when using CONFIG_THERMAL_EMU=
LATION
+ * @passive:=09step-wise specific parameter.  1 if you've crossed a passiv=
e
+ *=09=09trip point, 0 otherwise
+ * @forced_passive:=09step-wise specific parameter.  If > 0, temperature a=
t
+ *=09=09=09which to switch on all cpufreq cooling devices.
+ * @ops:=09operations this thermal_zone_device supports
+ * @tzp:=09thermal zone parameters
+ * @governor:=09pointer to the governor for this thermal zone
+ * @thermal_instances:=09list of struct thermal_instance of this thermal z=
one
+ * @idr:=09struct idr to generate unique id for this zone's cooling device=
s
+ * @lock:=09lock to protect thermal_instances list
+ * @node:=09node in thermal_tz_list (in thermal_core.c)
+ * @poll_queue:=09delayed work for polling
+ */
 struct thermal_zone_device {
 =09int id;
 =09char type[THERMAL_NAME_LENGTH];
@@ -179,12 +213,18 @@ struct thermal_zone_device {
 =09struct thermal_governor *governor;
 =09struct list_head thermal_instances;
 =09struct idr idr;
-=09struct mutex lock; /* protect thermal_instances list */
+=09struct mutex lock;
 =09struct list_head node;
 =09struct delayed_work poll_queue;
 };
=20
-/* Structure that holds thermal governor information */
+/**
+ * struct thermal_governor - structure that holds thermal governor informa=
tion
+ * @name:=09name of the governor
+ * @throttle:=09callback called for every trip point even if temperature i=
s
+ *=09=09below the trip point temperature
+ * @governor_list:=09node in thermal_governor_list (in thermal_core.c)
+ */
 struct thermal_governor {
 =09char name[THERMAL_NAME_LENGTH];
 =09int (*throttle)(struct thermal_zone_device *tz, int trip);
--=20
1.7.9.5
