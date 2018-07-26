From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.18-rc7
Date: Thu, 26 Jul 2018 16:12:20 +0200
Message-ID: <CAJZ5v0jq73sRO77qRBcDqCH4rojnBNK+mTs9UJ3RQyNLW3x2zw@mail.gmail.com>
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
 pm-4.18-rc7

with top-most commit bafaf056e0734f7bca7d27716bb3c672e87bb0b1

 cpufreq: qcom-kryo: add NULL entry to the end of_device_id array

on top of commit d72e90f33aa4709ebecc5005562f52335e106a60

 Linux 4.18-rc6

to receive a power management fix for 4.18-rc7.

This fixes up the recently introduced cpufreq driver for Qualcomm
Kryo processors by adding a terminating NULL entry to its table of
device IDs (YueHaibing).

Thanks!


---------------

YueHaibing (1):
      cpufreq: qcom-kryo: add NULL entry to the end of_device_id array

---------------

 drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
 1 file changed, 1 insertion(+)
