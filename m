From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Fri, 10 Nov 2017 09:42:14 -0800
Message-ID: <001901d35a4b$40d2f310$c278d930$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net> CCuzeI4ZRt1L5CCv4eEEwJ
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:50649 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbdKJRmU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Nov 2017 12:42:20 -0500
In-Reply-To: CCuzeI4ZRt1L5CCv4eEEwJ
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: =?UTF-8?Q?'Marcus_H=C3=A4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?'Robert_Sch=C3=B6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>, Doug Smythies <dsmythies@telus.net>

Hi Thomas,

In addition to my previous reply:

On 2017.11.7 15:04 Thomas Ilsche wrote:

> I made a hack[1] to stop poll_idle after timer_expires which prevents the issue
> in my tests. The idea is to make sure that poll_idle is really exited whenever a
> timer happens. I was trying to use existing information, but I'm not entirely
> sure if tick_sched.timer_expires actually has the right semantic.

Your patch does not prevent the issue in my case.
And actually I wouldn't expect it to. Why not? My (unproven) theory has always been
that by the time it ends up in the loop in drivers/cpuidle/poll_state.c the timer has
already expired, so you are looking at the next timer time, which is long.

As previously mentioned, another old, but rebased, patch does work for my case,
I'll paste it below.

I'll just add a note that I find testing results hard to repeat here. Sometimes my tests
will go for hours without an issue and other times they go for hours with constant issues.
I will say that there does appear to be some repeatable pattern, where forcing minimum
pstate makes the problem worse than when forcing the maximum pstate. (i.e. the time between
reading the original call to tick_nohz_get_sleep_length and the loop inside
drivers/cpuidle/poll_state.c is longer).

[1]: https://github.com/tud-zih-energy/linux/commit/7529b167dc7c2afaacd4551fe01ec576df5097e3

... Doug

>From 788fab5531625d7bc7f6db9622984c8e87fe7672 Mon Sep 17 00:00:00 2001
From: Doug Smythies <dsmythies@telus.net>
Date: Sat, 28 Oct 2017 07:15:41 -0700
Subject: [PATCH] cpuidle: break out of idle polling loop after HLT threshold

This was from Rik van Riel on 2016.03.18

Staying in the poll loop can be beneficial for workloads that
wake back up very, very quickly, but staying in the poll loop
for too long can waste a lot of power.

Break out of the idle polling loop if the system has spent more
time in the loop than the threshold for entering the next power
saving mode.

The poll loop uses full CPU power already, so this will not
increase the power use of the poll loop.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpuidle/poll_state.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 7416b16..3023d44 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -11,10 +11,29 @@
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
                               struct cpuidle_driver *drv, int index)
 {
+       /*
+        * Polling is state 0; break out of the polling loop after the
+        * threshold for the next power state has passed. Doing this several
+        * times in a row should cause the menu governor to immediately
+        * select a deeper power state.
+        */
+       u64 limit = drv->states[1].target_residency * NSEC_PER_USEC;
+       ktime_t start = ktime_get();
+       int i = 0;
+
        local_irq_enable();
        if (!current_set_polling_and_test()) {
-               while (!need_resched())
+               while (!need_resched()) {
+                       ktime_t now;
                        cpu_relax();
+
+                       /* Occasionally check for a timeout. */
+                       if (!(i++ % 1000)) {
+                               now = ktime_get();
+                               if (ktime_to_ns(ktime_sub(now, start)) > limit)
+                                       break;
+                       }
+               }
        }
        current_clr_polling();

--
2.7.4
