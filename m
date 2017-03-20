From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Domains: Add support for always on PM domains in genpd
Date: Mon, 20 Mar 2017 11:19:19 +0100
Message-ID: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33509 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbdCTKUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 06:20:23 -0400
Received: by mail-lf0-f48.google.com with SMTP id a6so53368811lfa.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 03:19:34 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

The current method to implement an always on PM domain by users of genpd,
consists of returning -EBUSY from their ->power_off() callback. This approach is
suboptimal as genpd is required to follow the regular execution path of its
power off sequence, which ends by invoking the ->power_off() callback.

To enable genpd to early abort the power off sequence for always on PM domains,
it needs static information about these configurations. Therefore this series
invents add new genpd configuration flag, GENPD_FLAG_ALWAYS_ON, which allow
users to explicity tell genpd about these kind of PM domains.

Some additonal changes, which are related this context, are also folded in as a
part of the series.

Ulf Hansson (4):
  PM / Domains: Clean up code validating genpd's status
  PM / Domains: Enable users of genpd to specify always on PM domains
  PM / Domains: Respect errors from genpd's ->power_off() callback
  PM / Domains: Don't warn about IRQ safe device for an always on PM
    domain

 drivers/base/power/domain.c | 42 ++++++++++++++++++++++++++++--------------
 include/linux/pm_domain.h   |  1 +
 2 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.7.4
