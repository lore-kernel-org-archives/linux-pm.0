From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.17-rc4
Date: Fri, 4 May 2018 12:12:17 +0200
Message-ID: <CAJZ5v0gF8FCEFAKnKs2sBOcMdXcbyctYmsS-KLu8EmOjLdKcow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.17-rc4

with top-most commit d4f3388afd488ed15368fa7413b8bd6d1f98bb1d

 cpufreq / CPPC: Set platform specific transition_delay_us

on top of commit 6da6c0db5316275015e8cc2959f12a17584aeb64

 Linux v4.17-rc3

to receive a power management fix for 4.17-rc4.

This fixes a regression from the 4.14 cycle in the CPPC cpufreq
driver causing it to use an incorrect transition delay value
which leads to a very high rate of frequency change requests when
the schedutil governor is in use (Prashanth Prakash).

Thanks!


---------------

Prashanth Prakash (1):
      cpufreq / CPPC: Set platform specific transition_delay_us

---------------

 drivers/cpufreq/cppc_cpufreq.c | 46 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)
