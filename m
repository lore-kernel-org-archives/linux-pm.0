Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88452C433FE
	for <linux-pm@archiver.kernel.org>; Tue,  1 Mar 2022 09:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiCAJgs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiCAJgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 04:36:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 708C5BC1B;
        Tue,  1 Mar 2022 01:36:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03A7CED1;
        Tue,  1 Mar 2022 01:36:06 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.20.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F9AE3F73D;
        Tue,  1 Mar 2022 01:36:03 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 0/4] Introduce "opp-microwatt" and Energy Model from DT
Date:   Tue,  1 Mar 2022 09:35:20 +0000
Message-Id: <20220301093524.8870-1-lukasz.luba@arm.com>
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
Existing machinery in the OPP framework now handles "opp-microwatt", similarly
to "opp-microamp". It also has helper exported function to get power from OPP.
For the EM, it adds a new callback in OPP framework to use this new API and
read power while having an opp pointer. It's agreed to work with OPP-v2.

Comments, suggestions are very welcome.

changelog:
v4:
- changed calculation of power, summing add all supliers power for an opp
- added opp debugfs for u_watt
- added patternProperties in dt-bindings for this new opp-microwatt
- changed the EM opp registration flow and used one EM api registration call
- changed name of _get_opp_power() to _get_dt_power()
- removed 'advanced' word from the new paragraph and content in EM doc changes
v3 [2]

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20220207073036.14901-2-lukasz.luba@arm.com/
[2] https://lore.kernel.org/linux-pm/20220224081131.27282-1-lukasz.luba@arm.com/

Lukasz Luba (4):
  dt-bindings: opp: Add "opp-microwatt" entry in the OPP
  OPP: Add "opp-microwatt" supporting code
  OPP: Add support of "opp-microwatt" for advanced EM registration
  Documentation: EM: Describe new registration method using DT

 .../devicetree/bindings/opp/opp-v2-base.yaml  |  23 ++++
 Documentation/power/energy-model.rst          |  10 ++
 drivers/opp/core.c                            |  25 +++++
 drivers/opp/debugfs.c                         |   3 +
 drivers/opp/of.c                              | 104 +++++++++++++++++-
 include/linux/pm_opp.h                        |  12 +-
 6 files changed, 174 insertions(+), 3 deletions(-)

-- 
2.17.1

