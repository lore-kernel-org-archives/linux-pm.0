From: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 0/4] add sysfs_notify on some attributes
Date: Tue, 29 Mar 2016 17:41:33 -0700
Message-ID: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patchset adds support to send certain thermal notifications and
facilitate workload throttling in userspace. Userspace apps that
want to reduce workload when thermal throttling starts, will
have to register for these events and interpret them as per their
requirement. This workload throttling allows userspace to react before
any hardware clocks are throttled and can keep some critical apps
running reliably longer.

v3
 * Reduced the number of sysfs_notify calls, Notify once per trip only
   when the temperature crosses the trip point.
 * Use hysteresis to avoid sending too many notifications when
   temperatures are bouncing around.
 * Add trip state tracking.
 * Add support to disable trip point notifications.

v2
 * Call sysfs_notify for thermal_zone*/temp only when a trip has
   violated.

v1
 * Base version, added two sysfs_notify calls.

Srikar Srimath Tirumala (4):
  thermal: send notifications for cdev state change
  thermal: send notifications for tz temperature
  thermal: of: enable temperature notifications
  thermal: update documentation for new device ops

 Documentation/thermal/sysfs-api.txt |  5 +++++
 drivers/thermal/of-thermal.c        | 43 +++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.c      | 29 +++++++++++++++++++++++++
 include/linux/thermal.h             | 12 +++++++++++
 4 files changed, 89 insertions(+)

-- 
2.1.4
