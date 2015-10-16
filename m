From: Rafael Wysocki <rjwysocki@gmail.com>
Subject: [GIT PULL] Power management and ACPI fixes for v4.3-rc6
Date: Fri, 16 Oct 2015 15:26:20 +0200
Message-ID: <CAJZ5v0iTKevUN+-fJQFAT-eK7NAwQuCkn0r-uaYL43vRNny46Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34662 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbbJPN0W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 09:26:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.3-rc6

to receive power management and ACPI fixes for v4.3-rc6 with
top-most commit fa548237321c4469e80741f773c4f5935a68a998

 Merge branches 'acpica', 'pm-domains' and 'pm-cpufreq'

on top of commit 25cb62b76430a91cc6195f902e61c2cb84ade622

 Linux 4.3-rc5

These fix two recent regressions (ACPICA, the generic power
domains framework) and one crash that may happen on specific
hardware supported since 4.1 (intel_pstate).

Specifics:

 - Fix a regression introduced by a recent ACPICA cleanup that
   uncovered a latent bug (Lv Zheng).

 - Fix a recent regression in the generic power domains framework
   that may cause it to violate PM QoS latency constraints in some
   cases (Ulf Hansson).

 - Fix an intel_pstate driver crash on the Knights Landing chips
   that do not update the MPERF counter as often as expected by the
   driver which may result in a divide by 0 (Srinivas Pandruvada).

Thanks!


---------------

Lv Zheng (1):
      ACPICA: Tables: Fix FADT dependency regression

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix divide by zero on Knights Landing (KNL)

Ulf Hansson (1):
      PM / Domains: Fix validation of latency constraints in genpd governor

---------------

 drivers/acpi/acpica/acglobal.h       |  1 +
 drivers/acpi/acpica/actables.h       |  4 +---
 drivers/acpi/acpica/evxfevnt.c       |  2 +-
 drivers/acpi/acpica/tbfadt.c         | 10 +++++-----
 drivers/acpi/acpica/tbutils.c        | 26 ++------------------------
 drivers/base/power/domain_governor.c | 22 ++++++----------------
 drivers/cpufreq/intel_pstate.c       |  5 +++++
 7 files changed, 21 insertions(+), 49 deletions(-)
