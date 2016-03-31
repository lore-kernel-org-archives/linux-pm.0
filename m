From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] PM / Domains: Further consolidate and clarify genpd code
Date: Thu, 31 Mar 2016 11:21:24 +0200
Message-ID: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33484 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbcCaJVm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 05:21:42 -0400
Received: by mail-lf0-f50.google.com with SMTP id p188so27837505lfd.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 02:21:41 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>

This is yet another quite trivial series of patches that further intends to
consolidate and clarify some of the code for the generic PM domain (genpd).

Ulf Hansson (3):
  PM / Domains: Rename stop_ok to suspend_ok for the genpd governor
  PM / Domains: Rename pm_genpd_runtime_suspend|resume()
  PM / Domains: Remove ->save|restore_state() callbacks

 drivers/base/power/domain.c          | 131 ++++++++++++++++-------------------
 drivers/base/power/domain_governor.c |  20 +++---
 include/linux/pm_domain.h            |   6 +-
 3 files changed, 70 insertions(+), 87 deletions(-)

-- 
1.9.1

