From: Ruchi Kandoi <kandoiruchi@google.com>
Subject: [PATCH] suspend: Return error when pending wakeup source is found.
Date: Thu,  7 May 2015 19:07:42 -0700
Message-ID: <1431050862-26473-1-git-send-email-kandoiruchi@google.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38759 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbEHCJX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 22:09:23 -0400
Received: by igbhj9 with SMTP id hj9so10052676igb.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 19:09:22 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kandoiruchi@google.com

If a wakeup source is found to be pending in the last stage of suspend
after syscore suspend then the device doesn't suspend but the error is
not propogated which causes an error in the accounting for the number
of suspend aborts and successful suspends.

Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
---
 kernel/power/suspend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8d7a1ef..343b4e4 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -366,6 +366,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 			trace_suspend_resume(TPS("machine_suspend"),
 				state, false);
 			events_check_enabled = false;
+		} else if (*wakeup) {
+			error = -EBUSY;
 		}
 		syscore_resume();
 	}
-- 
2.2.0.rc0.207.ga3a616c

