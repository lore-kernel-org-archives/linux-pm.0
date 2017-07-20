From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.13-rc2
Date: Thu, 20 Jul 2017 23:55:31 +0200
Message-ID: <CAJZ5v0gv2LRp+ARKRcXisGyX4tUJ3Ouv5P1gr_mFO+Dk826cPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35567 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934927AbdGTVzc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 17:55:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.13-rc2

with top-most commit ffa64d5e0d2f053d76ff9b1d2f437150b49c4112

 Merge branches 'intel_pstate' and 'pm-domains'

on top of commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877

 Linux v4.13-rc1

to receive power management fixes for v4.13-rc2.

These are two stable-candidate fixes for the intel_pstate driver and
the generic power domains (genpd) framework.

Specifics:

 - Fix the average CPU load computations in the intel_pstate driver
   on Knights Landing (Xeon Phi) processors that require an extra
   factor to compensate for a rate change differences between the
   TSC and MPERF which is missing (Srinivas Pandruvada).

 - Fix an initialization ordering issue in the generic power domains
   (genpd) framework (Sudeep Holla).

Thanks!


---------------

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Correct the busy calculation for KNL

Sudeep Holla (1):
      PM / Domains: defer dev_pm_domain_set() until genpd->attach_dev
succeeds if present

---------------

 drivers/base/power/domain.c    |  8 ++++----
 drivers/cpufreq/intel_pstate.c | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 6 deletions(-)
