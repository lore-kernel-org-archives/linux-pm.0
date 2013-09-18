From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/3] PM / OPP: check for existing OPP list when initialising from device tree
Date: Wed, 18 Sep 2013 11:58:13 +0100
Message-ID: <1379501893-12669-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1379501893-12669-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379501893-12669-1-git-send-email-Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>

CPUs are registered as devices and their OPPs can be initialised from
the device tree. Whenever CPUs are hotplugged out, the corresponding
cpu devices are not removed. As a result all their OPPs remain intact
even when they are offlined.

But when they are hotplugged back-in, the cpufreq along with other cpu
related subsystem gets re-initialised. Since its almost same as secondary
cpu being brought up, no special consideration is taken in the hotplug
path. This may result in cpufreq trying to initialise the OPPs again though
the cpu device already contains the OPPs.

This patch checks if there exist an OPP list associated with the device,
before attempting to initialise it.

Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
---
 drivers/base/power/opp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index a450e2f..0ebd884 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -709,9 +709,15 @@ int of_init_opp_table(struct device *dev)
 {
 	const struct property *prop;
 	struct device_node *opp_node;
+	struct device_opp *dev_opp;
 	const __be32 *val;
 	int nr;
 
+	/* Check for existing list for 'dev' */
+	dev_opp = find_device_opp(dev);
+	if (!IS_ERR(dev_opp))
+		return -EEXIST; /* Device OPP already initialized */
+
 	opp_node = of_parse_phandle(dev->of_node,
 					"operating-points-phandle", 0);
 	if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
