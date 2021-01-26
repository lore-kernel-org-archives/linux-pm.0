Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924DC433E0
	for <linux-pm@archiver.kernel.org>; Tue, 26 Jan 2021 10:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116A723103
	for <linux-pm@archiver.kernel.org>; Tue, 26 Jan 2021 10:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404226AbhAZKml (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Jan 2021 05:42:41 -0500
Received: from foss.arm.com ([217.140.110.172]:60876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404262AbhAZKlJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 05:41:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF83D6E;
        Tue, 26 Jan 2021 02:40:23 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.2.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA2D83F66B;
        Tue, 26 Jan 2021 02:40:20 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com, amitk@kernel.org,
        rui.zhang@intel.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max power
Date:   Tue, 26 Jan 2021 10:39:58 +0000
Message-Id: <20210126104001.20361-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set tries to add the missing feature in the Intelligent Power
Allocation (IPA) governor which is: frequency limit set by user space.
User can set max allowed frequency for a given device which has impact on
max allowed power. In current design there is no mechanism to figure this
out. IPA must know the maximum allowed power for every device. It is then
used for proper power split and divvy-up. When the user limit for max
frequency is not know, IPA assumes it is the highest possible frequency.
It causes wrong power split across the devices.

This new mechanism provides the max allowed frequency to the thermal
framework and then max allowed power to the IPA.
The implementation is done in this way because currently there is no way
to retrieve the limits from the PM QoS, without uncapping the local
thermal limit and reading the next value. It would be a heavy way of
doing these things, since it should be done every polling time (e.g. 50ms).
Also, the value stored in PM QoS can be different than the real OPP 'rate'
so still would need conversion into proper OPP for comparison with EM.
Furthermore, uncapping the device in thermal just to check the user freq
limit is not the safest way.
Thus, this simple implementation moves the calculation of the proper
frequency to the sysfs write code, since it's called less often. The value
is then used as-is in the thermal framework without any hassle.

As it's a RFC, it still misses the cpufreq sysfs implementation, but would
be addressed if all agree.

Regards,
Lukasz Luba

Lukasz Luba (3):
  PM /devfreq: add user frequency limits into devfreq struct
  thermal: devfreq_cooling: add new callback to get user limit for min
    state
  thermal: power_allocator: get proper max power limited by user

 drivers/devfreq/devfreq.c             | 41 ++++++++++++++++++++++++---
 drivers/thermal/devfreq_cooling.c     | 33 +++++++++++++++++++++
 drivers/thermal/gov_power_allocator.c | 17 +++++++++--
 include/linux/devfreq.h               |  4 +++
 include/linux/thermal.h               |  1 +
 5 files changed, 90 insertions(+), 6 deletions(-)

-- 
2.17.1

