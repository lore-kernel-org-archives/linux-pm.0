From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH 0/2] PM / Domains: Expand generic power domain debugfs.
Date: Thu, 25 May 2017 19:51:31 -0400
Message-ID: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34676 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969366AbdEYXvl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 19:51:41 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so180723718pfj.1
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2017 16:51:40 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, ulf.hansson@linaro.org, khilman@baylibre.com

This patch set attempts to improve the existing generic power domain
debugfs capabilities. The first  patch adds various accounting and
other bits needed to expose out the generic power domain statistics.
The second patch removes the old debugfs entry and introduces new
entries and attributes.

Thara Gopinath (2):
  PM / Domains: Add time accounting to various genpd states.
  PM / Domains: Extend generic power domain debugfs.

 drivers/base/power/domain.c | 257 ++++++++++++++++++++++++++++++--------------
 include/linux/pm_domain.h   |   4 +
 2 files changed, 178 insertions(+), 83 deletions(-)

-- 
2.1.4
