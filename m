From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 5/9] ACPI / cpuidle: remove dev->state_count setting
Date: Fri, 20 Dec 2013 19:47:27 +0100
Message-ID: <1387565251-7051-6-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

dev->state_count is now always equal to drv->state_count and
drv->state_count no longer can change during driver's lifetime so
the default dev->state_count initialization in cpuidle_enable_device()
(called from cpuidle_register_device()) can be used instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/processor_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index c080c99..da8ce91 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -951,8 +951,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 			break;
 	}
 
-	dev->state_count = count;
-
 	if (!count)
 		return -EINVAL;
 
-- 
1.8.2.3
