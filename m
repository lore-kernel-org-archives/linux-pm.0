From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] powercap/intel_rapl: fix and tidy up error handling
Date: Wed, 23 Nov 2016 11:01:06 -0800
Message-ID: <1479927666-563-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Marcin Koss <marcin.koss@intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Commit e1399ba20eee ("powercap / RAPL: handle missing MSRs") added
contraint_to_pl() function to return index into an array. But it
can potentially return -EINVAL if powercap layer sends an out of
range constraint ID. This patch adds sanity check.

Unnecessary RAPL domain pointer check is removed since it must be
initialized before calling rapl_unit_xlate().

Reported-by: Odzioba, Lukasz <lukasz.odzioba@intel.com>
Reported-by: Koss, Marcin <marcin.koss@intel.com>

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 65ed88a..f6937d0 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -429,6 +429,7 @@ static int contraint_to_pl(struct rapl_domain *rd, int cid)
 			return i;
 		}
 	}
+	pr_err("Cannot find matching power limit for constraint %d\n", cid);
 
 	return -EINVAL;
 }
@@ -444,6 +445,10 @@ static int set_power_limit(struct powercap_zone *power_zone, int cid,
 	get_online_cpus();
 	rd = power_zone_to_rapl_domain(power_zone);
 	id = contraint_to_pl(rd, cid);
+	if (id < 0) {
+		ret = id;
+		goto set_exit;
+	}
 
 	rp = rd->rp;
 
@@ -483,6 +488,11 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
 	get_online_cpus();
 	rd = power_zone_to_rapl_domain(power_zone);
 	id = contraint_to_pl(rd, cid);
+	if (id < 0) {
+		ret = id;
+		goto get_exit;
+	}
+
 	switch (rd->rpl[id].prim_id) {
 	case PL1_ENABLE:
 		prim = POWER_LIMIT1;
@@ -499,6 +509,7 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
 	else
 		*data = val;
 
+get_exit:
 	put_online_cpus();
 
 	return ret;
@@ -514,6 +525,10 @@ static int set_time_window(struct powercap_zone *power_zone, int cid,
 	get_online_cpus();
 	rd = power_zone_to_rapl_domain(power_zone);
 	id = contraint_to_pl(rd, cid);
+	if (id < 0) {
+		ret = id;
+		goto set_time_exit;
+	}
 
 	switch (rd->rpl[id].prim_id) {
 	case PL1_ENABLE:
@@ -525,6 +540,8 @@ static int set_time_window(struct powercap_zone *power_zone, int cid,
 	default:
 		ret = -EINVAL;
 	}
+
+set_time_exit:
 	put_online_cpus();
 	return ret;
 }
@@ -539,6 +556,10 @@ static int get_time_window(struct powercap_zone *power_zone, int cid, u64 *data)
 	get_online_cpus();
 	rd = power_zone_to_rapl_domain(power_zone);
 	id = contraint_to_pl(rd, cid);
+	if (id < 0) {
+		ret = id;
+		goto get_time_exit;
+	}
 
 	switch (rd->rpl[id].prim_id) {
 	case PL1_ENABLE:
@@ -553,6 +574,8 @@ static int get_time_window(struct powercap_zone *power_zone, int cid, u64 *data)
 	}
 	if (!ret)
 		*data = val;
+
+get_time_exit:
 	put_online_cpus();
 
 	return ret;
@@ -694,7 +717,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 	case ENERGY_UNIT:
 		scale = ENERGY_UNIT_SCALE;
 		/* per domain unit takes precedence */
-		if (rd && rd->domain_energy_unit)
+		if (rd->domain_energy_unit)
 			units = rd->domain_energy_unit;
 		else
 			units = rp->energy_unit;
-- 
1.9.1
