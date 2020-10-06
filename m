Return-Path: <SRS0=ZSVA=DN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B204C41604
	for <linux-pm@archiver.kernel.org>; Tue,  6 Oct 2020 19:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3345E20789
	for <linux-pm@archiver.kernel.org>; Tue,  6 Oct 2020 19:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJFTnq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:43:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48368 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgJFTnq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 15:43:46 -0400
Received: from 89-64-87-80.dynamic.chello.pl (89.64.87.80) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.489)
 id 3bf34580619004af; Tue, 6 Oct 2020 21:43:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v2] cpufreq: stats: Add memory barrier to store_reset()
Date:   Tue, 06 Oct 2020 21:43:43 +0200
Message-ID: <4635763.B4JZuFUhXG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is nothing to prevent the CPU or the compiler from reordering
the writes to stats->reset_time and stats->reset_pending in
store_reset(), in which case the readers of stats->reset_time may see
a stale value.  Moreover, on 32-bit arches the write to reset_time
cannot be completed in one go, so the readers of it may see a
partially updated value in that case.

To prevent that from happening, add a write memory barrier between
the writes to stats->reset_time and stats->reset_pending in
store_reset() and corresponding read memory barrier in the
readers of stats->reset_time.

Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

linux-next material.

-> v2: Pair read and write memory barriers as appropriate.

---
 drivers/cpufreq/cpufreq_stats.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-pm/drivers/cpufreq/cpufreq_stats.c
@@ -47,6 +47,11 @@ static void cpufreq_stats_reset_table(st
 
 	/* Adjust for the time elapsed since reset was requested */
 	WRITE_ONCE(stats->reset_pending, 0);
+	/*
+	 * Prevent the reset_time read from being reordered before the
+	 * reset_pending accesses in cpufreq_stats_record_transition().
+	 */
+	smp_rmb();
 	cpufreq_stats_update(stats, READ_ONCE(stats->reset_time));
 }
 
@@ -71,10 +76,16 @@ static ssize_t show_time_in_state(struct
 
 	for (i = 0; i < stats->state_num; i++) {
 		if (pending) {
-			if (i == stats->last_index)
+			if (i == stats->last_index) {
+				/*
+				 * Prevent the reset_time read from occurring
+				 * before the reset_pending read above.
+				 */
+				smp_rmb();
 				time = get_jiffies_64() - READ_ONCE(stats->reset_time);
-			else
+			} else {
 				time = 0;
+			}
 		} else {
 			time = stats->time_in_state[i];
 			if (i == stats->last_index)
@@ -99,6 +110,11 @@ static ssize_t store_reset(struct cpufre
 	 * avoid races.
 	 */
 	WRITE_ONCE(stats->reset_time, get_jiffies_64());
+	/*
+	 * The memory barrier below is to prevent the readers of reset_time from
+	 * seeing a stale or partially updated value.
+	 */
+	smp_wmb();
 	WRITE_ONCE(stats->reset_pending, 1);
 
 	return count;



