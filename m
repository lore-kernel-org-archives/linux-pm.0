Return-Path: <SRS0=bbN6=27=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E59C33CA2
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C4B20721
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578651821;
	bh=tdMN/tJOAa9UpC1JBkHVFxNqh5Ppy7K4tbhwbRhLBnI=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=f76BlF3eZRi5XvqpTDfygv8tuxo3QgsA0cjAY459kNtoJ770MYhqXKCL6tXRK3j89
	 UyyRcWiz+CTkyICi8gfnFsbB8cZ1qSfVeTMYSaD/mhJ4Tmc6bH/utGYZqn6Lgb76p9
	 6h/On8p19JErFTCwGZTQpV34tz/SiwcIml7Gdmrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgAJKXl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:23:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34985 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgAJKXk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:23:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so1467583oto.2;
        Fri, 10 Jan 2020 02:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rU/nzWaAkvUKYiZR6iZ7M9rKwj74Is/miQ7jfGzneiY=;
        b=l8DQFgL/Kwe5QJCs5SBn68Xy1T/Cy4FjMdmDOpeVvwogevKP8Getm75hQ8oRTACFA/
         zKa3enGTVeI9iTmkqvp6seV7XnyYu8JYYsDI1pGE4hWY152sQ4eeYSW92QIWn4l2fpD1
         ZZDQdmoEWADxlScRCTEn+PA2G3f13xfijonL+4ZMGftuegG8kz+YFsBOOj50rGvM9C+Q
         81fJL5RL1dhKZ6WOloqW6pZeBbF0H7yFdKM+EpRr1LJ39iyeW7QBWw192E2qKTfRKCq3
         3tF78zlnyMctd3UpzSpzH7E10/2YqjNFDatVnWjs3ykdpM/7r/YdWjLEaJGwAKHna8aw
         J0tQ==
X-Gm-Message-State: APjAAAWL/3oQL3HQLiLDtxxoNtvJdV1coqJHydkWK9nLOjJUTDaVL8G/
        qpWiBpO5XpCzaL9/vvqEEK4Ap4UxKvOiXaRlcKuaQqQ/
X-Google-Smtp-Source: APXvYqwFQ1xvUY+GiJkE0vgl4fCLQfKuMnYxU9W2I8OYUiqIeuHcOwLzNlxLs+1ijGdLu70UoWShKm1JfUzJw+7GRxU=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr1885562otk.189.1578651820305;
 Fri, 10 Jan 2020 02:23:40 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Jan 2020 11:23:29 +0100
Message-ID: <CAJZ5v0g27E7+wsrMXw1KhUQV6PZJhWcSQ5VG_HTZ5JgYejh15w@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.5-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.5-rc6

with top-most commit 10674d97c4e266e8c50ce794d1c470c26228d52b

 Merge branch 'powercap'

on top of commit c79f46a282390e0f5b306007bf7b11a46d529538

 Linux 5.5-rc5

to receive power management fixes for 5.5-rc6.

These prevent the cpufreq-dt driver from probing Tegra20/30 (Dmitry
Osipenko) and prevent the Intel RAPL power capping driver from
crashing during CPU initialization due to a NULL pointer dereference
if the processor model in use is not known to it (Harry Pan).

Thanks!


---------------

Dmitry Osipenko (1):
      cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs

Harry Pan (1):
      powercap: intel_rapl: add NULL pointer check to rapl_mmio_cpu_online()

---------------

 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 drivers/powercap/intel_rapl_common.c | 3 +++
 2 files changed, 5 insertions(+)
