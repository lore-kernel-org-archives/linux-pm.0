From: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 3/4] thermal: of: enable temperature notifications
Date: Tue, 29 Mar 2016 17:41:36 -0700
Message-ID: <1459298497-29481-4-git-send-email-srikars@nvidia.com>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459298497-29481-1-git-send-email-srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

* Add a state variable to track if trip point is triggered.
* Enable trip events only when the state of the tirp point changes.
* Implement the get\set callbacks for trip state.

Change-Id: I1bd6a7b0e5e520d8ee678b83111d23cada7a580c
Signed-off-by: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/of-thermal.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 49ac23d..f6d9d3d 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -379,6 +379,43 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 	return -EINVAL;
 }
 
+static bool of_thermal_enb_temp_notify(struct thermal_zone_device *tz, int trip)
+{
+	bool ret = true;
+	struct __thermal_zone *data = tz->devdata;
+
+	if (trip >= data->ntrips || trip < 0)
+		ret = false;
+
+	return ret;
+}
+
+static int of_thermal_get_trip_state(struct thermal_zone_device *tz, int trip,
+				     enum thermal_trip_state *state)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (trip >= data->ntrips || trip < 0)
+		return -EDOM;
+
+	*state = data->trips[trip].state;
+
+	return 0;
+}
+
+static int of_thermal_set_trip_state(struct thermal_zone_device *tz, int trip,
+				     enum thermal_trip_state state)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (trip >= data->ntrips || trip < 0)
+		return -EDOM;
+
+	data->trips[trip].state = state;
+
+	return 0;
+}
+
 static struct thermal_zone_device_ops of_thermal_ops = {
 	.get_mode = of_thermal_get_mode,
 	.set_mode = of_thermal_set_mode,
@@ -392,6 +429,10 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 
 	.bind = of_thermal_bind,
 	.unbind = of_thermal_unbind,
+
+	.get_trip_state = of_thermal_get_trip_state,
+	.set_trip_state = of_thermal_set_trip_state,
+	.enb_temp_notify = of_thermal_enb_temp_notify,
 };
 
 /***   sensor API   ***/
@@ -782,6 +823,8 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
+	trip->state = THERMAL_TRIP_NOT_TRIPPED;
+
 	/* Required for cooling map matching */
 	trip->np = np;
 	of_node_get(np);
-- 
2.1.4
