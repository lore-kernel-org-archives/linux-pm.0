From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [RFC PATCH 4/5] power: Add formula for computing LiIon State of Charge from Voltage
Date: Tue,  1 Aug 2017 22:55:25 +0200
Message-ID: <1501620926-22669-5-git-send-email-marek.belisko@open-nandra.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Marek Belisko <marek.belisko@gmail.com>

The formula appears to be known in RC model communities.
We did find the first reference on the web in a a forum post
by "SilverFox" from 04-16-2008:

http://www.candlepowerforums.com/vb/showthread.php?115871-Li-Ion-State-of-Charge-and-Voltage-Measurements#post2440539

Some other posts attribute it to Sanyo.

The linear interpplation below 19.66% was suggested by Pavel Machek.

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 include/linux/power/generic-fuel-gauge.h | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 include/linux/power/generic-fuel-gauge.h

diff --git a/include/linux/power/generic-fuel-gauge.h b/include/linux/power/generic-fuel-gauge.h
new file mode 100644
index 0000000..2da7825
--- /dev/null
+++ b/include/linux/power/generic-fuel-gauge.h
@@ -0,0 +1,38 @@
+#ifndef PWR_GENERIC_FUEL_GAUSE_H
+#define PWR_GENERIC_FUEL_GAUSE_H
+
+/* calculate remaining fuel level (in %) of a LiIon battery assuming
+ * a standard chemistry model
+ *    The first reference found on the web seems to be a forum post
+ *    by "SilverFox" from 04-16-2008. It appears to be attributed to Sanyo.
+ *    http://www.candlepowerforums.com/vb/showthread.php?115871-Li-Ion-State-of-Charge-and-Voltage-Measurements#post2440539
+ *    The linear interpplation below 19.66% was suggested by Pavel Machek.
+ *
+ * @mV: voltage measured outside the battery
+ * @mA: current flowing out of the battery
+ * @mOhm: assumed series resitance of the battery
+ *
+ * returns value between 0 and 100
+ */
+static inline int fuel_level_LiIon(int mV, int mA, int mOhm) {
+	int u;
+
+	/* internal battery voltage is higher than measured when discharging */
+	mV += (mOhm * mA) /1000;
+
+	if (mV == 0)
+		return 0;
+
+	/* apply first part of formula */
+	u = 3870000 - (14523 * (37835 - 10 * mV));
+
+	/* use linear approx. below 3.756V => 19.66% assuming 3.3V => 0% */
+	if (u < 0) {
+		return  max(((mV - 3300) * ((3756 - 3300) * 1966)) / 100000000, 0);
+	}
+
+	/* apply second part of formula */
+	return min((int)(1966 + int_sqrt(u))/100, 100);	
+}
+
+#endif /* PWR_GENERIC_FUEL_GAUSE_H */
-- 
2.7.4
