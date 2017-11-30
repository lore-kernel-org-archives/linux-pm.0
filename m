From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.15-rc2
Date: Thu, 30 Nov 2017 22:46:07 +0100
Message-ID: <CAJZ5v0jfxdfzZWo3Rv0TdHHycKvOS-xLqoJ7-eaKYbHd-GO40Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37140 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdK3VqI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Nov 2017 16:46:08 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.15-rc2

with top-most commit 6981037442b05b192504fbc3c165cb240e01f6e2

 Merge branch 'pm-tools'

on top of commit e75080f185c103a638c66d7b65c673769a57cb87

 Merge tag 'pm-fixes-4.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for 4.15-rc2.

These add missing module information to the Mediatek cpufreq driver
module (Jesse Chan), fix config dependencies for the Loongson cpufreq
driver (James Hogan) and fix two issues related to CPU offline in
the cpupower utility (Abhishek Goel).

Thanks!


---------------

Abhishek Goel (2):
      cpupowerutils: bench - Fix cpu online check
      cpupower : Fix cpupower working when cpu0 is offline

James Hogan (1):
      cpufreq: Add Loongson machine dependencies

Jesse Chan (1):
      cpufreq: mediatek: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

---------------

 drivers/cpufreq/Kconfig                                 | 2 ++
 drivers/cpufreq/mediatek-cpufreq.c                      | 4 ++++
 tools/power/cpupower/bench/system.c                     | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 9 ++++++---
 4 files changed, 13 insertions(+), 4 deletions(-)
