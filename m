From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.3-rc5
Date: Sat, 10 Oct 2015 00:23:25 +0200
Message-ID: <CAJZ5v0hrz7UqcNHSwi=9PuCcOX1nXdAMiei-M0Akux-XjTA1+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33111 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140AbbJIWX1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2015 18:23:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.3-rc5

to receive power management and ACPI fixes for v4.3-rc5 with
top-most commit 670aee3fc7ac37ae947f8b582d87b51d5fa36524

 Merge branches 'pm-devfreq' and 'pm-cpufreq'

on top of commit 049e6dde7e57f0054fdc49102e7ef4830c698b46

 Linux 4.3-rc4

These are four fixes for bugs in the devfreq and cpufreq
subsystems, including two regression fixes (one for a recent
regression and one for a problem introduced in 4.2).

Specifics:

 - Two fixes for cpufreq regressions, an acpi-cpufreq driver one
   introduced during the 4.2 cycle when we started to preserve
   cpufreq directories for offline CPUs and a general one
   introduced recently (Srinivas Pandruvada).

 - Two devfreq fixes, one for a double kfree() in an error code
   path and one for a confusing sysfs-related failure (Geliang Tang,
   Tobias Jakobi).

Thanks!


---------------

Geliang Tang (1):
      PM / devfreq: fix double kfree

Srinivas Pandruvada (2):
      cpufreq: acpi_cpufreq: prevent crash on reading freqdomain_cpus
      cpufreq: prevent lockup on reading scaling_available_frequencies

Tobias Jakobi (1):
      PM / devfreq: Fix governor_store()

---------------

 drivers/cpufreq/acpi-cpufreq.c | 3 +++
 drivers/cpufreq/cpufreq.c      | 4 +++-
 drivers/devfreq/devfreq.c      | 7 ++++---
 3 files changed, 10 insertions(+), 4 deletions(-)
