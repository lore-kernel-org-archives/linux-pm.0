From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] PM / Domains: Power off masters immediately
Date: Fri, 17 Feb 2017 10:55:22 +0100
Message-ID: <1487325325-18212-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33656 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933960AbdBQJzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 04:55:31 -0500
Received: by mail-lf0-f42.google.com with SMTP id x1so20213238lff.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2017 01:55:31 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Currently genpd queues a power off work for each of the subdomain's
corresponding masters, thus postponing the masters to be powered off to a later
point.

This series intends to improve that behaviour in genpd, by instead power off
the masters immediately, thus avoiding unnecessary works from being queued.

Ulf Hansson (3):
  PM / Domains: Move genpd_power_off() above genpd_power_on()
  PM / Domains: Rename is_async to one_dev_on for genpd_power_off()
  PM / Domains: Power off masters immediately in the power off sequence

 drivers/base/power/domain.c | 178 +++++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 85 deletions(-)

-- 
1.9.1
