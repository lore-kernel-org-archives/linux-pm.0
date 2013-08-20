From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH] freezer: allow killing of frozen tasks
Date: Tue, 20 Aug 2013 13:20:03 +0200
Message-ID: <5917186.DMyAa9ofOj@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51873 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab3HTLUX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 07:20:23 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRT00DW9U5ED3P0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 20:20:21 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

Change __refrigerator() to allow SIGKILL signal handling during
the frozen state (by setting task to a TASK_KILLABLE state instead
of TASK_UNINTERRUPTIBLE one before entering sleep) and make tasks
leave __refrigerator() upon receiving such signal.

These changes allow frozen tasks to be killed immediately without
the need to thaw them first.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 kernel/freezer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index b462fa1..0c05a7a 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -57,12 +57,13 @@ bool __refrigerator(bool check_kthr_stop)
 	pr_debug("%s entered refrigerator\n", current->comm);
 
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_KILLABLE);
 
 		spin_lock_irq(&freezer_lock);
 		current->flags |= PF_FROZEN;
 		if (!freezing(current) ||
-		    (check_kthr_stop && kthread_should_stop()))
+		    (check_kthr_stop && kthread_should_stop()) ||
+		    fatal_signal_pending(current))
 			current->flags &= ~PF_FROZEN;
 		spin_unlock_irq(&freezer_lock);
 
-- 
1.8.2.3


