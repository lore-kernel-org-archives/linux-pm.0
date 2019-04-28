Return-Path: <SRS0=Zmry=S6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE8FC43218
	for <linux-pm@archiver.kernel.org>; Sun, 28 Apr 2019 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDF6206BB
	for <linux-pm@archiver.kernel.org>; Sun, 28 Apr 2019 09:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oc9EakPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfD1Jvh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 28 Apr 2019 05:51:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35575 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfD1Jvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Apr 2019 05:51:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so11028940wmd.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2019 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5xrv+roHMyTgrScP6HnGJBXKE2TsH49nxvl3B7+wocw=;
        b=oc9EakPlbe5w9lqeY60aCtQzpTdktaayjwRlelIJAIMQAftSolF/3kS30WeQ7splSu
         HHlOQuqn91A7CjgOceu7YX66T3rG++7FVBzd0k2Mm/77lFGS8PJp5BOLpZCU1jXcpU/n
         /hbUYaVa6RONgxLSodmuFqGIQWyD5U32AsrFMaBmDm7wukPFNI0gST4fSfPXQAORkF/V
         KyPS28AUMyXfDwt6KiPROmHqb3KaFx1xMDq0WOezv4PPvfR21EJyF247AF/o0O8Qxw8M
         ophYnf+kQTy5StyjBe2EN5Te3yYYsyLEv97leNJAFUDf9pDItDlEjNv85J9sf8b6SnEE
         gUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5xrv+roHMyTgrScP6HnGJBXKE2TsH49nxvl3B7+wocw=;
        b=mYElUo2Im/YfLv2Alb9kfjvAWyQ1hQwWqp2b45WNnf6sjCaft4tbshB1T86DnAtNi5
         0JGUF1HxWwWiE7Z9SGG3Wa0VF+pdW/AsMwsSw8XuBJ1pMeCC5ohRMj8x0YeWPKd+ULMq
         ZccISl5U56iyoWvoLy5aXJGPNJlDhikwFbJWfzEDaNalG26ik/kiFHqEq+CczdFdEndL
         JYafyzcZrUQLPozN88BBx4nzxYF2Ko+kpi0IfGCLgQO2jRQncNHALoSz01KCEGIH0+Ca
         SdMDcr0QwLvYCInipzDINWP8eeyZsr84XWrgoGUY5j7v1o2ktxn3J9cDQDThbaYc2hId
         gaVg==
X-Gm-Message-State: APjAAAXmiQ5l2ialPL6SXLA4joCJEdxHBewtnvkVQR/IRrBpTWjznNN6
        H0kSoXhPkiuaN5KHB32CFgR12A==
X-Google-Smtp-Source: APXvYqyy0qXN239tAcMx3DIkKN75/TXnJB9pmEsLgqqHL8DRggYiFw23I7hrX2ZNzGmfQyjT5ozojQ==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr14472087wmi.75.1556445094884;
        Sun, 28 Apr 2019 02:51:34 -0700 (PDT)
Received: from clegane.local (86.204.129.77.rev.sfr.net. [77.129.204.86])
        by smtp.gmail.com with ESMTPSA id e5sm1560675wrh.79.2019.04.28.02.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 02:51:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Subject: [PATCH - resend 2/3] thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
Date:   Sun, 28 Apr 2019 11:51:04 +0200
Message-Id: <20190428095106.5171-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428095106.5171-1-daniel.lezcano@linaro.org>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190428095104.MkpkhFdS1XGErgzilvQYvliYh7SxuCnZB19Gopi2dEk@z>

For license auditing purpose, let's add the SPDX tag.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
---
 drivers/thermal/cpu_cooling.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 42aeb9087cab..b9d152a5f7ba 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  linux/drivers/thermal/cpu_cooling.c
  *
@@ -8,21 +9,6 @@
  *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
  *		Viresh Kumar <viresh.kumar@linaro.org>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/module.h>
 #include <linux/thermal.h>
-- 
2.17.1

