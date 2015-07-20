From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/1] ARM: cpuidle: heterogeneous systems extension
Date: Mon, 20 Jul 2015 15:54:50 +0100
Message-ID: <1437404091-30555-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Howard Chen <howard.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch is a v3 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/337794.html

v2 -> v3:

- Added config option to enable multiple drivers explicitly
- Added config option to select the maximum number of supported
  drivers
- Dropped RFC status
- Rebased against 4.2-rc2

v1 -> v2:

- Rebased against 4.0
- Removed DT affinity probe interface
- Improved and optimized idle states comparison and cpumask creation
- Merged DT idle states vetting code in the ARM CPUidle driver

This patch aims at enabling the generic CPUidle driver on ARM systems
with heterogeneous idle states. In the CPUidle context the kernel
considers cpus equal (and group them together through a CPUidle driver)
if they share the same set of idle states.
Since the idle states represent the differentiation point when it comes
to creating CPUidle drivers (their states and related cpu logical mask),
the idle states can be used as a means to create logical masks of cpus
for which the CPUidle driver applies.

This series introduces a config option to enable multiple drivers
support for the ARM generic CPUidle driver and related code that
creates cpumasks of cpus sharing same idle states at run-time.
The maximum number of supported generic idle drivers can be configured
through a Kconfig entry.

The code carrying out idle states comparison is completely generic
and borrowed from OF unit tests; it overrides the OF API entirely
though to carry out properties (ie phandles list) comparison in the
fastest possible way. If deemed worthwhile it can be moved to generic OF
layer.

Tested through several dts idle states permutations on Juno board with
CPUidle and related idle states enabled.

Cc: Howard Chen <howard.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Lorenzo Pieralisi (1):
  drivers: cpuidle: cpuidle-arm: heterogeneous systems extension

 drivers/cpuidle/Kconfig.arm   |  25 +++++
 drivers/cpuidle/cpuidle-arm.c | 236 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 230 insertions(+), 31 deletions(-)

-- 
2.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
