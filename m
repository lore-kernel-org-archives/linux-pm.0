Return-Path: <SRS0=ThCx=TQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D98C04AB4
	for <linux-pm@archiver.kernel.org>; Thu, 16 May 2019 11:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0873620862
	for <linux-pm@archiver.kernel.org>; Thu, 16 May 2019 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558007334;
	bh=Fgt6H83M2tsRzAYkq+/1EP5rQP8bkQs3/QX8HGCIpYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K6eY5NHPppepjS8sUTCgQ9n4MtNpx4WRP0wicr1NK/+gt3fQS6arNclf/VmnvksiG
	 NIu/eqys7kx0H1h9PlN1l0dV0TsiIaKTa3BUZcTYl8g2uak3kWo/QGbiGX/hkIb0sW
	 GdR/znpBbuk7+X6pnaihTacQ23Kf7njzQbo/9HoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEPLsx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 May 2019 07:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfEPLju (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 07:39:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2EE20833;
        Thu, 16 May 2019 11:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006790;
        bh=Fgt6H83M2tsRzAYkq+/1EP5rQP8bkQs3/QX8HGCIpYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI/xmPEb3AYmyuQTgGRBkgOfv5gesdJkMBwZu1U0MpafURK9fkzkXikVihtKoAyvS
         kHotoXxXuBNsKJcXPiF9esYqprqWLxBVeuVJvSCHC1cMo5jHQ4I29YdNJkU9l/C+Lw
         t0oQItWHBItLmioVWyC5+/68EWv+iVdcIhhXUQ1A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 13/34] power: supply: cpcap-battery: Fix division by zero
Date:   Thu, 16 May 2019 07:39:10 -0400
Message-Id: <20190516113932.8348-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516113932.8348-1-sashal@kernel.org>
References: <20190516113932.8348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190516113910.pedqD-Z85btE-sTgkkgWTVf6o1Zw9mzH1euhGzAGx4A@z>

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit dbe7208c6c4aec083571f2ec742870a0d0edbea3 ]

If called fast enough so samples do not increment, we can get
division by zero in kernel:

__div0
cpcap_battery_cc_raw_div
cpcap_battery_get_property
power_supply_get_property.part.1
power_supply_get_property
power_supply_show_property
power_supply_uevent

Fixes: 874b2adbed12 ("power: supply: cpcap-battery: Add a battery driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cpcap-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 08d5037fd0521..6887870ba32c3 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -221,6 +221,9 @@ static int cpcap_battery_cc_raw_div(struct cpcap_battery_ddata *ddata,
 	int avg_current;
 	u32 cc_lsb;
 
+	if (!divider)
+		return 0;
+
 	sample &= 0xffffff;		/* 24-bits, unsigned */
 	offset &= 0x7ff;		/* 10-bits, signed */
 
-- 
2.20.1

