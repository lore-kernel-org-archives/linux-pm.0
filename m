From: Yasuaki Ishimatsu <yasu.isimatu@gmail.com>
Subject: [PATCH] thermal: add thermal_zone_remove_device_groups()
Date: Thu, 15 Dec 2016 16:47:08 -0500
Message-ID: <6c5a1a95-9b03-6f43-8de8-1ab4ac27cc78@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35484 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbcLOVrM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Dec 2016 16:47:12 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com

When offlining all cores on a CPU, the following system panic
occurs:

BUG: unable to handle kernel NULL pointer dereference at (null)
IP: strlen+0x0/0x20
<snip>
Call Trace:
  ? kernfs_name_hash+0x17/0x80
  kernfs_find_ns+0x3f/0xd0
  kernfs_remove_by_name_ns+0x36/0xa0
  remove_files.isra.1+0x36/0x70
  sysfs_remove_group+0x44/0x90
  sysfs_remove_groups+0x2e/0x50
  device_remove_attrs+0x5e/0x90
  device_del+0x1ea/0x350
  device_unregister+0x1a/0x60
  thermal_zone_device_unregister+0x1f2/0x210
  pkg_thermal_cpu_offline+0x14f/0x1a0 [x86_pkg_temp_thermal]
  ? kzalloc.constprop.2+0x10/0x10 [x86_pkg_temp_thermal]
  cpuhp_invoke_callback+0x8d/0x3f0
  cpuhp_down_callbacks+0x42/0x80
  cpuhp_thread_fun+0x8b/0xf0
  smpboot_thread_fn+0x110/0x160
  kthread+0x101/0x140
  ? sort_range+0x30/0x30
  ? kthread_park+0x90/0x90
  ret_from_fork+0x25/0x30

thermal_zone_create_device_group() sets attribute_groups in
thermal_zone_attribute_groups[] to tz->device.groups. But these
attributes_groups do not have name argument.

So when offlining all cores on CPU and executing
thermal_zone_device_unregister(), the panic occurs in strlen()
called from kernfs_name_hash() because name argument is NULL.

The patch adds thermal_zone_remove_device_groups() to free
tz->device.groups and set NULL pointer.

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
CC: Zhang Rui <rui.zhang@intel.com>
CC: Eduardo Valentin <edubezval@gmail.com>
---
  drivers/thermal/thermal_core.c  | 3 ++-
  drivers/thermal/thermal_core.h  | 1 +
  drivers/thermal/thermal_sysfs.c | 6 ++++++
  3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 641faab..926e385 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1251,6 +1251,7 @@ struct thermal_zone_device *

  unregister:
  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
+	thermal_zone_remove_device_groups(tz);
  	device_unregister(&tz->device);
  	return ERR_PTR(result);
  }
@@ -1315,8 +1316,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
  	idr_destroy(&tz->idr);
  	mutex_destroy(&tz->lock);
+	thermal_zone_remove_device_groups(tz);
  	device_unregister(&tz->device);
-	kfree(tz->device.groups);
  }
  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 2412b37..e3a60db 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -70,6 +70,7 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
  int thermal_build_list_of_policies(char *buf);

  /* sysfs I/F */
+void thermal_zone_remove_device_groups(struct thermal_zone_device *tz);
  int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
  void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
  /* used only at binding time */
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index a694de9..3dfd29b 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -605,6 +605,12 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
  	return 0;
  }

+void thermal_zone_remove_device_groups(struct thermal_zone_device *tz)
+{
+	kfree(tz->device.groups);
+	tz->device.groups = NULL;
+}
+
  int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
  				      int mask)
  {
-- 
1.8.3.1

