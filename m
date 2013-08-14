From: tuukka.tikkanen@linaro.org
Subject: [PATCH 5/8] Cpuidle: Fix menu_device->intervals type
Date: Wed, 14 Aug 2013 19:02:38 +0300
Message-ID: <74a396e4bd6ae83ef1b3d708e51a468a3ab1ea70.1376493949.git.tuukka.tikkanen@linaro.org>
References: <cover.1376487596.git.tuukka.tikkanen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376487596.git.tuukka.tikkanen@linaro.org>
In-Reply-To: <cover.1376493949.git.tuukka.tikkanen@linaro.org>
References: <cover.1376493949.git.tuukka.tikkanen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: private-pmwg@linaro.org, linux-kernel@vger.kernel.org, Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>

Struct menu_device member intervals is declared as u32, but the value
stored is (unsigned) int. The type is changed to match the value being
stored.

Signed-off-by: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
---
 drivers/cpuidle/governors/menu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index fe2dd04..0b37ee4 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -118,7 +118,7 @@ struct menu_device {
 	unsigned int	exit_us;
 	unsigned int	bucket;
 	u64		correction_factor[BUCKETS];
-	u32		intervals[INTERVALS];
+	unsigned int	intervals[INTERVALS];
 	int		interval_ptr;
 };
 
-- 
1.7.9.5
