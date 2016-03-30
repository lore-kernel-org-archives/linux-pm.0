From: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 4/4] thermal: update documentation for new device ops
Date: Tue, 29 Mar 2016 17:41:37 -0700
Message-ID: <1459298497-29481-5-git-send-email-srikars@nvidia.com>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459298497-29481-1-git-send-email-srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add documentation for two new thermal_zone_device_ops.

Change-Id: Id1c5cc2ae4051a398dfe81c7ff0b27c1eab02579
Signed-off-by: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 Documentation/thermal/sysfs-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index ed419d6..13344167 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -59,6 +59,11 @@ temperature) and throttle appropriate devices.
 			will be fired.
 	.set_emul_temp: set the emulation temperature which helps in debugging
 			different threshold temperature points.
+	.get_trip_state: get the current state (TRIPPED or NOT_TRIPPED) of a
+		certain trip point.
+	.set_trip_state: set the state of a certain trip point.
+	.enb_temp_notify: check if temperature notifications are enabled for a
+		certain trip point.
     tzp: thermal zone platform parameters.
     passive_delay: number of milliseconds to wait between polls when
 	performing passive cooling.
-- 
2.1.4
