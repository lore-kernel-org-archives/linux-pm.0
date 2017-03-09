From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.11-rc2
Date: Thu, 9 Mar 2017 23:58:36 +0100
Message-ID: <CAJZ5v0h=4H2AoDvPP6TWdvbOtkO23ah0xg_5oX9r6aRxDNUiuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35118 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbdCIW6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2017 17:58:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.11-rc2

with top-most commit 32d3b06a39783fbe849176774037b44f209979ea

 Merge branch 'pm-cpufreq-sched'

on top of commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201

 Linux 4.11-rc1

to receive power management updates for v4.11-rc2.

These fix several issues in the intel_pstate driver and one issue in
the schedutil cpufreq governor, clean up that governor a bit and hook
up existing code for disabling cpufreq to a new kernel command line
option.

Specifics:

 - Three fixes for intel_pstate problems related to the passive
   mode (in which it acts as a regular cpufreq scaling driver), two
   for the handling of global P-state limits and one for the handling
   of the cpu_frequency tracepoint in that mode (Rafael Wysocki).

 - Three fixes for the handling of P-state limits in intel_pstate in
   the active mode (Rafael Wysocki).

 - Introduction of a new cpufreq.off=1 kernel command line argument
   that will disable cpufreq entirely if passed to the kernel and
   is simply hooked up to the existing code used by Xen (Len Brown).

 - Fix for the schedutil cpufreq governor to prevent it from using
   stale raw frequency values in configurations with mutiple CPUs
   sharing one policy object and a cleanup for it reducing its
   overhead slightly (Viresh Kumar).

Thanks!

---------------

Len Brown (1):
      cpufreq: Add the "cpufreq.off=1" cmdline option

Rafael J. Wysocki (6):
      cpufreq: intel_pstate: Do not use performance_limits in passive mode
      cpufreq: intel_pstate: Fix intel_cpufreq_verify_policy()
      cpufreq: intel_pstate: Avoid triggering cpu_frequency tracepoint
unnecessarily
      cpufreq: intel_pstate: Fix global settings in active mode
      cpufreq: intel_pstate: Fix intel_pstate_verify_policy()
      cpufreq: intel_pstate: Do not reinit performance limits in ->setpolicy

Viresh Kumar (2):
      cpufreq: schedutil: move cached_raw_freq to struct sugov_policy
      cpufreq: schedutil: Pass sg_policy to get_next_freq()

---------------

 Documentation/admin-guide/kernel-parameters.txt |  3 ++
 drivers/cpufreq/cpufreq.c                       |  1 +
 drivers/cpufreq/intel_pstate.c                  | 67 ++++++++++++-------------
 kernel/sched/cpufreq_schedutil.c                | 19 ++++---
 4 files changed, 44 insertions(+), 46 deletions(-)
