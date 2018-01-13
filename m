From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v6 00/12]  Support PPTT for ARM64
Date: Fri, 12 Jan 2018 18:59:08 -0600
Message-ID: <20180113005920.28658-1-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

This patch set is dependent on "[14/15] ACPICA: ACPI 6.2: Additional
PPTT flags" https://patchwork.kernel.org/patch/10064191/

ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to describe the processor and cache topology. Ideally it is
used to extend/override information provided by the hardware, but
right now ARM64 is entirely dependent on firmware provided tables.

This patch parses the table for the cache topology and CPU topology.
When we enable ACPI/PPTT for arm64 we map the physical_id to the
PPTT node flagged as the physical package by the firmware.
This results in topologies that match what the remainder of the
system expects.

For example on juno:
[root@mammon-juno-rh topology]# lstopo-no-graphics
  Package L#0
    L2 L#0 (1024KB)
      L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
      L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
      L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
      L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
    L2 L#1 (2048KB)
      L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
      L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
  HostBridge L#0
    PCIBridge
      PCIBridge
        PCIBridge
          PCI 1095:3132
            Block(Disk) L#0 "sda"
        PCIBridge
          PCI 1002:68f9
            GPU L#1 "renderD128"
            GPU L#2 "card0"
            GPU L#3 "controlD64"
        PCIBridge
          PCI 11ab:4380
            Net L#4 "enp8s0"


Git tree at:
http://linux-arm.org/git?p=linux-jlinton.git
branch: pptt_v6

v5->v6:
Add additional patches which re-factor how the initial DT code sets
  up the cacheinfo structure so that its not as dependent on the
  of_node stored in that tree. Once that is done we rename it
  for use with the ACPI code.

Additionally there were a fair number of minor name/location/etc
  tweaks scattered about made in response to review comments.

v4->v5:
Update the cache type from NOCACHE to UNIFIED when all the cache
  attributes we update are valid. This fixes a problem where caches
  which are entirely created by the PPTT don't show up in lstopo.

Give the PPTT its own firmware_node in the cache structure instead of
  sharing it with the of_node.

Move some pieces around between patches.

v3->v4:
Suppress the "Found duplicate cache level/type..." message if the
  duplicate cache entry is actually a duplicate node. This allows cases
  like L1I and L1D nodes that point at the same L2 node to be accepted
  without the warning.
  
Remove cluster/physical split code. Add a patch to rename cluster_id
  so that its clear the topology may not be referring to a cluster.
  
Add additional ACPICA patch for the PPTT cache properties. This matches
  an outstanding ACPICA pull that should be merged in the near future.
  
Replace a number of (struct*)((u8*)ptr+offset) constructs with ACPI_ADD_PTR

Split out the topology parsing into an additional patch.

Tweak the cpu topology code to terminate on either a level, or a flag.
  Add an additional function which retrives the physical package id
  for a given cpu.

Various other comments/tweaks.

v2->v3:

Remove valid bit check on leaf nodes. Now simply being a leaf node
  is sufficient to verify the processor id against the ACPI
  processor ids (gotten from MADT). 

Use the acpi processor for the "level 0" Id. This makes the /sys
  visible core/thread ids more human readable if the firmware uses
  small consecutive values for processor ids.

Added PPTT to the list of injectable ACPI tables.

Fix bug which kept the code from using the processor node as intended
  in v2, caused by misuse of git rebase/fixup.

v1->v2:

The parser keys off the acpi_pptt_processor node to determine
  unique cache's rather than the acpi_pptt_cache referenced by the
  processor node. This allows PPTT tables which "share" cache nodes
  across cpu nodes despite not being a shared cache.

Jeremy Linton (12):
  drivers: base: cacheinfo: move cache_setup_of_node()
  drivers: base: cacheinfo: setup DT cache properties early
  cacheinfo: rename of_node to fw_unique
  arm64/acpi: Create arch specific cpu to acpi id helper
  ACPI/PPTT: Add Processor Properties Topology Table parsing
  ACPI: Enable PPTT support on ARM64
  drivers: base cacheinfo: Add support for ACPI based firmware tables
  arm64: Add support for ACPI based firmware tables
  ACPI/PPTT: Add topology parsing code
  arm64: topology: rename cluster_id
  arm64: topology: enable ACPI/PPTT based CPU topology
  ACPI: Add PPTT to injectable table list

 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/acpi.h     |   4 +
 arch/arm64/include/asm/topology.h |   4 +-
 arch/arm64/kernel/cacheinfo.c     |  15 +-
 arch/arm64/kernel/topology.c      |  73 ++++-
 arch/riscv/kernel/cacheinfo.c     |   3 +-
 drivers/acpi/Kconfig              |   3 +
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/pptt.c               | 592 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c             |   3 +-
 drivers/base/cacheinfo.c          | 159 +++++-----
 include/linux/acpi.h              |   3 +
 include/linux/cacheinfo.h         |  18 +-
 13 files changed, 772 insertions(+), 107 deletions(-)
 create mode 100644 drivers/acpi/pptt.c

-- 
2.13.5

