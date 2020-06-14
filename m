Return-Path: <SRS0=KdAB=73=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0F4C433DF
	for <linux-pm@archiver.kernel.org>; Sun, 14 Jun 2020 01:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093F62074D
	for <linux-pm@archiver.kernel.org>; Sun, 14 Jun 2020 01:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgFNBKW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:10:22 -0400
Received: from foss.arm.com ([217.140.110.172]:53250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFNBKW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Jun 2020 21:10:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 544221FB;
        Sat, 13 Jun 2020 18:10:21 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 621943F73C;
        Sat, 13 Jun 2020 18:10:19 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH 0/3] sched, arch_topology: Thermal pressure configuration cleanup
Date:   Sun, 14 Jun 2020 02:07:52 +0100
Message-Id: <20200614010755.9129-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi folks,

This stems from this thread [1] on the list. TL;DR: the thermal pressure config
has no helpful documentation, and figuring out if the right dependencies are in
place is not easy for a regular user. 

The current landscape also paints an odd picture: arch_set_thermal_pressure() is
hardcoded in sched/core.c, and is *not* architecture-definable, while
arch_get_thermal_pressure() is. Patch 1 is tackling this, the rest is Kconfig
stuff.

Cheers,
Valentin

[1]: https://lkml.kernel.org/r/20200603173150.GB1551@shell.armlinux.org.uk

Valentin Schneider (3):
  thermal/cpu-cooling, sched/core: Cleanup thermal pressure definition
  sched: Cleanup SCHED_THERMAL_PRESSURE setup
  arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE

 arch/arm/Kconfig                  |  1 +
 arch/arm64/Kconfig                |  1 +
 drivers/base/arch_topology.c      | 11 +++++++++++
 drivers/thermal/cpufreq_cooling.c |  5 +++++
 include/linux/arch_topology.h     |  3 ---
 init/Kconfig                      | 15 ++++++++++++++-
 kernel/sched/core.c               | 11 -----------
 7 files changed, 32 insertions(+), 15 deletions(-)

--
2.27.0

