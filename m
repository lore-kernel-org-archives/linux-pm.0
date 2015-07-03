From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 1/4] PM / devfreq: Add function to set max/min frequency
Date: Fri,  3 Jul 2015 13:58:27 +0100
Message-ID: <1435928310-15938-2-git-send-email-javi.merino@arm.com>
References: <1435928310-15938-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53235 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755388AbbGCM7Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Jul 2015 08:59:16 -0400
In-Reply-To: <1435928310-15938-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

=46rom: =C3=98rjan Eide <orjan.eide@arm.com>

=46actor out the logic to set minimum and maximum frequency for the dev=
ice
so that it can be used by other parts of the kernel.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: =C3=98rjan Eide <orjan.eide@arm.com>
---
 drivers/devfreq/devfreq.c | 72 +++++++++++++++++++++++++++++++--------=
--------
 include/linux/devfreq.h   | 13 +++++++++
 2 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ca1b362d77e2..6390d5db6816 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -768,6 +768,48 @@ err_out:
 }
 EXPORT_SYMBOL(devfreq_remove_governor);
=20
+int devfreq_qos_set_max(struct devfreq *df, unsigned long value)
+{
+	unsigned long min;
+	int ret =3D 0;
+
+	mutex_lock(&df->lock);
+	min =3D df->min_freq;
+	if (value && min && value < min) {
+		ret =3D -EINVAL;
+		goto unlock;
+	}
+
+	df->max_freq =3D value;
+	update_devfreq(df);
+unlock:
+	mutex_unlock(&df->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(devfreq_qos_set_max);
+
+int devfreq_qos_set_min(struct devfreq *df, unsigned long value)
+{
+	unsigned long max;
+	int ret =3D 0;
+
+	mutex_lock(&df->lock);
+	max =3D df->max_freq;
+	if (value && max && value > max) {
+		ret =3D -EINVAL;
+		goto unlock;
+	}
+
+	df->min_freq =3D value;
+	update_devfreq(df);
+unlock:
+	mutex_unlock(&df->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(devfreq_qos_set_min);
+
 static ssize_t governor_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -899,24 +941,15 @@ static ssize_t min_freq_store(struct device *dev,=
 struct device_attribute *attr,
 	struct devfreq *df =3D to_devfreq(dev);
 	unsigned long value;
 	int ret;
-	unsigned long max;
=20
 	ret =3D sscanf(buf, "%lu", &value);
 	if (ret !=3D 1)
 		return -EINVAL;
=20
-	mutex_lock(&df->lock);
-	max =3D df->max_freq;
-	if (value && max && value > max) {
-		ret =3D -EINVAL;
-		goto unlock;
-	}
+	ret =3D devfreq_qos_set_min(df, value);
+	if (!ret)
+		ret =3D count;
=20
-	df->min_freq =3D value;
-	update_devfreq(df);
-	ret =3D count;
-unlock:
-	mutex_unlock(&df->lock);
 	return ret;
 }
=20
@@ -932,24 +965,15 @@ static ssize_t max_freq_store(struct device *dev,=
 struct device_attribute *attr,
 	struct devfreq *df =3D to_devfreq(dev);
 	unsigned long value;
 	int ret;
-	unsigned long min;
=20
 	ret =3D sscanf(buf, "%lu", &value);
 	if (ret !=3D 1)
 		return -EINVAL;
=20
-	mutex_lock(&df->lock);
-	min =3D df->min_freq;
-	if (value && min && value < min) {
-		ret =3D -EINVAL;
-		goto unlock;
-	}
+	ret =3D devfreq_qos_set_max(df, value);
+	if (!ret)
+		ret =3D count;
=20
-	df->max_freq =3D value;
-	update_devfreq(df);
-	ret =3D count;
-unlock:
-	mutex_unlock(&df->lock);
 	return ret;
 }
 static DEVICE_ATTR_RW(min_freq);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index ce447f0f1bad..ffbe1f62ec2c 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -204,6 +204,9 @@ extern int devm_devfreq_register_opp_notifier(struc=
t device *dev,
 extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
 						struct devfreq *devfreq);
=20
+int devfreq_qos_set_min(struct devfreq *df, unsigned long value);
+int devfreq_qos_set_max(struct devfreq *df, unsigned long value);
+
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
  * struct devfreq_simple_ondemand_data - void *data fed to struct devf=
req
@@ -289,6 +292,16 @@ static inline void devm_devfreq_unregister_opp_not=
ifier(struct device *dev,
 							struct devfreq *devfreq)
 {
 }
+
+static inline int devfreq_qos_set_min(struct devfreq *df, unsigned lon=
g value)
+{
+	return -EINVAL;
+}
+
+static inline int devfreq_qos_set_max(struct devfreq *df, unsigned lon=
g value)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_PM_DEVFREQ */
=20
 #endif /* __LINUX_DEVFREQ_H__ */
--=20
1.9.1

