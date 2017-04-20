From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 3/8] arm: fix return value of parse_cpu_capacity
Date: Thu, 20 Apr 2017 15:43:11 +0100
Message-ID: <20170420144316.15632-4-juri.lelli@arm.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170420144316.15632-1-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, juri.lelli-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

parse_cpu_capacity() has to return 0 on failure, but it currently returns
1 instead if raw_capacity kcalloc failed.

Fix it (by directly returning 0).

Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Reported-by: Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>
Fixes: 06073ee26775 ('ARM: 8621/3: parse cpu capacity-dmips-mhz from DT')
Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Acked-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
---

Changes from v3:

 - directly return 0 on failure (as pointed out by Vincent)
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index f8a3ab82e77f..1b8ec3054642 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -166,7 +166,7 @@ static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			if (!raw_capacity) {
 				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
 				cap_parsing_failed = true;
-				return !ret;
+				return 0;
 			}
 		}
 		capacity_scale = max(cpu_capacity, capacity_scale);
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
