Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3831C63777
	for <linux-pm@archiver.kernel.org>; Wed, 18 Nov 2020 12:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99369241A5
	for <linux-pm@archiver.kernel.org>; Wed, 18 Nov 2020 12:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKRMEQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 Nov 2020 07:04:16 -0500
Received: from foss.arm.com ([217.140.110.172]:52866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgKRMEQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Nov 2020 07:04:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 002C8D6E;
        Wed, 18 Nov 2020 04:04:15 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.23.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 888363F70D;
        Wed, 18 Nov 2020 04:04:13 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com, orjan.eide@arm.com,
        robh@kernel.org, alyssa.rosenzweig@collabora.com,
        steven.price@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        ionela.voinescu@arm.com
Subject: [PATCH v2 0/5] Thermal devfreq cooling improvements with Energy Model
Date:   Wed, 18 Nov 2020 12:03:53 +0000
Message-Id: <20201118120358.17150-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set is a continuation of my previous work, which aimed
to add Energy Model to all devices. This series is a follow up
for the patches which got merged to v5.9-rc1. It aims to change
the thermal devfreq cooling and use the Energy Model instead of
private power table and structures. The new registration interface
in the patch 3/5 helps to register devfreq cooling and the EM in one
call. There is also another improvement, patch 2/5 is changing the
way how thermal gets the device status. Now it's taken on demand
and stored as a copy. The last patch wouldn't go through thermal tree,
but it's here for consistency.

The patch set is based on current next-20201118, which has new EM API
in the pm/linux-next tree.

changes:
v2:
- renamed freq_get_state() and related to perf_idx pattern as
  suggested by Ionela
v1 [2]

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2020/5/11/326
[2] https://lore.kernel.org/linux-pm/20200921122007.29610-1-lukasz.luba@arm.com/

Lukasz Luba (5):
  thermal: devfreq_cooling: change tracing function and arguments
  thermal: devfreq_cooling: get a copy of device status
  thermal: devfreq_cooling: add new registration functions with Energy
    Model
  thermal: devfreq_cooling: remove old power model and use EM
  drm/panfrost: Register devfreq cooling and attempt to add Energy Model

 drivers/gpu/drm/panfrost/panfrost_devfreq.c |   2 +-
 drivers/thermal/devfreq_cooling.c           | 434 ++++++++++----------
 include/linux/devfreq_cooling.h             |  39 +-
 include/trace/events/thermal.h              |  19 +-
 4 files changed, 259 insertions(+), 235 deletions(-)

-- 
2.17.1

