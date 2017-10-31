From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management commit reverts for v4.14
Date: Tue, 31 Oct 2017 23:22:51 +0100
Message-ID: <CAJZ5v0jbiNjuTK96sdtAJXgmH3w5gTZh=uXcNSGN0zAK61Kzow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44180 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbdJaWWw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2017 18:22:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Since Geert reports additional problems with my PM QoS fix from the
last week that have not been addressed by the most recent fixup on top
of it, they both should better be reverted now and let's fix the
original issue properly in 4.15.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-reverts-4.14

with top-most commit d5919dcc349d2a16d805ef8096d36e4f519e42ae

 Revert "PM / QoS: Fix device resume latency PM QoS"

on top of commit 2a9a86d5c81389cd9afe6a4fea42c585733cd705

 PM / QoS: Fix default runtime_pm device resume latency

to receive extra power management fixes for v4.14.

This reverts two recent PM QoS commits one of which introduced multiple
problems and the other one fixed some, but not all of them (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (2):
      Revert "PM / QoS: Fix default runtime_pm device resume latency"
      Revert "PM / QoS: Fix device resume latency PM QoS"

---------------

 Documentation/ABI/testing/sysfs-devices-power |  4 +-
 drivers/base/cpu.c                            |  3 +-
 drivers/base/power/domain_governor.c          | 53 ++++++++++++---------------
 drivers/base/power/qos.c                      |  2 +-
 drivers/base/power/runtime.c                  |  2 +-
 drivers/base/power/sysfs.c                    | 25 ++-----------
 drivers/cpuidle/governors/menu.c              |  4 +-
 include/linux/pm_qos.h                        |  8 ++--
 8 files changed, 36 insertions(+), 65 deletions(-)
