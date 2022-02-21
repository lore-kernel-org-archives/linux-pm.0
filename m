Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47779C433F5
	for <linux-pm@archiver.kernel.org>; Mon, 21 Feb 2022 22:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiBUWwG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 21 Feb 2022 17:52:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBUWwG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Feb 2022 17:52:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31D972458C;
        Mon, 21 Feb 2022 14:51:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1BC5106F;
        Mon, 21 Feb 2022 14:51:41 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62B133F66F;
        Mon, 21 Feb 2022 14:51:39 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC][PATCH 0/2] Introduce 'advanced' Energy Model in DT
Date:   Mon, 21 Feb 2022 22:51:29 +0000
Message-Id: <20220221225131.15836-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set solves a few issues:
1. It allows to register EM from DT, when the voltage information is not
   available. (Some background of the issues present on Chromebook devices
   can be checked at [1].)
2. It allows to register 'advanced' EM from the DT, which is more accurate
   and reflects total power (dynamic + static).

Implementation details:
It adds a new callback in OPP framework to parse the "energy-model" DT
entry. The propsed DT bindings heavily draw on "operating-points" (v1)
schema.

Comments, suggestions are very welcome.

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20220207073036.14901-2-lukasz.luba@arm.com/

Lukasz Luba (2):
  dt-bindings: power: add Energy Model bindings
  opp: Add support for 'advanced' Energy Model in DT

 .../bindings/power/energy-model.yaml          | 51 ++++++++++
 drivers/opp/of.c                              | 95 ++++++++++++++++++-
 2 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/energy-model.yaml

-- 
2.17.1

