Return-Path: <SRS0=6wxd=CL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD03C433E7
	for <linux-pm@archiver.kernel.org>; Wed,  2 Sep 2020 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390DD20767
	for <linux-pm@archiver.kernel.org>; Wed,  2 Sep 2020 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060760;
	bh=gBiAdSr/rlD2GPMPqMUuP5613nlb1jdrzG98kvU5uTY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Y0ZCqS7PnAKLVzA1BDnC6N5RI5QQGve8f/PzTM0mph9L9mP1il20I6Ls6itOSvb39
	 d4oPjN5TV8W4yIpN6Hxw7qCL4Kks/10fyQfjUSBpx7ineogFpLVrG7ecd5NEYa/QgW
	 OEPvqVEBbll3vjTdqBlnqU+JSf5895G3hzkf9e7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgIBPch (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbgIBPcf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 11:32:35 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0753D208CA;
        Wed,  2 Sep 2020 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599060754;
        bh=gBiAdSr/rlD2GPMPqMUuP5613nlb1jdrzG98kvU5uTY=;
        h=Date:From:To:Cc:Subject:From;
        b=02VlrZVDpXeIJFmuhXQHWRzQzXZcBm5YdfcDu5Dm85ecv/ADBPKebuLK8IlzPyfrO
         gHh3gx32KmGCZ5kiPrlpaKMftGgPqM8p3S4uqMrHjS9Eiz+aCUB4b6UyoxqnmwfASJ
         fipW98xGJ81469ZT5m9LqluK8ml9ajbw68qLT1es=
Date:   Wed, 2 Sep 2020 10:38:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] power: supply: charger-manager: Fix info message in
 check_charging_duration()
Message-ID: <20200902153846.GA10327@embeddedor>
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

Addresses-Coverity-ID: 1496803 ("Copy-paste error")
Fixes: e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/power/supply/charger-manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 07992821e252..6117018e89df 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -472,8 +472,8 @@ static int check_charging_duration(struct charger_manager *cm)
 		duration = curr - cm->charging_end_time;
 
 		if (duration > desc->charging_max_duration_ms) {
-			dev_info(cm->dev, "Discharging duration exceed %ums\n",
-				 desc->discharging_max_duration_ms);
+			dev_info(cm->dev, "Charging duration exceed %ums\n",
+				 desc->charging_max_duration_ms);
 			ret = true;
 		}
 	}
-- 
2.27.0

