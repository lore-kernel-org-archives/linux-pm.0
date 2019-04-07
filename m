Return-Path: <SRS0=LXM6=SJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E862C10F0E
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0EA2084F
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDGSNE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:13:04 -0400
Received: from muru.com ([72.249.23.125]:44676 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfDGSNE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Apr 2019 14:13:04 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C9D02818C;
        Sun,  7 Apr 2019 18:13:18 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/7] power: supply: cpcap-battery: Fix low battery check
Date:   Sun,  7 Apr 2019 11:12:49 -0700
Message-Id: <20190407181254.64537-3-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190407181254.64537-1-tony@atomide.com>
References: <20190407181254.64537-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We need to check current instead of the charge counter to see if
a charger is connected. The charge counter shows the cumulated value
instead of the current charge current and can be negative or positive.

Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -562,11 +562,11 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 
 	switch (d->action) {
 	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
-		if (latest->counter_uah >= 0)
+		if (latest->current_ua >= 0)
 			dev_warn(ddata->dev, "Battery low at 3.3V!\n");
 		break;
 	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
-		if (latest->counter_uah >= 0) {
+		if (latest->current_ua >= 0) {
 			dev_emerg(ddata->dev,
 				  "Battery empty at 3.1V, powering off\n");
 			orderly_poweroff(true);
-- 
2.21.0
