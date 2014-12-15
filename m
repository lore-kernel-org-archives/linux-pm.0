From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: cpu_cooling: document node in struct cpufreq_cooling_device
Date: Mon, 15 Dec 2014 16:55:52 +0000
Message-ID: <1418662552-26128-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:50033 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbaLOQ4L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 11:56:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, Yadwinder Singh Brar <yadi.brar@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>

The node field of struct cpufreq_cooling_device was reintroduced in
2dcd851fe4b4 (thermal: cpu_cooling: Update always cpufreq policy with
thermal constraints) but without the documentation that it once had.
Add it back so that all the fields of struct cpufreq_cooling_device
are documented.

Cc: Yadwinder Singh Brar <yadi.brar@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/cpu_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ad09e51ffae4..588185abeab0 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -39,6 +39,7 @@
  * @cpufreq_val: integer value representing the absolute value of the clipped
  *	frequency.
  * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
+ * @node: list_head to link all cpufreq_cooling_device together.
  *
  * This structure is required for keeping information of each
  * cpufreq_cooling_device registered. In order to prevent corruption of this a
-- 
1.9.1

