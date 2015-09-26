From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/6] thermal: iio Documentation
Date: Sat, 26 Sep 2015 15:05:10 -0700
Message-ID: <1443305111-28272-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4616 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932638AbbIZWFo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 26 Sep 2015 18:05:44 -0400
In-Reply-To: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jic23@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

An overview document about thermal iio binding.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
---
 Documentation/thermal/thermal_iio_binding | 88 +++++++++++++++++++++++=
++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/thermal/thermal_iio_binding

diff --git a/Documentation/thermal/thermal_iio_binding b/Documentation/=
thermal/thermal_iio_binding
new file mode 100644
index 0000000..df501f1
--- /dev/null
+++ b/Documentation/thermal/thermal_iio_binding
@@ -0,0 +1,88 @@
+
+Thermal IIO Bindings
+
+When CONFIG_THERMAL_IIO is enabled, in addition to the regular thermal
+zone attributes, an additional entry for an IIO device is created.
+IIO sysfs ABI documents is available at Documentation/ABI/sysfs-bus-ii=
o.
+
+The following example shows the contents of the IIO:device in a therma=
l
+zone.
+
+thermal_zoneX
+=E2=94=9C=E2=94=80=E2=94=80 iio:device9
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 buffer
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 enable
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 length
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 watermark
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 events
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_temp_thresh_either_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 in_temp_thresh_either_value
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 in_temp_raw
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 name
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 scan_elements
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_temp_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_temp_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_temp_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_timestamp_en
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 in_timestamp_index
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 in_timestamp_type
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../.=
=2E/../../bus/iio
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 trigger0
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 name
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 trigger
+=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 current_trigger
+=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 uevent
+=E2=94=9C=E2=94=80=E2=94=80 integral_cutoff
+...
+... other thermal_zone attributes
+...
+
+
+IIO Attributes
+
+name: This shows iio device name, which will match thermal_zone/type a=
ttribute
+in_temp_raw: This will show raw temperature values same as thermal_zon=
e/temp
+attribute.
+
+trigger/current_trigger: This is IIO way of specifying data ready indi=
cation.
+If the thermal client can provide asynchronous notifications, then a i=
io trigger
+device is created under trigger0. The name of this trigger will be the=
rmal
+device name suffixed with devX. To enable iio buffer notifications,
+trigger/current_trigger cab be updated with this trigger. For example
+
+#echo "x86_pkg_temp-dev9" > trigger/current_trigger
+
+In addition of samples can be pushed to iio buffers with external stan=
dard IIO
+device triggers, E.g. sysfs trigger.
+
+How to enable events?
+To enable events a suitable threshold temperature can be written to
+in_temp_thresh_either_value
+and enable by writing 1 to in_temp_thresh_either_en.
+
+To monitor events a good user space program is here:
+tools/iio/iio_event_monitor.c
+
+For example
+# echo 50000 > /sys/devices/virtual/thermal/thermal_zone9/iio:device9/=
events/in_temp_thresh_either_value
+# echo 1 > /sys/devices/virtual/thermal/thermal_zone9/iio:device9/even=
ts/in_temp_thresh_either_en
+# ./iio_event_monitor x86_pkg_temp
+Found IIO device with name x86_pkg_temp with device number 9
+Event: time: 1443297126626859289, type: temp, channel: 0, evtype: thre=
sh, direction: either
+
+How to read temperature samples?
+When thermal client or core driver calls thermal_zone_device_update, t=
his will
+result in sample pushed to iio buffers. These samples can be read from
+/dev/iio:deviceX file.
+
+To enable buffer select scan_elements
+# echo 1 > scan_elements/in_temp_en
+
+Set buffer length to n samples and enable buffer.
+# echo 2 > buffer/length
+# echo 1 > buffer/enable
+
+Then user can poll/select or /dev/iio:deviceX (Here X correspond to ii=
o device number),
+and read temperature samples. A good example is at tools/iio/generic_b=
uffer.c.
+
+
--=20
2.4.3

