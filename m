From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.8-rc6
Date: Fri, 9 Sep 2016 23:30:49 +0200
Message-ID: <CAJZ5v0i=gQ94aZi2hG45-xJTQNCuQ7Y2mzyLyaRcusbCAZX7sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.8-rc6

to receive power management fixes for v4.8-rc6.

The top-most commit is 8a2a835bbcaa6af0ec659606d3eabc23ccaaab80

 Merge branches 'pm-core-fixes' and 'pm-cpufreq-fixes'

and the base is commit c6935931c1894ff857616ff8549b61236a19148f

 Linux 4.8-rc5

This includes a PM QoS framework fix from Tejun to prevent interrupts
from being enabled unexpectedly during early boot and a cpufreq
documentation fix.

Specifics:

 - If the PM QoS framework invokes cancel_delayed_work_sync() during
   early boot, it will enable interrupts which is not expected at
   that point, so prevent it from happening (Tejun Heo).

 - Fix cpufreq statistic documentation to follow a recent change in
   behavior that forgot to update it as appropriate (Jean Delvare).

Thanks!

---------------

Jean Delvare (1):
      cpufreq-stats: Minor documentation fix

Tejun Heo (1):
      PM / QoS: avoid calling cancel_delayed_work_sync() during early boot

---------------

 Documentation/cpu-freq/cpufreq-stats.txt |  2 +-
 kernel/power/qos.c                       | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)
