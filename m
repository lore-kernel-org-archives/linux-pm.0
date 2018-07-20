From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.18-rc6
Date: Fri, 20 Jul 2018 10:03:28 +0200
Message-ID: <CAJZ5v0ipKgfRfCmkRshrm9726=5rj5dUrKSLAK2GNEcdvnBMtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.18-rc6

with top-most commit 95d6c0857e54b788982746071130d822a795026b

 cpufreq: intel_pstate: Register when ACPI PCCH is present

on top of commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe

 Linux 4.18-rc5

to receive a power management fix for 4.18-rc6.

This fixes a relatively old initialization issue in intel_pstate
causing the pcc-cpufreq driver to be used instead of it on some HP
Proliant systems, which turned into a functional regression during
the 4.17 cycle, because pcc-cpufreq is a scalability disaster and
that was amplified by the idle loop rework done at that time (Rafael
Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Register when ACPI PCCH is present

---------------

 drivers/cpufreq/intel_pstate.c | 17 ++++++++++++++++-
 drivers/cpufreq/pcc-cpufreq.c  |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)
