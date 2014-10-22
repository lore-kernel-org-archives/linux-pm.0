From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFD PATCH 08/10] cpuidle: select: hack - increase rating to have this governor as default
Date: Wed, 22 Oct 2014 15:57:51 +0200
Message-ID: <1413986273-28522-9-git-send-email-daniel.lezcano@linaro.org>
References: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, rafael.j.wysocki@intel.com, mingo@kernel.org, peterz@infradead.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, mturquette@linaro.org, tuukka.tikkanen@linaro.org, nicolas.pitre@linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governors/select.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/select.c b/drivers/cpuidle/governors/select.c
index 0de7095..2193b78 100644
--- a/drivers/cpuidle/governors/select.c
+++ b/drivers/cpuidle/governors/select.c
@@ -41,7 +41,7 @@ static int select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 static struct cpuidle_governor select_governor = {
 	.name   = "select",
-	.rating = 10,
+	.rating = 30,
 	.select = select,
 	.owner  = THIS_MODULE,
 };
-- 
1.9.1
