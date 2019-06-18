Return-Path: <SRS0=IxOQ=UR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7919AC31E51
	for <linux-pm@archiver.kernel.org>; Tue, 18 Jun 2019 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52726206BA
	for <linux-pm@archiver.kernel.org>; Tue, 18 Jun 2019 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiJtJdWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfFRJR3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:17:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46750 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbfFRJR3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 05:17:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so8652211lfh.13
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 02:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJanYe36yi/CmGKqaCrG1otgHpkv5KX5H3hS1IRh33g=;
        b=RiJtJdWoPD8zAWLrRuFlXYtFDm2X0N6/21V3ItMvPDDbdX9jIMVD2NDDE50Evpd7c5
         NP91pnFt1FTIfxm71pG+sw/GLrffxSGkjN5FKLqFCZzFnGDzFCMG19dHtlagjO53JVr/
         80CRzxaL1cN4BtODGKh0tEiNCVJAKGD2hlezCr0t0JeIi0cngbJDXFeAYYfVdH4xapR0
         1nFQQDgIcTIQ1+QHAOYncbIigzuTHyGJIGn5wK5x+yFT1HBY5GkQFMYtVVGMYtPf8zk4
         6jr/zmJsnunS/onnUn73MCCqmxxeoLyyYlMOV/H4O9N6tMze7daUZL+ggyMfqPaVWAIO
         OQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJanYe36yi/CmGKqaCrG1otgHpkv5KX5H3hS1IRh33g=;
        b=CrsmqFKUTtGqyPnofouwmASApisJkYL/dQyGrccz+Rq7A7gKhO/TBsd9XMoeHONzy7
         YB0QOG6y7UVKRbK4zm1NMvCh5jCQJOVHITNFvZL1b4sG1SUNFhELJhZpDd0ToVD9okD3
         XOw7ou5QPVMv7U2q5AJp7aecuF+9n7erYkG7TPUzSXhK/yXe7uc4IXA4rGARORoyh+ku
         dKf5WiJsgWj7bFEh0cNBp3aNJG2DBfpPDe8Bv/ZB6ISo3CUVU+jINn8dKfMzSV0rhLxQ
         To2HxP5UNi+WH0Y5fnmeBDBrkPN5XEY6B9a/NjUWjWHfcxt9WBDDjs1LQCQ2MIXVZK4Y
         fi0Q==
X-Gm-Message-State: APjAAAVzRWJzZ+ENxjp5+bQQd77lIk55t7n9Y2pHnDxSNtHYS2LULikZ
        6KSbVF5pzPObIBEtNMAD8m/bEDM9o2s=
X-Google-Smtp-Source: APXvYqzZIY8KYRJ7T3S77TJbee+KXLTlqzbOJRplLldZUlUxRX5u3jYNnsAy45fO6GHH7GsxDOvD1w==
X-Received: by 2002:ac2:482d:: with SMTP id 13mr14129676lft.132.1560849447214;
        Tue, 18 Jun 2019 02:17:27 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b9sm2497444ljj.92.2019.06.18.02.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jun 2019 02:17:26 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        evgreen@chromium.org, dianders@chromium.org,
        seansw@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v2 0/2] interconnect: Add path tagging support
Date:   Tue, 18 Jun 2019 12:17:22 +0300
Message-Id: <20190618091724.28232-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SoCs that have multiple coexisting CPUs and DSPs, may have shared
interconnect buses between them. In such cases, each CPU/DSP may have
different bandwidth needs, depending on whether it is active or sleeping.
This means that we have to keep different bandwidth configurations for
the CPU (active/sleep). In such systems, usually there is a way to
communicate and synchronize this information with some firmware or pass
it to another processor responsible for monitoring and switching the
interconnect configurations based on the state of each CPU/DSP.

The above problem can be solved by introducing the path tagging concept,
that allows consumers to optionally attach a tag to each path they use.
This tag is used to differentiate between the aggregated bandwidth values
for each state. The tag is generic and how it's handled is up to the
platform specific interconnect provider drivers.

v2:
- Store tag with the request. (Evan)
- Reorganize the code to save bandwidth values into buckets and use the
  tag as a bitfield. (Evan)
- Clear the aggregated values after icc_set().

v1: https://lore.kernel.org/lkml/20190208172152.1807-1-georgi.djakov@linaro.org/


David Dai (1):
  interconnect: qcom: Add tagging and wake/sleep support for sdm845

Georgi Djakov (1):
  interconnect: Add support for path tags

 drivers/interconnect/core.c           |  24 ++++-
 drivers/interconnect/qcom/sdm845.c    | 131 +++++++++++++++++++-------
 include/linux/interconnect-provider.h |   4 +-
 include/linux/interconnect.h          |   5 +
 4 files changed, 129 insertions(+), 35 deletions(-)

