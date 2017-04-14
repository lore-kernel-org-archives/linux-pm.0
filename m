From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.11-rc7
Date: Fri, 14 Apr 2017 13:55:18 +0200
Message-ID: <CAJZ5v0gEoqBN4DQ2B9keomHOEn+u1cUJZXO04RrMpjbgaphZLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34401 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdDNLzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 07:55:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.11-rc7

with top-most commit 66803c946ee6065bc49a7f029b0a48d93467f228

 Merge branches 'pm-cpufreq-fixes' and 'pm-tools-fixes'

on top of commit 39da7c509acff13fc8cb12ec1bb20337c988ed36

 Linux 4.11-rc6

to receive power management fixes for v4.11-rc7.

These fix a cpufreq core regression related to CPU online/offline and
several issues in the turbostat and cpupower utilities.

Specifics:

 - Allow CPUs to be put back online even if the cpufreq driver is
   unable to work with them (eg. due to missing information from
   platform firmware), which was the previous behavior expected by
   users, but it changed in the 4.9 time frame (Chen Yu).

 - Fix a few minor issues in the turbostat utility, introduced mostly
   during the recent update of it (Len Brown, Doug Smythies).

 - Fix a cpupower utility bug causing it to report incorrect values
   for turbo frequencies in some cases (Ben Hutchings).

Thanks!

---------------

Ben Hutchings (1):
      cpupower: Fix turbo frequency reporting for pre-Sandy Bridge cores

Chen Yu (1):
      cpufreq: Bring CPUs up even if cpufreq_online() failed

Doug Smythies (1):
      tools/power turbostat: turbostat.8 add missing column definitions

Len Brown (6):
      tools/power turbostat: bugfix: GFXMHz column not changing
      tools/power turbostat: show missing Core and GFX power on SKL and KBL
      tools/power turbostat: enable package THERM_INTERRUPT dump
      tools/power turbostat: update HWP dump to decimal from hex
      tools/power turbostat: fix impossibly large CPU%c1 value
      tools/power turbostat: update version number

---------------

 drivers/cpufreq/cpufreq.c                  | 18 ++++++++++++++++--
 tools/power/cpupower/utils/helpers/cpuid.c |  1 +
 tools/power/x86/turbostat/turbostat.8      |  2 ++
 tools/power/x86/turbostat/turbostat.c      | 26 +++++++++++++-------------
 4 files changed, 32 insertions(+), 15 deletions(-)
