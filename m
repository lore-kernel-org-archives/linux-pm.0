From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v5 0/7] Fix issues and factorize arm/arm64 capacity
 information code
Date: Wed, 31 May 2017 17:59:24 +0100
Message-ID: <20170531165931.6945-1-juri.lelli@arm.com>
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
information. This is v5 of a solution [1] (based on Will's, Catalin's and
Mark's off-line suggestions) to move such common code in a single place:
drivers/base/arch_topology.c (by creating such file and conditionally compiling
it for arm and arm64 only).

First 3 patches are actually fixes for the current code.

Patch 4 is the actual refactoring.

Patch 5 removes one of the extern symbols by changing a bit the now common
code.

Patch 6 removes the remaining externs (as required by Russell during v1 review)
by creating a new header file include/linux/arch_topology.h and including that
from arm, arm64 and drivers.

Last patch addresses Greg, Dietmar and Morten's comments to v4 by adding a
'topology_' prefix to interfaces exported by drivers code and used by arch (and
potentially others in the future). It also rename function names to make them
better reflect what the functions really do.

Changes from v4:

 - rebase on top of 4.12-rc3 (3f173bde7e43)
 - addressed Greg, Dietmar and Morten's comment on patch 7/7
 - added Vincent and Greg's Acked-by

The set is based on top of linux/master (4.12-rc3 3f173bde7e43) and it is also
available from:

 git://linux-arm.org/linux-jl.git upstream/default_caps_factorize-v5

Greg, if 7/7 looks now OK to you, could you please take the set so that it will
be ready for 4.13 merge window?

Thanks,

- Juri

[1] v1 - https://marc.info/?l=linux-kernel&m=148483680119355&w=2
    v2 - https://marc.info/?l=linux-kernel&m=148663344018205&w=2
    v3 - http://marc.info/?l=linux-kernel&m=149062080701399&w=2
    v4 - https://marc.info/?l=linux-kernel&m=149269955206646&w=2

Juri Lelli (7):
  Documentation: arm: fix wrong reference number in DT definition
  arm: fix return value of parse_cpu_capacity
  arm: remove wrong CONFIG_PROC_SYSCTL ifdef
  arm, arm64: factorize common cpu capacity default code
  arm,arm64,drivers: reduce scope of cap_parsing_failed
  arm,arm64,drivers: move externs in a new header file
  arm,arm64,drivers: add a prefix to drivers arch_topology interfaces

 Documentation/devicetree/bindings/arm/cpus.txt |   4 +-
 arch/arm/Kconfig                               |   1 +
 arch/arm/kernel/topology.c                     | 221 +---------------------
 arch/arm64/Kconfig                             |   1 +
 arch/arm64/kernel/topology.c                   | 226 +----------------------
 drivers/base/Kconfig                           |   8 +
 drivers/base/Makefile                          |   1 +
 drivers/base/arch_topology.c                   | 243 +++++++++++++++++++++++++
 include/linux/arch_topology.h                  |  17 ++
 9 files changed, 283 insertions(+), 439 deletions(-)
 create mode 100644 drivers/base/arch_topology.c
 create mode 100644 include/linux/arch_topology.h

-- 
2.11.0
