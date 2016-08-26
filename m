From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v5 00/16] PM: SoC idle support using PM domains
Date: Fri, 26 Aug 2016 14:17:42 -0600
Message-ID: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34713 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbcHZUSZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2016 16:18:25 -0400
Received: by mail-pf0-f173.google.com with SMTP id p64so31713500pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2016 13:18:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Hi all,

Changes since v4 [10]:
- Rebased on top of v4.8-rc3.
- Generalized CPU runtime PM, not specific to ARM anymore.
- CPU PM domains not dependent on OF anymore.

Changes since v3 [7]:
- Mostly refactoring and reorganization, no functional changes.
- Refactored DT support for CPU PM domains into a separate patch.
  (Suggested by Ulf)
- Reorganized domain idle state into DT binding, to be more in line
  with the discussions that followed the last patch submission.
  (Thanks Brendan, Sudeep, Lorenzo for some really good discussions.)

Changes since v2 [5]:
- Update PSCI documentation to define OS-Initiated PM domains.
- Nifty updates and bug fixes. Thanks Brendan!
- Define PSCI PM domains under psci node in 8916 DT.
- Documentation updates for domain definitions.
- Updated series is at [4].

Changes since v1 [6]:
- Use arm,idle-state as the DT binding for domain idle state.
- OS-Initated changes to support that and to read arm,psci-suspend-param
(Thanks Mark Rutland and Kevin Hilman)
- tick_nohz_get_next_wakeup() - suggestions from Thomas Gleixner.
- The updated series is at [3].

Changes since RFC-v3 [1]:
- Reorganize the patches. Documentations have their own patch.
- Moved code around with PSCI OS initiated so they would not have compiler
  errors in other configuration.
- Minor bug fixes with genpd power_on functionality.
- Rebased on top of 4.7-rc1

This is the submission of the SoC idle support in the kernel for CPU domains
using genpd. The patches were submitted as RFC's earlier, the last of them is
[1]. Since the RFC, multiple discussions have happened around making the
patches generic across all architectures.

The patch has been tested on the 410c Dragonboard and the MTK EVB boards. Both
show good power savings when used with OS Initiated PSCI f/w.

This entire series can be found at [9].

Thanks,
Lina

[1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/412934.html
[2]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v1
[3]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v2
[4]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v3
[5]. https://lwn.net/Articles/695987/
[6]. https://lwn.net/Articles/675674/
[7]. http://www.spinics.net/lists/arm-kernel/msg522021.html
[8]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v4
[9]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v5
[10]. http://www.spinics.net/lists/arm-kernel/msg526463.html

Axel Haslam (2):
  PM / Domains: Allow domain power states to be read from DT
  dt/bindings: Update binding for PM domain idle states

Lina Iyer (14):
  PM / Domains: Abstract genpd locking
  PM / Domains: Support IRQ safe PM domains
  PM / doc: Update device documentation for devices in IRQ safe PM
    domains
  drivers: cpu: Setup CPU devices to do runtime PM
  kernel/cpu_pm: Add runtime PM support for CPUs
  PM / cpu_domains: Setup PM domains for CPUs/clusters
  PM / cpu_domains: Initialize CPU PM domains from DT
  timer: Export next wake up of a CPU
  PM / cpu_domains: Add PM Domain governor for CPUs
  doc / cpu_domains: Describe CPU PM domains setup and governor
  drivers: firmware: psci: Allow OS Initiated suspend mode
  drivers: firmware: psci: Support cluster idle states for OS-Initiated
  dt/bindings: Add PSCI OS-Initiated PM Domains bindings
  ARM64: dts: Define CPU power domain for MSM8916

 Documentation/devicetree/bindings/arm/psci.txt     |  79 ++++
 .../devicetree/bindings/power/power_domain.txt     |  57 +++
 Documentation/power/cpu_domains.txt                | 109 +++++
 Documentation/power/devices.txt                    |  12 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  25 ++
 drivers/base/cpu.c                                 |  18 +
 drivers/base/power/Makefile                        |   2 +-
 drivers/base/power/cpu_domains.c                   | 459 +++++++++++++++++++++
 drivers/base/power/domain.c                        | 308 ++++++++++++--
 drivers/firmware/psci.c                            | 135 +++++-
 include/linux/cpu_domains.h                        |  67 +++
 include/linux/pm_domain.h                          |  24 +-
 include/linux/tick.h                               |   7 +
 include/uapi/linux/psci.h                          |   5 +
 kernel/cpu_pm.c                                    |  45 ++
 kernel/time/tick-sched.c                           |  11 +
 16 files changed, 1298 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/power/cpu_domains.txt
 create mode 100644 drivers/base/power/cpu_domains.c
 create mode 100644 include/linux/cpu_domains.h

-- 
2.7.4

