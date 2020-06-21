Return-Path: <SRS0=YAo6=AC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD16C433E0
	for <linux-pm@archiver.kernel.org>; Sun, 21 Jun 2020 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE1224880
	for <linux-pm@archiver.kernel.org>; Sun, 21 Jun 2020 08:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgFUIS7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 21 Jun 2020 04:18:59 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:31855 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgFUIS7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 04:18:59 -0400
Received: from localhost.localdomain ([93.22.149.109])
        by mwinf5d20 with ME
        id tkJw2200D2MrWsD03kJxC6; Sun, 21 Jun 2020 10:18:58 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jun 2020 10:18:58 +0200
X-ME-IP: 93.22.149.109
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drivers: base: power: mark 2 functions as __init to save some memory
Date:   Sun, 21 Jun 2020 10:18:54 +0200
Message-Id: <20200621081854.882705-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'early_resume_init()' and 'late_resume_init() 'are only called respectively
via 'early_resume_init' and 'late_resume_init'.
They can be marked as __init to save a few bytes of memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/base/power/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 977d27bd1a22..a97f33d0c59f 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -265,14 +265,14 @@ static struct notifier_block pm_trace_nb = {
 	.notifier_call = pm_trace_notify,
 };
 
-static int early_resume_init(void)
+static int __init early_resume_init(void)
 {
 	hash_value_early_read = read_magic_time();
 	register_pm_notifier(&pm_trace_nb);
 	return 0;
 }
 
-static int late_resume_init(void)
+static int __init late_resume_init(void)
 {
 	unsigned int val = hash_value_early_read;
 	unsigned int user, file, dev;
-- 
2.25.1

