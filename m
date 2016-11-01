From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v1 0/2] set specific ddr frequency when stop ddr dvfs
Date: Tue,  1 Nov 2016 16:47:07 +0800
Message-ID: <1477990029-11062-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33002 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168059AbcKAIrR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 04:47:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id a136so7729177pfa.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2016 01:47:16 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: cw00.choi@samsung.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, Lin Huang <hl@rock-chips.com>

We need ddr run a specific frequency when ddr dvfs stop working. So we
implement get suspend frequency function in devfreq framework, and call
it in rk3399 dmc driver.

Lin Huang (2):
  PM/devfreq: add suspend frequency support
  PM/devfreq: rk3399: set specific ddr frequency when stop ddr dvfs

 drivers/devfreq/devfreq.c    | 17 ++++++++++++++++-
 drivers/devfreq/rk3399_dmc.c |  2 +-
 include/linux/devfreq.h      |  9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.6.6

