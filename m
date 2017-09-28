From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.14-rc3
Date: Thu, 28 Sep 2017 23:32:00 +0200
Message-ID: <CAJZ5v0g641jR5jz9GdsS5CvQ4rrx53N2oa6YJQ4tQZgKKPVVCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34476 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdI1VcB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2017 17:32:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.14-rc3

with top-most commit abeb19a219dce5c021c759d01434f82924354df7

 Merge branches 'pm-opp' and 'pm-cpufreq'

on top of commit e19b205be43d11bff638cad4487008c48d21c103

 Linux 4.14-rc2

to receive power management fixes for v4.14-rc3.

These fix a deadlock in the operating performance points (OPP)
framework introduced during the 4.11 cycle, more issues with
duplicate device objects for cpufreq-dt and cpufreq documentation.

Specifics:

 - Fix a deadlock in the operating performance points (OPP)
   framework caused by a notifier callback taking a lock that's
   already held by its caller (Viresh Kumar).

 - Prevent the ti-cpufreq and cpufreq-dt-platdev drivers from
   attempting to register conflicting device objects which
   triggers a warning from sysfs (Suniel Mahesh).

 - Drop a stale reference to a piece of intel_pstate documentation
   that's not in the tree any more (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: docs: Drop intel-pstate.txt from index.txt

Suniel Mahesh (1):
      cpufreq: dt: Fix sysfs duplicate filename creation for platform-device

Viresh Kumar (1):
      PM / OPP: Call notifier without holding opp_table->lock

---------------

 Documentation/cpu-freq/index.txt     | 2 --
 drivers/base/power/opp/core.c        | 7 +++++++
 drivers/cpufreq/cpufreq-dt-platdev.c | 4 ++++
 3 files changed, 11 insertions(+), 2 deletions(-)
