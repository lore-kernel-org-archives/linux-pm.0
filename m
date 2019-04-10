Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03951C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC534206B6
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggzb/CTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfDJIUj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:20:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38291 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbfDJIUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 04:20:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id u24so1119363lfg.5
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2019 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/H33UR2lbvV2qXIXD3WcE8LMFe5SakmefXrAMYhEKWI=;
        b=ggzb/CTEwtPOa+EtvWGn1UyvsYhP3zmyRCmLzifWKfhBrG7ZLkoxFTyA1k1bruzB2q
         yFPqMMZ9y2ejMENPYsMYts6p3phKjY3QVcPX1/PCwI7FdMF8w9KtlnSjPtdFB14Yppee
         KrbYq74mFwtqMUImgXqSDwoWYCCWeKfUKkiRqiVb9xp2R5dthxQGH3mNeymy53KfXegr
         ELA8P9LsUFWS2sp6oqDxidOfLoEtMdBwQ42ccgPTmMphJ9VTtw3fYv0szs1emgzfirAz
         wOBNO+ZQFBfpMVS/TTZ5B9zQWNaDixPizVLTkp+kGPWLS0n/W3RSPDQxwDmC6PyW3X+4
         LWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/H33UR2lbvV2qXIXD3WcE8LMFe5SakmefXrAMYhEKWI=;
        b=SEcpNlsdiST6z7v6PjM06Yzdsg+DDcvYKt0QOk4jP6WJWcVnAQj3oYDpEPmSnr13Hz
         t3qvHb3r/wSswMO6JKyjSaerAvi7JWlxBv9THLYPpbWYbD61RKvWmU8ic2DECA+UpT+L
         D14/tMNj7uIwXfVuX1g/XhSjdLHD4KE8Wp14dYPcRMA2HAM/SfDAJ1RMMF4YZKLOI6Ro
         aDQzB8iQYIDvCA1r/mBp92f6qbUKzLFO1OzeBrEgfWTLJLgilRnqHifEpjsNCPyjVO+V
         JLorApzGv5seH5GjhpW6aKtpj2yEy6lgu2SOtlDJnfsQpqHEEx0MniVswuoTkO0ZZ0LJ
         /FdA==
X-Gm-Message-State: APjAAAV+g6qp2i4m557YwON8LBhU/1DamB8QDGkdPJeejE/sM9H0ssw0
        oP/wjnFMFoNf5j69SYpWvpPE3w==
X-Google-Smtp-Source: APXvYqxj1Ip2ypHe+hw332XrFBM/4q7jYmi3ORQv5pz/nSCfKTbW1Hx9Wf5eP40FkP2S/yccF99zBA==
X-Received: by 2002:a19:c51a:: with SMTP id w26mr21562594lfe.59.1554884436642;
        Wed, 10 Apr 2019 01:20:36 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q6sm3385189lfj.36.2019.04.10.01.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:20:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 0/5] drivers: firmware: psci: Some cleanup and refactoring
Date:   Wed, 10 Apr 2019 10:20:20 +0200
Message-Id: <20190410082025.5989-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410082020.jB7Jo8WQLRbiy6q-3O3KjfJ40SuWy-Blyyt29HVvV4s@z>

Rafael, could you please queue this series via your pm-tree? It has been acked
by PSCI aintainers and it's ready to go. There is no dependency, so the changes
are standalone.

Kind regards
Ulf Hansson

Changes in v2:
	- Drop two patches from the series.
	- Added acks and other tags, no other changes.

Background:
All of these patches have been sent earlier, but part of a bigger series [1].
Instead of waiting for that series to get reviewed and accepted, I have split
it up, such that these trivial independent cleanups can go in as a first step.

The only intentional function change, should be the last patch, where we start
checking if PSCI OSI mode is supported in the PSCI FW and print a message about
it, as that is quite useful information for the user/developer.

[1]
https://lkml.org/lkml/2018/11/29/1801

Ulf Hansson (5):
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  drivers: firmware: psci: Simplify error path of psci_dt_init()
  drivers: firmware: psci: Announce support for OS initiated suspend
    mode

 MAINTAINERS                                |  2 +-
 drivers/firmware/Kconfig                   | 15 +---
 drivers/firmware/Makefile                  |  3 +-
 drivers/firmware/psci/Kconfig              | 13 ++++
 drivers/firmware/psci/Makefile             |  4 +
 drivers/firmware/{ => psci}/psci.c         | 86 +++++++++++++---------
 drivers/firmware/{ => psci}/psci_checker.c |  0
 include/uapi/linux/psci.h                  |  5 ++
 8 files changed, 78 insertions(+), 50 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (93%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

-- 
2.17.1

