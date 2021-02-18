Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5967DC433DB
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 07:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A5264E28
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 07:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhBRH05 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Feb 2021 02:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhBRHVm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 02:21:42 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB3BC061574
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 23:20:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p21so589816pgl.12
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 23:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XltfFnhdkkmxRNwfTTBqDgU1r3DsmbFDawD/e5Vx2mw=;
        b=qsxOQs42wFe/LMyrH+79JFIj/Zs5gFLIDEz6C6QSlegIJesgU/ccyYK3+PXam9LE6b
         wKIgvvHeLcuoGzUv1FDnIH3JQYdgz9DLbd9I/cpyeSsK327FfYnFQ2s0ouYLznnIAmgs
         R9b5h1fcF9KqN6RGAMz8E2YllyLBZ9LxXEmggNHRWY6bf11emddKsPEJ/vo5aDvnV3iU
         had2PccHkyAmg+esL2CsuaVlWLKxGzJQegmETJ/GxtHF9JHtzOsIOHJ9b9gCnjWCKnwS
         0iHU7ikggkaVCqmVp7n7cAYkLCex5snG/QRtvMTJWrETnS7pmseYpTWh3GnYDvDJNlGY
         Xpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XltfFnhdkkmxRNwfTTBqDgU1r3DsmbFDawD/e5Vx2mw=;
        b=n+cVKKUNBRcx29WOJXrnm6CWLeFsjqoQ3QvOU+yo7aatCLXOBpxNCgnWNNnNnmHaEB
         kid6boJ4s37dS+RyCKP6GdyIixLhjfMUd4iPT3A1FXjObAGnjcKdVg+IEtHaV+64QtFM
         786XnK1/MVT/6NNtFgxanNVEGZ6qcBDAAuLX0QhmiAt4eYGpvWgVJwWFCgU+8Cm0aGH6
         Th7Cmc2fAJHAzfWIhV/EkSIMzkcDZm2gtmyIpluyxzgfAJfPZcZdNT9z9gFvovfXg2vu
         yTgiynTNptb7CcQ/otwEMvno0cJ1xPAE4nShgxXzPRFBGymmHkqysZAONYym/R5wh2hE
         SfMg==
X-Gm-Message-State: AOAM531+hBR/GplSZVimcFJRALGIthQ7oGudnPtJVRmxbqfpqE+G1Jyd
        TN/bOWXcF1Epw4K0sdhsbDCNgA==
X-Google-Smtp-Source: ABdhPJwFgd5ZMI6ND+xKAPUg64MvAxXz40nTve6E1hevM1qs5dCa03vLuRQEMxfNbxfbAmyjjYlxsg==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr2994282pge.156.1613632857678;
        Wed, 17 Feb 2021 23:20:57 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id x8sm4282110pjf.55.2021.02.17.23.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 23:20:56 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:50:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.12
Message-ID: <20210218072055.tfnwyv3hzcrgtopx@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains a single patch to fix an issue where a frequency
update may get skipped.

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit 86ad9a24f21ea7aac7deed06fe9556392568d88a:

  PM / devfreq: Add required OPPs support to passive governor (2021-02-04 16:48:16 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to de04241ab87afcaac26f15fcc32a7bd27294dd47:

  opp: Don't skip freq update for different frequency (2021-02-18 12:31:08 +0530)

----------------------------------------------------------------
Jonathan Marek (1):
      opp: Don't skip freq update for different frequency

 drivers/opp/core.c | 8 +++++---
 drivers/opp/opp.h  | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)
