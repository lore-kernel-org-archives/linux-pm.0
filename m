From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH V4 0/2] PM / Domains: Expand generic power domain debugfs.
Date: Fri, 14 Jul 2017 13:10:14 -0400
Message-ID: <1500052216-22252-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33655 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbdGNRKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2017 13:10:19 -0400
Received: by mail-qk0-f182.google.com with SMTP id a66so66565622qkb.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2017 10:10:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org

This patch set attempts to improve the existing generic power domain
debugfs capabilities. The first  patch adds various accounting and
other bits needed to expose out the generic power domain statistics.
The second patch introduces new debugfs entries and attributes.

V3->V4:
- Renamed the newly defined static functions in domain.c to adhere
  to existing naming convention.
V2->V3:
- Changed the order of calling genpd_update_accounting and genpd->status
  getting updated in power on and power off apis.
- Minor fixes from review comments on the list.
V1->V2:
- Removed calling of update accounting from suspend resume context
  where time keeping can be disabled.
- Added back the pm_genpd_summary which was removed by the first version
  of this patchset.
- Renamed a few debugfs parameters. 

Thara Gopinath (2):
  PM / Domains: Add time accounting to various genpd states.
  PM / Domains: Extend generic power domain debugfs.

 drivers/base/power/domain.c | 237 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   |   3 +
 2 files changed, 230 insertions(+), 10 deletions(-)

-- 
2.1.4
