From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.17-rc6
Date: Fri, 18 May 2018 10:02:11 +0200
Message-ID: <CAJZ5v0iecQwakKwyRb_Db=ebTEdpzKiGhkynW1GRRvf_ycVGnw@mail.gmail.com>
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
 pm-4.17-rc6

with top-most commit 0cf442c6bcf572e04f5690340d5b8e62afcee2ca

 cpufreq: armada-37xx: driver relies on cpufreq-dt

on top of commit 67b8d5c7081221efa252e111cd52532ec6d4266f

 Linux 4.17-rc5

to receive a power management fix for 4.17-rc6.

This fixes Kconfig dependencies of the armada-37xx cpufreq driver
(Miquel Raynal).

Thanks!


---------------

Miquel Raynal (1):
      cpufreq: armada-37xx: driver relies on cpufreq-dt

---------------

 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
