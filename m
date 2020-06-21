Return-Path: <SRS0=YAo6=AC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42DCC433DF
	for <linux-pm@archiver.kernel.org>; Sun, 21 Jun 2020 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7512487A
	for <linux-pm@archiver.kernel.org>; Sun, 21 Jun 2020 08:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgFUIEi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 21 Jun 2020 04:04:38 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:35325 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729449AbgFUIEi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 04:04:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09860458|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0436881-0.000910199-0.955402;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07381;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Hq1RdEZ_1592726668;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.Hq1RdEZ_1592726668)
          by smtp.aliyun-inc.com(10.147.44.145);
          Sun, 21 Jun 2020 16:04:33 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>,
        Frank Lee <frank@allwinnertech.com>
Subject: [PATCH] powercap: idle_inject: Fix the comment about play_idle
Date:   Sun, 21 Jun 2020 16:04:12 +0800
Message-Id: <20200621080412.28388-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

After commit 333cff6c963fbc ("powercap/drivers/idle_inject: Specify
idle state max latency"), we convert to use play_idle_precise() with
max allowed latency to specify the idle state.

Some function comments still use play_idle(), let's update it to
play_idle_precise().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 drivers/powercap/idle_inject.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index c90f0990968b..597733ed86e9 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -19,8 +19,8 @@
  * The idle + run duration is specified via separate helpers and that allows
  * idle injection to be started.
  *
- * The idle injection kthreads will call play_idle() with the idle duration
- * specified as per the above.
+ * The idle injection kthreads will call play_idle_precise() with the idle
+ * duration and max allowed latency specified as per the above.
  *
  * After all of them have been woken up, a timer is set to start the next idle
  * injection cycle.
@@ -100,7 +100,7 @@ static void idle_inject_wakeup(struct idle_inject_device *ii_dev)
  *
  * This function is called when the idle injection timer expires.  It wakes up
  * idle injection tasks associated with the timer and they, in turn, invoke
- * play_idle() to inject a specified amount of CPU idle time.
+ * play_idle_precise() to inject a specified amount of CPU idle time.
  *
  * Return: HRTIMER_RESTART.
  */
@@ -124,8 +124,8 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
  * idle_inject_fn - idle injection work function
  * @cpu: the CPU owning the task
  *
- * This function calls play_idle() to inject a specified amount of CPU idle
- * time.
+ * This function calls play_idle_precise() to inject a specified amount of CPU
+ * idle time.
  */
 static void idle_inject_fn(unsigned int cpu)
 {
-- 
2.24.0

