From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH V5 0/9] CPU PM domains
Date: Fri,  3 Mar 2017 12:41:26 -0800
Message-ID: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, brendan.jackman@arm.com, sudeep.holla@arm.com, andy.gross@linaro.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

This is the revised patchset after good discussions at Plumbers' conference.
So far, the design fashioned a PM domain around a cluster of CPUs. After
discussions, it was agreed that each CPU will be considered a PM domain, for it
can be powered on/off individually. This series implements that change.

This set adds support for CPU PM domains. One of users of CPU PM Domains is
PSCI on ARM architectures. A following patchset will add that support.

Changes since V4[1]:
- CPU PM domains re-organized
- Update patchset to use hotplug mechanism
- Rebase on top of rwy/linux-next

The patches do the following -

#1:    Allows CPU's idle states be presented using domain-idle-states property
#2,#3: Add runtime PM support for CPU devices
#4:    Create PM domains for CPUs
#5:    Export timer for CPU wakeup
#6:    Determine CPU cluster wakeup
#7,#8: Data and DT support for CPU PM domains
#9:    Add Documentation

Thanks,
Lina

[1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/463419.html

Lina Iyer (9):
  PM / Domains: Ignore domain-idle-states that are not compatible
  drivers: cpu: Setup CPU devices to do runtime PM
  kernel/cpu_pm: Add runtime PM support for CPUs
  PM / cpu_domains: Setup PM domains for CPUs/clusters
  timer: Export next wake up of a CPU
  PM / cpu_domains: Add PM Domain governor for CPUs
  PM / Domains: allow platform specific data for genpd states
  PM / cpu_domains: Initialize CPU PM domains from DT
  doc / cpu_domains: Describe CPU PM domains setup and governor

 .../devicetree/bindings/power/power_domain.txt     |   4 +-
 Documentation/power/cpu_domains.txt                | 109 +++++
 drivers/base/cpu.c                                 |  15 +
 drivers/base/power/Makefile                        |   2 +-
 drivers/base/power/cpu_domains.c                   | 480 +++++++++++++++++++++
 drivers/base/power/domain.c                        |  16 +-
 include/linux/cpu_domains.h                        |  68 +++
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/pm_domain.h                          |   1 +
 include/linux/tick.h                               |  10 +
 kernel/cpu_pm.c                                    |  47 ++
 kernel/time/tick-sched.c                           |  11 +
 12 files changed, 755 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/power/cpu_domains.txt
 create mode 100644 drivers/base/power/cpu_domains.c
 create mode 100644 include/linux/cpu_domains.h

-- 
2.7.4
