From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 0/8] PM / Domains: Bunch of small improvements and fixes
Date: Fri,  9 Jun 2017 18:08:45 +0200
Message-ID: <20170609160853.31789-1-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbdFIQJA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jun 2017 12:09:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Hi,

Except adding lockdep assert to domains list mutex (3/8), all patches
are independent.  Including the fixes for unsafe loop iteration.

The last patch is RFC as this brings small overhead.

Best regards,
Krzysztof


Krzysztof Kozlowski (8):
  PM / Domains: Constify genpd pointer
  PM / domains: Protect reading loop over list of domains
  PM / domains: Add lockdep asserts for domains list mutex
  PM / domains: Fix unsafe iteration over modified list of device links
  PM / domains: Fix unsafe iteration over modified list of domain
    providers
  PM / domains: Fix unsafe iteration over modified list of domains
  PM / domains: Fix missing default_power_down_ok comment
  PM / Domains: Add asserts for PM domain locks

 drivers/base/power/domain.c          | 66 ++++++++++++++++++++++++++++--------
 drivers/base/power/domain_governor.c | 12 +++----
 2 files changed, 58 insertions(+), 20 deletions(-)

-- 
2.9.3
