Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73D1C10F0E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955DA20821
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDzFggAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbfDRK2E (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:28:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35846 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388301AbfDRK2E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 06:28:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so1233449lfi.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3gfH/JykxYqyNODMHJRTCz28W0rt6sVKpWMKmlcLa0g=;
        b=bDzFggAEGO3gW/BNfAQqBub+y1/YofP2uesJU2aripwzJm1ek+6H6nnJxPZR+AwNd6
         BFgY0z7Vq6lUhExyez4m4CZX7/LQM0nbJwh7O3DnwOVwUaw/hic9EWaswSs8/qE7uSQ7
         /HGC0QtMkbWJa8aBkaDSIEO9YHeSdlv+wUdz7Wlwh5NmuHPMtqnjPwGuFaDUjqdnrA0l
         RG36RA0DE3bdQfU1cCWDhz6gtB3uRBhJyoXgCK7KntcWU75b6JsXhKjz1sdZQBSURtgW
         CTpateCWhDuLFaP8PMel7LCUDtBq49B9qjPUJzKlaDTkJqIv7WajvM8wBpKca2lAz43b
         oJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3gfH/JykxYqyNODMHJRTCz28W0rt6sVKpWMKmlcLa0g=;
        b=eU8ZabONIOt7OOhclMou4UtidPT2CCaNjzEKtpkCoQM5Kd4jjle6XvLhusrtF0v69O
         JrfkBI9ER/gJhtSZxXn6Z3ou4tudQkPndARRxkME/FQNsgn8lYKxVv5U/4McKew+BTi4
         mHyU66FG9ZncFQQc7IzV7ZJOLJg8KrdOHFYxQgEFVVeIeDEt8p4j/3CaFZnCSCjThscC
         pfsYkczg9YbxudGTL/i+Q1w/q6+/ehlw/o4KHzi+7g+B7ZRYMAZFY6ljSlPUS89Mumsg
         ngp+COnniY0VosxRczJvfEPVHshZmi9k1hr0AhRXIiuTxPQm7hFXkjFhwaucg9TpFsod
         qNQQ==
X-Gm-Message-State: APjAAAUOjVXhTHNbfCBGX4qe+zdl2vS2wrOu47DWnMMMyJ7BBrS8AAXY
        ykEND+sivl/LyG+x8ZQJ59LrHaDnn4k=
X-Google-Smtp-Source: APXvYqy0HmQvgHWnRoeyNXiHx4H5QwoDLvnZDnOXgt1KG6894LmpVJ0o9lEPamOUcXKwvLMSUQxYog==
X-Received: by 2002:a19:7005:: with SMTP id h5mr26334193lfc.143.1555583282594;
        Thu, 18 Apr 2019 03:28:02 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l13sm320409ljj.96.2019.04.18.03.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:28:01 -0700 (PDT)
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
Subject: [PATCH 0/3] PM / Domains: Improve support for multi PM domains
Date:   Thu, 18 Apr 2019 12:27:54 +0200
Message-Id: <20190418102757.1246-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418102754.pb40QgNZdgfEDApCperfq9eAWS27DfxwDkD7QgcJde8@z>

It's been a while since the introduction for the support for multi PM domains
per device in genpd. In this small series, a couple of different improvement
are being made to this code in genpd.

Ulf Hansson (3):
  PM / Domains: Don't kfree() the virtual device in the error path
  PM / Domains: Allow OF lookup for multi PM domain case from
    ->attach_dev()
  PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM
    domain

 drivers/base/power/domain.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.17.1

