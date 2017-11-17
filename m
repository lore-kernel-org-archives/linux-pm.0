From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Two power management fixes for v4.15-rc1
Date: Fri, 17 Nov 2017 15:37:13 +0100
Message-ID: <CAJZ5v0joz4Gu5GRRK0=u=Dgfmcb1nBEEekcz1PpZfNK_BfXyHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40293 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbdKQOhO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Nov 2017 09:37:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-fixes-4.15-rc1

with top-most commit 3e4c9e637df1fac4123db5f3165b0034226a671b

 Merge branch 'pm-core'

on top of commit bd2cd7d5a8f83ddc761025f42a3ca8e56351a6cc

 Merge tag 'pm-4.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive two power management fixes for 4.15-rc1.

This is the change making /proc/cpuinfo on x86 report current
CPU frequency in "cpu MHz" again in all cases and an additional
one dealing with an overzealous check in one of the helper
routines in the runtime PM framework.

Thanks!


---------------

Rafael J. Wysocki (2):
      x86 / CPU: Always show current CPU frequency in /proc/cpuinfo
      PM / runtime: Drop children check from __pm_runtime_set_status()

---------------

 Documentation/power/runtime_pm.txt |  3 +-
 arch/x86/kernel/cpu/Makefile       |  2 +-
 arch/x86/kernel/cpu/aperfmperf.c   | 74 ++++++++++++++++++++++++++------------
 arch/x86/kernel/cpu/cpu.h          |  3 ++
 arch/x86/kernel/cpu/proc.c         |  6 +++-
 drivers/base/power/runtime.c       | 31 ++++++----------
 fs/proc/cpuinfo.c                  |  6 ++++
 include/linux/cpufreq.h            |  1 +
 8 files changed, 80 insertions(+), 46 deletions(-)
