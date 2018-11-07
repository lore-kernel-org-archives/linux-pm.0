From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH] irq/timings: Ignore predictions in the past
Date: Wed, 7 Nov 2018 11:09:08 +0100
Message-ID: <20181107100908.GJ9781@hirez.programming.kicks-ass.net>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 07, 2018 at 12:39:31AM +0100, Rafael J. Wysocki wrote:
> In general, however, I need to be convinced that interrupts that
> didn't wake up the CPU from idle are relevant for next wakeup
> prediction.

So you're worried about the case where we're 100% busy and generating IO
interrupts (disk, network, etc..) and then go idle and those interrupts
stop happening, but we'll base a prediction off of them?

Any predictor will have some of those trancients, but note that we'll
only actually train the irq timing thing when here is idle time. If
we're 100% busy, we'll never actually consume the data.

Also, I think the below delta (on top of my earlier patch) would make
sense; as I don't see how the current code makes sense there.

--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -306,22 +306,17 @@ u64 irq_timings_next_event(u64 now)
 			continue;
 
 		if (irqs->next_evt <= now) {
-			irq = i;
-			next_evt = now;
-
 			/*
-			 * This interrupt mustn't use in the future
-			 * until new events occur and update the
-			 * statistics.
+			 * If the last prediction was in the past, mark the IRQ
+			 * as invalid until a next interrupt updates the
+			 * prediction.
 			 */
 			irqs->valid = 0;
-			break;
+			continue;
 		}
 
-		if (irqs->next_evt < next_evt) {
-			irq = i;
+		if (irqs->next_evt < next_evt)
 			next_evt = irqs->next_evt;
-		}
 	}
 
 	return next_evt;
