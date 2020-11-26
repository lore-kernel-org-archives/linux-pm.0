Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF2C63697
	for <linux-pm@archiver.kernel.org>; Thu, 26 Nov 2020 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E59521D46
	for <linux-pm@archiver.kernel.org>; Thu, 26 Nov 2020 18:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgKZS5j (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Nov 2020 13:57:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43478 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgKZS5j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:57:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id f12so2625735oto.10;
        Thu, 26 Nov 2020 10:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0F4Sbq1OXjU3nO1RZKiyi6zzwkWC6qG6T+GTEdm5/KQ=;
        b=gyqwIPpRtBSzavY/wfvCQ9NephUJQ7VOdwGUG7sycKSaCulescP497lHlMcT8GAxaZ
         A0dqSb691tThJh7g78sEwYypoRJA73zB9L6tMmOby2rVSTVi6vejXWxNzUzkxF9Erw6B
         TssxNiGO910dhBShGba3f4Fdqv24GU6ZDLJEXveMv56PNCfgcFI057as0l7tkylT4MVN
         LLltbztTMvXQrPvQEJHdf05Y44OnWLlFDwDiOybmvkPeQZmzEiirOZA0j46K7CpSMez7
         aezBMkjwVlwgfoPa1NngzG1EEfPnMjELCuJZKGWksxLis4uxBifk5+3o6egnZJdv/Nzc
         Dm8A==
X-Gm-Message-State: AOAM532aoLFxdVwAyXrx6UgYTjkAt9Z7GNkz5cbYKEfVS4Mo9cMuBuRj
        wDJIPOGGWsizzBw5VcrWIVmPO6+RRScMis+6sOAUDxVQcvs=
X-Google-Smtp-Source: ABdhPJx2y2tfpf4cj1xqUM3oyfvz8D/0r1O8GGAbyp72XG4+Q0vIJM6jP8dEk+G1FKQMbbtksch2jIp5wKqIzOwB/cQ=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr3346649otu.206.1606417058598;
 Thu, 26 Nov 2020 10:57:38 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Nov 2020 19:57:27 +0100
Message-ID: <CAJZ5v0iYMoRORnZerF4Za84aQZ4Dg70rYgfJkOP3rECBNALRbw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.10-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.10-rc6

with top-most commit 05b8955f43536c3e1e73edc39639aac9ae32edd8

 Merge branch 'cpufreq/arm/fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 418baf2c28f3473039f2f7377760bd8f6897ae18

 Linux 5.10-rc5

to receive a power management fix for 5.10-rc6.

This fixes a recently introduced build issue in the cpufreq SCMI
driver (Sudeep Holla).

Thanks!


---------------

Sudeep Holla (1):
      cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK

---------------

 drivers/cpufreq/scmi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
