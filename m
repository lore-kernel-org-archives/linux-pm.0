Return-Path: <SRS0=2KKr=C6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFCBC43463
	for <linux-pm@archiver.kernel.org>; Mon, 21 Sep 2020 12:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55F6206A4
	for <linux-pm@archiver.kernel.org>; Mon, 21 Sep 2020 12:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIUMUe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 21 Sep 2020 08:20:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgIUMUe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Sep 2020 08:20:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 604F1D6E;
        Mon, 21 Sep 2020 05:20:33 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E49C3F73B;
        Mon, 21 Sep 2020 05:20:26 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com, orjan.eide@arm.com,
        robh@kernel.org, alyssa.rosenzweig@collabora.com,
        steven.price@arm.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH 0/5] Thermal devfreq cooling improvements with Energy Model
Date:   Mon, 21 Sep 2020 13:20:02 +0100
Message-Id: <20200921122007.29610-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This path set is a continuation of my previous work, which aimed
to add Energy Model to all devices. This series is a follow up
for the patches which got merged to v5.9-rc1. It aims to change
the thermal devfreq cooling and use the Energy Model instead of
private calculation and structures. The new registration interface
in the patch 3/5 helps to register devfreq cooling and the EM in one
call. There is also another improvement, patch 2/5 is changing the
way how thermal gets the device status. Now it's taken on demand
and stored as a copy. The last patch wouldn't go through thermal tree,
but it's here to consistency.

The patch set is based on current next (next-20200921).

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2020/5/11/326

Lukasz Luba (5):
  thermal: devfreq_cooling: change tracing function and arguments
  thermal: devfreq_cooling: get a copy of device status
  thermal: devfreq_cooling: add new registration functions with Energy
    Model
  thermal: devfreq_cooling: remove old power model and use EM
  drm/panfrost: Register devfreq cooling and attempt to add Energy Model

 drivers/gpu/drm/panfrost/panfrost_devfreq.c |   2 +-
 drivers/thermal/devfreq_cooling.c           | 414 ++++++++++----------
 include/linux/devfreq_cooling.h             |  39 +-
 include/trace/events/thermal.h              |  19 +-
 4 files changed, 249 insertions(+), 225 deletions(-)

-- 
2.17.1

