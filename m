From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.8-rc5
Date: Fri, 2 Sep 2016 23:42:45 +0200
Message-ID: <CAJZ5v0gtjuSeQeqZyju6_37VVWvMqR2rgnK4_58PQL=TrH2=dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34034 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbcIBVmr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2016 17:42:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.8-rc5

to receive power management fixes for v4.8-rc5.

The top-most commit is b654c62e7734cdcd507a5751cd940077be2ad373

 Merge branches 'pm-cpufreq-fixes' and 'pm-core-fixes'

and the base is commit 3eab887a55424fc2c27553b7bfe32330df83f7b8

 Linux 4.8-rc4

This includes a stable-candidate cpufreq-dt driver problem fix and
annotations of tracepoints in the runtime PM framework.

Specifics:

 - Fix the definition of the cpufreq-dt driver's machines table
   introduced during the 4.7 cycle that should be NULL-terminated,
   but the termination entry is missing from it (Wei Yongjun).

 - Annotate tracepoints in the runtime PM framework's core so as to
   allow the functions containing them to be called from the idle
   code path without causing RCU to complain about illegal usage
   (Paul McKenney).

Thanks!

---------------

Paul E. McKenney (2):
      PM / runtime: Add _rcuidle suffix to allow rpm_resume() to be
called from idle
      PM / runtime: Add _rcuidle suffix to allow rpm_idle() use from idle

Wei Yongjun (1):
      cpufreq: dt: Add terminate entry for of_device_id tables

---------------

 drivers/base/power/runtime.c         | 10 +++++-----
 drivers/cpufreq/cpufreq-dt-platdev.c |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)
