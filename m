Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CAFC10F14
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF84E206B6
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHIYi9ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfDJIUq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:20:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42390 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfDJIUq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 04:20:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so1100747lfc.9
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2019 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wXapuDJ/TxdZdSmwteecFqdWBuQB0h5GI4Aq0atblIM=;
        b=rHIYi9ba92gg8LkA31/7tWSmN9BXPCv4fviYMZe1iSFxfd6GajN5HaoOMcKMj56Nl2
         Q+VQP0P0fcCiyIHQcUv3VuufwXB5YDzUOrbe/olGwQoIRC3Qbq/2gzL14A62daskwX0R
         F+YJAxbPsh6EaLOhueGYvhaHloVSpkyLXcm0H6sbRg5COodlIaq9yB1HLZDeHDZYudu7
         FSWO0M4QMkjflN1bIF20Et0VFSYnT/YuRlaLJ8ZTlyH3kFkc0Z73Ff2oiarV0PQlJMGP
         7DAvpzBVUIsbIzyhjiDbthAMuTse3GD4kzZKkZ5hDgL3EVQLiQTMOqeZQ3AiWvj5gE5H
         SWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wXapuDJ/TxdZdSmwteecFqdWBuQB0h5GI4Aq0atblIM=;
        b=Rl/5FcHfBNXqaHrqMs7jRw0Q2O7tdSgd0mWD3pVnC3BIHj+BrT7MK0cX+4FbwpX8Un
         wqs/inPnQDY4xMZfvDM2mriDmmCsn9ICOcJ+gTY3Wsdtc5uxAuROuE1elE+gj+MqT+Sr
         Z+kTbsPSbbBYMi5smEWhKSUW5em0nN0pKkAN3X2EKmorHy1k0bwvjnozJKvUTGm67plZ
         CctGkO9K+hWqZITtusUbsUpb+RS70Lrhb6UZ4oilzaLwsXh69G8wK3iUpytTZZl/ZWEK
         er3aeJ6edzwZLk/ACiustIJ+AvEgdFAQ4w1iRvPu3NaiKO4vdLkeMNT+Yn5RdGIFnicU
         Of/A==
X-Gm-Message-State: APjAAAVdjmft3tZqpsBcCRm1B13bXTINSSLlqvFIpNNQPtX/Vz305xMR
        h7X6Us9zZnZcTH6bgXd1Yluf0A==
X-Google-Smtp-Source: APXvYqyryS1q15a6d0UsZY2G/O7PEH4B07acNQrCSSgxP4ck3B8hMWAB5vl6cz5C1FZ2tb6e/Um+Mw==
X-Received: by 2002:ac2:4242:: with SMTP id m2mr1249881lfl.142.1554884443988;
        Wed, 10 Apr 2019 01:20:43 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q6sm3385189lfj.36.2019.04.10.01.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:20:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 2/5] MAINTAINERS: Update files for PSCI
Date:   Wed, 10 Apr 2019 10:20:22 +0200
Message-Id: <20190410082025.5989-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410082025.5989-1-ulf.hansson@linaro.org>
References: <20190410082025.5989-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410082022.AfR7jFDjlc45sVlmazIGdv69PxCjQXNYmt0pw-NZxp8@z>

The files for the PSCI firmware driver were moved to a sub-directory, let's
update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a419acaa01c5..97dcec6fc877 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12257,7 +12257,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1

