From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5/9] ACPI / cpuidle: remove dev->state_count setting
Date: Tue, 20 Aug 2013 16:23:43 +0200
Message-ID: <1377008627-32691-6-git-send-email-b.zolnierkie@samsung.com>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13338 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3HTO0C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 10:26:02 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU008UT2RB3WL0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 23:26:00 +0900 (KST)
In-reply-to: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, Len Brown <lenb@kernel.org>

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
index 853fe86..4b6d20a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -982,8 +982,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 			break;
 	}
 
-	dev->state_count = count;
-
 	if (!count)
 		return -EINVAL;
 
-- 
1.8.2.3

