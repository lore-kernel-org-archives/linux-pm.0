From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 05/09] clockevents: Remove extra local_irq_save in clockevents_exchange_device()
Date: Wed, 25 Mar 2015 13:08:27 +0100
Message-ID: <51005827.yXt5tjZMBs@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Called with clockevents_lock held and interrupts disabled already.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/clockevents.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux/kernel/time/clockevents.c
===================================================================
--- linux.orig/kernel/time/clockevents.c
+++ linux/kernel/time/clockevents.c
@@ -491,14 +491,12 @@ void clockevents_handle_noop(struct cloc
  * @old:	device to release (can be NULL)
  * @new:	device to request (can be NULL)
  *
- * Called from the notifier chain. clockevents_lock is held already
+ * Called from various tick functions with clockevents_lock held and
+ * interrupts disabled.
  */
 void clockevents_exchange_device(struct clock_event_device *old,
 				 struct clock_event_device *new)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	/*
 	 * Caller releases a clock event device. We queue it into the
 	 * released list and do a notify add later.
@@ -514,7 +512,6 @@ void clockevents_exchange_device(struct
 		BUG_ON(new->mode != CLOCK_EVT_MODE_UNUSED);
 		clockevents_shutdown(new);
 	}
-	local_irq_restore(flags);
 }
 
 /**
