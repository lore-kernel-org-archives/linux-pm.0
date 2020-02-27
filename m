Return-Path: <SRS0=WjjV=4P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E31EC11D3D
	for <linux-pm@archiver.kernel.org>; Thu, 27 Feb 2020 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1257324697
	for <linux-pm@archiver.kernel.org>; Thu, 27 Feb 2020 17:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBmmg033"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgB0RJ2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:09:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39290 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0RJ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 12:09:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so40220ljg.6;
        Thu, 27 Feb 2020 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0d2ikdqfSzyCyHKBwzyOB/NzazDViDKr5gLhXg7TE5w=;
        b=cBmmg033uMjVyyiiZzBQ6LYyy+VgUvpGxjDYnJbqsFA5QYw4c0+iBD+yt8NL3fyA0z
         1mhds+EI/xVyu45GOaJ12WhmGvH3xJ4r8WG8AXlPRIgvu/FZ6FEeemJCuIz+Wpwov7m2
         AT1+Y90aYC9YIILe1wY5yqYOvyStCo09yByNLSItCx+gkhB6dGCJJQdX69wXJOpMDx5Q
         kv5wJcBKwIUyY2qFVR8zCsY4CzWjhPtccyMk4ZvVFe5jsVGdiUnTx2fXJKMtD3jvKMqv
         q4UExMEqTsprti7lEPu3ezmD8PS3vUPu4YT4Xbg3onwy2gaYHmDmUzyimxrwl5kgBCt1
         KJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0d2ikdqfSzyCyHKBwzyOB/NzazDViDKr5gLhXg7TE5w=;
        b=iKTLlkwG7+GMd6i4/bGmxIuoMa+C4pZL5Oa1KxPMWNZYqihToYsjrmE94irzvYt3e9
         rqCw5XHcJIKEuKg7YGcQVzbp65b+6PjQSiwUno/GTncBxJ3G0P5Fu5chN56WhOIU52be
         eDVhRXUjYgtYURFcp7A5wLY2byjomg+B8+o7i7RaHBZZNwncR/6uWWNbexQo/kNPapiw
         UCWAzoO6zrila/m04kSwBywhIBvIrghQph6i/Y2pyamCxnBSsyW0tnC7X8c1O+q1zx5I
         NWl/v03GKW0HC35hgUA0fbwn4msA47nGJ02P7fvw8jiAu+F2jAszHgts4wfanjwVoJlP
         nhUw==
X-Gm-Message-State: ANhLgQ23NwqsGVS2ZTaYQOjhbXx9DVHsQTq3cHu8sBaN8ch4WzZaP2Gx
        FO+xb1yuQqo7dYxsHa9lAPLcqQbp
X-Google-Smtp-Source: ADFU+vvgTDPwZpbNLylJZlslLydu4OjybK/HBSQ1vL7bDA6o+HD8DhCJKwHAJcYdOChS2Co1JE4Yaw==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr59358ljp.68.1582823366131;
        Thu, 27 Feb 2020 09:09:26 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j11sm3049513lfb.58.2020.02.27.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:09:24 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RE-SEND v1] PM / devfreq: Replace strncpy with strscpy
Date:   Thu, 27 Feb 2020 20:08:54 +0300
Message-Id: <20200227170854.9949-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

GCC produces this warning when kernel compiled using `make W=1`:

  warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
  772 |  strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);

The strncpy doesn't take care of NULL-termination of the destination
buffer, while the strscpy does.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8494c5f05a73..2011f64bfa3a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -769,7 +769,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->dev.release = devfreq_dev_release;
 	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
-	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
+	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
-- 
2.24.0

