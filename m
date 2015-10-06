From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Domains: Trivial clean-up for power on/off functions
Date: Tue,  6 Oct 2015 14:26:29 +0200
Message-ID: <1444134389-17851-1-git-send-email-ulf.hansson@linaro.org>
References: <mainline_patches/genpd_powerAPI_cleanups/0001-soc-dove-Let-genpd-deal-with-disabling-of-unused-PM-.patch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:36248 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbJFM0r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 08:26:47 -0400
Received: by laddr2 with SMTP id dr2so25635951lad.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2015 05:26:46 -0700 (PDT)
In-Reply-To: <mainline_patches/genpd_powerAPI_cleanups/0001-soc-dove-Let-genpd-deal-with-disabling-of-unused-PM-.patch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

This patchset aims to reduce some code for the generic PM domain and to improve
consistency around function names - all related to power on/off functions.

Regarding patch1, I am requesting an ack from some of the dove SoC maintainers,
as this needs to go together via Rafael's linux-pm tree.

Ulf Hansson (4):
  soc: dove: Let genpd deal with disabling of unused PM domains
  PM / Domains: Remove pm_genpd_poweroff_unused() API
  PM / Domains: Remove pm_genpd_poweron() API
  PM / Domains: Rename *pm_genpd_poweron|poweroff()

 drivers/base/power/domain.c | 48 ++++++++++++++++++++++-----------------------
 drivers/soc/dove/pmu.c      |  1 -
 include/linux/pm_domain.h   |  8 --------
 3 files changed, 23 insertions(+), 34 deletions(-)

-- 
1.9.1

