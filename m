From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/6] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Tue,  3 Mar 2015 13:29:31 +0100
Message-ID: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
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
To: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net
Cc: devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, linux-kernel@vger.kernel.org, lina.iyer@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

There is a big number of cpuidle drivers for the ARM architecture.

These drivers have been cleaned up and grouped into the drivers/cpuidle
directory to keep track of the changes more easily and ensure the code
is following the same scheme across the drivers.

That had the benefit of simplifying the code and factor out a lot of common
parts. Beside that, as the drivers belong to the 'drivers' directory, we had
to split the arch specific bits and the generic code in order to keep
everything self contained. The platform driver paradigm was used for this
purpose.

Unfortunately, this approach is now no longer accepted and a different solution
must be provided to reach the same goal: one example is the Qualcomm cpuidle
driver upstreaming attempt [1].

In the meantime, ARM64 developed a generic cpuidle driver based on DT definition.

The DT definition provides an 'enable-method' to specify one of the cpu
operations (PSCI, ...).

This patchset unify this driver with ARM32, using the same DT definition.

Thanks with this patchset we can use the 'enable-method' to specify a cpu
operations, hence get rid of the platform driver approach and go further in the
cpuidle driver flexibility via the DT.

Daniel Lezcano (6):
  ARM: cpuidle: Remove duplicate header inclusion
  ARM: cpuidle: Add a cpuidle ops structure to be used for DT
  ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function
  ARM64: cpuidle: Rename cpu_init_idle to a common function name
  ARM64: cpuidle: Remove arm64 reference
  ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64

 arch/arm/include/asm/cpuidle.h                     | 12 +++
 arch/arm/include/asm/cpuidle_ops.h                 |  3 +
 arch/arm/kernel/cpuidle.c                          | 87 +++++++++++++++++++++-
 arch/arm/mach-davinci/cpuidle.c                    |  1 -
 arch/arm/mach-imx/cpuidle-imx6q.c                  |  1 -
 arch/arm/mach-imx/cpuidle-imx6sl.c                 |  1 -
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |  1 -
 arch/arm/mach-omap2/cpuidle44xx.c                  |  1 -
 arch/arm/mach-tegra/cpuidle-tegra20.c              |  1 -
 arch/arm/mach-tegra/cpuidle-tegra30.c              |  1 -
 arch/arm64/include/asm/cpuidle.h                   |  9 ++-
 arch/arm64/kernel/cpuidle.c                        |  2 +-
 drivers/cpuidle/Kconfig                            |  7 +-
 drivers/cpuidle/Kconfig.arm                        | 10 +++
 drivers/cpuidle/Kconfig.arm64                      | 13 ----
 drivers/cpuidle/Makefile                           |  5 +-
 drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} | 38 +++++-----
 drivers/cpuidle/cpuidle-at91.c                     |  1 -
 drivers/cpuidle/cpuidle-exynos.c                   |  1 -
 drivers/cpuidle/cpuidle-kirkwood.c                 |  1 -
 drivers/cpuidle/cpuidle-ux500.c                    |  1 -
 drivers/cpuidle/cpuidle-zynq.c                     |  1 -
 22 files changed, 139 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/include/asm/cpuidle_ops.h
 delete mode 100644 drivers/cpuidle/Kconfig.arm64
 rename drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} (72%)

-- 
1.9.1
