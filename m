From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 02/10] timerqueue: Document return values of
 timerqueue_add/del()
Date: Mon, 17 Apr 2017 20:32:43 +0200
Message-ID: <20170417184356.129279639@linutronix.de>
References: <20170417183241.244217993@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48367 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755332AbdDQSxc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 14:53:32 -0400
Content-Disposition: inline; filename=timerqueue--Document-return-values.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

The return values of timerqueue_add/del() are not documented in the kernel doc
comment. Add proper documentation.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/timerqueue.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: b/lib/timerqueue.c
===================================================================
--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -33,8 +33,9 @@
  * @head: head of timerqueue
  * @node: timer node to be added
  *
- * Adds the timer node to the timerqueue, sorted by the
- * node's expires value.
+ * Adds the timer node to the timerqueue, sorted by the node's expires
+ * value. Returns true if the newly added timer is the first expiring timer in
+ * the queue.
  */
 bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 {
@@ -70,7 +71,8 @@ EXPORT_SYMBOL_GPL(timerqueue_add);
  * @head: head of timerqueue
  * @node: timer node to be removed
  *
- * Removes the timer node from the timerqueue.
+ * Removes the timer node from the timerqueue. Returns true if the queue is
+ * not empty after the remove.
  */
 bool timerqueue_del(struct timerqueue_head *head, struct timerqueue_node *node)
 {
