Return-Path: <SRS0=rzrg=DW=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1918CC433DF
	for <linux-pm@archiver.kernel.org>; Thu, 15 Oct 2020 11:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF12F20B1F
	for <linux-pm@archiver.kernel.org>; Thu, 15 Oct 2020 11:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgJOLZj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 15 Oct 2020 07:25:39 -0400
Received: from foss.arm.com ([217.140.110.172]:32774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgJOLY6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 07:24:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CC7031B;
        Thu, 15 Oct 2020 04:24:57 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.48.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 359323F66B;
        Thu, 15 Oct 2020 04:24:55 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
Subject: [PATCH v2 0/4] Add upper and lower limits in IPA power budget calculation
Date:   Thu, 15 Oct 2020 12:24:37 +0100
Message-Id: <20201015112441.4056-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set makes thermal governor Intelligent Power Allocation (IPA)
aware of cooling device limits for upper and lower bounds and respects them
in the internal power budget calculation.

This v2 contains for completeness a patch posted by Michael. The patches
are re-based on top of current thermal/linux-next branch.

Changes:
v2:
- added check for cdev_is_power_actor(), before using cdev->ops->state2power()
  pointed out by Daniel
- added Michael's patch for consistency
- re-based on top of current thermal/linux-next
v1:
 can be found here [2]

Regards,
Lukasz

[1] https://lore.kernel.org/linux-pm/20201007024332.30322-1-michael.kao@mediatek.com/
[2] https://lore.kernel.org/linux-pm/20201007122256.28080-1-lukasz.luba@arm.com/

Lukasz Luba (3):
  thermal: power_allocator: respect upper and lower bounds for cooling
    device
  thermal: core: remove unused functions in power actor section
  thermal: move power_actor_set_power into IPA

Michael Kao (1):
  thermal: core: add upper and lower limits to power_actor_set_power

 drivers/thermal/gov_power_allocator.c | 40 +++++++++++-
 drivers/thermal/thermal_core.c        | 88 ---------------------------
 drivers/thermal/thermal_core.h        |  6 --
 3 files changed, 38 insertions(+), 96 deletions(-)

-- 
2.17.1

