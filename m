Return-Path: <SRS0=KdAB=73=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB02C433E0
	for <linux-pm@archiver.kernel.org>; Sun, 14 Jun 2020 01:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D06C2074D
	for <linux-pm@archiver.kernel.org>; Sun, 14 Jun 2020 01:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgFNBK0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:10:26 -0400
Received: from foss.arm.com ([217.140.110.172]:53288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFNBK0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Jun 2020 21:10:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8958AD6E;
        Sat, 13 Jun 2020 18:10:25 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A62A73F73C;
        Sat, 13 Jun 2020 18:10:23 -0700 (PDT)
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
Subject: [PATCH 2/3] sched: Cleanup SCHED_THERMAL_PRESSURE setup
Date:   Sun, 14 Jun 2020 02:07:54 +0100
Message-Id: <20200614010755.9129-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614010755.9129-1-valentin.schneider@arm.com>
References: <20200614010755.9129-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As Russell pointed out [1], this option is severely lacking in the
documentation department, and figuring out if one has the required
dependencies to benefit from turning it on is not straightforward.

Make it non user-visible, and add a bit of help to it. While at it, make it
depend on CPU_FREQ_THERMAL.

[1]: https://lkml.kernel.org/r/20200603173150.GB1551@shell.armlinux.org.uk

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 init/Kconfig | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 74a5ac65644f..052c9f4531c2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -439,8 +439,21 @@ config HAVE_SCHED_AVG_IRQ
 	depends on SMP
 
 config SCHED_THERMAL_PRESSURE
-	bool "Enable periodic averaging of thermal pressure"
+	bool
 	depends on SMP
+	depends on CPU_FREQ_THERMAL
+	help
+	  Select this option to enable thermal pressure accounting in the
+	  scheduler. Thermal pressure is the value conveyed to the scheduler
+	  that reflects the reduction in CPU compute capacity resulted from
+	  thermal throttling. Thermal throttling occurs when the performance of
+	  a CPU is capped due to high operating temperatures.
+
+	  If selected, the scheduler will be able to balance tasks accordingly,
+	  i.e. put less load on throttled CPUs than on non/less throttled ones.
+
+	  This requires the architecture to implement
+	  arch_set_thermal_pressure() and arch_get_thermal_pressure().
 
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
-- 
2.27.0

