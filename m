From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Domains: Remove some code and APIs to simplify genpd
Date: Fri, 11 Apr 2014 17:26:40 +0200
Message-ID: <1397230004-22306-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:48573 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758686AbaDKP0u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Apr 2014 11:26:50 -0400
Received: by mail-la0-f44.google.com with SMTP id c6so3649406lan.31
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2014 08:26:48 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <t.figa@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Some parts in the generic power domain seems just too generic. Simplify the code
by removing it, which also happens to include two APIs.

For the SOC specific patch for shmobile, I am seeking an ack since it needs to
go together with the rest of patches.

Ulf Hansson (4):
  ARM: shmobile: Ignore callbacks for subsys generic_pm_domain_data
  PM / Domains: Ignore callbacks for subsys generic_pm_domain_data
  PM / Domains: Remove the pm_genpd_add|remove_callbacks APIs
  PM / Domains: Remove system PM callbacks from gpd_dev_ops

 arch/arm/mach-shmobile/pm-rmobile.c |   38 +----
 drivers/base/power/domain.c         |  285 +----------------------------------
 include/linux/pm_domain.h           |   28 ----
 3 files changed, 11 insertions(+), 340 deletions(-)

-- 
1.7.9.5

