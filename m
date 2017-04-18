From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 01/10] timer: Invoke timer_start_debug() where it makes
 sense
Date: Tue, 18 Apr 2017 13:11:03 +0200
Message-ID: <20170418111400.410779616@linutronix.de>
References: <20170418111102.490432548@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdDRQlP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 12:41:15 -0400
Content-Disposition: inline;
 filename=timer--call-debug-function-after-setting-properly-the-base-and-the-flags.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

The timer start debug function is called before the proper timer base
is set.

As a consequence the trace data contains the stale CPU and flags values.

Call the debug function after setting the new base and flags.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -970,8 +970,6 @@ static inline int
 	if (!ret && pending_only)
 		goto out_unlock;
 
-	debug_activate(timer, expires);
-
 	new_base = get_target_base(base, timer->flags);
 
 	if (base != new_base) {
@@ -994,6 +992,8 @@ static inline int
 		}
 	}
 
+	debug_activate(timer, expires);
+
 	/* Try to forward a stale timer base clock */
 	forward_timer_base(base);
 
