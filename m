Return-Path: <SRS0=q0VI=2G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1367C43603
	for <linux-pm@archiver.kernel.org>; Mon, 16 Dec 2019 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBB5206A5
	for <linux-pm@archiver.kernel.org>; Mon, 16 Dec 2019 14:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfLPOTW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:19:22 -0500
Received: from foss.arm.com ([217.140.110.172]:56950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfLPOTV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 09:19:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DADE1FB;
        Mon, 16 Dec 2019 06:19:21 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71AE03F718;
        Mon, 16 Dec 2019 06:19:19 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     amit.kucheria@verdurent.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH 0/2] Thermal devfreq cooling small updates
Date:   Mon, 16 Dec 2019 14:19:07 +0000
Message-Id: <20191216141909.30063-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Hi all,

This patch set adds small changes to devfreq cooling:
- updating the license to SPDX and copyright to 2019
- reclaiming the device node in registration function

It is based on the current work in thermal branch thermal/linux-next
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

Regards,
Lukasz Luba

Lukasz Luba (2):
  thermal: devfreq_cooling: Change license header to SPDX
  thermal: devfreq_cooling: Add device node reclaiming in
    devfreq_cooling_register()

 drivers/thermal/devfreq_cooling.c | 33 ++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

-- 
2.17.1

