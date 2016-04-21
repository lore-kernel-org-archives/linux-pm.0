From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.6-rc5
Date: Thu, 21 Apr 2016 21:56:20 +0200
Message-ID: <CAJZ5v0jegZNvq5pJf2Xkief6LMcYBAzNoaggpfUT-at+SUS5PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33632 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbcDUT4W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 15:56:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.6-rc5

to receive power management material for v4.6-rc5 with top-most
commit 395da1259ac3e3fdc70636a854c993ddb76c6169

 Merge branch 'pm-cpufreq-fixes'

on top of commit c3b46c73264b03000d1e18b22f5caf63332547c9

 Linux 4.6-rc4

Two fixes for issues introduced recently, one for an intel_pstate
driver problem uncovered by the recent switch over from using
timers and the other one for a potential cpufreq core problem
related to system suspend/resume.

Specifics:

 - Fix an intel_pstate driver problem causing CPUs to get stuck in
   the highest P-state when completely idle uncovered by the recent
   switch over from using timers (Rafael Wysocki).

 - Avoid attempts to get the current CPU frequency when all devices
   (like I2C controllers that may be nedded for that purpose) have
   been suspended during system suspend/resume (Rafael Wysocki).

Thanks!

---------------

Rafael J. Wysocki (2):
      intel_pstate: Avoid getting stuck in high P-states when idle
      cpufreq: Abort cpufreq_update_current_freq() for cpufreq_suspended set

---------------

 drivers/cpufreq/cpufreq.c      | 3 +++
 drivers/cpufreq/intel_pstate.c | 4 ++++
 2 files changed, 7 insertions(+)
