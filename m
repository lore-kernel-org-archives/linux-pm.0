From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.10-rc8
Date: Mon, 6 Feb 2017 23:41:59 +0100
Message-ID: <CAJZ5v0hSAVexs_bJ0aYrA3Ygfa1msMCaydS-9nBb7hxJE-HDWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35112 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdBFWmA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 17:42:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.10-rc8

with top-most commit cbf304e420da96992eae50bb6d51035681340ab8

 Merge branches 'pm-core-fixes' and 'pm-cpufreq-fixes'

on top of commit d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c

 Linux 4.10-rc7

to receive power management fixes for v4.10-rc8 (if there is one) or
for the final 4.10 (if there's no -rc8).

These add a quirk to intel_pstate to work around a firmware setting
that leads to frequency scaling issues (discovered recently) on some
Intel Kaby Lake processors, fix up the recently added brcmstb-avs
cpufreq driver and avoid false-positive warnings from the runtime PM
framework triggered by recent changes in i915.

Specifics:

 - Add an intel_pstate driver quirk to work around a firmware setting
   that leads to frequency scaling issues on desktop Intel Kaby Lake
   processors in some configurations if the hardware-managed P-states
   (HWP) feature is in use (Srinivas Pandruvada).

 - Fix up the recently added brcmstb-avs cpufreq driver: fix a bug
   related to system suspend and change the sysfs interface to match
   the user space expectations (Markus Mayer).

 - Modify the runtime PM framework to avoid false-positive warnings
   from the might_sleep_if() assertions in it (Rafael Wysocki).

Thanks!

---------------

Markus Mayer (2):
      cpufreq: brcmstb-avs-cpufreq: extend sysfs entry brcm_avs_pmap
      cpufreq: brcmstb-avs-cpufreq: properly retrieve P-state upon suspend

Rafael J. Wysocki (1):
      PM / runtime: Avoid false-positive warnings from might_sleep_if()

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Disable energy efficiency optimization

---------------

 drivers/base/power/runtime.c          | 11 ++++++-----
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 17 ++++++++++++++---
 drivers/cpufreq/intel_pstate.c        | 30 ++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)
