Return-Path: <SRS0=LXM6=SJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419FBC10F0E
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152FB214AE
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDGSNI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:13:08 -0400
Received: from muru.com ([72.249.23.125]:44694 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfDGSNI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Apr 2019 14:13:08 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 402488139;
        Sun,  7 Apr 2019 18:13:23 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 5/7] power: supply: cpcap-battery: Use accumulator for current and power average
Date:   Sun,  7 Apr 2019 11:12:52 -0700
Message-Id: <20190407181254.64537-6-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190407181254.64537-1-tony@atomide.com>
References: <20190407181254.64537-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We should not use measured current value for average since we have proper
coulomb counter values available. Using measured current value should
be only used when the value is queried at a higher rate than the 250 ms
rate the coulomb counter is configured to run at.

Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -476,11 +476,11 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		val->intval = ddata->config.info.voltage_min_design;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
-		if (cached) {
+		sample = latest->cc.sample - previous->cc.sample;
+		if (!sample) {
 			val->intval = cpcap_battery_cc_get_avg_current(ddata);
 			break;
 		}
-		sample = latest->cc.sample - previous->cc.sample;
 		accumulator = latest->cc.accumulator - previous->cc.accumulator;
 		val->intval = cpcap_battery_cc_to_ua(ddata, sample,
 						     accumulator,
@@ -497,13 +497,13 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		val->intval = div64_s64(tmp, 100);
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
-		if (cached) {
+		sample = latest->cc.sample - previous->cc.sample;
+		if (!sample) {
 			tmp = cpcap_battery_cc_get_avg_current(ddata);
 			tmp *= (latest->voltage / 10000);
 			val->intval = div64_s64(tmp, 100);
 			break;
 		}
-		sample = latest->cc.sample - previous->cc.sample;
 		accumulator = latest->cc.accumulator - previous->cc.accumulator;
 		tmp = cpcap_battery_cc_to_ua(ddata, sample, accumulator,
 					     latest->cc.offset);
-- 
2.21.0
