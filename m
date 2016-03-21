From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 2/3 v4] powercap, intel_rapl, implement check for minimum time window
Date: Mon, 21 Mar 2016 08:27:15 -0400
Message-ID: <1458563236-19269-3-git-send-email-prarit@redhat.com>
References: <1458563236-19269-1-git-send-email-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458563236-19269-1-git-send-email-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>, Mathias Krause <minipli@googlemail.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
List-Id: linux-pm@vger.kernel.org

Using an small value for the time window results in a
bogus value for the time window.  For example,

[root@intel-chiefriver-03 linux]# echo 950 >
/sys/devices/virtual/powercap/intel-rapl/intel-rapl\:0/constraint_0_time_window_us;
egrep ^ /sys/devices/virtual/powercap/intel-rapl/intel-rapl\:0/constraint_0_time_window_us
-bash: echo: write error: Invalid argument
/sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/constraint_0_time_window_us:1:4501502475370496

The Intel ASDM doesn't explicitly define a minimum time window.
The MSR_RAPL_POWER_UNIT register, read during initialization, does
specify a minimum time window unit so that can be used as a lower
bound for error checking.

After this change the minimum time window is properly clamped:

[root@intel-chiefriver-03 linux]# echo 950 >
/sys/devices/virtual/powercap/intel-rapl/intel-rapl\:0/constraint_0_time_window_us;
egrep ^ /sys/devices/virtual/powercap/intel-rapl/intel-rapl\:0/constraint_0_time_window_us
-bash: echo: write error: Invalid argument
/sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/constraint_0_time_window_us:1:976

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
Cc: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/powercap/intel_rapl.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index feb063d..cf89b3d 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -516,6 +516,7 @@ static int set_time_window(struct powercap_zone *power_zone, int id,
 								u64 window)
 {
 	struct rapl_domain *rd;
+	struct rapl_package *rp;
 	int ret = 0;
 	u64 max_window;
 
@@ -524,12 +525,18 @@ static int set_time_window(struct powercap_zone *power_zone, int id,
 	if (ret < 0)
 		goto out;
 
-	if (window > max_window) {
+	rd = power_zone_to_rapl_domain(power_zone);
+	rp = find_package_by_id(rd->package_id);
+	/*
+	 * The Intel ASDM doesn't explicitly define a minimum time window.
+	 * The MSR_RAPL_POWER_UNIT register, read during initialization,
+	 * does contain the smallest unit of time that can be measured.
+	 */
+	if ((window > max_window) || (window < rp->time_unit)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	rd = power_zone_to_rapl_domain(power_zone);
 	switch (rd->rpl[id].prim_id) {
 	case PL1_ENABLE:
 		rapl_write_data_raw(rd, TIME_WINDOW1, window);
-- 
1.7.9.3
