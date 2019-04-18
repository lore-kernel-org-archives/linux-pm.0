Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3BDC10F0E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A8720821
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9Sn5ca6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbfDRK2J (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:28:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44386 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbfDRK2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 06:28:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so1445025ljg.11
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wafwrLwOuLKydkAOyUifP9IzxQmxoflkxenKIZVDVeM=;
        b=K9Sn5ca6TLeYDzKn/bN0TDe+nBCMyuOLBWUuArQo7+dzpUKJpvn2vC/VHvLutr05HY
         jRRNPoWivQlbL/nj01AJEJxNa7KKC7mKk5VBoI2GH1i0Dkmyp065vuviSSdxEWPSEb1p
         FSlMikftkKCT4Wf2/u7AIPrWhj3FNe+CUXvvnYQdRbVhIt3gRVotEnbHjwT0o0xpb02j
         iYFLKdVcNVc9w07qzKTzTVJSrHgwGOcD0lj+Z9VOR+PxqmbhiPAG+2rvvcyWmB4847PA
         u5jTfl35ZCmk5DxVBm/itv5LnmOIFEpQOB2jD9VC0KoURpTWIms4TuJJfE6XYSv+plo/
         gZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wafwrLwOuLKydkAOyUifP9IzxQmxoflkxenKIZVDVeM=;
        b=bgRH01sJaT7CwlWyEQVvBnf2abK5CcbUQuX/ol7Srs3Df5QqglS2xVj8Z2aDR8FIBH
         oR66QVmbupnmfHAYPQgZO20ABsY6j7/D7A/1e08D3kcs12iReac3YaLvXecLasARPYlD
         q0UO6ktjKGXMGsuewMH6sWvQbJjCF1Q+rF2Kyp64h4oELgFmgiJ10olI+kYZo29iwXFN
         Yy0UG18b5ToHXlzllWL3RDELBxVXfYRy21abo7VBbpcwIS5sYHjvGJoX8kkBqSjdYvA5
         NraKkLKBvXtM+pA5JiOFcWJsxQvsuGYuzV5pyxw/7SxL6b60HNeehtLGFa6wSgBuU+kU
         fZ7w==
X-Gm-Message-State: APjAAAXEM5VcUjdA8yQY8rCJVN4RBAqhFs0wue5MHoXG18jL2x0YdoVG
        6wvN83HXcgKiS3KtfoM+G3pFvQ==
X-Google-Smtp-Source: APXvYqx8DZQj9MIb9HjHiAJTg3ChuW8LvgA8jYMtqeuoPHn2n+vFcwnvvMiE9fHrTl1DCQzJpnEXyw==
X-Received: by 2002:a2e:3207:: with SMTP id y7mr133196ljy.117.1555583287085;
        Thu, 18 Apr 2019 03:28:07 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l13sm320409ljj.96.2019.04.18.03.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:28:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain
Date:   Thu, 18 Apr 2019 12:27:57 +0200
Message-Id: <20190418102757.1246-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418102757.1246-1-ulf.hansson@linaro.org>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418102757.xaqEi9PDcckFTg94RFe1ttwTbVUKDzIDkEv1alsugY0@z>

If a call to dev_pm_domain_attach() succeeds to attach a device to its
single PM domain, the important point is to prevent following calls to
dev_pm_domain_attach_by_name|id() to fail. This is managed by checking the
dev->pm_domain pointer and then return -EEXIST, rather than continue
calling genpd_dev_pm_attach_by_id|name().

For this reason, let's enable genpd_dev_pm_attach_by_id|name() to be used
for also single PM domains. This simplifies for future users to solely make
use of dev_pm_domain_attach_by_id|name() rather than having to combine it
with dev_pm_domain_attach().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 801f31c87d16..1b026704a8fc 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2512,10 +2512,10 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	if (!dev->of_node)
 		return NULL;
 
-	/* Deal only with devices using multiple PM domains. */
+	/* Verify that the index is within a valid range. */
 	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
 						 "#power-domain-cells");
-	if (num_domains < 2 || index >= num_domains)
+	if (index >= num_domains)
 		return NULL;
 
 	/* Allocate and register device on the genpd bus. */
-- 
2.17.1

