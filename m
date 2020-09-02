Return-Path: <SRS0=6wxd=CL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF1C433E7
	for <linux-pm@archiver.kernel.org>; Wed,  2 Sep 2020 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581D120639
	for <linux-pm@archiver.kernel.org>; Wed,  2 Sep 2020 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063433;
	bh=737eL5OJnps+Fgda6I/02laUfr4yPyternnQSNU90a0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XNW7zxE1BvOE2OdogU7uTktVpnFnJpc9sZR1SmSpyzDcHBFnMR3ulamRel9gRV1HB
	 cMOo4MjSYosKdzQyGs+kP3wx8Q/SjBEGaaxivpPvDn4SEg54Dno3IvogSxAendc/7B
	 MGhSqpWvwziGfsIbkYiqGSXsBi+RtH6cahWK7ILM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgIBQRI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbgIBQRE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 12:17:04 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607D220639;
        Wed,  2 Sep 2020 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063424;
        bh=737eL5OJnps+Fgda6I/02laUfr4yPyternnQSNU90a0=;
        h=Date:From:To:Cc:Subject:From;
        b=ai+8YXn0v79UX78y4IXY2HWQ5Bt6T6zyzZQlahXCcyiagM/Z9NIXdZY7Fm3rms1xl
         hpgsXBGEVeTa09MJcILzKm9XOjrsX1qUOQcq2GiAScX+HtZHzLMJkmAdLayUo4e6IR
         EV67gJrXzXM3MbDr4TCpX5V1mgs/HXSVGLutSoxI=
Date:   Wed, 2 Sep 2020 11:23:15 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v2] power: supply: charger-manager: Fix info message in
 check_charging_duration()
Message-ID: <20200902162315.GA11384@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few months ago, commit e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
changed the expression in the if statement from "duration > desc->discharging_max_duration_ms"
to "duration > desc->charging_max_duration_ms", but the arguments for dev_info() were left unchanged.
Apparently, due to a copy-paste error.

Fix this by using the proper arguments for dev_info().

Also, while there, replace "exceed" with "exceeds", for both messages.

Addresses-Coverity-ID: 1496803 ("Copy-paste error")
Fixes: e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 -  Replace "exceed" with "exceeds"

 drivers/power/supply/charger-manager.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 07992821e252..a6d5dbd55e37 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -464,7 +464,7 @@ static int check_charging_duration(struct charger_manager *cm)
 		duration = curr - cm->charging_start_time;
 
 		if (duration > desc->charging_max_duration_ms) {
-			dev_info(cm->dev, "Charging duration exceed %ums\n",
+			dev_info(cm->dev, "Charging duration exceeds %ums\n",
 				 desc->charging_max_duration_ms);
 			ret = true;
 		}
@@ -472,8 +472,8 @@ static int check_charging_duration(struct charger_manager *cm)
 		duration = curr - cm->charging_end_time;
 
 		if (duration > desc->charging_max_duration_ms) {
-			dev_info(cm->dev, "Discharging duration exceed %ums\n",
-				 desc->discharging_max_duration_ms);
+			dev_info(cm->dev, "Charging duration exceeds %ums\n",
+				 desc->charging_max_duration_ms);
 			ret = true;
 		}
 	}
-- 
2.27.0

