From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH] PM / Domains: Fix for domain idle state
Date: Thu,  3 Nov 2016 14:54:34 -0700
Message-ID: <1478210075-92045-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33600 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbcKCVzZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2016 17:55:25 -0400
Received: by mail-oi0-f48.google.com with SMTP id 128so114221734oih.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Nov 2016 14:55:24 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Hi Rafael,

This follows the discussions we had at LPC. The decision to use a different
compatible (different from that of the CPU's idle state) resulted in a new idle
state node definition that is specific to PM domains. The patch describes this
new binding.

You have already pulled in my earlier changes for domain idle states into your
linux-next. This patch is intended to be applied on top of that and fixes the
domain idle state and maps it to the new definition.

Thanks,
Lina

Lina Iyer (1):
  PM / Domains: Fix compatible for domain idle state

 .../bindings/power/domain-idle-state.txt           | 33 ++++++++++++++++++++++
 .../devicetree/bindings/power/power_domain.txt     |  8 +++---
 drivers/base/power/domain.c                        |  2 +-
 3 files changed, 38 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt

-- 
2.7.4

