From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] PM / Domains: Fix asynchronous execution of *noirq() callbacks
Date: Thu,  8 Dec 2016 14:45:19 +0100
Message-ID: <1481204721-11431-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35195 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbcLHNyL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2016 08:54:11 -0500
Received: by mail-wm0-f44.google.com with SMTP id a197so217761043wmd.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2016 05:54:10 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Brian Norris <briannorris@chromium.org>

This problem was brought up by Brian Norris [1], and I decided to help out
fixing the issue in genpd.

While working on it, I realized that the execution path when powering on/off a
PM domain in genpd, wasn't self-explanatory, so I folded in a change which
improved the code around that a bit.

I did not target stable or fixes for this, but perhaps we should!?

[1]
https://marc.info/?l=linux-pm&m=147990652405772&w=2

Ulf Hansson (2):
  PM / Domains: Rename functions in genpd for power on/off
  PM / Domains: Fix asynchronous execution of *noirq() callbacks

 drivers/base/power/domain.c | 116 +++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 56 deletions(-)

-- 
1.9.1

