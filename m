Return-Path: <SRS0=UY+e=US=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C50C31E49
	for <linux-pm@archiver.kernel.org>; Wed, 19 Jun 2019 11:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7A42080C
	for <linux-pm@archiver.kernel.org>; Wed, 19 Jun 2019 11:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRaeF7GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFSLft (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:35:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45060 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSLft (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 07:35:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so7091679plb.12
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTnYfqTb0OBC2laN/lIv6dOgEAubgbEVPliB3a16uOM=;
        b=tRaeF7GL6QCrXnAixdhrtY1QzqXVvyFk9x5FcLD5r/8ehKDD62SYjbXqBpzZdmSAoB
         XMifUtRyH2BEKQoE9NA96VG7h75HPB/yKZcLlZnKkAVlINTnkjLlXHMzMTv6lT5MTmvb
         KvpIMZzJkrV+QmFMVQj33idXwLkn0pbT7HL41cgPm0i9cRnZlbQFMU/SIuUJAGP/KFSz
         1e/wK5tpK7AhUtVINDYQ8xldmk/rH9fnh12pCw6oprOlnu6Z54nZLIHSMPt2KuGKH+co
         IVqmChrM3Rj++F89aO65fv1VnLzr6YOqvE/nalsQF/4/336JUmTxj3nLXSgLFHhW7XTc
         hzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTnYfqTb0OBC2laN/lIv6dOgEAubgbEVPliB3a16uOM=;
        b=bFtaGu1eeyrEmniYrgQrGOU1TI9AgZbl7ZMy1aFVrhFXn61WFUBHTiB6rmioXUfDin
         9d5RQh5tFX/92t30xbfkgqj4Cj+3y8D/tpJcYUZIJgat9rkxQXufK0inhoeD4LGpyrDf
         nsVI5GUcODwpVT0SZoki8AMORXvg6/mkv2fyxBtB3037yksh7AcR9nDb5jBoEmq22KOR
         UCKc753ycAy/YlDwe1uEAT9jaDwrI3GrTlY6wUMrScbO/Jodt3/9HhHHCzdq3zUtolUL
         Exa3mz/StOB3hdX9wHsDC1RwiGbG9pAVjg5Oh9wAhfJNCbmYL687vNMREb9AEv0di5aM
         eDXQ==
X-Gm-Message-State: APjAAAXyfi41rclKhIfp0QkmPuuPofe7v45ggksuBwh7dbqcXEjxjH4X
        fkeSCbGX3nqh9fVTA+uIf4HzWA==
X-Google-Smtp-Source: APXvYqy8HanHBVPi2DgQgsCccD876Sg8jjuYxE3b1d0PRm0weiWf70PqoZuCINDZCou8yW8BM8qaJw==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr51526563plp.47.1560944148634;
        Wed, 19 Jun 2019 04:35:48 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id c130sm10691784pfc.184.2019.06.19.04.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:35:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] cpufreq: cleanups
Date:   Wed, 19 Jun 2019 17:05:36 +0530
Message-Id: <cover.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

I accumulated these while reworking the freq-constraint series and it
would be nice if these can get in before I send the next version of
freq-constraint stuff.

These are mostly cleanups and code consolidation for better management
of code. Compile and boot tested only.

Thanks.

Viresh Kumar (6):
  cpufreq: Remove the redundant !setpolicy check
  cpufreq: Replace few CPUFREQ_CONST_LOOPS checks with has_target()
  cpufreq: Remove the has_target() check from notifier handler
  cpufreq: Use has_target() instead of !setpolicy
  cpufreq: Reuse cpufreq_update_current_freq() in __cpufreq_get()
  cpufreq: Avoid calling cpufreq_verify_current_freq() from
    handle_update()

 drivers/cpufreq/cpufreq.c | 115 +++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 63 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

