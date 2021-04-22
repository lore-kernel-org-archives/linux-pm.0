Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1646FC433ED
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 15:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0AA6140F
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 15:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhDVPhU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:37:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233106AbhDVPhU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 11:37:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B60B106F;
        Thu, 22 Apr 2021 08:36:45 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F3F13F73B;
        Thu, 22 Apr 2021 08:36:43 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH 0/3] Thermal governors improvements and a fix
Date:   Thu, 22 Apr 2021 16:36:21 +0100
Message-Id: <20210422153624.6074-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The patch set introduces one fix (patch 1/3) and two improvements, which
are possible thanks to the new helper function [1].
The patch 1/3 with a fix for fair share thermal governor is also sent
CC'ed stable, but it's hard to point a particular commit, which back
then was for fair_share.c.

The patch set should apply on top of [1].

Regards,
Lukasz

[1] https://lore.kernel.org/linux-pm/20210422114308.29684-2-lukasz.luba@arm.com/

Lukasz Luba (3):
  thermal: fair share: lock thermal zone while looping over instances
  thermal: fair share: use __thermal_cdev_update()
  thermal: power allocator: use __thermal_cdev_update()

 drivers/thermal/gov_fair_share.c      | 11 +++++++----
 drivers/thermal/gov_power_allocator.c |  3 +--
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.17.1

