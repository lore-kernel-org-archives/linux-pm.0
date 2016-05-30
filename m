From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 40/48] thermal: sysfs: remove symbols of emul_temp when config is disabled
Date: Mon, 30 May 2016 15:16:16 -0700
Message-ID: <1464646584-14322-41-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Remove the following warning:
In file included from drivers/thermal/thermal_sysfs.c:19:0:
include/linux/device.h:575:26: warning: =E2=80=98dev_attr_emul_temp=E2=80=
=99 defined but not used [-Wunused-variable]
  struct device_attribute dev_attr_##_name =3D __ATTR(_name, _mode, _sh=
ow, _store)
                          ^
drivers/thermal/thermal_sysfs.c:395:8: note: in expansion of macro =E2=80=
=98DEVICE_ATTR=E2=80=99

when emul temp is disabled at Kconfig.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_=
sysfs.c
index 111ec71..10c8fe4 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -289,6 +289,7 @@ available_policies_show(struct device *dev, struct =
device_attribute *devattr,
 	return thermal_build_list_of_policies(buf);
 }
=20
+#if (IS_ENABLED(CONFIG_THERMAL_EMULATION))
 static ssize_t
 emul_temp_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
@@ -313,6 +314,8 @@ emul_temp_store(struct device *dev, struct device_a=
ttribute *attr,
=20
 	return ret ? ret : count;
 }
+static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
+#endif
=20
 static ssize_t
 sustainable_power_show(struct device *dev, struct device_attribute *de=
vattr,
@@ -392,7 +395,6 @@ create_s32_tzp_attr(offset);
  */
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
-static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
 static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_stor=
e);
 static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_sho=
w, NULL);
 static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_p=
ower_show,
--=20
2.1.4
