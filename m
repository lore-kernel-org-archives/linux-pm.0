Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7F8C433DB
	for <linux-pm@archiver.kernel.org>; Thu, 31 Dec 2020 06:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA23C22227
	for <linux-pm@archiver.kernel.org>; Thu, 31 Dec 2020 06:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLaGEU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 31 Dec 2020 01:04:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51588 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgLaGEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Dec 2020 01:04:20 -0500
Received: from 1-171-101-114.dynamic-ip.hinet.net ([1.171.101.114] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kur3d-00057y-V7; Thu, 31 Dec 2020 06:03:34 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     tiwai@suse.de, kenny@panix.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PM: sleep: core: Resume suspended device if direct-complete is disabled
Date:   Thu, 31 Dec 2020 14:03:19 +0800
Message-Id: <20201231060319.137133-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HDA controller can't be runtime-suspended after commit 215a22ed31a1
("ALSA: hda: Refactor codjc PM to use direct-complete optimization"),
which enables direct-complete for HDA codec.

The HDA codec driver doesn't expect direct-complete will be disabled
after it returns a positive value from prepare() callback. So freeze()
is called directly when it's runtime-suspended, breaks the balance of
its internal codec_powered counting.

So if a device is prepared for direct-complete but PM core breaks the
assumption, resume the device to keep PM operations balanced.

Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/base/power/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 46793276598d..9c0e25a92ad0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1849,6 +1849,10 @@ static int device_prepare(struct device *dev, pm_message_t state)
 		(ret > 0 || dev->power.no_pm_callbacks) &&
 		!dev_pm_test_driver_flags(dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 	spin_unlock_irq(&dev->power.lock);
+
+	if (ret > 0 && !dev->power.direct_complete)
+		pm_runtime_resume(dev);
+
 	return 0;
 }
 
-- 
2.29.2

