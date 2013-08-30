From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/3] intel_idle: mark some functions with __init tag
Date: Fri, 30 Aug 2013 12:27:45 +0200
Message-ID: <2017492.SHLf7BQHGW@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13461 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab3H3K2A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2013 06:28:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

intel_idle_probe() and intel_idle_cpuidle_driver_init() can be marked
with __init tag as they are only called from intel_idle_init().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 53b24f1..33e599e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -490,7 +490,7 @@ MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
 /*
  * intel_idle_probe()
  */
-static int intel_idle_probe(void)
+static int __init intel_idle_probe(void)
 {
 	unsigned int eax, ebx, ecx;
 	const struct x86_cpu_id *id;
@@ -558,7 +558,7 @@ static void intel_idle_cpuidle_devices_uninit(void)
  * intel_idle_cpuidle_driver_init()
  * allocate, initialize cpuidle_states
  */
-static int intel_idle_cpuidle_driver_init(void)
+static int __init intel_idle_cpuidle_driver_init(void)
 {
 	int cstate;
 	struct cpuidle_driver *drv = &intel_idle_driver;
-- 
1.8.2.3


