From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.11-rc5
Date: Fri, 31 Mar 2017 23:33:06 +0200
Message-ID: <CAJZ5v0jFhv_M50MGyeUyYvshhzt8M9V_aLssVEYhFaG4ZzKciA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34466 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbdCaVdH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 17:33:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.11-rc5

with top-most commit 46e1d5e972db830379533f4d2d282cbb812dbb9b

 Merge branches 'pm-cpufreq-fixes' and 'pm-cpuidle-fixes'

on top of commit c02ed2e75ef4c74e41e421acb4ef1494671585e8

 Linux 4.11-rc4

to receive power management fixes for v4.11-rc5.

These fix a cpufreq core issue with the initialization of the cpufreq
sysfs interface and a cpuidle powernv driver initialization issue.

Specifics:

 - Symbolic links from CPU directories to the corresponding cpufreq
   policy directories in sysfs are not created during initialization
   in some cases which confuses user space, so prevent that from
   happening (Rafael Wysocki).

 - The powernv cpuidle driver fails to pass a correct cpumaks to
   the cpuidle core in some cases which causes subsequent failures
   to occur, so fix it (Vaidyanathan Srinivasan).

Thanks!

---------------

Rafael J. Wysocki (1):
      cpufreq: Fix creation of symbolic links to policy directories

Vaidyanathan Srinivasan (1):
      cpuidle: powernv: Pass correct drv->cpumask for registration

---------------

 drivers/cpufreq/cpufreq.c         | 38 +++++++++++++++++++++-----------------
 drivers/cpuidle/cpuidle-powernv.c | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+), 17 deletions(-)
