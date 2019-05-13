From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement for PSCI
Date: Mon, 13 May 2019 21:22:42 +0200
Message-ID: <20190513192300.653-1-ulf.hansson@linaro.org>
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
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Tony Lindgren <tony@atomide.com>, Lina Iyer <ilina@codeaurora.org>, linux-arm-msm@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>, Souvik Chakravarty <souvik.chakravarty@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

This series enables support for hierarchical CPU arrangement, managed by PSCI
for ARM/ARM64. It's based on using the generic PM domain (genpd), which
recently was extended to manage devices belonging to CPUs.

The last two DTS patches enables the hierarchical topology to be used for the
Qcom 410c Dragonboard and the Hisilicon Hikey board. The former uses PSCI OS-
initiated mode, while the latter uses the PSCI Platform-Coordinated mode. In
other words, the hierarchical description of the topology in DT, is orthogonal
to the supported PSCI CPU suspend mode.

Do note, these patches have been posted earlier, but then being part of bigger
series, which at that point also included the needed infrastructure changes to
genpd and cpuidle. Rather than continue to carry the old version history,
which may be a bit confusing, I decided to start over. Although, for clarity,
the changelog below explains what changes that have been made since the last
submission was made.

Changes since last submission:
 - Converted to use dev_pm_domain_attach_by_name() rather than
   dev_pm_domain_attach(),when attaching a CPU to its PM domain. This is done to
   cope with multiple PM domains per CPU, if that turns out to be needed in the
   future. Changes mainly consisted of storing the returned struct device* from
   dev_pm_domain_attach_by_name() into a per CPU struct.
 - Due to above changes, some simplification of the code became possible, in
   particular the deployment of runtime PM became a bit nicer, I think.
 - Moved some of the new code inside "#ifdef CONFIG_CPU_IDLE".
 - Addressed various comments for each patch.

The series is also available at:
git.linaro.org/people/ulf.hansson/linux-pm.git next

More background (if you are still awake):
For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
>From a CPU idle state perspective, this means some states may be shared among a
group of CPUs (aka CPU cluster).

To deal with idle management of a group of CPUs, sometimes the kernel needs to
be involved to manage the last-man standing algorithm, simply because it can't
rely solely on power management FWs to deal with this. Depending on the
platform, of course.

There are a couple of typical scenarios for when the kernel needs to be in
control, dealing with synchronization of when the last CPU in a cluster is about
to enter a deep idle state.

1)
The kernel needs to carry out so called last-man activities before the
CPU cluster can enter a deep idle state. This may for example involve to
configure external logics for wakeups, as the GIC may no longer be functional
once a deep cluster idle state have been entered. Likewise, these operations
may need to be restored, when the first CPU wakes up.

2)
Other more generic I/O devices, such as an MMC controller for example, may be a
part of the same power domain as the CPU cluster, due to a shared power-rail.
For these scenarios, when the MMC controller is in use dealing with an MMC
request, a deeper idle state of the CPU cluster may needs to be temporarily
disabled. This is needed to retain the MMC controller in a functional state,
else it may loose its register-context in the middle of serving a request.

Kind regards
Ulf Hansson


Lina Iyer (4):
  dt: psci: Update DT bindings to support hierarchical PSCI states
  cpuidle: dt: Support hierarchical CPU idle states
  drivers: firmware: psci: Support hierarchical CPU idle states
  arm64: dts: Convert to the hierarchical CPU topology layout for
    MSM8916

Ulf Hansson (14):
  of: base: Add of_get_cpu_state_node() to get idle states for a CPU
    node
  ARM/ARM64: cpuidle: Let back-end init ops take the driver as input
  drivers: firmware: psci: Simplify state node parsing
  drivers: firmware: psci: Prepare to use OS initiated suspend mode
  drivers: firmware: psci: Prepare to support PM domains
  drivers: firmware: psci: Add support for PM domains using genpd
  drivers: firmware: psci: Add hierarchical domain idle states converter
  drivers: firmware: psci: Introduce psci_dt_topology_init()
  drivers: firmware: psci: Add a helper to attach a CPU to its PM domain
  drivers: firmware: psci: Attach the CPU's device to its PM domain
  drivers: firmware: psci: Manage runtime PM in the idle path for CPUs
  drivers: firmware: psci: Support CPU hotplug for the hierarchical
    model
  arm64: kernel: Respect the hierarchical CPU topology in DT for PSCI
  arm64: dts: hikey: Convert to the hierarchical CPU topology layout

 .../devicetree/bindings/arm/psci.txt          | 166 ++++++++
 arch/arm/include/asm/cpuidle.h                |   4 +-
 arch/arm/kernel/cpuidle.c                     |   5 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |  87 +++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 ++-
 arch/arm64/include/asm/cpu_ops.h              |   4 +-
 arch/arm64/include/asm/cpuidle.h              |   6 +-
 arch/arm64/kernel/cpuidle.c                   |   6 +-
 arch/arm64/kernel/setup.c                     |   3 +
 drivers/cpuidle/cpuidle-arm.c                 |   2 +-
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/psci/Makefile                |   2 +-
 drivers/firmware/psci/psci.c                  | 219 ++++++++--
 drivers/firmware/psci/psci.h                  |  29 ++
 drivers/firmware/psci/psci_pm_domain.c        | 403 ++++++++++++++++++
 drivers/of/base.c                             |  36 ++
 drivers/soc/qcom/spm.c                        |   3 +-
 include/linux/of.h                            |   8 +
 include/linux/psci.h                          |   6 +-
 19 files changed, 987 insertions(+), 64 deletions(-)
 create mode 100644 drivers/firmware/psci/psci.h
 create mode 100644 drivers/firmware/psci/psci_pm_domain.c

-- 
2.17.1
