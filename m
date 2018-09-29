From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.19-rc6
Date: Sat, 29 Sep 2018 15:41:23 +0200
Message-ID: <CAJZ5v0gwor9gvdgYrxQTL5E=mpVj8-2H2atg5ukFUmTnzopx+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc6

with top-most commit d51aea13dd6753186a2bea7619029c460bdf0c4c

 cpufreq: qcom-kryo: Fix section annotations

on top of commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84

 Linux 4.19-rc5

to receive a power management fix for 4.19-rc6.

This fixes incorrect __init and __exit annotations in the Qualcomm
Kryo cpufreq driver (Nathan Chancellor).

Thanks!


---------------

Nathan Chancellor (1):
      cpufreq: qcom-kryo: Fix section annotations

---------------

 drivers/cpufreq/qcom-cpufreq-kryo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
