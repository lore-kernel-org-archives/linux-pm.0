Return-Path: <SRS0=WjHB=3Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10767C2D0DB
	for <linux-pm@archiver.kernel.org>; Mon, 27 Jan 2020 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97D620716
	for <linux-pm@archiver.kernel.org>; Mon, 27 Jan 2020 15:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgA0PRp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:17:45 -0500
Received: from foss.arm.com ([217.140.110.172]:45986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgA0PRp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jan 2020 10:17:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB7431B;
        Mon, 27 Jan 2020 07:17:44 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2ECC73F67D;
        Mon, 27 Jan 2020 07:17:41 -0800 (PST)
From:   lukasz.luba@arm.com
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, lukasz.luba@arm.com
Subject: [PATCH 0/1] drivers: devfreq: use DELAYED_WORK in DEVFREQ monitoring subsystem
Date:   Mon, 27 Jan 2020 15:17:30 +0000
Message-Id: <20200127151731.8640-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Hi all,

This patch is a continuation of my previous work for fixing DEVFREQ monitoring
subsystem [1]. The issue is around DEFERRABLE_WORK, which uses TIMER_DEFERRABLE
under the hood which will work normally when the system is busy, but will not
cause a CPU to come out of idle and serve the DEVFREQ monitoring requests.

This is especially important in the SMP systems with many CPUs, when the load
balance tries to keep some CPUs idle. The next service request could not be
triggered when the CPU went idle in the meantime.

The DELAYED_WORK is going to be triggered even on an idle CPU. This will allow
to call the DEVFREQ monitoring in reliable intervals. Some of the drivers might
use internal counters to monitor their load, when the DEVFREQ work is not
triggered in a predictable way, these counters might overflow leaving the
device in undefined state.

To observe the difference, the trace output might be used, i.e.

echo 1 > /sys/kernel/debug/tracing/events/devfreq/enable
#your test starts here, i.e. 'sleep 5' or 'dd ' or 'gfxbench'
echo 0 > /sys/kernel/debug/tracing/events/devfreq/enable
cat /sys/kernel/debug/tracing/trace

When there are some registered devfreq drivers, you should see the traces
'devfreq_moniotor' triggered in reliable intervals.

The patch set is based on Chanwoo's devfreq repository and branch
'devfreq-next' [2].

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2019/2/12/1179
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next


Lukasz Luba (1):
  drivers: devfreq: add DELAYED_WORK to monitoring subsystem

 drivers/devfreq/Kconfig   | 19 +++++++++++++++++++
 drivers/devfreq/devfreq.c |  6 +++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.17.1

