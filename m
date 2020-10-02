Return-Path: <SRS0=MpoM=DJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCBC47423
	for <linux-pm@archiver.kernel.org>; Fri,  2 Oct 2020 11:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D31C2072E
	for <linux-pm@archiver.kernel.org>; Fri,  2 Oct 2020 11:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgJBLoy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 2 Oct 2020 07:44:54 -0400
Received: from foss.arm.com ([217.140.110.172]:33354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLoy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Oct 2020 07:44:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFBDB1063;
        Fri,  2 Oct 2020 04:44:53 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.50.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C1813F73B;
        Fri,  2 Oct 2020 04:44:49 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, amitk@kernel.org, corbet@lwn.net,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, qperret@google.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rjw@rjwysocki.net
Subject: [PATCH v2 0/3] Clarify abstract scale usage for power values in Energy Model, EAS and IPA
Date:   Fri,  2 Oct 2020 12:44:23 +0100
Message-Id: <20201002114426.31277-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The Energy Model supports power values expressed in an abstract scale.
This has an impact on Intelligent Power Allocation (IPA) and should be
documented properly. There is also a need to update the DT binding for the
'sustainable-power' and allow it to have abstract scale as well.

Changes:
v2:
- updated sustainable power section in IPA documentation
- updated DT binding for the 'sustainable-power'

The v1 of the patch set and related discussion can be found in [1].

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-doc/20200929121610.16060-1-lukasz.luba@arm.com/

Lukasz Luba (3):
  docs: Clarify abstract scale usage for power values in Energy Model
  PM / EM: update the comments related to power scale
  dt-bindings: thermal: update sustainable-power with abstract scale

 .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
 .../driver-api/thermal/power_allocator.rst          | 13 ++++++++++++-
 Documentation/power/energy-model.rst                | 13 +++++++++++++
 Documentation/scheduler/sched-energy.rst            |  5 +++++
 include/linux/energy_model.h                        | 11 +++++------
 kernel/power/energy_model.c                         |  2 +-
 6 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.17.1

