Return-Path: <SRS0=IxOQ=UR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE21C31E51
	for <linux-pm@archiver.kernel.org>; Tue, 18 Jun 2019 04:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D139E21019
	for <linux-pm@archiver.kernel.org>; Tue, 18 Jun 2019 04:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5ib5yz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfFREOv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:14:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40300 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFREOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 00:14:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so6841033pfp.7
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 21:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcFyPwPNKq29ytAFd305q8rwNyzYsZ7B9zTaK8mx6W4=;
        b=k5ib5yz5jpa3Ba1wvKnJflDfqnsh3w7oWfVsHcIR29wlU3SHF2pEifWYxqhLA97FMe
         7xvOKFA9uwpxaZqS+FNvKvWuh9RiMfbc52D7g62n13fFs3PXWb0iNZ91gU7ikLXDDxcY
         H4K8xc9rKyACph6YvMZ5WoQzAKvhs/sKx3KlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcFyPwPNKq29ytAFd305q8rwNyzYsZ7B9zTaK8mx6W4=;
        b=X1l0JmkZ6uN0yRUGGoDRHPR/zQ+VNTpt10XzV2OeRViHZSeGrfU5uZXgM7XYpkO/+R
         kI6edtSSJySBIDRQoTJoVVF2M8IZ7eNSVQW9x8FnIJPisWfwbRsTi4nyswVxrdA2SsqV
         0/FJdguWmA9D59lugiFWDUjRx3aS8T+jA34gbzLaXnyvNnUWGf0A5YysRxmWGTIqQwi1
         jC4WowiWG3ZVr0NDi1Uv0Y2GuBvJYkY9g8QcGqa162zhn6qwJWDN0imrov8oIPexS7jR
         EIT9IOdUS1tj1Ve5fpPPa/JCVF2D4Lz3dHQamTWinCyZGZp23VVvUfMX4FIhtElaYYeQ
         /Aaw==
X-Gm-Message-State: APjAAAWldsv865b3VaqrzE9Ns6nijqP7NIABKB8sqOv/X6vLQY3AmQAK
        E1fjusRXruEYSgsYVZ4L9I/K8Q==
X-Google-Smtp-Source: APXvYqxGfG3zg+MvrVoA7HRSbr/Kl/ngYm8xn6JzKxClD9kGWk3bbE+WQ/dp1ZzdPxo78Q5ajjWSWg==
X-Received: by 2002:a17:90a:2562:: with SMTP id j89mr2781411pje.123.1560831290393;
        Mon, 17 Jun 2019 21:14:50 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id 25sm13590685pfp.76.2019.06.17.21.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 21:14:49 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Subject: [PATCH RFC 0/2] Use cpufreq-map governor for MT8183 CCI
Date:   Tue, 18 Jun 2019 12:14:32 +0800
Message-Id: <20190618041433.245629-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hsin-Yi Wang <hsinyi@chromium.org>

This series uses cpufreq-map governor for mt8183-cci to improve performance.

Hsin-Yi Wang (1):
  devfreq: mt8183-cci: using cpufreq-map governor in cci dvfs driver

Saravana Kannan (1):
  PM / devfreq: Generic CPU frequency to device frequency mapping
    governor

 .../bindings/devfreq/devfreq-cpufreq-map.txt  |  53 ++
 drivers/devfreq/Kconfig                       |   8 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/governor_cpufreq_map.c        | 583 ++++++++++++++++++
 drivers/devfreq/mt8183-cci-devfreq.c          | 194 +-----
 5 files changed, 649 insertions(+), 190 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
 create mode 100644 drivers/devfreq/governor_cpufreq_map.c

-- 
2.20.1

