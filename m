From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH V2 0/2] PM / Domains: Expand generic power domain debugfs.
Date: Tue, 13 Jun 2017 16:27:37 -0400
Message-ID: <1497385659-2356-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34465 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753791AbdFMU1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 16:27:42 -0400
Received: by mail-qt0-f179.google.com with SMTP id c10so188915209qtd.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 13:27:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org

This patch set attempts to improve the existing generic power domain
debugfs capabilities. The first  patch adds various accounting and
other bits needed to expose out the generic power domain statistics.
The second patch introduces new debugfs entries and attributes.

V1->V2:
- Removed calling of update accounting from suspend resume context
  where time keeping can be disabled.
- Added back the pm_genpd_summary which was removed by the first version
  of this patchset.
- Renamed a few debugfs parameters. 

Thara Gopinath (2):
  PM / Domains: Add time accounting to various genpd states.
  PM / Domains: Extend generic power domain debugfs.

 drivers/base/power/domain.c | 229 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   |   3 +
 2 files changed, 224 insertions(+), 8 deletions(-)

-- 
2.1.4
