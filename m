From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/2] Support to tune governor in run time
Date: Mon, 13 Jan 2014 19:17:41 +0800
Message-ID: <1389611863-7812-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: eduardo.valentin-l0cyMroinI0@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This serie can support to turn governor for thermal zone in
run time.
Adds avaiable_policies attribute, so the user can get available
governor policies and change te governor to a new one.
Adds thermal_update_governor() function, so the thermal platform
driver can use it to update governor.

Changes from v1:
1. split avaiable_policies part to the "patch 1/2", and add document
for it.
2. add document for the thermal_update_governor.

Wei Ni (2):
  thermal: add available policies attribut
  thermal: add interface to support tune governor in run-time

 Documentation/thermal/sysfs-api.txt |   11 ++++
 drivers/thermal/thermal_core.c      |  105 ++++++++++++++++++++++++++++++++---
 include/linux/thermal.h             |   12 ++++
 3 files changed, 119 insertions(+), 9 deletions(-)

-- 
1.7.9.5
