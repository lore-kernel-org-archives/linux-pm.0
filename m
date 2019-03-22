From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v5.1-rc2
Date: Fri, 22 Mar 2019 11:25:39 +0100
Message-ID: <CAJZ5v0gTJn9fdpM_y2wL=y0vqGeJhvLKzoD_BfNj-yNkmepBnw@mail.gmail.com>
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
 pm-5.1-rc2

with top-most commit 112a04f653ddf1d4246415e8e0d820002ebe8dca

 Merge branch 'pm-domains' into pm

on top of commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b

 Linux 5.1-rc1

to receive power management fixes for 5.1-rc2.

These rearrange some code in the generic power domains (genpd)
framework to avoid a potential deadlock and make the turbostat
utility behave more as expected.

Specifics:

 - Rearrange the generic power domains (genpd) code to avoid a
   potential deadlock possible due to its interactions with the
   clock framework (Jiada Wang).

 - Make turbostat return the exit status of the command run
   under it if that command fails (David Arcari).

Thanks!


---------------

David Arcari (1):
      tools/power turbostat: return the exit status of a command

Jiada Wang (1):
      PM / Domains: Avoid a potential deadlock

---------------

 drivers/base/power/domain.c           | 13 ++++++-------
 tools/power/x86/turbostat/turbostat.c |  3 +++
 2 files changed, 9 insertions(+), 7 deletions(-)
