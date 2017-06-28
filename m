From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 0/8] PM / Domains: Bunch of small improvements and fixes
Date: Wed, 28 Jun 2017 16:56:15 +0200
Message-ID: <20170628145623.20716-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Changes since v2:
=================
1. Add Ulf's acks.
2. Re-order patches so the un-acked commits are at the end.

Changes since v1:
=================
1. Patch 2/8: Follow Ulf's advice and use genpd_lookup_dev() which also
   solves risk of calling this for non-genpd (thus I added Ulf's
   Reported-by).



The last patch is RFC as this brings small overhead.

Best regards,
Krzysztof


Krzysztof Kozlowski (8):
  PM / Domains: Constify genpd pointer
  PM / Domains: Handle safely genpd_syscore_switch() call on non-genpd
    device
  PM / Domains: Fix unsafe iteration over modified list of device links
  PM / Domains: Fix unsafe iteration over modified list of domain
    providers
  PM / Domains: Fix unsafe iteration over modified list of domains
  PM / Domains: Fix missing default_power_down_ok comment
  PM / Domains: Add lockdep asserts for domains list mutex
  PM / Domains: Add asserts for PM domain locks

 drivers/base/power/domain.c          | 63 +++++++++++++++++++++++++++---------
 drivers/base/power/domain_governor.c | 12 +++----
 2 files changed, 54 insertions(+), 21 deletions(-)

-- 
2.11.0
