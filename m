From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH 0/7] Fix issues and factorize arm/arm64 capacity information
 code
Date: Thu, 19 Jan 2017 14:37:50 +0000
Message-ID: <20170119143757.14537-1-juri.lelli@arm.com>
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
To: linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, juri.lelli@arm.com, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

arm and arm64 topology.c share a lot of code related to parsing of capacity
information. This set of patches proposes a solution (based on Will's,
Catalin's and Mark's off-line suggestions) to move such common code in a single
place: drivers/base/arch_topology.c (by creating such file and conditionally
compiling it for arm and arm64 only).

First 5 patches are actually fixes for the current code.

Patch 6 is the actual refactoring.

Last patch removes one of the extern symbols by changing a bit the now common
code. We still remain with some other externs, which are not nice. Moving them
in some header file solves the issue, should I just create a new include/
linux/arch_topology.h file and move them there?

The set is based on top of linux/master (4.10-rc4 fb1d8e0e2c50) and it is also
available from:

 git://linux-arm.org/linux-jl.git upstream/default_caps_factorize

Best,

- Juri

Juri Lelli (7):
  Documentation: arm: fix wrong reference number in DT definition
  Documentation/ABI: add information about cpu_capacity
  arm: fix return value of parse_cpu_capacity
  arm: remove wrong CONFIG_PROC_SYSCTL ifdef
  arm64: remove wrong CONFIG_PROC_SYSCTL ifdef
  arm, arm64: factorize common cpu capacity default code
  arm,arm64,drivers: reduce scope of cap_parsing_failed

 Documentation/ABI/testing/sysfs-devices-system-cpu |   7 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   4 +-
 arch/arm/Kconfig                                   |   1 +
 arch/arm/kernel/topology.c                         | 216 +------------------
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/topology.c                       | 218 +------------------
 drivers/base/Kconfig                               |   8 +
 drivers/base/Makefile                              |   1 +
 drivers/base/arch_topology.c                       | 240 +++++++++++++++++++++
 9 files changed, 269 insertions(+), 427 deletions(-)
 create mode 100644 drivers/base/arch_topology.c

-- 
2.10.0
