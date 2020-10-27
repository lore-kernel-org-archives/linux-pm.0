Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63220C388F9
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 10:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF9422281
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 10:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897646AbgJ0KP3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:15:29 -0400
Received: from 14.143.115.186.static-Bangalore.vsnl.net.in ([14.143.115.186]:10400
        "EHLO BLRMIESPC-1169" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2897644AbgJ0KP2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 06:15:28 -0400
X-Greylist: delayed 693 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 06:15:26 EDT
Received: from BLRMIESPC-1169 (localhost [127.0.0.1])
        by BLRMIESPC-1169 (8.15.2/8.15.2/Debian-3) with ESMTP id 09RA04WK030701;
        Tue, 27 Oct 2020 15:30:04 +0530
Date:   Tue, 27 Oct 2020 15:30:04 +0530
From:   ravisankarreddylingareddy@gmail.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        rafael.j.wysocki@intel.com
Cc:     masaya.takahashi@sony.com, Shingo.Takeuchi@sony.com,
        Srinavasa.Nagaraju@sony.com, soumya.x.khasnis@sonymobile.com,
        ravisankar.reddy@sony.com, linux-pm@vger.kernel.org
Subject: [PATCH] PM: Use WQ_MEM_RECLAIM flag for PM workqueue
Message-ID: <20201027100004.GA30670@tsappmail.ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Deadlock is seen under below high memory usage scenario.

kswapd waiting to reclaim memory is blocked on i/o kworker and pm_wq
context which needs to wakeup i/o kworker is waiting for kthread
creation which is again blocked in memory reclaim path.

Use WQ_MEM_RECLAIM flag for PM workqueue to avoid this deadlock.

Signed-off-by: Ravisankar Reddy (Sony) <ravisankarreddylingareddy@gmail.com>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 40f86ec4ab30..ff5f3349e76f 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -933,7 +933,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueue(void)
 {
-	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE, 0);
+	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
 
 	return pm_wq ? 0 : -ENOMEM;
 }
-- 
2.17.1

