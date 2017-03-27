From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 6/9] drivers: remove useless comment from base/arch_topology.c
Date: Mon, 27 Mar 2017 14:18:22 +0100
Message-ID: <20170327131825.32134-7-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170327131825.32134-1-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, juri.lelli-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Printing out an error message when we failed to get the cpu device is
not helping anyone. Remove it.

Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
---
 drivers/base/arch_topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index c33482121b7d..b24d9a2af2c5 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -81,11 +81,9 @@ static int register_cpu_capacity_sysctl(void)
 
 	for_each_possible_cpu(i) {
 		cpu = get_cpu_device(i);
-		if (!cpu) {
-			pr_err("%s: too early to get CPU%d device!\n",
-			       __func__, i);
+		if (!cpu)
 			continue;
-		}
+
 		device_create_file(cpu, &dev_attr_cpu_capacity);
 	}
 
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
