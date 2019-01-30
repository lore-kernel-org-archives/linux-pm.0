From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] cpuidle: poll_state: Fix default time limit.
Date: Wed, 30 Jan 2019 08:28:22 -0800
Message-ID: <1548865702-3524-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The default time is declared in units of microsecnds,
but is used as nano seconds, resulting in significant
accounting errors for idle state 0 time when all idle
states deeper than 0 are disabled.

Under these unusual conditions, we don't really care
about the poll time limit anyhow.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpuidle/poll_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index b17d153..23a1b27 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -21,7 +21,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		unsigned int loop_count = 0;
-		u64 limit = TICK_USEC;
+		u64 limit = TICK_NSEC;
 		int i;
 
 		for (i = 1; i < drv->state_count; i++) {
-- 
2.7.4
