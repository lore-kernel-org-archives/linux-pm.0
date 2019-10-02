Return-Path: <SRS0=v0US=X3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111FC4360C
	for <linux-pm@archiver.kernel.org>; Wed,  2 Oct 2019 19:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B02D21783
	for <linux-pm@archiver.kernel.org>; Wed,  2 Oct 2019 19:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfJBTZX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:25:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51694 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfJBTZW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 15:25:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C92FC1A069D;
        Wed,  2 Oct 2019 21:25:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB3AE1A0698;
        Wed,  2 Oct 2019 21:25:20 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C4572060C;
        Wed,  2 Oct 2019 21:25:20 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 3/8] PM / devfreq: Set scaling_max_freq to max on OPP notifier error
Date:   Wed,  2 Oct 2019 22:25:06 +0300
Message-Id: <bee69d4635f83d8812fedbc108beb6c51ac9d4e7.1570044052.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1570044052.git.leonard.crestez@nxp.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1570044052.git.leonard.crestez@nxp.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq_notifier_call functions will update scaling_min_freq and
scaling_max_freq when the OPP table is updated.

If fetching the maximum frequency fails then scaling_max_freq remains
set to zero which is confusing. Set to ULONG_MAX instead so we don't
need special handling for this case in other places.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 32bbf6e80380..3e0e936185a3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -557,12 +557,14 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
 	if (!devfreq->scaling_min_freq)
 		goto out;
 
 	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->scaling_max_freq)
+	if (!devfreq->scaling_max_freq) {
+		devfreq->scaling_max_freq = ULONG_MAX;
 		goto out;
+	}
 
 	err = update_devfreq(devfreq);
 
 out:
 	mutex_unlock(&devfreq->lock);
-- 
2.17.1

