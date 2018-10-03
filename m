From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM) (a subset)
Date: Wed,  3 Oct 2018 16:38:13 +0200
Message-ID: <20181003143824.13059-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

I have digested the review comments so far, including a recent offlist chat
with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
have a plan for how to move forward.

However, to avoid re-posting non-changed patches over and over again, I decided
to withhold the more debatable part from this v9, hence this is not the complete
series to make things play. In v9, I have just included the trivial changes,
which are either already acked/reviewed or hopefully can be rather soon/easily.

My hope is to get this queued for v4.20, to move things forward. I know it's
late, but there are more or less nothing new here since v8.

Kind regards
Ulf Hansson

Changes in v9:
 - Collect only a subset from the changes in v8.
 - Patch 3 is new, documenting existing genpd flags. Future wise, this means
when a new genpd flag is invented, we must also properly document it.
 - No changes have been made to the patches picked from v8.
 - Dropped the text from v8 cover-letter[1], to avoid confusion. When posting v10
(or whatever the next version containing the rest becomes), I am going re-write
the cover-letter to clarify, more exactly, the problems this series intends to
solve. The earlier text was simply too vague.

[1]
https://lwn.net/Articles/758091/

Changes in v8:
 - Added some tags for reviews and acks.
 - Cleanup timer patch (patch6) according to comments from Rafael.
 - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
 - While adopting patch 5 to new genpd changes, I took the opportunity to
   improve the new function description a bit.
 - Corrected malformed SPDX-License-Identifier in patch20.

Changes in v7:
 - Addressed comments concerning the PSCI changes from Mark Rutland, which moves
   the psci firmware driver to a new firmware subdir and change to force PSCI PC
   mode during boot to cope with kexec'ed booted kernels.
 - Added some maintainers in cc for the timer/nohz patches.
 - Minor update to the new genpd governor, taking into account the state's
   poweroff latency while validating the sleep duration time.
 - Addressed a problem pointed out by Geert Uytterhoeven, around calling
   pm_runtime_get|put() for CPUs that has not been attached to a CPU PM domain.
 - Re-based on Linus' latest master.


Lina Iyer (3):
  dt: psci: Update DT bindings to support hierarchical PSCI states
  cpuidle: dt: Support hierarchical CPU idle states
  drivers: firmware: psci: Support hierarchical CPU idle states

Ulf Hansson (8):
  PM / Domains: Don't treat zero found compatible idle states as an
    error
  PM / Domains: Deal with multiple states but no governor in genpd
  PM / Domains: Document flags for genpd
  of: base: Add of_get_cpu_state_node() to get idle states for a CPU
    node
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  drivers: firmware: psci: Simplify error path of psci_dt_init()

 .../devicetree/bindings/arm/psci.txt          | 156 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 drivers/base/power/domain.c                   |  20 ++-
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/Kconfig                      |  15 +-
 drivers/firmware/Makefile                     |   3 +-
 drivers/firmware/psci/Kconfig                 |  13 ++
 drivers/firmware/psci/Makefile                |   4 +
 drivers/firmware/{ => psci}/psci.c            |  70 ++++----
 drivers/firmware/{ => psci}/psci_checker.c    |   0
 drivers/of/base.c                             |  35 ++++
 include/linux/of.h                            |   8 +
 include/linux/pm_domain.h                     |  35 +++-
 13 files changed, 302 insertions(+), 64 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (95%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

-- 
2.17.1
