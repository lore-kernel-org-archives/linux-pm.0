Return-Path: <SRS0=Z2ey=53=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82EFC2BBFD
	for <linux-pm@archiver.kernel.org>; Sat, 11 Apr 2020 00:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11B021744
	for <linux-pm@archiver.kernel.org>; Sat, 11 Apr 2020 00:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbgzlwyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgDKAU0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Apr 2020 20:20:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45010 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgDKAUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 20:20:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so4025674wro.11;
        Fri, 10 Apr 2020 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evS1Gd0mYBhXTAjCV3dzUcM/sTYhBLIlQOkalJ0AkMA=;
        b=FbgzlwynoTQPwao9PAPWW39jzj/Gzj1N394UpRJZ9TvXyJIxAU7+4rmoMaf8fFLE2r
         RcQg667B2vZGgXiY7F7cOasoi786I/UqhvdCVDa7ALXNae63/kQMStGL0URM90FPMoSa
         DJ1K0kNkDsGKPBhxEzFQKO3MqDjwFLAVJCsWYoUj6HCiMX1t40JcAQ8N4Y+VX7QOxzWy
         6I4qnvklmwEe7+xnjnkWsqxPzKwxng8L+eJQiQKOw0qYEDrskuPZW2wO43TUOG39a9MZ
         CggT5hiqZx81ok2WmPvig0OWjlA6Fr+El15Hxb/N5w+O35E2EFp9nobnyhe1dhGC85iw
         AAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evS1Gd0mYBhXTAjCV3dzUcM/sTYhBLIlQOkalJ0AkMA=;
        b=icEOEpsH0GZrtL61Ohy7hBnHkH2fcllia8XPWhHjrGJquBDBdfh5FKIHB69MZ+JXdg
         339Qgg6XpYW4atcP11D5Mk6r32K13wpv0KFeBvhnw8UCzigyDx+D4YkCmcl31dLQtltu
         Ypes4Uz/J1MemmJhQqGPQdKlZbulW0EvN8HOo7fjXUGyWkjAm/sEC8EtsY4kIxNzqpvq
         YFPyWMnJcWR4YYE5I2cm22irUXDpY1cDuRjIchx6xcV0p4aQM1lZBwp774rnU76x4k1w
         C5sqd4dlNXwHrM1aP1WCvwJrs3mGOmnN67KEEo2z9x6XqFaPrENy0IQyCych92EIeio7
         j/FQ==
X-Gm-Message-State: AGi0PuYLyz0liSPt45OoiQfFu8thSQI5mM5OoGXKwivMDcaqP9DuXU0z
        CFx5m2xwjw/h+ku0TxhceEUMMLJa9jaY
X-Google-Smtp-Source: APiQypL9+Y3FnS59lypT6b279qCBb89m8eNsC0cDe/afDwiChzijzhfuMVss+6+KaUKZ2JovWOY2RA==
X-Received: by 2002:adf:f790:: with SMTP id q16mr6690593wrp.94.1586564422500;
        Fri, 10 Apr 2020 17:20:22 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-14-153.as13285.net. [2.102.14.153])
        by smtp.gmail.com with ESMTPSA id b191sm5091594wmd.39.2020.04.10.17.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 17:20:22 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp))
Subject: [PATCH 8/9] power: wakeup: Add missing annotation for wakeup_sources_stats_seq_start() and wakeup_sources_stats_seq_stop()
Date:   Sat, 11 Apr 2020 01:19:32 +0100
Message-Id: <20200411001933.10072-9-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200411001933.10072-1-jbi.octave@gmail.com>
References: <0/9>
 <20200411001933.10072-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sparse reports warnings at wakeup_sources_stats_seq_start()
	and wakeup_sources_stats_seq_stop()

warning: context imbalance in wakeup_sources_stats_seq_start()
	- wrong count at exit
context imbalance in wakeup_sources_stats_seq_stop()
	- unexpected unlock

The root cause is the missing annotation at
wakeup_sources_stats_seq_start() and wakeup_sources_stats_seq_stop()

Add the missing  __acquires(&wakeup_srcu) annotation
Add the missing __releases(&wakeup_srcu) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/base/power/wakeup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 27f3e60608e5..41ce086d8f57 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1092,6 +1092,7 @@ static int print_wakeup_source_stats(struct seq_file *m,
 
 static void *wakeup_sources_stats_seq_start(struct seq_file *m,
 					loff_t *pos)
+	__acquires(&wakeup_srcu)
 {
 	struct wakeup_source *ws;
 	loff_t n = *pos;
@@ -1132,6 +1133,7 @@ static void *wakeup_sources_stats_seq_next(struct seq_file *m,
 }
 
 static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
+	__releases(&wakeup_srcu)
 {
 	int *srcuidx = m->private;
 
-- 
2.24.1

