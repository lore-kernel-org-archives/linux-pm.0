From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.10-rc1
Date: Thu, 22 Dec 2016 15:16:14 +0100
Message-ID: <CAJZ5v0h+u6xFa1xF+O=vEZ6LWoyQRu-o6hcn7bxNWv9aHxxMiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36479 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754679AbcLVOQQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2016 09:16:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-fixes-4.10-rc1

with top-most commit 7b99f1aeed37196ad54099c30c2f154a7d6e91e0

 Merge branch 'pm-cpufreq'

on top of commit 7ae123edd37a47e178eb9a6631fe4a7108262c10

 Merge tag 'acpi-urgent-4.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for v4.10-rc1.

They fix one bug introduced recently, a build warning and a kerneldoc
function description.

Specifics:

 - Prevent the acpi-cpufreq driver from crashing on exit by fixing
   a check against the __cpuhp_setup_state() return value and fix
   the kerneldoc description of that function to make it clear that
   it may return positive numbers on success too (Boris Ostrovsky).

 - Drop an incorrect __init annotation of a function in the
   s3c64xx cpufreq driver and fix a build warning generated (by
   older compilers) because of it (Arnd Bergmann).

Thanks!

---------------

Arnd Bergmann (1):
      cpufreq: s3c64xx: remove incorrect __init annotation

Boris Ostrovsky (2):
      CPU/hotplug: Clarify description of __cpuhp_setup_state() return value
      cpufreq: Remove CPU hotplug callbacks only if they were initialized

---------------

 drivers/cpufreq/acpi-cpufreq.c    | 2 +-
 drivers/cpufreq/s3c64xx-cpufreq.c | 2 +-
 kernel/cpu.c                      | 6 +++++-
 3 files changed, 7 insertions(+), 3 deletions(-)
