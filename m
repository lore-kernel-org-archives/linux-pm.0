Return-Path: <SRS0=Zmry=S6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F30EC43218
	for <linux-pm@archiver.kernel.org>; Sun, 28 Apr 2019 08:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1516B2075D
	for <linux-pm@archiver.kernel.org>; Sun, 28 Apr 2019 08:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XmJ4T4p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfD1Iyw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 28 Apr 2019 04:54:52 -0400
Received: from m12-13.163.com ([220.181.12.13]:46392 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfD1Iyw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Apr 2019 04:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=91IVm
        mFNSsbC8jMuap9NKAy6qR0joeIxALhIy0WOl1U=; b=XmJ4T4p08RSajlXZKhqsy
        apboWWkwkohtVdvupqQklw8N81sabM/r+LsPJdyi+sYrgBdEGelO+E+TmVHCOSJ3
        J6mHpr7wSu0RVHN1UqXfQKzc9LvikAbKObNPERUQfC2yDZs49OaZ4pnyBH8obZpm
        7M5oVj55bZ6yVQrNUbw8wE=
Received: from DONGJIAN-NJ.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowAB3znlLasVcfIBrAQ--.11653S2;
        Sun, 28 Apr 2019 16:54:38 +0800 (CST)
From:   dongjian <dj0227@163.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, dongjian@yulong.com, huyue2@yulong.com
Subject: [PATCH] cpufreq: Fix centrino_setpolicy to centrino_target
Date:   Sun, 28 Apr 2019 16:54:17 +0800
Message-Id: <20190428085417.16156-1-dj0227@163.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAB3znlLasVcfIBrAQ--.11653S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryftrWfAF1UtFW7KryDZFb_yoW3Xrc_ur
        1Sgr47Wr45u39rZrnxur1rX34aka4xuF1xXF1vk3sIqa42yry5Zw1kZry8Zr1fJrWUAr9x
        C3Z09w4FkF45tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8XdbUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiTA6k3VSIeyxihwAAsV
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: dongjian <dongjian@yulong.com>

The code is using centrino_target rather than centrino_setpolicy.

Signed-off-by: dongjian <dongjian@yulong.com>
---
 drivers/cpufreq/speedstep-centrino.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 7d4a315..26fab0c 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -412,7 +412,7 @@ static int centrino_cpu_exit(struct cpufreq_policy *policy)
 }
 
 /**
- * centrino_setpolicy - set a new CPUFreq policy
+ * centrino_target - set a new CPUFreq policy
  * @policy: new policy
  * @index: index of target frequency
  *
-- 
1.9.1


