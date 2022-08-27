Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEB2ECAAD2
	for <linux-pm@archiver.kernel.org>; Sat, 27 Aug 2022 13:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiH0NlI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 27 Aug 2022 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiH0NlH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Aug 2022 09:41:07 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E719C0E;
        Sat, 27 Aug 2022 06:41:06 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3378303138bso97685207b3.9;
        Sat, 27 Aug 2022 06:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=3S8GLscL1BbPQnxNrAIv/bfGmf54xyMLKMaxv/NlX1Q=;
        b=aviSgfyNf7lhDpU7OOeim4ctkReS5o7YZnDQq33j0/oGP8crZMl/auUr7tne0yaN7Y
         2Bi337WTQrgPVqH68IBIOj+EkgBYvxQV4l9bC/ykCxhRmo/sEipESXJRgBZsiossOQmc
         dX5Vt9R3ZyvmMPCM/IiviUKfCTN6PNP8Yi8ifaYmScG+b8TaiE3u0RoHt3oaQGlNi0W9
         r1SlW8SpiihA0qOc9sJcZimFPbsTugMn7FauH58XkD09OwS2gRYEuaN6R4VF4Iqsn5fx
         B9kbi8AmjFeUvjC0+sJejF/PXWcIQGYVgwZWVcnT5edmmVYNXhNJX3IkXc/zDwBPqMbq
         wQ0w==
X-Gm-Message-State: ACgBeo2zCQfPf7u5WkZZSoOp0/FlTgRkWAtOB9ZVkLAHSw0I/8IqadxH
        MSL+AlBNWmAlu1+uL+DyKjvpJP5ADr4kUca4knZ981KJ2aE=
X-Google-Smtp-Source: AA6agR5loCahhw7TDcxb8MojEFJLKVXd+hua3jJ2Sv5dARJnF4eyAn5Xj1RYC67Zt4YfwcsthabCF3JrpEFdzTid2zY=
X-Received: by 2002:a25:c204:0:b0:692:72b9:a778 with SMTP id
 s4-20020a25c204000000b0069272b9a778mr3399264ybf.81.1661607665415; Sat, 27 Aug
 2022 06:41:05 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 27 Aug 2022 15:40:54 +0200
Message-ID: <CAJZ5v0jN76n5aVoh5C+awG5N0ewzp52HCikW-H=L88EMT=DTZQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.0-rc3
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
 pm-6.0-rc3

with top-most commit 6ca7076fbfaeccce173aeab832d76b9e49e1034b

 cpufreq: check only freq_table in __resolve_freq()

on top of commit 1c23f9e627a7b412978b4e852793c5e3c3efc555

 Linux 6.0-rc2

to receive a power management fix for 6.0-rc3.

This makes __resolve_freq() check the presence of the frequency table
instead of checking whether or not the ->target_index() callback is
implemented by the driver, because that need not be the case when
__resolve_freq() is used (Lukasz Luba).

Thanks!


---------------

Lukasz Luba (1):
      cpufreq: check only freq_table in __resolve_freq()

---------------

 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
