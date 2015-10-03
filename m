From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC PATCH] cpuidle: mvebu: indicate failure to enter deeper sleep states
Date: Sat, 03 Oct 2015 09:24:39 +0100
Message-ID: <E1ZiI7T-0002zo-Ez@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:35999 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbJCIYp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Oct 2015 04:24:45 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

The cpuidle ->enter method expects the return value to be the sleep
state we entered.  Returning negative numbers or other codes is not
permissible since coupled CPU idle was merged.

At least some of the mvebu_v7_cpu_suspend() implementations return the
value from cpu_suspend(), which returns zero if the CPU vectors back
into the kernel via cpu_resume() (the success case), or the non-zero
return value of the suspend actor, or one (failure cases).

We do not want to be returning the failure case value back to CPU idle
as that indicates that we successfully entered one of the deeper idle
states.  Always return zero instead, indicating that we slept for the
shortest amount of time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Please think about this - having only an Armada 388 platform, I can't
test this due to CPU idle being disabled there.  However, the code paths
indicate that if we fail to sleep in armada_370_xp_pmsu_idle_enter() or
armada_38x_do_cpu_suspend() fail to sleep, we end up reporting that we
successfully slept in CPU idle state 1 in both cases.

Rafael - the code in cpuidle.c prior to the addition of coupled CPU idle
seems to allow the return of negative error numbers from the ->enter()
method:

        if (entered_state >= 0) {
                /* Update cpuidle counters */
                /* This can be moved to within driver enter routine
                 * but that results in multiple copies of same code.
                 */
                dev->states_usage[entered_state].time += dev->last_residency;
                dev->states_usage[entered_state].usage++;
        } else {
                dev->last_residency = 0;
        }

Since coupled CPU idle, negative return codes will give a negative table
index inside cpuidle_state_is_coupled() - which is obviously buggy.  Does
this need fixing?  If so, this patch below is wrong, and we should be
returning a negative errno rather than zero on failure to enter a low
power state.

 drivers/cpuidle/cpuidle-mvebu-v7.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 01a856971f05..18ded9e7cb34 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -39,8 +39,12 @@ static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
 	ret = mvebu_v7_cpu_suspend(deepidle);
 	cpu_pm_exit();
 
+	/*
+	 * If we failed to enter the desired state, indicate that we
+	 * slept lightly.
+	 */
 	if (ret)
-		return ret;
+		return 0;
 
 	return index;
 }
-- 
2.1.0

