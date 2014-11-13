From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 7/8] thermal:core:fix: Initialize the max_state variable to 0
Date: Thu, 13 Nov 2014 18:02:44 +0100
Message-ID: <1415898165-27406-8-git-send-email-l.majewski@samsung.com>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux PM list <linux-pm@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@st.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Pointer to the uninitialized max_state variable is passed to get the
maximal cooling state.
For CPU cooling device (cpu_cooling.c) the cpufreq_get_max_state() is
called, which even when error occurs will return the max_state variable
unchanged.
Since error for ->get_max_state() is not checked, the automatically
allocated value of max_state is used for (upper > max_state) comparison.
For any possible max_state value it is very unlikely that it will be less
than upper.
As a consequence, the cooling device is bind even without the backed
cpufreq table initialized.

This initialization will prevent from accidental binding trip points to
cpu freq cooling frequencies when cpufreq driver itself is not yet fully
initialized.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 43b9070..413daa4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -927,7 +927,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	struct thermal_instance *pos;
 	struct thermal_zone_device *pos1;
 	struct thermal_cooling_device *pos2;
-	unsigned long max_state;
+	unsigned long max_state = 0;
 	int result;
 
 	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
-- 
2.0.0.rc2
