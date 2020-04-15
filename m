Return-Path: <SRS0=3FgU=57=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A6DC3815B
	for <linux-pm@archiver.kernel.org>; Wed, 15 Apr 2020 12:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABE2214AF
	for <linux-pm@archiver.kernel.org>; Wed, 15 Apr 2020 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586953074;
	bh=czNOZ/O19Y/a5rd/bkVz1OVazGaWvhmfaQGyVFf4l9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dItquYZunJCgsHSjc1o5CjiZ07N6sBn29gIFVMNU2cMRkOw0aRqmfvDwoX0e6tDJz
	 +Pe/vZislGMfM/R2FHkyrFeWymj/b5Hdx7HJeuPK7lCt/gI89JSNqrjdcmmXqNZ+h3
	 3asmBfOv6Zyi4923IKXMwdrnMLR7hXRcbY8uJPWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368794AbgDOMRf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406546AbgDOLq1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Apr 2020 07:46:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC63820775;
        Wed, 15 Apr 2020 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951186;
        bh=czNOZ/O19Y/a5rd/bkVz1OVazGaWvhmfaQGyVFf4l9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HHVNO6VWPK03en7PlBzbOT5yDFxYNxfyuhc15uHwhDlAQ0t1NTTWHbGqM5VJ77Ku
         HJnqh4P8AD6wQ7cXQr4Uw3MSF3nb9ymo05hr9oXwaw7C/ThUILXLablyboU31WHxa6
         oWkE88QOCs1TKn+dlgNMr8DmvIo+Nyhw178AL0o0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        "Andrew F . Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/40] power: supply: bq27xxx_battery: Silence deferred-probe error
Date:   Wed, 15 Apr 2020 07:45:45 -0400
Message-Id: <20200415114623.14972-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114623.14972-1-sashal@kernel.org>
References: <20200415114623.14972-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 583b53ece0b0268c542a1eafadb62e3d4b0aab8c ]

The driver fails to probe with -EPROBE_DEFER if battery's power supply
(charger driver) isn't ready yet and this results in a bit noisy error
message in KMSG during kernel's boot up. Let's silence the harmless
error message.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index f022e1b550dfe..ff02a917556a9 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1887,7 +1887,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat)) {
-		dev_err(di->dev, "failed to register battery\n");
+		if (PTR_ERR(di->bat) == -EPROBE_DEFER)
+			dev_dbg(di->dev, "failed to register battery, deferring probe\n");
+		else
+			dev_err(di->dev, "failed to register battery\n");
 		return PTR_ERR(di->bat);
 	}
 
-- 
2.20.1

