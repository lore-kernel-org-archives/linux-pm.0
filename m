From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Domains: Some simplifications/clean-ups for genpd
Date: Wed, 21 Sep 2016 15:38:49 +0200
Message-ID: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36184 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934100AbcIUNjB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2016 09:39:01 -0400
Received: by mail-lf0-f43.google.com with SMTP id g62so41152997lfe.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2016 06:39:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>

Ulf Hansson (4):
  PM / Domains: Simplify detaching a device from its genpd
  PM / Domains: Remove redundant system PM callbacks
  PM / Domains: Don't measure latency of ->power_on|off() during system
    PM
  PM / Domains: Rename pm_genpd_sync_poweron|poweroff()

 drivers/base/power/domain.c | 77 +++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

-- 
1.9.1

