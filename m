From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Runtime: Improvements for parent/child relations
Date: Mon, 17 Oct 2016 20:16:57 +0200
Message-ID: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33951 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbcJQSRL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2016 14:17:11 -0400
Received: by mail-lf0-f44.google.com with SMTP id b81so297287875lfe.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2016 11:17:11 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

While working on improving the pm_runtime_force_suspend|resume() helpers [1], I
bumped into some code in the runtime PM core, which I think deserves some
improvement. Particularly these changes concerns parent-child management.

[1]
https://marc.info/?l=linux-pm&m=147637080702518&w=2

Ulf Hansson (4):
  PM / Runtime: Remove the exported function pm_children_suspended()
  PM / Runtime: Clarify comment in rpm_resume() when resuming the parent
  PM / Runtime: Convert pm_runtime_set_suspended() to return an int
  PM / Runtime: Don't allow to suspend a device with an active child

 drivers/base/power/runtime.c | 19 +++++++++++++++----
 include/linux/pm_runtime.h   | 11 ++---------
 2 files changed, 17 insertions(+), 13 deletions(-)

-- 
1.9.1

