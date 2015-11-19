From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/3] PM / OPP: Parse opp-supported-hw/opp-<prop>-<name> bindings
Date: Thu, 19 Nov 2015 09:13:55 +0530
Message-ID: <cover.1447904566.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35285 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbbKSDoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 22:44:06 -0500
Received: by pacej9 with SMTP id ej9so66188054pac.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 19:44:05 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael/Stephen,

The bindings are reviewed now and here is the code to parse them. The
first patch is a minor cleanup and other two contain the real stuff.

Rebased over: v4.4-rc1 + OPP debugfs support patch.
Tested-on: Exynos 5250, dual core A15.

V1->V2:
- Fixed locking
- NUL terminate strings instead of sprintf
- Remove NULL checkers for the routines
- constify 'versions'
- s/EINVAL/EBUSY
- updated comments over routines
- Use of_property_read_u32_index() instead of allocating arrays
- remove dev_opp for failures

Viresh Kumar (3):
  PM / OPP: Add missing doc comments
  PM / OPP: Parse 'opp-supported-hw' binding
  PM / OPP: Parse 'opp-<prop>-<name>' bindings

 drivers/base/power/opp/core.c | 301 +++++++++++++++++++++++++++++++++++++++---
 drivers/base/power/opp/opp.h  |  11 +-
 include/linux/pm_opp.h        |  22 +++
 3 files changed, 318 insertions(+), 16 deletions(-)

-- 
2.6.2.198.g614a2ac

