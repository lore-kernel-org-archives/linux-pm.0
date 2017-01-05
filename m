From: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 1/3] cpuidle/menu: stop seeking deeper idle if current state is too deep
Date: Thu,  5 Jan 2017 23:29:45 +0800
Message-ID: <1483630187-29622-2-git-send-email-alex.shi@linaro.org>
References: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35089 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969402AbdAEPaS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2017 10:30:18 -0500
Received: by mail-it0-f41.google.com with SMTP id c20so329079593itb.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2017 07:30:18 -0800 (PST)
In-Reply-To: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, open list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>

The obsolete commit 71abbbf85 want to introduce a dynamic cstates,
but it was removed for long time. Just left the nonsense deeper cstate
checking.

Since all target_residency and exit_latency are going longer in deeper
idle state, no needs to waste some cpu cycle on useless seeking.

Signed-off-by: Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index d9b5b93..07e36bb 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -357,9 +357,9 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		if (s->disabled || su->disable)
 			continue;
 		if (s->target_residency > data->predicted_us)
-			continue;
+			break;
 		if (s->exit_latency > latency_req)
-			continue;
+			break;
 
 		data->last_state_idx = i;
 	}
-- 
2.8.1.101.g72d917a

