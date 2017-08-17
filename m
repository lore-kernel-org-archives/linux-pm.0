From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.13-rc6
Date: Thu, 17 Aug 2017 23:07:29 +0200
Message-ID: <CAJZ5v0g6Brei01w62uEi7EWcerh8oigP6-GQwp5KD8qAAAhp9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33024 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753326AbdHQVHa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2017 17:07:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.13-rc6

with top-most commit 8179962b84668d71586cd3efcb70e823f37a5702

 Merge branches 'intel_pstate-fix' and 'cpufreq-x86-fix'

on top of commit ef954844c7ace62f773f4f23e28d2d915adc419f

 Linux v4.13-rc5

to receive power management fixes for v4.13-rc6.

These fix two issues related to exposing the current CPU frequency
to user space on x86.

Specifics:

 - Disable interrupts around reading IA32_APERF and IA32_MPERF in
   aperfmperf_snapshot_khz() (introduced recently) to avoid excessive
   delays between the reads that may result from intterrupt handling
   (Doug Smythies).

 - Fix the comutation of the CPU frequency to be reported through the
   pstate_sample tracepoint in intel_pstate (Doug Smythies).

Thanks!


---------------

Doug Smythies (2):
      cpufreq: intel_pstate: report correct CPU frequencies during trace
      cpufreq: x86: Disable interrupts during MSRs reading

---------------

 arch/x86/kernel/cpu/aperfmperf.c | 3 +++
 drivers/cpufreq/intel_pstate.c   | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)
