Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE05C07E9A
	for <linux-pm@archiver.kernel.org>; Wed, 14 Jul 2021 11:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA56128C
	for <linux-pm@archiver.kernel.org>; Wed, 14 Jul 2021 11:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbhGNL35 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhGNL34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 07:29:56 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BEAC061760
        for <linux-pm@vger.kernel.org>; Wed, 14 Jul 2021 04:27:05 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by michel.telenet-ops.be with bizsmtp
        id UzT3250041ccfby06zT3Yt; Wed, 14 Jul 2021 13:27:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3d2d-0017Xv-5e; Wed, 14 Jul 2021 13:27:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3d2c-00A7yD-Hv; Wed, 14 Jul 2021 13:27:02 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] thermal: Spelling s/scallbacks/callbacks/
Date:   Wed, 14 Jul 2021 13:27:01 +0200
Message-Id: <ae38372996a23bb67769e2d62ca170ae9457c4df.1626261946.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix a misspelling of the word "callbacks".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d296f3b88fb98e04..4abd8b8034d71c51 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -285,7 +285,7 @@ struct thermal_zone_params {
 };
 
 /**
- * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
+ * struct thermal_zone_of_device_ops - callbacks for handling DT based zones
  *
  * Mandatory:
  * @get_temp: a pointer to a function that reads the sensor temperature.
-- 
2.25.1

