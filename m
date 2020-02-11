Return-Path: <SRS0=vVHs=37=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571CC35242
	for <linux-pm@archiver.kernel.org>; Tue, 11 Feb 2020 23:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429902070A
	for <linux-pm@archiver.kernel.org>; Tue, 11 Feb 2020 23:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBKXjS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:39:18 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44707 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBKXjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:03 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id bb3e1864880233c1; Wed, 12 Feb 2020 00:39:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 03/28] PM: QoS: Drop the PM_QOS_SUM QoS type
Date:   Tue, 11 Feb 2020 23:58:26 +0100
Message-ID: <4044638.r6IGMOjVKC@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The PM_QOS_SUM QoS type is not used, so drop it along with the
code referring to it in pm_qos_get_value() and the related local
variables in there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h | 1 -
 kernel/power/qos.c     | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4747bdb6bed2..48bfb96a9360 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -53,7 +53,6 @@ enum pm_qos_type {
 	PM_QOS_UNITIALIZED,
 	PM_QOS_MAX,		/* return the largest value */
 	PM_QOS_MIN,		/* return the smallest value */
-	PM_QOS_SUM		/* return the sum */
 };
 
 /*
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 67dab7f330e4..a6be7faa1974 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -101,9 +101,6 @@ static const struct file_operations pm_qos_power_fops = {
 /* unlocked internal variant */
 static inline int pm_qos_get_value(struct pm_qos_constraints *c)
 {
-	struct plist_node *node;
-	int total_value = 0;
-
 	if (plist_head_empty(&c->list))
 		return c->no_constraint_value;
 
@@ -114,12 +111,6 @@ static inline int pm_qos_get_value(struct pm_qos_constraints *c)
 	case PM_QOS_MAX:
 		return plist_last(&c->list)->prio;
 
-	case PM_QOS_SUM:
-		plist_for_each(node, &c->list)
-			total_value += node->prio;
-
-		return total_value;
-
 	default:
 		/* runtime check for not using enum */
 		BUG();
-- 
2.16.4





