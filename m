From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/4] SH: cpuidle: remove pointless initialization
Date: Wed, 17 Apr 2013 15:32:54 +0200
Message-ID: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:50227 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966219Ab3DQNdB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 09:33:01 -0400
Received: by mail-wg0-f46.google.com with SMTP id e11so1544911wgh.25
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2013 06:33:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lethal@linux-sh.org, rjw@sisk.pl
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

The driver is a global static variable automatically initialized to zero.

Removing the useless initialization in the init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 0986f21..5b44af9 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -64,12 +64,6 @@ void sh_mobile_setup_cpuidle(void)
 	struct cpuidle_state *state;
 	int i;
 
-
-	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
-		drv->states[i].name[0] = '\0';
-		drv->states[i].desc[0] = '\0';
-	}
-
 	i = CPUIDLE_DRIVER_STATE_START;
 
 	state = &drv->states[i++];
-- 
1.7.9.5

