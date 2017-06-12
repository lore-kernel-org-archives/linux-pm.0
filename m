From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 0/8] PM / Domains: Bunch of small improvements and fixes
Date: Mon, 12 Jun 2017 17:17:40 +0200
Message-ID: <20170612151748.7380-1-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751331AbdFLPR5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 11:17:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Hi,

Changes since v1:
=================
1. Patch 2/8: Follow Ulf's advice and use genpd_lookup_dev() which also
   solves risk of calling this for non-genpd (thus I added Ulf's
   Reported-by).

Description:
============
Except adding lockdep assert to domains list mutex (3/8), all patches
are independent.  Including the fixes for unsafe loop iteration.

The last patch is RFC as this brings small overhead.

Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  PM / Domains: Constify genpd pointer
  PM / Domains: Handle safely genpd_syscore_switch() call on non-genpd
    device
  PM / Domains: Add lockdep asserts for domains list mutex
  PM / Domains: Fix unsafe iteration over modified list of device links
  PM / Domains: Fix unsafe iteration over modified list of domain
    providers
  PM / Domains: Fix unsafe iteration over modified list of domains
  PM / Domains: Fix missing default_power_down_ok comment
  PM / Domains: Add asserts for PM domain locks

 drivers/base/power/domain.c          | 63 +++++++++++++++++++++++++++---------
 drivers/base/power/domain_governor.c | 12 +++----
 2 files changed, 54 insertions(+), 21 deletions(-)

-- 
2.9.3
